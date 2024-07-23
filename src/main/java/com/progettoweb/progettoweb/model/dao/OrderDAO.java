package com.progettoweb.progettoweb.model.dao;

import com.progettoweb.progettoweb.model.mo.Order;
import com.progettoweb.progettoweb.model.mo.Utente;
import com.progettoweb.progettoweb.model.mo.Prodotto;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public interface OrderDAO {

    public Order create(
            Utente user,
            Prodotto prodotto,
            Long quantity,
            String status,
            Timestamp timestamp,
            BigDecimal total_amount
    );

    public List<Order> findOrders(Utente user);

    public List<Order> findBySingleOrder(Utente user, Timestamp timestamp);

    public void updateStatus(Utente user, Timestamp timestamp, String status);
}
