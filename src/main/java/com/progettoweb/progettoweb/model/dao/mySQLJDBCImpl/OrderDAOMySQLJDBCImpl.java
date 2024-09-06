package com.progettoweb.progettoweb.model.dao.mySQLJDBCImpl;

import com.progettoweb.progettoweb.model.dao.OrderDAO;
import com.progettoweb.progettoweb.model.dao.exception.DuplicatedObjectException;
import com.progettoweb.progettoweb.model.mo.Utente;
import com.progettoweb.progettoweb.model.mo.Prodotto;
import com.progettoweb.progettoweb.model.mo.Order;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class OrderDAOMySQLJDBCImpl implements OrderDAO {

    Connection conn;

    public OrderDAOMySQLJDBCImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public Order create(
            Utente user,
            Prodotto prodotto,
            Long quantity,
            String status,
            Timestamp timestamp,
            BigDecimal total_amount
    ){

        PreparedStatement ps;
        Order order = new Order();
        order.setUser(user);
        order.setProduct(prodotto);
        order.setQuantity(quantity);
        order.setStatus(status);
        order.setTimestamp(timestamp);
        order.setTotalAmount(total_amount);

        try {
            String sql
                    = " INSERT INTO `ordine` "
                    + "   ( Id_utente,"
                    + "     Id_prod,"
                    + "     Quantità,"
                    + "     Stato,"
                    + "     `Timestamp`,"
                    + "     Totale,"
                    + "     Deleted "
                    + "   ) "
                    + " VALUES (?,?,?,?,?,?,'0')";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, order.getUser().getId_utente());
            ps.setLong(i++, order.getProduct().getId_prod());
            ps.setLong(i++, order.getQuantity());
            ps.setString(i++, order.getStatus());
            ps.setTimestamp(i++, order.getTimestamp());
            ps.setBigDecimal(i++, order.getTotalAmount());

            ps.executeUpdate();
        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return order;
    }

    @Override
    public List<Order> findOrders(Utente user) {

        PreparedStatement ps;
        Order order;
        ArrayList<Order> order_tuples = new ArrayList<Order>();

        try {

            Long user_id = user.getId_utente();
            String sql
                    = " SELECT *"
                    + " FROM `ordine`"
                    + " WHERE "
                    + " Deleted ='0' AND"
                    + " Id_utente = ? "
                    + " ORDER BY timestamp DESC ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, user_id);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                order = read(resultSet);
                order_tuples.add(order);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return order_tuples;
    }

    @Override
    public List<Order> findBySingleOrder(Utente user, Timestamp timestamp) {

        PreparedStatement ps;
        Order order;
        ArrayList<Order> order_tuples = new ArrayList<Order>();

        try {

            Long user_id = user.getId_utente();
            String sql
                    = " SELECT *"
                    + " FROM `ordine`"
                    + " WHERE "
                    + " Deleted ='0' AND"
                    + " timestamp = ? AND"
                    + " Id_utente = ? ";

            ps = conn.prepareStatement(sql);
            ps.setTimestamp(1, timestamp);
            ps.setLong(2, user_id);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                order = read(resultSet);
                order_tuples.add(order);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return order_tuples;
    }

    @Override
    public void updateStatus(Utente user, Timestamp timestamp, String status) {

        PreparedStatement ps;
        Order order;
        ArrayList<Order> order_tuples = new ArrayList<Order>();

        try {

            Long user_id = user.getId_utente();
            String sql
                    = " SELECT *"
                    + " FROM `ordine`"
                    + " WHERE "
                    + " Deleted ='0' AND"
                    + " timestamp = ? AND"
                    + " Id_utente = ? ";

            ps = conn.prepareStatement(sql);
            ps.setTimestamp(1, timestamp);
            ps.setLong(2, user_id);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                order = read(resultSet);
                order_tuples.add(order);
            }

            resultSet.close();

            sql
                    = " UPDATE `ordine` "
                    + " SET "
                    + " Stato = ?"
                    + " WHERE "
                    + " Deleted ='0' AND"
                    + " timestamp = ? AND"
                    + " Id_utente = ? ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setString(i++, status);
            ps.setTimestamp(i++, timestamp);
            ps.setLong(i++, user_id);

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    Order read(ResultSet rs) {
        Order order = new Order();
        Utente user = new Utente();
        order.setUser(user);
        Prodotto prodotto = new Prodotto();
        order.setProduct(prodotto);

        try {
            order.setOrderId(rs.getLong("order_id"));
        } catch (SQLException sqle) {
        }
        try {
            order.getUser().setId_utente(rs.getLong("Id_utente"));
        } catch (SQLException sqle) {
        }
        try {
            order.getProduct().setId_prod(rs.getLong("Id_prod"));
        } catch (SQLException sqle) {
        }
        try {
            order.setQuantity(rs.getLong("Quantità"));
        } catch (SQLException sqle) {
        }
        try {
            order.setStatus(rs.getString("Stato"));
        } catch (SQLException sqle) {
        }
        try {
            order.setTimestamp(rs.getTimestamp("Timestamp"));
        } catch (SQLException sqle) {
        }
        try {
            order.setTotalAmount(rs.getBigDecimal("Totale"));
        } catch (SQLException sqle) {
        }
        try {
            order.setDeleted(rs.getString("Deleted").equals("1"));
        } catch (SQLException sqle) {
        }
        return order;
    }
}