<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<title>수강신청 입력</title>
</head>
<%@ include file="main.jsp" %>

<body>
	<%
		int s_id = Integer.parseInt((String) session.getAttribute("user"));
		String c_id = request.getParameter("c_id");
		String c_id_no = request.getParameter("c_id_no");
		int check = Integer.parseInt(request.getParameter("check_pick"));
	%>
	<%
		Connection myConn = null;
		String result = null;
		String result2 =null;
		String mySQL = null;
		Statement stmt = null;
		int succ = 0;

		String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
		String user = "jdb";
		String passwd = "0000";
		String dbdriver = "oracle.jdbc.driver.OracleDriver";
		try {
			Class.forName(dbdriver);
			myConn = DriverManager.getConnection(dburl, user, passwd);
			stmt = myConn.createStatement();
		} catch (SQLException ex) {
			System.err.println("SQLException: " + ex.getMessage());
		}
		
		
		CallableStatement cstmt = myConn.prepareCall("{call InsertEnroll(?,?,?,?)}");
		cstmt.setInt(1, s_id);
		cstmt.setString(2, c_id);
		cstmt.setString(3, c_id_no);
		cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
		
		CallableStatement cstmt2 = myConn.prepareCall("{Call insertPickEnroll(?,?,?,?,?)}");
		cstmt2.setInt(1, s_id);
		cstmt2.setString(2, c_id);
		cstmt2.setString(3, c_id_no);
		cstmt2.registerOutParameter(4, java.sql.Types.VARCHAR);
		cstmt2.registerOutParameter(5, java.sql.Types.NUMERIC);

		try {
			if(check == 1){
				cstmt2.execute();
				System.out.println("durl answp");
				result = cstmt2.getString(4);
				succ = cstmt2.getInt(5);
				check =0;
				if(succ ==1){
					mySQL = "DELETE FROM PICK where c_id=" + c_id +" and s_id=" + s_id + "and c_id_no='" + c_id_no+"'";
					ResultSet myResultSet = stmt.executeQuery(mySQL);
				}
			}
			else{
			cstmt.execute();
			result = cstmt.getString(4);
			}

	%>
	<script>
	alert("<%=result%>");
		location.href = "insert.jsp";
	</script>
	<%
		} catch (SQLException ex) {
			System.err.println("SQLException: " + ex.getMessage());
		} finally {
			if (cstmt != null)
				try {
					myConn.commit();
					cstmt.close();
					myConn.close();
				} catch (SQLException ex) {
				}
		}
	%>
	</body>
</html>

