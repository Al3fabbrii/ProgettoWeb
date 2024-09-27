package com.progettoweb.progettoweb.controller;

import com.progettoweb.progettoweb.model.dao.*;
import com.progettoweb.progettoweb.model.dao.exception.DuplicatedObjectException;
import com.progettoweb.progettoweb.model.mo.*;
import com.progettoweb.progettoweb.services.config.Configuration;
import com.progettoweb.progettoweb.services.logservice.LogService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

import java.sql.Timestamp;
import java.math.BigDecimal;

public class CheckoutManagement {

    public static void view(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        Utente loggedUser;
        String applicationMessage = null;
        String viewUrl = "checkoutManagement/view";

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            UtenteDAO sessionUserDAO = sessionDAOFactory.getUtenteDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            cartRetrieve(daoFactory, sessionDAOFactory, request);

            List<Cart> carts = (List<Cart>) request.getAttribute("carts");
            for(int i = 0; i < carts.size(); i++) {
                if(carts.get(i).getQuantity() > carts.get(i).getProdotto().getQuantita_disponibile()) {
                    applicationMessage = "Errore: la quantita' richiesta di " + carts.get(i).getProdotto().getNome_prod() + " eccede la quantita' disponibile in magazzino";
                    viewUrl = "cartManagement/view";
                }
            }

            UtenteDAO userDAO = daoFactory.getUtenteDAO();
            Utente user = userDAO.findByUserId(loggedUser.getId_utente());

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("user", user);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", viewUrl);

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Controller Error", e);
            try {
                if (sessionDAOFactory != null) sessionDAOFactory.rollbackTransaction();
            } catch (Throwable t) {
            }
            throw new RuntimeException(e);

        } finally {
            try {
                if (sessionDAOFactory != null) sessionDAOFactory.closeTransaction();
            } catch (Throwable t) {
            }
        }
    }

    public static void order(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory = null;
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        Utente loggedUser;

        Logger logger = LogService.getApplicationLogger();

        try {
            Map sessionFactoryParameters = new HashMap<String,Object>();
            sessionFactoryParameters.put("request", request);
            sessionFactoryParameters.put("response", response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL, sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL, null);
            daoFactory.beginTransaction();

            UtenteDAO sessionUserDAO = sessionDAOFactory.getUtenteDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            OrderDAO orderDAO = daoFactory.getOrderDAO();

            cartRetrieve(daoFactory, sessionDAOFactory, request);
            List<Cart> carts = (List<Cart>) request.getAttribute("carts");

            Long user_id = loggedUser.getId_utente();
            UtenteDAO userDAO = daoFactory.getUtenteDAO();
            Utente current_user = userDAO.findByUserId(user_id);
            Date date = new Date();
            Timestamp ts = new Timestamp(date.getTime());

            BigDecimal total_amount = (BigDecimal) request.getAttribute("total_amount");

            String status = "Processamento ordine";

            ProdottoDAO prodottoDAO = daoFactory.getProdottoDAO();

            boolean orderSuccessful = true;

            for (Cart cart : carts) {
                Prodotto prodotto = cart.getProdotto();
                long quantity = cart.getQuantity();

                // Start of optimistic locking
                int retries = 3;
                while (retries > 0) {
                    try {
                        // Check if the product is still available
                        prodotto = prodottoDAO.findByProdIdForUpdate(prodotto.getId_prod());
                        if (prodotto.getQuantita_disponibile() < quantity) {
                            throw new SQLException("Not enough stock for product: " + prodotto.getNome_prod());
                        }

                        // Create the order
                        orderDAO.create(current_user, prodotto, quantity, status, ts, total_amount);

                        // Update product availability
                        prodottoDAO.updateAvalaibility(prodotto.getId_prod(), prodotto.getQuantita_disponibile() - (int) quantity);

                        // If we get here, the operation was successful
                        break;
                    } catch (SQLException e) {
                        retries--;
                        if (retries == 0) {
                            // If we've run out of retries, mark the order as failed and break the loop
                            orderSuccessful = false;
                            applicationMessage = "Errore: " + e.getMessage() + ". Riprova più tardi.";
                            break;
                        }
                        // If we still have retries, wait a bit before trying again
                        try {
                            Thread.sleep(100);
                        } catch (InterruptedException ie) {
                            Thread.currentThread().interrupt();
                        }
                    }
                }

                if (!orderSuccessful) {
                    break;
                }
            }

            if (orderSuccessful) {
                // Empty the cart only if the order was successful
                CartDAO cartDAO = daoFactory.getCartDAO();
                cartDAO.deleteCart(current_user);

                applicationMessage = "Ordine effettuato. Controlla gli ordini effettuati nella tua area personale.";
                daoFactory.commitTransaction();
            } else {
                daoFactory.rollbackTransaction();
            }

            sessionDAOFactory.commitTransaction();

            productRetrieve(daoFactory, sessionDAOFactory, request);
            showcaseProductRetrieve(daoFactory, sessionDAOFactory, request);

            request.setAttribute("loggedOn", loggedUser != null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "homeManagement/view");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Controller Error", e);
            try {
                if (daoFactory != null) daoFactory.rollbackTransaction();
                if (sessionDAOFactory != null) sessionDAOFactory.rollbackTransaction();
            } catch (Throwable t) {
            }
            throw new RuntimeException(e);

        } finally {
            try {
                if (daoFactory != null) daoFactory.closeTransaction();
                if (sessionDAOFactory != null) sessionDAOFactory.closeTransaction();
            } catch (Throwable t) {
            }
        }
    }


    private static void productRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        ProdottoDAO prodottoDAO = daoFactory.getProdottoDAO();
        List<Prodotto> products;
        ProdottoDAO ProdottoDAO = daoFactory.getProdottoDAO();
        products = ProdottoDAO.findAll();
        request.setAttribute("products", products);

    }

    private static void showcaseRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        ShowcaseDAO showcaseDAO = daoFactory.getShowcaseDAO();
        List<Showcase> showcases;
        showcases = showcaseDAO.findAll();
        request.setAttribute("showcases", showcases);

    }

    private static void showcaseProductRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        showcaseRetrieve(daoFactory, sessionDAOFactory, request);

        List<Prodotto> products = new ArrayList<Prodotto>();

        try {
            List<Showcase> showcases = (List<Showcase>)request.getAttribute("showcases");
            ProdottoDAO prodottoDAO = daoFactory.getProdottoDAO();
            Prodotto prodotto;

            for(int i = 0; i < showcases.size(); i++) {

                prodotto = prodottoDAO.findByProdId(showcases.get(i).getId_prod());
                products.add(prodotto);
            }
        } catch(Exception e) {  }

        if(!products.isEmpty()) {
            request.setAttribute("showcase_products", products);
        }

    }

    private static void cartRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        UtenteDAO userDAO = daoFactory.getUtenteDAO();
        UtenteDAO sessionUserDAO = sessionDAOFactory.getUtenteDAO();

        Utente loggedUser;
        loggedUser = sessionUserDAO.findLoggedUser();

        Utente user = userDAO.findByUserId(loggedUser.getId_utente());

        CartDAO cartDAO = daoFactory.getCartDAO();
        List<Cart> carts;
        carts = cartDAO.findCart(user);

        ProdottoDAO prodottoDAO = daoFactory.getProdottoDAO();
        Prodotto prodotto = null;
        ArrayList<Prodotto> produts = new ArrayList<Prodotto>() ;

        BigDecimal total_amount = BigDecimal.ZERO;
        BigDecimal subtotal = BigDecimal.ZERO;
        BigDecimal shipping = BigDecimal.ZERO;

        int i=0;
        for (i = 0; i < carts.size(); i++) {
            prodotto=prodottoDAO.findByProdId(carts.get(i).getProdotto().getId_prod());
            Long quantity = carts.get(i).getQuantity();
            produts.add(prodotto);
            subtotal = subtotal.add(prodotto.getPrezzo().multiply(new BigDecimal(quantity)));
            carts.get(i).setProdotto(prodotto);
        }

        total_amount = subtotal.multiply(new BigDecimal("1"));


        request.setAttribute("total_amount", total_amount);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("carts", carts);
    }

}