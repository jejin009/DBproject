<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%
 int session_ID = Integer.parseInt((String) session.getAttribute("user"));
 String c_id_no = request.getParameter("c_id_no"); 
 String c_id = request.getParameter("c_id");
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
	mySQL = "DELETE FROM PICK where c_id='" + c_id +"' and s_id=" + session_ID + "and c_id_no='" + c_id_no+"'";
	myResultSet = stmt.executeQuery(mySQL);
	%>
	<script>
	alert("장바구니 취소완료");
		location.href = "mypick.jsp";
	</script>
	<%
	stmt.close();
	myConn.close();
	}

  catch(Exception e){
  out.println(e);
 }
 %>
 