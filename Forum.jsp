<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset = "UTF-8">
        <link rel="stylesheet" href="style.css"/>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Ubuntu&display=swap" rel="stylesheet">

    </head>
    <body>
        <div class="shead">
            <a href = "AboutMe.html"; class = "font"; style = "margin:10px 20px 0px 20px; font-size: 25px;"><b>About Me</b></a>
            <a href = "Project.html"; class = "font"; style = "margin:10px 20px 0px 20px; font-size: 25px;"><b>Project</b></a>
            <a href = "GuestBook.jsp"; class = "font"; style = "margin:10px 20px 0px 20px; font-size: 25px;"><b>Guest Book</b></a>
            <a href = "Forum.jsp"; class = "font"; style = "margin:10px 40px 0px 20px; font-size: 25px;"><b>Forum</b></a>
        </div>

        <div class = "sbody_normal">
            <div>
                <p class = "font"; style = "font-size:40px; color: #606060;"><b>Forum</b></p>
            </div>

            <div>
                <button id = button type="button"onclick = "location.href='Forum_make_post.jsp'" style = "font-size: 22px" >Make Post</button>
 
            </div>

            <div>
                <p class = "font" style = "margin:30px 10px 10px 5px; width: 800px">
                <b>List</b></br>
                    <%
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try
                        {
                            Class.forName("com.mysql.jdbc.Driver");
                            String mysql_url = "jdbc:mysql://172.17.0.3:3306/forum?useSSL=false";
                            conn = (Connection)DriverManager.getConnection(mysql_url, "root", "mysql");
                            stmt = conn.createStatement();
                            if(stmt.execute("select * from post")){rs = stmt.getResultSet();}
                            while(rs.next())
                            {
                                int page_id = rs.getInt("_id");
                                String title = rs.getString("title");
                                String url_post = "Forum_post.jsp?id=" + page_id;
                                

                                out.write("<table class=font width=100% border=1><tr bgcolor = #beb6f0>");
                                out.write("<td width = \"120px\"> ID: ");
                                out.println(rs.getString("name"));
                                out.write("</td>");

                                out.write("<td>");
                                out.write("<a href =\"" + url_post + "\">Title: " + title);
                                out.write("</a>");
                                out.write("</td>");

                                out.write("<td width = \"250px\" align = \"right\"> Date: ");
                                out.println(rs.getTimestamp("wdate"));
                                out.write("</td>");


                                out.write("</tr></table>");
                                out.write("<br/>");
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
                            if(stmt != null)
                                stmt.close();
                            if(conn != null)
                                conn.close();
                        }
                            
                    %> 
                </p>
            </div>
        </div>

    </body>
</html>