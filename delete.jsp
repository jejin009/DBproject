<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
@import url('https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap&subset=korean');
*{font-family: 'Noto Sans KR'}
.classtable { sans-serif;, monospace;, cursive;, cursive; font-size:12px;width:75%;border-width: 1px;border-color: #778597;border-collapse: collapse; margin:70px auto;}
.classtable th {cursive; font-size:12px;background-color:#94A0AD;border-width: 1px;padding: 8px;border-style: solid;border-color: #778597;text-align:center;}
.classtable tr { background-color:#ffffff;}
.classtable td {cursive;font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #778597;}
.classtable tr:hover {background-color:#E5EAED;}
.title {margin-left: auto; margin-right: auto; margin-top: 50px; width: 300px;}
.s2:link{color:#405784;}
.s2:visited{color:#405784;}
a:link{color:#000000;}
a:visited{color:#000000;}
.s1{color:#ffffff;}
</style>
<title>수강삭제페이지</title>
</head>
<body>
<%@ include file="top.jsp"%>
<%
		if(session_id == null){
			%>
			<script>
			alert("로그인 후 사용하세요.");
			location.href("login.jsp");
			</script>
			<% 
		}
	%>
<table class="classtable" border="1" align="center" >
<tr>
	<th class="s1">과목번호</th>
	<th class="s1">과목명</th>
	<th class="s1">분반</th>
	<th class="s1">강의실</th>
	<th class="s1">시간</th>
	<th class="s1">교수명</th>
	<th class="s1">수강취소</th>
</tr>
<%	
	Connection myConn = null; 
	Statement stmt = null;	
	ResultSet myResultSet = null; 
	String mySQL = "";
	String mySQL2 = "";
	String mySQL3 = "";

	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	Class.forName(dbdriver);
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
	mySQL2 = "{? = call Date2EnrollYear(SYSDATE)}";
	CallableStatement cstmt1 = myConn.prepareCall(mySQL2);
	cstmt1.registerOutParameter(1,java.sql.Types.INTEGER);
	cstmt1.execute();
	int nYear = cstmt1.getInt(1);
	
 	mySQL3 = "{? = call Date2EnrollSemester(SYSDATE)}";
	CallableStatement cstmt2 = myConn.prepareCall(mySQL3);
	cstmt2.registerOutParameter(1,java.sql.Types.INTEGER);
	cstmt2.execute();
	int nSemester = cstmt2.getInt(1);
%>
<p class="title" >
<%=nYear%>년도 <%=nSemester%>학기 수강삭제
</p>
<%
	mySQL = "select c_id, c_name, c_id_no, c_where, c_day, c_unit, c_time, p_name from course c, professor p where c.p_id = p.p_id and (c.c_id, c.c_id_no) in (select c_id, c_id_no from enroll where e_year ="
			+ nYear + " and e_semester ="+ nSemester + " and s_id='" + session_id + "')";
	myResultSet = stmt.executeQuery(mySQL);
	if (myResultSet != null) {
		while (myResultSet.next()) {
			String c_id = myResultSet.getString("c_id");	
			String c_name = myResultSet.getString("c_name");
			String c_class = myResultSet.getString("c_id_no");	
			String c_classroom = myResultSet.getString("c_where");
			String p_name = myResultSet.getString("p_name");
			String c_dayAndTime = myResultSet.getString("c_day")+myResultSet.getString("c_time");
%>
	<tr>
	  <td align="center"><%= c_id %></td>
	  <td align="center"><%= c_name %></td>
	  <td align="center"><%= c_class %></td>
	  <td align="center"><%= c_classroom %></td>
	  <td align="center"><%= c_dayAndTime %></td>
	  <td align="center"><%= p_name %></td>
	  <td align="center"><a class="s2" href="delete_verify.jsp?c_id=<%= c_id %>&c_id=<%= c_id %>&c_class=<%= c_class %>" >삭제</a></td>
	</tr>
<%
	}
	}
	stmt.close(); 
	myConn.close();
%>
</table>
</body>
</html>