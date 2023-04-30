import java.util.ArrayList;
import java.util.Collections;

public class Jugador {

  private String nombreJ;
  private int idJ;
  private static int contadorId = 0;
  private boolean mano = false;
  public ArrayList <Carta> cartas = new ArrayList <Carta> ();
  private int puntosJ = 0;


  public Jugador (String nom) {
    nombreJ = nom;
    idJ = contadorId;
    contadorId++;
  }


  public int getPuntos () {
    return puntosJ;
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


  public void ordenarCartas () {
    Collections.sort (cartas, new Ordenar ());
  }
}
