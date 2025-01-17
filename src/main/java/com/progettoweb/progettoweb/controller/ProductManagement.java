package com.progettoweb.progettoweb.controller;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.progettoweb.progettoweb.model.dao.mySQLJDBCImpl.ProdottoDAOMySQLJDBCImpl;
import com.progettoweb.progettoweb.services.config.Configuration;
import com.progettoweb.progettoweb.services.logservice.LogService;

import com.progettoweb.progettoweb.model.mo.Utente;
import com.progettoweb.progettoweb.model.mo.Prodotto;
import com.progettoweb.progettoweb.model.dao.DAOFactory;
import com.progettoweb.progettoweb.model.dao.UtenteDAO;
import com.progettoweb.progettoweb.model.dao.ProdottoDAO;
import com.progettoweb.progettoweb.model.dao.exception.DataTruncationException;
import com.progettoweb.progettoweb.model.dao.exception.DuplicatedObjectException;
import java.math.BigDecimal;
public class ProductManagement extends HttpServlet {
    private ProdottoDAO prodottoDAO;
    private ProductManagement() { }

    public static void view(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        Utente loggedUser;
        String applicationMessage = null;

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

            List<Prodotto> products = productRetrieve(daoFactory, sessionDAOFactory, request);

            int maxViewSize;
            if(products.size() < 8) {
                maxViewSize = products.size();
            } else{
                maxViewSize = 8;
            }
            try {
                maxViewSize = Integer.parseInt(request.getParameter("maxViewSize"));
            } catch(NumberFormatException | NullPointerException e) { }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("maxViewSize", maxViewSize);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "productManagement/view");

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

    public static void viewManagement(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        Utente loggedUser;
        String applicationMessage = null;

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

            List<Prodotto> products = productRetrieve(daoFactory, sessionDAOFactory, request);

            int maxViewSize;
            if(products.size() < 8) {
                maxViewSize = products.size();
            } else{
                maxViewSize = 8;
            }
            try {
                maxViewSize = Integer.parseInt(request.getParameter("maxViewSize"));
            } catch(NumberFormatException | NullPointerException e) { }

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("maxViewSize", maxViewSize);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "adminManagement/productManagement");

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

