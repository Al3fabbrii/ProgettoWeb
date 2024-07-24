package com.progettoweb.progettoweb.model.mo;

public class Utente {
    private Long id_utente;
    private String username;
    private String email;
    private String password;
    private String nome;
    private String cognome;
    private String indirizzo;
    private String stato;
    private String citta;
    private Long cap;
    private String admin;
    private String blocked;
    private String deleted;
    private String card_n;
    private Long cvc;
    private String exp_date;

    /*1:N*/
    private Cart[] carts;

    public String getUsername() {return username;}
    public void setUsername(String username) {this.username = username;}
    public Cart[] getCarts() { return carts; }

    public void setCarts(Cart[] carts) {this.carts = carts; }

    public Cart getCarts(int index) { return this.carts[index]; }

    public void setCarts(int index, Cart carts) {this.carts[index] = carts; }
    public Long getId_utente() {return id_utente;}
    public void setId_utente(Long id_utente){this.id_utente=id_utente;}
    public String getEmail() {return email;}
    public void setEmail(String email){this.email=email;}
    public String getPassword() {return password;}
    public void setPassword(String password){this.password=password;}
    public String getNome() {return nome;}
    public void setNome(String nome){this.nome=nome;}
    public String getCognome() {return cognome;}
    public void setCognome(String cognome){this.cognome=cognome;}
    public String getIndirizzo() {return indirizzo;}
    public void setIndirizzo(String indirizzo){this.indirizzo=indirizzo;}
    public String getStato() {return stato;}
    public void setStato(String stato){this.stato=stato;}
    public String getCitta() {return citta;}
    public void setCitta(String citta){this.citta=citta;}
    public Long getCap() {return cap;}
    public void setCap(Long cap){this.cap=cap;}

    public String getAdmin() {
        return admin;
    }

    public void setAdmin(String admin) {
        this.admin = admin;
    }

    public String getBlocked() {
        return blocked;
    }

    public void setBlocked(String blocked) {
        this.blocked = blocked;
    }

    public String getDeleted() {
        return deleted;
    }

    public void setDeleted(String deleted) {
        this.deleted = deleted;
    }
    public String getCard_n() { return card_n; }

    public void setCard_n(String card_n) { this.card_n = card_n;  }

    public Long getCvc() { return cvc; }

    public void setCvc(Long cvc) { this.cvc = cvc; }

    public String getExp_date() { return exp_date; }

    public void setExp_date(String exp_date) { this.exp_date = exp_date; }
}
