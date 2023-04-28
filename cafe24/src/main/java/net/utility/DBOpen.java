package net.utility;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBOpen {
 
  public Connection getConnection() {
   
    /* 카페24 MySQL DB연결 정보 */
    String url      = "jdbc:mysql://localhost/sssooon";
    String user     = "sssooon";
    String password = "chqkqsiasia7!";
    String driver   = "org.gjt.mm.mysql.Driver";   
   
    Connection con = null;
   
    try {
     
      Class.forName(driver);
      con = DriverManager.getConnection(url, user, password);
     
    }catch (Exception e) {
      System.out.println("DB 연결 실패: "+e);
    }
   
    return con;   
   
  }//end
 
 
}//class end