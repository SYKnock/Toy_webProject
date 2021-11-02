<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
    </head>

    <body>
        <%
            Connection con = null;
            PreparedStatement pstmt = null;
            String text = request.getParameter("text");
            String user = request.getParameter("user");
            String pwd = request.getParameter("pwd");
            Long datetime = System.currentTimeMillis();
            Timestamp timestamp = new Timestamp(datetime);

            try
            {
                Class.forName("com.mysql.jdbc.Driver");
                String mysql_url = "jdbc:mysql://172.17.0.2:3306/guest_book?useSSL=false";
                con = (Connection)DriverManager.getConnection(mysql_url, "root", "mysql");
                String sql = "INSERT INTO content (name, content, wdate, pwd) values(?, ?, ?, ?)";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, user);
                pstmt.setString(2, text);
                pstmt.setTimestamp(3, timestamp);
                pstmt.setString(4, pwd);
                pstmt.executeUpdate();
            }
            catch(Exception e)
            {
                out.write("error");
                out.write("@@ " + e);
            }
            finally
            {
                if(pstmt != null)
                    pstmt.close();
                if(con != null)
                    con.close();
            }
            
        %>

        <script>
            location.href = 'GuestBook.jsp';
        </script>

    </body>
</html>

