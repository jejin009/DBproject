<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>수업목록페이지</title>
<style type="text/css">
@import url('https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap&subset=korean');
*{font-family: 'Noto Sans KR';}
.resultTable { sans-serif;, monospace;, cursive;, cursive; font-size:12px;width:75%;border-width: 1px;border-color: #778597;border-collapse: collapse; margin:70px auto;}
.resultTable th {cursive; font-size:12px;background-color:#94A0AD;border-width: 1px;padding: 8px;border-style: solid;border-color: #778597;text-align:center;}
.resultTable tr { background-color:#ffffff;}
.resultTable td { cursive;font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #778597;}
.resultTable tr:hover {background-color:#E5EAED;}
.title {margin-left: auto; margin-right: auto; margin-top: 50px; width: 300px;}
.s2:link{color:#405784;}
.s2:visited{color:#405784;}
.s1{color:#ffffff;}
</style>
</head>
<body>
	<%@ include file="p_top.jsp"%>
	<%
		if (session_id == null)
			response.sendRedirect("login.jsp");
	%>
	<table class="resultTable">
		<tr>
			<th>과목번호</th>
			<th>분반</th>
			<th>과목명</th>
		</tr>
		<%
			Connection myConn = null;
			Statement stmt = null;
			ResultSet myResultSet = null;
			String mySQL = "";
			String mySQL2 = "";
			String mySQL3 = "";
			String dbdriver = "oracle.jdbc.driver.OracleDriver";
			String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
			String user = "jdb";
			String passwd = "0000";
			try {
				Class.forName(dbdriver);
				myConn = DriverManager.getConnection(dburl, user, passwd);
				stmt = myConn.createStatement();
			} catch (SQLException ex) {
				System.err.println("SQLException: " + ex.getMessage());
			}
			
			mySQL2 = "{? = call Date2EnrollYear(SYSDATE)}";
			CallableStatement cstmt = myConn.prepareCall(mySQL2);
			cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
			cstmt.execute();
			int nYear = cstmt.getInt(1);

			mySQL3 = "{? = call Date2EnrollSemester(SYSDATE)}";
			CallableStatement cstmt2 = myConn.prepareCall(mySQL3);
			cstmt2.registerOutParameter(1, java.sql.Types.INTEGER);
			cstmt2.execute();
			int nSemester = cstmt2.getInt(1);

			
			mySQL = "select c.c_id, c.c_id_no, c.c_name from course c, professor p where c.p_id=p.p_id and p.p_id=" + session_id +"and (c.c_id, c.c_id_no) IN (select c_id, c_id_no from teach where t_year ="
					+ nYear + " and t_semester =" + nSemester + ") order by c_id, c_id_no";
			myResultSet = stmt.executeQuery(mySQL);
			if (myResultSet != null) {
				while (myResultSet.next()) {
					int c_id = myResultSet.getInt("c_id");
					String c_id_no = myResultSet.getString("c_id_no");
					String c_name = myResultSet.getString("c_name");
		%>
		<tr style="color:#5b5b5b">
			<td align="center"><%=c_id%></td>
			<td align="center"><%=c_id_no%></td>
			<td align="center">
			<a class="s2" href="p_view_student.jsp?c_id=<%=c_id%>&c_id_no=<%=c_id_no%>"><%=c_name%></a></td>			
		</tr>
		<%
			}
			}
			stmt.close();
			myConn.close();
		%>
		<p class="title" align="center">
			<%=nYear%>년도 <%=nSemester%>학기 수업 목록<br></br>
		</p>
	</table>
</body>
</html>





