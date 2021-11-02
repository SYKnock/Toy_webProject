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
            request.setCharacterEncoding("UTF-8");
            String update_id = request.getParameter("update_id");
            String text = request.getParameter("text");
            Long datetime = System.currentTimeMillis();
            Timestamp timestamp = new Timestamp(datetime);

            try
            {
                Class.forName("com.mysql.jdbc.Driver");
                String mysql_url = "jdbc:mysql://172.17.0.2:3306/guest_book?useSSL=false";
                con = (Connection)DriverManager.getConnection(mysql_url, "root", "mysql");
                String update_sql = "UPDATE content SET content = ?,  wdate = ? WHERE _id = ?";
                pstmt = con.prepareStatement(update_sql);
                pstmt.setString(1, text);
                pstmt.setTimestamp(2, timestamp);
                pstmt.setString(3, update_id);
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

