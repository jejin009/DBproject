<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<% String session_id = (String) session.getAttribute("user");
String log;
if (session_id == null)
log = "<a class=\"s1\" href=login.jsp>로그인</a>";
else log = "<a class=\"s1\" href=logout.jsp>로그아웃</a>"; %>

<style type="text/css">
@import url('https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap&subset=korean');
*{font-family: 'Noto Sans KR'}
.classtop { sans-serif;, monospace;, cursive;, cursive; font-size:12px;color:#bcc8d3;width:75%;border-width: 1px;border-color: #000000;border-collapse: collapse; margin:70px auto;}
.classtop tr {background-color:#bcc8d3;}
.classtop td {cursive;font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #bcc8d3;}
.s1:link{color:#ffffff; text-decoration:none;}
.s1:visited{color:#ffffff;text-decoration:none;}
</style>

<table class="classtop" width="75%" height=50px; align="center"  >
	<tr>
		<br/>
		<a href="main.jsp">
			<img src=".\home2.gif" width="250px" style="margin-left: auto; margin-right: auto; display: block;">
		</a>
	</tr>
	<tr>
		<td align="center"><b><%=log%></b></td>
		<td align="center"><b><a class="s1" href="update.jsp">사용자 정보 수정</b></td>
		<td align="center"><b><a class="s1" href="insert.jsp">수강신청 입력</b></td>
		<td align="center"><b><a class="s1" href="delete.jsp">수강신청 삭제</b></td>
		<td align="center"><b><a class="s1" href="view.jsp">수강신청 조회</b></td>
		<td align="center"><b><a class="s1" href="mypick.jsp">장바구니</b></td>
	</tr>
</table> 