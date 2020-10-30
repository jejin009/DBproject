<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
    <html>
    	<head> <meta charset="UTF-8">
		<title>수강신청페이지 ( 교수용 )</title>
		</head>
		<style type="text/css">
		@import url('https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap&subset=korean');
		*{font-family: 'Noto Sans KR'}
		.s1:link{color:#ffffff; text-decoration:none;}
		.s1:visited{color:#ffffff;text-decoration:none;}
	</style>
		<%@include file="p_top.jsp"%>
	<div align="center">
		<% if (session_id != null) { %>
			<%=session_id%>님 방문을 환영합니다.
		<% } else { %>
			로그인한 후 사용하세요.
		<% } %>
	</div>	
</html>