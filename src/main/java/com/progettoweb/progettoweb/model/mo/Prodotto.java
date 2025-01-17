package com.progettoweb.progettoweb.model.mo;
import java.math.BigDecimal;

public class Prodotto {
    private Long id_prod;
    private String nome_prod;
    private String descrizione;
    private BigDecimal prezzo;
    private int quantita_disponibile;
    private String categoria;
    private boolean deleted_prod;
    private boolean blocked_prod;
    private String img_path;

    /*1:N*/
    private Cart[] carts;

    public Cart[] getCarts() { return carts; }

    public void setCarts(Cart[] carts) {this.carts = carts; }

    public Cart getCarts(int index) { return this.carts[index]; }

    public void setCarts(int index, Cart carts) {this.carts[index] = carts; }
    public Long getId_prod() {return id_prod;}
    public void setId_prod(Long id_prod){this.id_prod=id_prod;}
    public String getNome_prod() {return nome_prod;}
    public void setNome_prod(String nome_prod){this.nome_prod=nome_prod;}

    public String getDescrizione() {return descrizione;}
    public void setDescrizione(String descrizione){this.descrizione=descrizione;}
    public BigDecimal getPrezzo() {return prezzo;}
    public void setPrezzo(BigDecimal prezzo){this.prezzo=prezzo;}
    public int getQuantita_disponibile() {return quantita_disponibile;}
    public void setQuantita_disponibile(int quantita_disponibile){this.quantita_disponibile = quantita_disponibile;}
    public String getCategoria() {return categoria;}
    public void setCategoria(String categoria){this.categoria=categoria;}
    public boolean isDeleted_prod() {return deleted_prod;}
    public void setDeleted_prod(boolean deleted_prod){this.deleted_prod=deleted_prod;}
    public boolean isBlocked_prod() {return blocked_prod;}
    public void setBlocked_prod(boolean blocked_prod){this.blocked_prod=blocked_prod;}
    public String getImg_path() {return img_path;}
    public void setImg_path(String img_path){this.img_path=img_path;}
}
