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
            Statement stmt = null;
            PreparedStatement pstmt = null;
            request.setCharacterEncoding("UTF-8");
            String delete_id = request.getParameter("delete_id");
            String origin_pwd = null;

            try
            {
                Class.forName("com.mysql.jdbc.Driver");
                String mysql_url = "jdbc:mysql://172.17.0.3:3306/guest_book?useSSL=false";
                con = (Connection)DriverManager.getConnection(mysql_url, "root", "mysql");
                
                String sql = "DELETE FROM content WHERE _id=?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, delete_id);
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

