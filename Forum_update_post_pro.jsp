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
            String update_id = request.getParameter("id");
            String text = request.getParameter("text");
            String title = request.getParameter("title");
            Long datetime = System.currentTimeMillis();
            Timestamp timestamp = new Timestamp(datetime);

            try
            {
                Class.forName("com.mysql.jdbc.Driver");
                String mysql_url = "jdbc:mysql://172.17.0.2:3306/forum?useSSL=false";
                con = (Connection)DriverManager.getConnection(mysql_url, "root", "mysql");
                String update_sql = "UPDATE post SET wdate = ?, title = ?, content = ? WHERE _id = ?";
                pstmt = con.prepareStatement(update_sql);
                
                pstmt.setTimestamp(1, timestamp);
                pstmt.setString(2, title);
                pstmt.setString(3, text);
                pstmt.setString(4, update_id);
                pstmt.executeUpdate();
                
            }
            catch(Exception e)
            {
                out.write("error");
                out.write("@@ " + e);
            }
            finally
            {
                if(con != null)
                    con.close();
                if(pstmt != null)
                    pstmt.close();
            }
            
        %>

        <script>
            location.href = "Forum_post.jsp?id=" + <%=update_id%>;
        </script>

    </body>
</html>