    public static void insertView(HttpServletRequest request, HttpServletResponse response) {

            DAOFactory sessionDAOFactory=null;
            Utente loggedUser;
            Logger logger = LogService.getApplicationLogger();

            try {

                Map sessionFactoryParameters=new HashMap<String,Object>();
                sessionFactoryParameters.put("request",request);
                sessionFactoryParameters.put("response",response);
                sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
                sessionDAOFactory.beginTransaction();

                UtenteDAO sessionUserDAO = sessionDAOFactory.getUtenteDAO();
                loggedUser = sessionUserDAO.findLoggedUser();

                request.setAttribute("loggedOn",loggedUser!=null);
                request.setAttribute("loggedUser", loggedUser);
                request.setAttribute("viewUrl", "adminManagement/prodInsView");

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

    public static void insert(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        Utente loggedUser;

        Logger logger = LogService.getApplicationLogger();

        try {

            Map sessionFactoryParameters=new HashMap<String,Object>();
            sessionFactoryParameters.put("request",request);
            sessionFactoryParameters.put("response",response);
            sessionDAOFactory = DAOFactory.getDAOFactory(Configuration.COOKIE_IMPL,sessionFactoryParameters);
            sessionDAOFactory.beginTransaction();

            daoFactory = DAOFactory.getDAOFactory(Configuration.DAO_IMPL,null);
            daoFactory.beginTransaction();

            UtenteDAO sessionUserDAO = sessionDAOFactory.getUtenteDAO();
            loggedUser = sessionUserDAO.findLoggedUser();

            ProdottoDAO prodottoDAO = daoFactory.getProdottoDAO();

            String availabilityStr=request.getParameter("Quantità");
            if(availabilityStr==null ||availabilityStr.isEmpty()) {
                throw new IllegalArgumentException("Quantità is missing or is empty");
            }
            BigDecimal price = new BigDecimal(request.getParameter("Prezzo"));
            int avalaibility = Integer.parseInt(availabilityStr);

            String photo = request.getParameter("URL");
            //se la foto non è inserita metto di deafault quest
            if(photo.isEmpty()){
                photo = "https://media.istockphoto.com/id/1472933890/vector/no-image-vector-symbol-missing-available-icon-no-gallery-for-this-moment-placeholder.jpg?s=612x612&w=0&k=20&c=Rdn-lecwAj8ciQEccm0Ep2RX50FCuUJOaEM8qQjiLL0=" ;
            }


            try {

                prodottoDAO.create(
                        request.getParameter("Nome"),
                        request.getParameter("Descrizione"),
                        price,
                        avalaibility,
                        request.getParameter("Categoria"),
                        //request.getParameter("Blocked"),
                        photo
                );

            } catch (DuplicatedObjectException e) {
                applicationMessage = "Vino già esistente";
                logger.log(Level.INFO, "Tentativo di inserimento di vino già esistente");
            } catch (DataTruncationException e) {
                applicationMessage = "importo massimo consentito: sei cifre intere e due decimali.";
            }

            productRetrieve(daoFactory, sessionDAOFactory, request);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "adminManagement/productManagement");

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

    public static void modifyView(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory=null;
        DAOFactory daoFactory = null;
        Utente loggedUser;

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

            Long id_prod = Long.parseLong(request.getParameter("id_prod"));

            ProdottoDAO prodottoDAO = daoFactory.getProdottoDAO();
            Prodotto prodotto = prodottoDAO.findByProdId(id_prod);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("prodotto", prodotto);
            request.setAttribute("viewUrl", "adminManagement/prodModView");

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

    public static void modify(HttpServletRequest request, HttpServletResponse response) {

        DAOFactory sessionDAOFactory= null;
        DAOFactory daoFactory = null;
        String applicationMessage = null;
        Utente loggedUser;

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

            Long id_prod = Long.parseLong(request.getParameter("id_prod"));

            ProdottoDAO prodottoDAO = daoFactory.getProdottoDAO();
            Prodotto prodotto = prodottoDAO.findByProdId(id_prod);
            if(prodotto==null){
                logger.log(Level.INFO, "Prodotto non trovato, errore nella retrieve");
            }

            String availabilityStr=request.getParameter("Quantità");
            if(availabilityStr==null || availabilityStr.isEmpty()) {
                throw new IllegalArgumentException("Quantità is missing or is empty");
            }
            BigDecimal price = new BigDecimal(request.getParameter("Prezzo"));
            int avalaibility = Integer.parseInt(availabilityStr);

            String photo = request.getParameter("URL");
            //se la foto non è inserita metto di deafault quest
            if(photo.isEmpty()){
                photo = "https://media.istockphoto.com/id/1472933890/vector/no-image-vector-symbol-missing-available-icon-no-gallery-for-this-moment-placeholder.jpg?s=612x612&w=0&k=20&c=Rdn-lecwAj8ciQEccm0Ep2RX50FCuUJOaEM8qQjiLL0=" ;
            }

            prodotto.setNome_prod(request.getParameter("Nome"));
            prodotto.setDescrizione(request.getParameter("Descrizione"));
            prodotto.setPrezzo(price);
            prodotto.setQuantita_disponibile(avalaibility);
            prodotto.setCategoria(request.getParameter("Categoria"));
            prodotto.setImg_path(photo);

            try {
                prodottoDAO.modify(prodotto);
                applicationMessage = "Modifica avvenuta correttamente";
            } catch (DuplicatedObjectException e) {
                applicationMessage = "Prodotto già esistente";
                logger.log(Level.INFO, "Tentativo di inserimento di prodotto già esistente");
            } catch (DataTruncationException e) {
                applicationMessage = "Errore nella modifica del prezzo: importo massimo consentito: sei cifre intere e due decimali.";
                logger.log(Level.INFO, "Importo massimo consentito: sei cifre intere e due decimali.");
            }

            productRetrieve(daoFactory, sessionDAOFactory, request);

            daoFactory.commitTransaction();
            sessionDAOFactory.commitTransaction();

            productRetrieve(daoFactory, sessionDAOFactory, request);

            request.setAttribute("loggedOn",loggedUser!=null);
            request.setAttribute("loggedUser", loggedUser);
            request.setAttribute("applicationMessage", applicationMessage);
            request.setAttribute("viewUrl", "adminManagement/productManagement");

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


    public static void delete(HttpServletRequest request, HttpServletResponse response) {

            DAOFactory sessionDAOFactory= null;
            DAOFactory daoFactory = null;
            Utente loggedUser;

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

                Long id_prod = Long.parseLong(request.getParameter("id_prod"));

                ProdottoDAO prodDAO = daoFactory.getProdottoDAO();
                Prodotto prod = prodDAO.findByProdId(id_prod);

                //faccio la delete e catcho la Null pointer exception che avviene nel
                //caso un utente aggiorni la pagina dopo aver cliccato sul pulsante cestino
                try{
                    prodDAO.delete(prod);
                }
                catch(NullPointerException e){
                    request.setAttribute("viewUrl", "adminManagement/view");
                }

                productRetrieve(daoFactory, sessionDAOFactory, request);

                daoFactory.commitTransaction();
                sessionDAOFactory.commitTransaction();

                request.setAttribute("loggedOn",loggedUser!=null);
                request.setAttribute("loggedUser", loggedUser);
                request.setAttribute("viewUrl", "adminManagement/productManagement");

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

        public static void searchView(HttpServletRequest request, HttpServletResponse response) {

            DAOFactory sessionDAOFactory= null;
            DAOFactory daoFactory = null;
            Utente loggedUser;

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

                prodSearch(daoFactory, sessionDAOFactory, request);

                daoFactory.commitTransaction();
                sessionDAOFactory.commitTransaction();

                request.setAttribute("loggedOn",loggedUser!=null);
                request.setAttribute("loggedUser", loggedUser);
                request.setAttribute("viewUrl", "adminManagement/productManagement");

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

    public static List<Prodotto> productRetrieve(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

        ProdottoDAO prodDAO = daoFactory.getProdottoDAO();
        List<Prodotto> products;
        products = prodDAO.findAll();
        request.setAttribute("products", products);
        return products;

    }
    private static void prodSearch(DAOFactory daoFactory, DAOFactory sessionDAOFactory, HttpServletRequest request) {

            ProdottoDAO wineDAO = daoFactory.getProdottoDAO();
            List<Prodotto> products;
            products = wineDAO.findByName(request.getParameter("searchString"));
            request.setAttribute("products", products);
    }

}

