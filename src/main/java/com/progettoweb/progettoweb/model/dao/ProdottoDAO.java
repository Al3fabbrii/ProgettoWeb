package com.progettoweb.progettoweb.model.dao;

import java.math.BigDecimal;

import com.progettoweb.progettoweb.model.dao.exception.DataTruncationException;
import com.progettoweb.progettoweb.model.dao.exception.DuplicatedObjectException;
import com.progettoweb.progettoweb.model.mo.Prodotto;
import java.util.List;

public interface ProdottoDAO {
    Prodotto create(
            //Long id_prod,
            String nome_prod,
            String descrizione,
            BigDecimal prezzo,
            int quantita_disponibile,
            String categoria,
            //boolean deleted_prod,
            //boolean blocked_prod
            String img_path
    )throws DuplicatedObjectException, DataTruncationException;
    public void updateAvalaibility(Long id_prod, int quantita_disponibile);
    public void delete(Prodotto prodotto);
    public List<Prodotto> findAll();
    public Prodotto findByProdId(Long id_prod);

    public List<Prodotto> findByName(String nome_prod);
    public void modify(Prodotto prodotto)  throws DuplicatedObjectException, DataTruncationException;

}
