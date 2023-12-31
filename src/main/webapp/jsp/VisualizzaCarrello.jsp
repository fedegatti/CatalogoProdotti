<%@page import="java.util.Map"%>
<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Visualizza Carrello</title>

<!-- <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
<link rel="stylesheet" href="<%=request.getContextPath() + "/css/visualizzaCarrelloStyle.css" %>">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">

</head>
<body>

<%
	String baseUrl = "http://" + request.getServerName() + ":" +
		request.getServerPort() + request.getContextPath();

	String urlRimuovi = request.getContextPath() + "/rimuoviProdotto";
	String homepageNegozioUrl = request.getContextPath() + "/visualizzaProdottiUtente";
	String urlOrdini = request.getContextPath() + "/visualizzaOrdiniUtente";
	String urlLogout = request.getContextPath() + "/logout";
	
	String urlProcediAllOrdine = baseUrl + "/jsp/ProcediAllOrdine.jsp";
	String urlRicercaProdotto = baseUrl + "/jsp/RicercaProdottiUtente.jsp";
	
	List<Prodotto> listaProdotti = (List<Prodotto>)request.getAttribute("chiave_listaCarrello");
	Map<Integer, String> mappaImmagini = (Map<Integer, String>) request.getAttribute("chiave_mappaImmagini");
	request.setAttribute("chiave_listaCarrello", listaProdotti);
	String messaggioRisultatoRimuoviProdotto = (String) request.getAttribute("chiave_risultatoRisultatoRimuoviProdottoCarrello");
%>

<h1> Carrello utente </h1>

<%if(messaggioRisultatoRimuoviProdotto != null) {%>
	<p><%=messaggioRisultatoRimuoviProdotto %></p>
<%} %>

	<br></br>
	<br></br>
	
	<%if(!listaProdotti.isEmpty()) {%>
		<div style="text-align: center;">
			<a href="<%=urlProcediAllOrdine %>"><button class="big-button">Procedi all'ordine</button></a> &nbsp;
		</div>
	<%} %>


<!--TORNA ALLA HOME  -->
	<div class="wrapper">
		<a  class ="button" href="<%=homepageNegozioUrl %>">Torna alla home</a> &nbsp;
	</div>
	<svg style="visibility: hidden; position: absolute;" width="0" height="0" xmlns="http://www.w3.org/2000/svg" version="1.1">
    <defs>
        <filter id="goo"><feGaussianBlur in="SourceGraphic" stdDeviation="10" result="blur" />    
            <feColorMatrix in="blur" mode="matrix" values="1 0 0 0 0  0 1 0 0 0  0 0 1 0 0  0 0 0 19 -9" result="goo" />
            <feComposite in="SourceGraphic" in2="goo" operator="atop"/>
        </filter>
    </defs>
</svg>

<nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left" style="display:none;z-index:2;width:40%;min-width:300px;background-color:#f9dcc4" id="mySidebar">
	<a href="javascript:void(0)" onclick="w3_close()" class="w3-bar-item w3-button">Chiudi il Menu</a>
	<a href="<%=homepageNegozioUrl %>" onclick="w3_close()" class="w3-bar-item w3-button">Torna alla home</a>

	<a href="<%=urlOrdini %>" onclick="w3_close()" class="w3-bar-item w3-button">Ordini</a>
	<a href="<%=urlRicercaProdotto %>" onclick="w3_close()" class="w3-bar-item w3-button">Ricerca Prodotto</a>
	
	<a href="<%=urlLogout %>" onclick="w3_close()" class="w3-bar-item w3-button">Logout</a>
</nav>

<div class="w3-top">
	<div class="w3-white w3-xlarge" style="max-width:1200px;margin:left; background-color: #E0AFA0;">
		<div class="w3-button w3-padding-16 w3-left" onclick="w3_open()">☰</div>
		<div class="w3-center w3-padding-16"style=" font-family: 'Nanum Myeongjo', serif; color: #7f5539">CARRELLO</div>
	</div>
</div>

 <%if(listaProdotti != null && listaProdotti.size()==0) {%> 	
 		<p> Carrello vuoto </p>
	<% } else{ %> 
	<div class="container">
	<table>
	<thead>
		<tr><th>Nome</th><th>Disponibiità</th><th>Prezzo</th><th>Immagine</th><th>Rimuovi dal carrello</th></tr>
	</thead>
	<tbody>
		<%for(Prodotto p : listaProdotti) {%>
			<%if(p.isCancellato() == false) { %>		
			<tr><td><%= p.getNome()%></td><td><%=p.getDisponibilita() %></td><td><%= p.getPrezzo() %> €</td> <td><img alt="" src="<%= mappaImmagini.get(p.getId()) %>" width="100" height="100" ></td>
				<td>
					<form action="<%=urlRimuovi %>" method="POST" class="beige-button">
						<input type="hidden" name="id" value="<%=p.getId() %>">
						<input type="submit" value="rimuovi">
					</form>
				</td>
			</tr>
			<%} %>	
		<%} %>
		</tbody>
		</table>
		</div>
	<%} %>


	<script>
	// Script to open and close sidebar
	function w3_open() {
	document.getElementById("mySidebar").style.display = "block";
	}
             
	function w3_close() {
	document.getElementById("mySidebar").style.display = "none";
	}
</script>

</body>
</html>


