<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
@import url('https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap&subset=korean');
*{font-family: 'Noto Sans KR';}
.resultTable { sans-serif;, monospace;, cursive;, cursive; font-size:12px;width:75%;border-width: 1px;border-color: #778597;border-collapse: collapse; margin:70px auto;}
.resultTable th {cursive; font-size:12px;background-color:#94A0AD;border-width: 1px;padding: 8px;border-style: solid;border-color: #778597;text-align:center;}
.resultTable tr { background-color:#ffffff;}
.resultTable td { cursive;font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #778597;}
.resultTable tr:hover {background-color:#E5EAED;}
.searchTable { sans-serif;, monospace;, cursive;, cursive; font-size:12px;width:75%;border-width: 1px;border-color: #778597;border-collapse: collapse; margin:70px auto;}
.searchTable th {cursive; font-size:12px;background-color:#94A0AD;border-width: 1px;padding: 8px;border-style: solid;border-color: #778597;text-align:center;}
.searchTable tr { background-color:#ffffff;}
.searchTable td { cursive;font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #778597;}
.title {margin-left: auto; margin-right: auto; margin-top: 50px; width: 300px;}
.s2:link{color:#405784;}
.s2:visited{color:#405784;}
.s1{color:#ffffff;}
</style>
<title>수강신청페이지</title>
<script>
function removeContent() {
     if(flag == 1) {
       $("#search").val("");
       flag = 0;
     }
   }
</script>
</head>
<%@ include file="top.jsp"%>
<body>
   <br>
   <br>
   <br>
   <br>
   <%
      String search = request.getParameter("search");
      search = new String(search.getBytes("ISO-8859-1"), "UTF-8");
   %>

   <form action="insert_search.jsp" method="post">
      <table class="resultTable" width="75%" align="center" border>
         <tr class="s1">
            <th>과목번호</th>
            <th>분반</th>
            <th>과목명</th>
            <th>시간</th>
            <th>강의실</th>
            <th>학점</th>
            <th>교수명</th>
            <th>신청</th>
            <th>정원</th>
            <th>수강신청</th>
         </tr>
         <%
            String userID = (String) session.getAttribute("user");
            session.putValue("user", userID);

            Connection myConn = null;
            Statement stmt = null;
            ResultSet myResultSet = null;
            String mySQL = "";
            String mySQL2 = "";
            String mySQL3 = "";
            String result1 = "";
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

            mySQL = "select c.c_name, c.c_id, c.c_id_no, c.c_day, c.c_time, c.c_where, c.c_unit, c.c_max, p.p_name from course c, professor p where c.p_id = p.p_id and (c.c_name like '%"
                  + search + "%' or c.c_id like '%"+ search + "%') and (c.c_id, c.c_id_no) IN (select c_id, c_id_no from teach where t_year = "+ nYear + " and t_semester = "+ nSemester + ")order by c_id,c_id_no";

            myResultSet = stmt.executeQuery(mySQL);

            if (myResultSet != null) {
               while (myResultSet.next()) {
                  String c_name = myResultSet.getString("c_name");
                  String c_id = myResultSet.getString("c_id");
                  String c_id_no = myResultSet.getString("c_id_no");
                  String c_dayAndTime = myResultSet.getString("c_day") + myResultSet.getString("c_time");
                  String c_where = myResultSet.getString("c_where");
                  String c_unit = myResultSet.getString("c_unit");
                  String c_max = myResultSet.getString("c_max");
                  String p_name = myResultSet.getString("p_name");
                  
                  CallableStatement cstmt3 = myConn.prepareCall("{call countStudent(?,?,?,?,?)}");
                  cstmt3.setString(1, c_id);
                  cstmt3.setString(2, c_id_no);
                  cstmt3.setInt(3, nYear);
                  cstmt3.setInt(4, nSemester);
                  cstmt3.registerOutParameter(5, java.sql.Types.VARCHAR);
                  
                  cstmt3.execute();
                  result1 = cstmt3.getString(5);
                  
         %>
         <tr style="color:#5b5b5b">
            <td align="center"><%=c_name%></td>
            <td align="center"><%=c_id%></td>
            <td align="center"><%=c_id_no%></td>
            <td align="center"><%=c_dayAndTime%></td>
            <td align="center"><%=c_where%></td>
            <td align="center"><%=c_unit%></td>
            <td align="center"><%=c_max%></td>
            <td align="center"><%=p_name%></td>
            <td align="center"><%=result1%></td>
            <td align="center"><a class="s2"
               href="insert_verify.jsp?c_id=<%=c_id%>&c_class=<%=c_id_no%>">신청</a>
            </td>
         </tr>
         <%
            }
            }
            stmt.close();
            myConn.close();
         %>
         <p class="title">
            '<%=search%>'에 대한 검색결과
         </p>
         <form action="insert_search.jsp">
            <table class="searchTable">
               <tr>
                  <td align="center" width="700px"><input class="searchArea"
                     type="text" name="search" value="과목번호 또는 과목명을 입력해주세요"> <input
                     class="searchButton" type="submit" value="검색"></td>
               </tr>
            </table>
         </form>
         
      </table>
   </form>
</body>
</html>

