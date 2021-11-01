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
            String title = request.getParameter("title");
            String id = null;
            ResultSet rs = null;

            Long datetime = System.currentTimeMillis();
            Timestamp timestamp = new Timestamp(datetime);

            try
            {
                Class.forName("com.mysql.jdbc.Driver");
                String mysql_url = "jdbc:mysql://172.17.0.3:3306/forum?useSSL=false";
                con = (Connection)DriverManager.getConnection(mysql_url, "root", "mysql");
                String sql = "INSERT INTO post (name, pwd, wdate, title, content) values(?, ?, ?, ?, ?)";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, user);
                pstmt.setString(2, pwd);
                pstmt.setTimestamp(3, timestamp);
                pstmt.setString(4, title);
                pstmt.setString(5, text);
                pstmt.executeUpdate();

                rs = pstmt.executeQuery("SELECT LAST_INSERT_ID()");
                if(rs.next())
                {
                    id = Integer.toString(rs.getInt(1));
                }

            }
            catch(Exception e)
            {
                out.write("error");
                out.write("@@ " + e);
            }
            finally
            {
                if(rs != null)
                    rs.close();
                if(pstmt != null)
                    pstmt.close();
                if(con != null)
                    con.close();
            }

            
        %>

        <script>
            location.href = "Forum_post.jsp?id=" + <%=id%>;
        </script>

    </body>
</html>

