package com.progettoweb.progettoweb.model.dao.mySQLJDBCImpl;

import java.math.BigDecimal;
import java.security.Permission;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.progettoweb.progettoweb.model.dao.ProdottoDAO;
import com.progettoweb.progettoweb.model.dao.exception.DataTruncationException;
import com.progettoweb.progettoweb.model.dao.exception.DuplicatedObjectException;
import com.progettoweb.progettoweb.model.mo.Prodotto;

public class ProdottoDAOMySQLJDBCImpl implements ProdottoDAO {
    Connection conn;

    public ProdottoDAOMySQLJDBCImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public Prodotto create(
            //Long id_prod
            String nome_prod,
            String descrizione,
            BigDecimal prezzo,
            int quantita_disponibile,
            String categoria,
            //boolean deleted_prod
            //boolean blocked,
            String img_path) throws DuplicatedObjectException, DataTruncationException {

        PreparedStatement ps;
        Prodotto prod = new Prodotto();
        prod.setNome_prod(nome_prod);
        prod.setDescrizione(descrizione);
        prod.setPrezzo(prezzo);
        prod.setQuantita_disponibile(quantita_disponibile);
        prod.setCategoria(categoria);
        //prod.setblocked_prod(blocked);
        prod.setImg_path(img_path);

        try {

            String sql
                    = " SELECT * "
                    + " FROM prodotto "
                    + " WHERE "
                    + " Nome = ? AND"
                    + " Descrizione = ? AND"
                    + " Prezzo = ? AND"
                    + " Quantità = ? AND "
                    + " Categoria = ? AND "
                    + " img_path = ? ";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setString(i++, prod.getNome_prod());
            ps.setString(i++, prod.getDescrizione());
            ps.setBigDecimal(i++, prod.getPrezzo());
            ps.setInt(i++, prod.getQuantita_disponibile());
            ps.setString(i++, prod.getCategoria());
            //ps.setBoolean(i++, prod.isblocked_prod());
            ps.setString(i++, prod.getImg_path());

            ResultSet resultSet = ps.executeQuery();

            boolean exist;
            boolean deleted = true;
            Long retrived_prod_id = null;
            exist = resultSet.next();

            // leggo deleted e prod_id solo se esiste, altrimento ricevo nullPointer Exception
            if (exist) {
                deleted = resultSet.getString("Deleted").equals("1");
                retrived_prod_id = resultSet.getLong("Id_prod");
            }

            resultSet.close();

            if (exist && !deleted) {
                throw new DuplicatedObjectException("ProdottoDAOJDBCImpl.create: Tentativo di inserimento di un prodotto già esistente.");
            }

            if (exist && deleted){
                sql
                        = " UPDATE prodotto "
                        + " SET Deleted = '0' "
                        + " WHERE Id_prod = ? ";
                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setLong(i++, retrived_prod_id);
                ps.executeUpdate();
            }
            else {
                sql
                        = " INSERT INTO prodotto "
                        + "     (Nome,"
                        + "     Descrizione,"
                        + "     Prezzo,"
                        + "     Quantità,"
                        + "     Categoria,"
                        + "     img_path "
                        + "   ) "
                        + " VALUES (?,?,?,?,?,?)";

                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setString(i++, prod.getNome_prod());
                ps.setString(i++, prod.getDescrizione());
                ps.setBigDecimal(i++, prod.getPrezzo());
                ps.setInt(i++, prod.getQuantita_disponibile());
                ps.setString(i++, prod.getCategoria());
                ps.setString(i++, prod.getImg_path());

                try {
                    ps.executeUpdate();
                } catch(SQLException e) {
                    throw new RuntimeException(e);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return prod;
    }
    @Override
    public void modify(Prodotto prodotto) throws DuplicatedObjectException, DataTruncationException {
        PreparedStatement ps;
        try {

            String sql
                    = " SELECT Id_prod "
                    + " FROM prodotto "
                    + " WHERE "
//                    + " deleted ='N' AND "
                    + " Nome = ? AND"
                    + " Descrizione = ? AND"
                    + " Prezzo = ? AND"
                    + " Quantità = ? AND "
                    + " Categoria = ? AND "
                    + " img_path = ? AND "
                    + " Id_prod <> ?";

            ps = conn.prepareStatement(sql);
            int i = 1;
            ps.setString(i++, prodotto.getNome_prod());
            ps.setString(i++, prodotto.getDescrizione());
            ps.setBigDecimal(i++, prodotto.getPrezzo());
            ps.setInt(i++, prodotto.getQuantita_disponibile());
            ps.setString(i++, prodotto.getCategoria());
            ps.setString(i++, prodotto.getImg_path());
            ps.setLong(i++, prodotto.getId_prod());

            ResultSet resultSet = ps.executeQuery();

            boolean exist;
            boolean deleted = true;
            Long retrived_id_prod = null;
            exist = resultSet.next();

            // leggo deleted e id_prod solo se esiste, altrimento ricevo nullPointer Exception
            if (exist) {
                deleted = resultSet.getString("Deleted").equals("1");
                retrived_id_prod = resultSet.getLong("Id_prod");
            }

            if (exist) {
                throw new DuplicatedObjectException("ProdottoDAOJDBCImpl.create: Un prodotto con queste caratteristiche e' gia presente nel db.");
            }

            if (exist && deleted){
                sql = "update prodotto set Deleted='0' where Id_prod=?";
                ps = conn.prepareStatement(sql);
                i = 1;
                ps.setLong(i++, retrived_id_prod);
                ps.executeUpdate();
            }

            sql
                    = " UPDATE prodotto "
                    + " SET "
                    + " Nome = ?,"
                    + " Descrizione = ? ,"
                    + " Prezzo = ? ,"
                    + " Quantità = ? , "
                    + " Categoria = ? , "
                    + " img_path = ? "
                    + " WHERE "
                    + " Id_prod = ? ";


            ps = conn.prepareStatement(sql);
            i = 1;
            ps.setString(i++, prodotto.getNome_prod());
            ps.setString(i++, prodotto.getDescrizione());
            ps.setBigDecimal(i++, prodotto.getPrezzo());
            ps.setInt(i++, prodotto.getQuantita_disponibile());
            ps.setString(i++, prodotto.getCategoria());
            ps.setString(i++, prodotto.getImg_path());
            ps.setLong(i++, prodotto.getId_prod());

            try {
                ps.executeUpdate();
            } catch(SQLException e) {
                throw new DataTruncationException("Importo massimo consentito: sei cifre intere e due decimali.");
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    public void updateAvalaibility(Long id_prod, int quantita_disponibile) {
        PreparedStatement ps;
        try {

            Prodotto prod = null;
            String sql
                    = " SELECT *"
                    + " FROM prodotto "
                    + " WHERE "
                    + "Id_prod = ? AND "
                    + "Deleted = '0'";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, id_prod);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
                prod = read(resultSet);
            }
            resultSet.close();

            sql
                    = " UPDATE prodotto "
                    + " SET "
                    + " Quantità = ? "
                    + " WHERE "
                    + " Id_prod = ? ";

            int i = 1;
            ps = conn.prepareStatement(sql);
            ps.setInt(i++, prod.getQuantita_disponibile() - quantita_disponibile);
            ps.setLong(i++, id_prod);

            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    public void delete(Prodotto prod) {

        PreparedStatement ps;

        try {

            String sql
                    = " UPDATE prodotto "
                    + " SET deleted='1' "
                    + " WHERE "
                    + " Id_prod=?";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, prod.getId_prod());
            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    public Prodotto findByProdId(Long id_prod) {

        PreparedStatement ps;
        Prodotto prod = null;

        try {

            String sql
                    = " SELECT *"
                    + " FROM prodotto "
                    + " WHERE "
                    + "Id_prod = ? AND "
                    + "Deleted = '0'";

            ps = conn.prepareStatement(sql);
            ps.setLong(1, id_prod);

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next()) {
                prod = read(resultSet);
            }
            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return prod;
    }
    @Override
    public List<Prodotto> findByName(String name) {

        PreparedStatement ps;
        Prodotto prod;
        ArrayList<Prodotto> products = new ArrayList<Prodotto>();
        name = "%" + name + "%";

        try {

            String sql
                    = " SELECT *"
                    + " FROM prodotto "
                    + " WHERE "
                    + "nome LIKE ? AND "
                    + "deleted = '0'";

            ps = conn.prepareStatement(sql);
            ps.setString(1, name);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                prod = read(resultSet);
                products.add(prod);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return products;
    }
    @Override
    public List<Prodotto> findAll() {

        PreparedStatement ps;
        Prodotto product;
        ArrayList<Prodotto> products = new ArrayList<Prodotto>();

        try {

            String sql
                    = " SELECT *"
                    + " FROM prodotto"
                    + " WHERE "
                    + " deleted ='0'";

            ps = conn.prepareStatement(sql);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                product = read(resultSet);
                products.add(product);
            }

            resultSet.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return products;
    }
    Prodotto read(ResultSet rs) {
        Prodotto prod = new Prodotto();
        try {
            prod.setId_prod(rs.getLong("Id_prod"));
        } catch (SQLException sqle) {
        }
        try {
            prod.setNome_prod(rs.getString("Nome"));
        } catch (SQLException sqle) {
        }
        try {
            prod.setDescrizione(rs.getString("Descrizione"));
        } catch (SQLException sqle) {
        }
        try {
            prod.setPrezzo(rs.getBigDecimal("Prezzo"));
        } catch (SQLException sqle) {
        }
        try {
            prod.setQuantita_disponibile(rs.getInt("Quantità"));
        } catch (SQLException sqle) {
        }
        try {
            prod.setCategoria(rs.getString("Categoria"));
        } catch (SQLException sqle) {
        }
        try {
            prod.setDeleted_prod(rs.getString("deleted").equals("Y"));
        } catch (SQLException sqle) {
        }
        try {
            prod.setBlocked_prod(rs.getBoolean("blocked"));
        } catch (SQLException sqle) {
        }
        try {
            prod.setImg_path(rs.getString("img_path"));
        } catch (SQLException sqle) {
        }
        return prod;
    }
}
