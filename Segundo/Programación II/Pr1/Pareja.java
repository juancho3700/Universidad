public class Pareja {

  private String nombrePareja;
  private int idJ1;
  private int idJ2;
  private int idP;
  private static int contadorIdP = 0;

  public Pareja (String nom, int id1, int id2){
    nombrePareja = nom;
    idJ1 = id1;
    idJ2 = id2;
    idP = contadorIdP;
    contadorIdP++;
  }

  public int getIdP (){
    return idP;
  }

  public String getNombreP (){
    return nombrePareja;
  }
}
