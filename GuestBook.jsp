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
        <script>
            function checkAll()
            {
                var obj = document.fr;
                var alert_text = "Please input";
                var flag = true;
                
                if(obj.text.value == "")
                {
                    alert_text = alert_text + " [TEXT]";
                    flag = false;
                }
                if(obj.user.value == "")
                {
                    alert_text = alert_text + " [ID]";
                    flag = false;
                }
                if(obj.pwd.value == "")
                {
                    alert_text = alert_text + " [PWD]";
                    flag = false;
                }

                if(flag == false)
                {
                    alert(alert_text);
                    return false;
                }
                    
                return true;
            }
            function delete_check()
            {
                if(confirm("Remove it?") == true)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            function update_check()
            {
                if(confirm("Update it?") == true)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        </script>
    </head>
    <body>
        <div class="shead">
            <a href = "AboutMe.html"; class = "font"; style = "margin:10px 20px 0px 20px; font-size: 25px;"><b>About Me</b></a>
            <a href = "Project.html"; class = "font"; style = "margin:10px 20px 0px 20px; font-size: 25px;"><b>Project</b></a>
            <a href = "GuestBook.jsp"; class = "font"; style = "margin:10px 20px 0px 20px; font-size: 25px;"><b>Guest Book</b></a>
            <a href = "Forum.jsp"; class = "font"; style = "margin:10px 40px 0px 20px; font-size: 25px;"><b>Forum</b></a>
        </div>

        <div class ="sbody3">
            <div>
                <p class = "font"; style = "font-size:40px; color: #606060;"><b>Guest Book</b></p>
            </div>

            <div style = "background-color: #beb6f0; border: 1px solid black;">
                <form style = "margin:30px 10px 10px 5px;" action = "GuestBook_insert.jsp" method="post" name = "fr" onsubmit="return checkAll()">
                    <div>
                        <label for="user" class = "font">ID: </label>
                        <input name="user" autocomplete="off" type="text" maxlength = 10 size = 10 onkeypress="if(event.keyCode=='13'){event.preventDefault();}"/>

                        <label for="pwd" class = "font">PWD: </label>
                        <input name="pwd" autocomplete="off" type="password" maxlength = 10 size = 10 onkeypress="if(event.keyCode=='13'){event.preventDefault();}"/>
                    </div>
                    <div>
                        <textarea class = "font" name = "text" placeholder = "Input text(1~50 word)" maxlength = "50" style = "margin:10px 10px 0px 0px;"></textarea>
                        <button id = button type="submit" >Submit</button>
                    </div>
                </form>
            </div>

            <div>
                <p class = "font" style = "margin:30px 10px 10px 5px;">
                    <%
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try
                        {
                            Class.forName("com.mysql.jdbc.Driver");
                            String mysql_url = "jdbc:mysql://172.17.0.2:3306/guest_book?useSSL=false";
                            conn = (Connection)DriverManager.getConnection(mysql_url, "root", "mysql");
                            stmt = conn.createStatement();
                            if(stmt.execute("select * from content")){rs = stmt.getResultSet();}
                            while(rs.next())
                            {
                                int page_id = rs.getInt("_id");
                                String url_delete = "GuestBook_delete.jsp?id=" + page_id;
                                String url_update = "GuestBook_update.jsp?id=" + page_id;
                                

                                out.write("<table class=\"font\" width=700 border=1><tr bgcolor = #beb6f0>");
                                out.write("<td width=120> ID: ");
                                out.println(rs.getString("name"));
                                out.write("</td>");

                                out.write("<td width=400> Last updated date: ");
                                out.println(rs.getTimestamp("wdate"));
                                out.write("</td>");

                                out.write("<td align = center><a href =\"" + url_update + "\" onclick=\"return update_check()\">Update</a> </td>");

                                out.write("<td align = center><a href =\"" + url_delete + "\" onclick=\"return delete_check()\">Delete</a> </td>");

                                out.write("</tr>");
                                
                                out.write("<tr>");

                                out.write("<td colspan=4>");
                                out.println(rs.getString("content"));
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