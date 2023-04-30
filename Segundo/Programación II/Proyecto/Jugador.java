import java.util.ArrayList;
import java.util.Collections;

public class Jugador {

  private String nombreJ;
  private int idJ;
  private boolean mano = false;
  public ArrayList <Carta> cartas = new ArrayList <Carta> ();
  private int puntosJ = 0;
  private int piedrasJ = 0;


  public Jugador (int id, String nom) {
    nombreJ = nom;
    idJ = id;
  }



  public void calculaPuntosJ () {
    for (int i = 0; i < 4; i++) {
      puntosJ += cartas.get (i).getPuntos ();
    }
  }



  public void masPuntos (int nPuntos) {
    puntosJ += nPuntos;
  }



  public int getPuntos () {
    return puntosJ;
  }



  public void masPiedras (int nPiedras) {
    piedrasJ += nPiedras;
  }



  public void resetPiedras () {
    piedrasJ = 0;
  }



  public int getPiedrasJ () {
    return piedrasJ;
  }



  public String getNombreJ () {
    return nombreJ;
  }



  public int getIdJ () {
    return idJ;
  }



  public boolean getMano () {
    return mano;
  }



  public void setMano (boolean nMano) {
    mano = nMano;
  }
}
