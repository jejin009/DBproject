<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%
String session_id = (String)session.getAttribute("user");
String log;
if (session_id==null) log="<a class=\"s1\" href=login.jsp>로그인</a>";
else log="<a class=\"s1\" href=logout.jsp>로그아웃</a>";
%>

<style type="text/css">
@import url('https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap&subset=korean');
*{font-family: 'Noto Sans KR'}
.p_classtop { sans-serif;, monospace;, cursive;, cursive; font-size:12px;color:#bcc8d3;width:75%;border-width: 1px;border-color: #000000;border-collapse: collapse; margin:70px auto;}
.p_classtop tr {background-color:#bcc8d3;}
.p_classtop td {cursive;font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #bcc8d3;}
.s1:link{color:#ffffff; text-decoration:none;}
.s1:visited{color:#ffffff;text-decoration:none;}
</style>

<table class="p_classtop" width="75%" align="center">
	<tr>
		<br/>
		<a href="p_main.jsp">
			<img src="./home2.gif" width="250px" style="margin-left: auto; margin-right: auto; display: block;">
		</a>
	</tr>
	<tr>
		<td align="center"><b><%=log%></b></td>
		<td align="center"><b><a class="s1" href="p_update.jsp">사용자 정보 수정</a></b></td>
		<td align="center"><b><a class="s1" href="p_view.jsp">수업목록 및 수업별 학생조회</a></b></td>
	</tr>
</table>