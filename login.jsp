<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<html>
<head> <meta charset="utf-8"> <title>수강신청 시스템 로그인</title>
<style type="text/css">
@import url('https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap&subset=korean');
*{font-family: 'Noto Sans KR'}
.classtable { sans-serif;, monospace;, cursive;, cursive; font-size:12px;width:75%;border-width: 1px;border-color: #778597;border-collapse: collapse; margin:70px auto;}
.classtable tr { background-color:#ffffff;}
.classtable td {cursive;font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #778597;}
.title {margin-left: auto; margin-right: auto; margin-top: 50px; width: 300px;}
.s1{background-color:#94A0AD; color:#ffffff;}

</style>
 </head>
<body>
<table class="classtable" width="75%" align="center">
<tr> <td class="s1"><div align="center">아이디와 패스워드를 입력하세요 </div></td></table>
<table class="classtable"  width="75%" align="center">
<form method="post" action="login_verify.jsp">
<tr>
<td class="s1"><div align="center">아이디</div></td>
<td><div align="center">
<input type="text" name="userID">
</div></td>
</tr>
<tr>
<td class="s1"><div align="center">패스워드</div></td>
<td><div align="center">
<input type="password" name="userPassword">
</div></td></tr>
</table>
<table align="center">
<td colspan=2><div align="center">
<INPUT TYPE="SUBMIT" NAME="Submit" VALUE="로그인"> <INPUT
TYPE="RESET" VALUE="취소">
</div></td></tr></table>
</form>
</body>
</html>
