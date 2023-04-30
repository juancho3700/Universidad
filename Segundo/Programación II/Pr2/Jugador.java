public class Jugador {

  private String nombreJ;
  private int idJ;
  private static int contadorId = 0;
  private boolean mano = false;

  public Jugador (String nom){
    nombreJ = nom;
    idJ = contadorId;
    contadorId++;
  }

  public String getNombreJ (){
    return nombreJ;
  }

  public int getIdJ (){
    return idJ;
  }

  public boolean getMano (){
    return mano;
  }

  public void sumNCartas (){
    nCartas ++;
  }

  public void setMano (boolean nMano){
    mano = nMano;
  }
}
