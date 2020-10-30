<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%
 String session_ID = (String)session.getAttribute("user");
 String c_class = request.getParameter("c_class"); 
 int c_id = Integer.parseInt(request.getParameter("c_id"));
 try{
	Connection myConn = null; 
	Statement stmt = null;	
	ResultSet myResultSet = null; 
	String mySQL = "";
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "jdb";
	String passwd = "0000";
	try {
		Class.forName(dbdriver);
	    myConn =  DriverManager.getConnection (dburl, user, passwd);
		stmt = myConn.createStatement();	
    } catch(SQLException ex) {
	     System.err.println("SQLException: " + ex.getMessage());
	}
	mySQL = "DELETE FROM enroll where c_id=" + c_id +" and s_id=" + session_ID + "and c_id_no='" + c_class+"'";
	myResultSet = stmt.executeQuery(mySQL);
	%>
	<script>
	alert("수강취소완료");
		location.href = "delete.jsp";
	</script>
	<%
	stmt.close();
	myConn.close();
	}

  catch(Exception e){
  out.println(e);
 }
 %>
 