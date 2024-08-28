package com.progettoweb.progettoweb.model.dao.mySQLJDBCImpl;

import com.progettoweb.progettoweb.model.dao.CartDAO;
import com.progettoweb.progettoweb.model.dao.exception.DuplicatedObjectException;
import com.progettoweb.progettoweb.model.mo.Cart;
import com.progettoweb.progettoweb.model.mo.Utente;
import com.progettoweb.progettoweb.model.mo.Prodotto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDAOMySQLJDBCImpl implements CartDAO {
    Connection conn;

    public CartDAOMySQLJDBCImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public Cart create(
            Utente user,
            Prodotto prodotto, long quantity) throws DuplicatedObjectException {

        PreparedStatement ps;
        Cart cart = new Cart();
        cart.setUser(user);
        cart.setProdotto(prodotto);
        cart.setQuantity(quantity);

        //controllo se esiste gia' una tupla con prod_id e user_id
        try {

            String sql
                    = " SELECT * "
                    + " FROM carrello "
                    + " WHERE "
                    + " Deleted ='0' AND "
                    + " Id_utente = ? AND"
                    + " Id_prod = ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, cart.getUser().getId_utente());
            ps.setLong(i++, cart.getProdotto().getId_prod());

            ResultSet resultSet = ps.executeQuery();

            boolean exist;
            Long oldquantity = null;
            Long existing_cart_id = null;
            exist = resultSet.next();
            if (exist){
                existing_cart_id = (resultSet.getLong("cart_id"));
                oldquantity = (resultSet.getLong("quantity"));
            }

            resultSet.close();

            if (exist) {
                try{
                    Long newquantity = oldquantity + 1;
                    sql
                            = " UPDATE carrello "
                            + " SET "
                            + " Quantità = ?"
                            + " WHERE "
                            + "   cart_id = ? ";

                    ps = conn.prepareStatement(sql);
                    i = 1;
                    ps.setLong(i++, newquantity);
                    ps.setLong(i++, existing_cart_id);

                    ps.executeUpdate();

                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }

                throw new DuplicatedObjectException("CartDAOJDBCImpl.create: Tentativo di creazione di un oggetto nel carrello gia esistente");
            }
            sql
                    = " INSERT INTO carrello "
                    + "     (Id_utente,"
                    + "     Id_prod,"
                    + "     Quantità,"
                    + "     Deleted "
                    + "   ) "
                    + " VALUES (?,?,1,'0')";

            ps = conn.prepareStatement(sql);
            i = 1;
            ps.setLong(i++, cart.getUser().getId_utente());
            ps.setLong(i++, cart.getProdotto().getId_prod());

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return cart;

    }

    @Override
    public Cart remove(
            Utente user,
            Prodotto prodotto) {

        PreparedStatement ps;
        Cart cart = new Cart();
        cart.setUser(user);
        cart.setProdotto(prodotto);

        try {

            String sql
                    = " SELECT * "
                    + " FROM carrello "
                    + " WHERE "
                    + " Deleted ='0' AND "
                    + " Id_utente = ? AND"
                    + " Id_prod = ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, cart.getUser().getId_utente());
            ps.setLong(i++, cart.getProdotto().getId_prod());

            ResultSet resultSet = ps.executeQuery();
            resultSet.next();

            Long oldquantity = (resultSet.getLong("quantity"));
            Long existing_cart_id = (resultSet.getLong("cart_id"));

            resultSet.close();

            Long newquantity = oldquantity - 1;
            // se newquantity è = a 0 allora elimino la tupla, altrimenti la aggiorno

            if(newquantity==0) {

                //elimino la tupla , setto anche la quantità = 0
                sql
                        = " UPDATE carrello "
                        + " SET "
                        + " Deleted = '1', "
                        + " Quantità = 0"
                        + " WHERE "
                        + "   cart_id = ? ";

                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setLong(i++, existing_cart_id);

                ps.executeUpdate();
            }

            //aggiorno la tupla con la nuova quantità
            sql
                    = " UPDATE carrello "
                    + " SET "
                    + " Quantità = ?"
                    + " WHERE "
                    + "   cart_id = ? ";

            ps = conn.prepareStatement(sql);
            i = 1;
            ps.setLong(i++, newquantity);
            ps.setLong(i++, existing_cart_id);

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return cart;
    }

    public Cart removeBlock(
            Utente user,
            Prodotto prodotto) {

        PreparedStatement ps;
        Cart cart = new Cart();
        cart.setUser(user);
        cart.setProdotto(prodotto);

        try {

            // recupero il cart_id
            String sql
                    = " SELECT * "
                    + " FROM carrello "
                    + " WHERE "
                    + " Deleted ='0' AND "
                    + " Id_utente = ? AND"
                    + " Id_prod = ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, cart.getUser().getId_utente());
            ps.setLong(i++, cart.getProdotto().getId_prod());

            ResultSet resultSet = ps.executeQuery();
            resultSet.next();

            Long existing_cart_id = (resultSet.getLong("cart_id"));

            resultSet.close();

            //elimino la tupla , setto anche la quantità = 0
            sql
                    = " UPDATE carrello "
                    + " SET "
                    + " Deleted = '1', "
                    + " Quantità = 0"
                    + " WHERE "
                    + "   cart_id = ? ";

            ps = conn.prepareStatement(sql);
            i = 1;
            ps.setLong(i++, existing_cart_id);

            ps.executeUpdate();


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return cart;
    }

    @Override
    public List<Cart> findCart(Utente user) {

        PreparedStatement ps;
        Cart cart;
        ArrayList<Cart> carts = new ArrayList<Cart>();

        try {

            Long user_id = user.getId_utente();
            String sql
                    = " SELECT *"
                    + " FROM carrello"
                    + " WHERE "
                    + " Deleted ='0' AND"
                    + " Id_utente = ? ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, user_id);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                cart = read(resultSet);
                carts.add(cart);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return carts;
    }

    @Override
    public void deleteCart( Utente user ) {

        PreparedStatement ps;
        Cart cart = new Cart();
        cart.setUser(user);

        try {


            //elimino le tuple con user_id corretto, setto anche la quantità = 0
            String sql
                    = " UPDATE carrello "
                    + " SET "
                    + " Deleted = '1', "
                    + " Quantità = 0"
                    + " WHERE "
                    + "   Id_utente = ? ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setLong(i++, user.getId_utente());

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    Cart read(ResultSet rs) {
        Cart cart = new Cart();
        Utente user = new Utente();
        cart.setUser(user);
        Prodotto prodotto = new Prodotto();
        cart.setProdotto(prodotto);

        try {
            cart.setCartId(rs.getLong("cart_id"));
        } catch (SQLException sqle) {
        }
        try {
            cart.getUser().setId_utente(rs.getLong("Id_utente"));
        } catch (SQLException sqle) {
        }
        try {
            cart.getProdotto().setId_prod(rs.getLong("Id_prod"));
        } catch (SQLException sqle) {
        }
        try {
            cart.setQuantity(rs.getLong("Quantità"));
        } catch (SQLException sqle) {
        }
        try {
            cart.setDeleted(rs.getString("Deleted").equals("1"));
        } catch (SQLException sqle) {
        }
        return cart;
    }
}