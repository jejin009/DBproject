<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>학생조회페이지</title>
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
.searchTable tr { background-color:#ffffff;}
.searchTable td { cursive;font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #778597;}
.s2:link{color:#405784;}
.s2:visited{color:#405784;}
.s1{color:#ffffff;}
</style>
</head>
<body>
   <%@ include file="p_top.jsp"%>
   <%
	String c_id_no = (String) request.getParameter("c_id_no");
   %>
   <table class="resultTable">
      <tr class="s1">
         <th>이름</th>
         <th>학번</th>
         <th>학과</th>
         <th>학년</th>
         <th>연락처</th>
      </tr>
      <%
		 String c_id = (String)request.getParameter("c_id");
         Connection myConn = null;
         Statement stmt = null;
         ResultSet myResultSet = null;
         String mySQL = "";
         String mySQL2 = "";
         String mySQL3 = "";
         String result1 = "";
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
         CallableStatement cstmt1 = myConn.prepareCall(mySQL2);
         cstmt1.registerOutParameter(1,java.sql.Types.INTEGER);
         cstmt1.execute();
         int nYear = cstmt1.getInt(1);
         
          mySQL3 = "{? = call Date2EnrollSemester(SYSDATE)}";
         CallableStatement cstmt2 = myConn.prepareCall(mySQL3);
         cstmt2.registerOutParameter(1,java.sql.Types.INTEGER);
         cstmt2.execute();
         int nSemester = cstmt2.getInt(1);
         
         mySQL = "select s_name, s_id, s_major, s_grade, s_tel from student where s_id IN(select s_id from enroll where e_year ="
               + nYear + " and e_semester ="+ nSemester + " and c_id ="+ c_id + " and c_id_no = '"+ c_id_no +"') order by s_name";
         myResultSet = stmt.executeQuery(mySQL);
         if (myResultSet != null) {
            while (myResultSet.next()) {
               String s_name = myResultSet.getString("s_name");
               int s_id = myResultSet.getInt("s_id");
               String s_major = myResultSet.getString("s_major");
               int s_grade = myResultSet.getInt("s_grade");
               String s_tel = myResultSet.getString("s_tel");
      %>
      <tr>
         <td align="center"><%=s_name%></td>
         <td align="center"><%=s_id%></td>
         <td align="center"><%=s_major%></td>
         <td align="center"><%=s_grade%></td>
         <td align="center"><%=s_tel%></td>
      </tr>
      <%
         }
         }       
         CallableStatement cstmt = myConn.prepareCall("{call countStudent(?,?,?,?,?)}");
         cstmt.setString(1, c_id);
         cstmt.setString(2, c_id_no);
         cstmt.setInt(3, nYear);
         cstmt.setInt(4, nSemester);
         cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
         try {
            cstmt.execute();
            result1 = cstmt.getString(5);
                        %>
            <p class="title">
            
      <%=nYear%>-<%=nSemester%> 과목번호 <%=c_id%> <%=c_id_no%>분반
      </p>
         <table class="searchTable">
         <tr>
            <td>총 수강인원</td>
            <td><%=result1%></td>
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
      <table class="searchTable">
      <tr>
      <td style="border-color:#ffffff"><input type="button" value="전체강의목록" OnClick="window.location='p_view.jsp'"></td></tr>
      </table>
      </p>
   </table>
</body>
</html>