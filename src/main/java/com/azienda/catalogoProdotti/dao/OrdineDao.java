package com.azienda.catalogoProdotti.dao;

import java.util.List;

import javax.persistence.EntityManager;

import com.azienda.catalogoProdotti.model.Ordine;
import com.azienda.catalogoProdotti.model.Utente;

public class OrdineDao implements DaoInterface<Ordine> {
	
	private EntityManager em;
	
	public OrdineDao(EntityManager em) {
		this.em = em;
	}

	@Override
	public void create(Ordine object) {
		this.em.persist(object);
	}

	@Override
	public List<Ordine> retrieve() {
		return this.em.createQuery("select o from Ordine o", Ordine.class).getResultList();
	}

	@Override
	public void update(Ordine object) {
		this.em.persist(object);
	}

	@Override
	public void delete(Ordine object) {
		this.em.remove(object);
	}
	
	/**
	 * 
	 */
	public List<Ordine> findOrdiniUtente(Utente u) {
		return this.em.createQuery("select o from Ordine o where o.utente = :idUtente", Ordine.class).
				setParameter("idUtente", u).getResultList();
	}

}
