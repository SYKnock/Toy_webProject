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
            String post_id = request.getParameter("post_id");
            String correct_pwd = request.getParameter("correct_pwd");
            String comment_pwd = request.getParameter("comment_pwd");
            String delete_id = request.getParameter("comment_id");
            String origin_pwd = null;

            if(comment_pwd =="")
            {
                out.write("<script>");
                out.write("alert(\"Please input [PWD]\");");
                out.write("</script>");
            }
            else
            {
                if(comment_pwd.equals(correct_pwd))
                {   
                    try
                    {
                        Class.forName("com.mysql.jdbc.Driver");
                        String mysql_url = "jdbc:mysql://172.17.0.2:3306/forum?useSSL=false";
                        con = (Connection)DriverManager.getConnection(mysql_url, "root", "mysql");
                
                        String sql = "DELETE FROM comment WHERE _id=?";
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
                }
                else
                {
                    out.write("<script>");
                    out.write("alert(\"Wrong password!\");");
                    out.write("</script>");
                }
            }
        %>

        <script>    
            location.href = "Forum_post.jsp?id=" + <%=post_id%>;
        </script>

    </body>
</html>

