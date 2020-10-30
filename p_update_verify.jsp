<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%		
	request.setCharacterEncoding("UTF-8");
	Connection myConn = null;
  	Statement stmt = null;	
  	String mySQL = null;

  	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	Class.forName(dbdriver);
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "jdb";
	String passwd = "0000";
  	
	Class.forName(dbdriver);
  	myConn =  DriverManager.getConnection (dburl, user, passwd);
	request.setCharacterEncoding("utf-8");
	
  	int userid = Integer.parseInt(request.getParameter("userid"));
  	String pwd = request.getParameter("password");
	String tel = request.getParameter("tel");
	String office = request.getParameter("office");
	String email = request.getParameter("email");
	email =  new String(email.getBytes("8859_1"), "UTF-8");
	
	stmt = myConn.createStatement();                 
	
    mySQL = "update professor set p_pwd='"+pwd+"', p_tel='"+tel+"',p_office= '"+office+"', p_email='"+email+"' where p_id = " + userid;      
	
    try{
    stmt.executeUpdate(mySQL);
	
  		%>
	<script language=javascript>
		  	self.window.alert("정보 수정 완료");
		  	location.href="p_update.jsp";
	</script>
<%
    }catch(SQLException ex){
    	String sMessage;
    	if (ex.getErrorCode() == 20002) {
    		sMessage="암호는 4자리 이상이어야 합니다"; %>
    		<script>
    		alert("<%=sMessage%>"); 
    		location.href="p_update.jsp";
    		</script>
    	<%
    	}else if (ex.getErrorCode() == 20003) { 
    		sMessage="암호에 공란은 입력되지않습니다."; %>
    		<script>
    		alert("<%=sMessage%>"); 
    		location.href="p_update.jsp"; 
    		</script>
    		<%
    	}else {
    		sMessage="잠시 후 다시 시도하십시오"; %>
    		<script>
    		alert("<%=sMessage%>"); 
    		location.href="p_update.jsp"; 
    		</script>
    		<%
    	}
    }
%>