<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<meta http-equiv="ContentType" content="text/html; charset=UTF-8">
<title>정보수정페이지</title>
<style type="text/css">
@import url('https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap&subset=korean');
*{font-family: 'Noto Sans KR'}
.infotable { sans-serif;, monospace;, cursive;, cursive; font-size:12px;width:75%;border-width: 1px;border-color: #778597;border-collapse: collapse; margin:70px auto;}
.infotable th {cursive; font-size:12px;background-color:#94A0AD;border-width: 1px;padding: 8px;border-style: solid;border-color: #778597;text-align:center;}
.infotable tr { background-color:#ffffff;}
.infotable td {cursive;font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #778597;}
.title {margin-left: auto; margin-right: auto; margin-top: 50px; width: 300px;}
.s2:link{color:#405784;}
.s2:visited{color:#405784;}
a:link{color:#000000;}
a:visited{color:#000000;}
.s3{background-color:#94A0AD; color:#ffffff;}
</style>
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
		else {
			request.setCharacterEncoding("UTF-8");
			String dbdriver = "oracle.jdbc.driver.OracleDriver";
			Class.forName(dbdriver);
			String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
			String user = "jdb";
			String passwd = "0000";
			Connection myConn = null;
		    Statement stmt = null;
		    String mySQL = null;
		    

		myConn = DriverManager.getConnection(dburl, user, passwd);
		stmt = myConn.createStatement();

		mySQL = "select * from student where s_id='" + session_id + "'";

		ResultSet rs = stmt.executeQuery(mySQL);
		rs.next();
		String s_pwd = rs.getString("s_pwd");
		String s_name = rs.getString("s_name");
		String s_univ = rs.getString("s_univ");
		String s_major = rs.getString("s_major");
		String s_grade = rs.getString("s_grade");
		String s_tel = rs.getString("s_tel");
		String s_addr = rs.getString("s_addr");
	%>
	<form method="post" action="update_verify.jsp">
	<p class="title">학생 정보 수정</p>
		<table class="infotable" border="1" align="center">
			<tr>
				<td class="s3">이름</td>
				<td><input type="text" name="username" value=<%=s_name%> readonly style="background-color: #e2e2e2;"></td>
			</tr>
			<tr>
				<td class="s3">아이디</td>
				<td><input type="text" id="userid" name="userid" value=<%=session_id%> readonly  style="background-color: #e2e2e2;"></td>
			</tr>
			<tr>
				<td class="s3">비밀번호</td>
				<td><input type="password" name="password" id ="password" value=<%=s_pwd%> /></td>
			</tr>
			<tr>
				<td class="s3">소속</td>
				<td><input type="text" id="univ" name="univ" value=<%=s_univ%> readonly style="background-color: #e2e2e2;"></td>
			</tr>			
			<tr>
				<td class="s3">전공</td>
				<td><input type="text" id="major" name="major" value=<%=s_major%> readonly style="background-color: #e2e2e2;"></td>
			</tr>
			<tr>
				<td class="s3">학년</td>
				<td><input type="text" id="grade" name="grade" value=<%=s_grade%> readonly style="background-color: #e2e2e2;"></td>
			</tr>
			<tr>
				<td class="s3">연락처</td>
				<td> <input type="text" id="tel" name="tel" value=<%=s_tel%> /></td>
			</tr>
			<tr>
				<td class="s3">주소</td>
				<td><input type="text" id="address" name="address" value=<%=s_addr%> /></td>
			</tr>
			</table>
			<div align="center" style="border-color:#ffffff">
				<input type="reset" value="초기화"/>&nbsp;&nbsp;
				<input type="submit" value="수정"/>
			</div>
	</form>
	<%} %>
</body>
</html>