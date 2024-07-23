package com.progettoweb.progettoweb.model.dao;

import com.progettoweb.progettoweb.model.dao.exception.DuplicatedObjectException;
import com.progettoweb.progettoweb.model.mo.Cart;
import com.progettoweb.progettoweb.model.mo.Utente;
import com.progettoweb.progettoweb.model.mo.Prodotto;

import java.util.List;

public interface CartDAO {

    public Cart create(
            Utente user,
            Prodotto prodotto,
            long quantity
    ) throws DuplicatedObjectException;

    public List<Cart> findCart(Utente user);

    public Cart remove(Utente user, Prodotto prodotto);

    public Cart removeBlock(Utente user, Prodotto prodotto);

    public void deleteCart(Utente user);
}
