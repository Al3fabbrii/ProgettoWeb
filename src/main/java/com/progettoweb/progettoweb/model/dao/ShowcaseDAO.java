package com.progettoweb.progettoweb.model.dao;

import com.progettoweb.progettoweb.model.dao.exception.DataTruncationException;
import com.progettoweb.progettoweb.model.dao.exception.DuplicatedObjectException;
import com.progettoweb.progettoweb.model.mo.Showcase;
import com.progettoweb.progettoweb.model.mo.Prodotto;

import java.util.List;

public interface ShowcaseDAO {

    public Showcase create(
            Long id_prod) throws DuplicatedObjectException;

    public List<Showcase> findAll();

    public void delete(Prodotto prodotto);
}
