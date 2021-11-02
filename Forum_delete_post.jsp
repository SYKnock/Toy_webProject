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
            String delete_id = request.getParameter("id");
            String origin_pwd = null;

            try
            {
                Class.forName("com.mysql.jdbc.Driver");
                String mysql_url = "jdbc:mysql://172.17.0.2:3306/forum?useSSL=false";
                con = (Connection)DriverManager.getConnection(mysql_url, "root", "mysql");

                String comment_sql = "DELETE FROM comment WHERE _post_id=?";
                pstmt = con.prepareStatement(comment_sql);
                pstmt.setString(1, delete_id);
                pstmt.executeUpdate();
                
                String sql = "DELETE FROM post WHERE _id=?";
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
            location.href = 'Forum.jsp';
        </script>

    </body>
</html>

