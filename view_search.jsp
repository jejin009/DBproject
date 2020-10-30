<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
@import url('https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap&subset=korean');
*{font-family: 'Noto Sans KR';}
.resultTable { sans-serif;, monospace;, cursive;, cursive; font-size:12px;width:75%;border-width: 1px;border-color: #778597;border-collapse: collapse; margin:70px auto;}
.resultTable th {cursive; font-size:12px;background-color:#94A0AD;border-width: 1px;padding: 8px;border-style: solid;border-color: #778597;text-align:center;}
.resultTable tr { background-color:#ffffff;}
.resultTable td { cursive;font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #778597;}
.resultTable tr:hover {background-color:#E5EAED;}
.title {margin-left: auto; margin-right: auto; margin-top: 50px; width: 300px;}
.searchTable { sans-serif;, monospace;, cursive;, cursive; font-size:12px;width:75%;border-width: 1px;border-color: #778597;border-collapse: collapse; margin:70px auto;}
.searchTable th {cursive; font-size:12px;background-color:#94A0AD;border-width: 1px;padding: 8px;border-style: solid;border-color: #778597;text-align:center;}
.searchTable tr { background-color:#ffffff;}
.searchTable td { cursive;font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #778597;}
.s2:link{color:#405784;}
.s2:visited{color:#405784;}
.s1{color:#ffffff;}
</style>
<title>수강신청 조회</title>
</head>
<body>
	<%@ include file="top.jsp"%>

	<%
		if (session_id == null)
			response.sendRedirect("login.jsp");
	%>
	<form id="my_form" action="view_search.jsp" method="post">
		<table class="resultTable" width="75%" align="center" border>
		
			<tr class="s1">
				<th>과목번호</th>
				<th>분반</th>
				<th>과목명</th>
				<th>강의실</th>
				<th>시간</th>
				<th>학점</th>
				<th>교수명</th>
			</tr>
			<%
			    String nYear = request.getParameter("nYear");
			    String nSemester = request.getParameter("nSemester");
				String result1 = null;
				String result2 = null;
				Connection myConn = null;
				Statement stmt = null;
				Statement stmt2 = null;
				ResultSet myResultSet = null;
				//ResultSet myResultSet2 = null;
				String mySQL = "";
				String mySQL2 = "";
				String mySQL3 = "";
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
				mySQL = "select c.c_name, c.c_id, c.c_id_no, c.c_day, c.c_time, c.c_where, c.c_unit, p.p_name from course c, professor p where c.p_id = p.p_id and (c.c_id, c.c_id_no) in (select c_id, c_id_no from enroll where e_year ='"
						+ nYear + "' and e_semester ='"+ nSemester + "' and s_id='"+ session_id + "')";
				myResultSet = stmt.executeQuery(mySQL);

				if (myResultSet != null) {
					while (myResultSet.next()) {
						String c_name = myResultSet.getString("c_name");
						String c_id = myResultSet.getString("c_id");
						String c_id_no = myResultSet.getString("c_id_no");
						String c_dayAndTime = myResultSet.getString("c_day") + myResultSet.getString("c_time");
						String c_where = myResultSet.getString("c_where");
						String c_unit = myResultSet.getString("c_unit");
						String p_name = myResultSet.getString("p_name");
						
			%>

			<tr>
				<td align="center"><%=c_id%></td>
				<td align="center"><%=c_id_no%></td>
				<td align="center"><%=c_name%></td>
				<td align="center"><%=c_where%></td>
				<td align="center"><%=c_dayAndTime%></td>
				<td align="center"><%=c_unit%></td>
				<td align="center"><%=p_name%></td>
				</td>
			</tr>
			

			<%
				}
				}

				
				CallableStatement cstmt = myConn.prepareCall("{call SelectTimeTable(?,?,?,?,?)}");
				cstmt.setString(1, session_id);
				cstmt.setString(2, nYear);
				cstmt.setString(3, nSemester);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
				try {
					cstmt.execute();
					result1 = cstmt.getString(4);
					result2 = cstmt.getString(5);
			%>
			<p class="title">
				<%=nYear%>년도 <%=nSemester%>학기 수강조회
			</p>
			<table class="searchTable">
			<tr>
				<td>총 신청 과목 수</td>
				<td><%=result1%></td>
			</tr>
			
			<tr>
				<td>총 신청 학점 수</td>
				<td><%=result2%></td>
			</tr>
			</table>
			
			<table class="searchTable">
			<tr align="center">
				<td style="background-color:#d5dde5" ><input type="text" id="nYear" name="nYear" value=<%=nYear%> /> 년도</td>
				<td style="background-color:#d5dde5"><input type="text" id="nSemester" name="nSemester" value=<%=nSemester%> />학기</td>
				<td style="border-color:#ffffff" ><input type="submit" value="조회" /></td>
			</tr>
			</table>


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
		</table>
		</form>
	</body>
</html>
