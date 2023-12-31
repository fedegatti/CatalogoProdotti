package com.azienda.catalogoProdotti.ui;

import java.io.IOException;

import com.azienda.catalogoProdotti.businessLogic.ServiceUtenti;
import com.azienda.catalogoProdotti.exception.DatiNonValidiException;
import com.azienda.catalogoProdotti.exception.UtenteNonRegistratoException;
import com.azienda.catalogoProdotti.model.Utente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// prendo i dati dalla request
			String email = req.getParameter("emailFormInput");
			String password = req.getParameter("passwordFormInput");

			// chiamata al metodo del service
			ServiceUtenti service = (ServiceUtenti) getServletContext().getAttribute(InitServlet.BUSINESS_LOGIC_UTENTE);
			Utente utente = service.cercaUtente(email, password);
			
			//Controllo login dell'admin
			if (utente.getProfiloUtente().getNome().equals("admin")) {
				req.getSession().setAttribute("chiave_utente", utente);
				req.getRequestDispatcher("/jsp/HomepageAdmin.jsp").forward(req, resp);
			} 
			else if (utente.getProfiloUtente().getNome().equals("simpleUser")){
				req.getSession().setAttribute("chiave_utente", utente);
				resp.sendRedirect(req.getContextPath() + "/visualizzaProdottiUtente");
			}

		} catch (DatiNonValidiException | UtenteNonRegistratoException e) {
			e.printStackTrace();
			String messaggioEccezione = e.getMessage();
			req.setAttribute("chiave_errore", messaggioEccezione);
			req.getRequestDispatcher("/jsp/Login.jsp").forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
			
			req.getRequestDispatcher("jsp/Registrazione.jsp").forward(req, resp);
		}
	}

}
