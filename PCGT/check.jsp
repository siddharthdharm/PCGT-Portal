<% 

    /*--CODE WRITTEN BY SIDDHARTH DHARM. 
        LAST MODIFIED ON 20/06/2017.
        BITS PILANI HYDERABAD CAMPUS.--*/


    final String JDBC_DRIVER = "com.mysql.jdbc.Driver";         // JDBC Driver Name //
    final String DB_URL = "jdbc:mysql://localhost:3306/pcgt";   // URL of your Database //
    final String USER = "pcgt";                                 // Database credentials //
    final String PASS = "pcgt@mytrah";
    Connection conn = null;
    Statement stmt = null;
    
	try{

        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL,USER,PASS);

        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();
        int proceed = 0;

        String q = "SELECT COUNT(*) FROM `users` WHERE username = '"+username+"' AND password = '"+password+"';";
        stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(q);
        while (rs.next()) {
            if(rs.getInt("COUNT(*)") > 0) {
                proceed = 20;
            }
        }
        stmt.close();
        

        if(proceed == 20) {
            String site = new String("index.html");
            response.setStatus(response.SC_MOVED_TEMPORARILY);
            response.setHeader("Location", site);
        }

        else {
            out.print("<br>INVALID USERNAME OR PASSWORD!!");
        }

        conn.close();
    
    }catch(SQLException se){
    //Handle errors for JDBC
    se.printStackTrace();
    }catch(Exception e){
    //Handle errors for Class.forName
    e.printStackTrace();
    }finally{
    //finally block used to close resources
    try{
    if(stmt!=null)
    stmt.close();
    }catch(SQLException se2){
    }// nothing we can do
    try{
    if(conn!=null)
    conn.close();
    }catch(SQLException se){
    se.printStackTrace();
    }//end finally try
    }//end try
      
%>
<%@page import="java.io.*,java.util.*, javax.servlet.*, java.text.*, java.sql.*, javax.servlet.http.*, org.apache.commons.fileupload.servlet.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.*, org.apache.commons.io.output.*" %>




