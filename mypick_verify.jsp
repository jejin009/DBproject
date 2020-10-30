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
	%>
	<%
		Connection myConn = null;
		String result = null;

		String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
		String user = "jdb";
		String passwd = "0000";
		String dbdriver = "oracle.jdbc.driver.OracleDriver";
		try {
			Class.forName(dbdriver);
			myConn = DriverManager.getConnection(dburl, user, passwd);
		} catch (SQLException ex) {
			System.err.println("SQLException: " + ex.getMessage());
		}
		
		
		CallableStatement cstmt = myConn.prepareCall("{call InsertPick(?,?,?,?)}");
		cstmt.setInt(1, s_id);
		cstmt.setString(2, c_id);
		cstmt.setString(3, c_id_no);
		cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);

		try {
			cstmt.execute();
			result = cstmt.getString(4);

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
	</form>
</body>
</html>