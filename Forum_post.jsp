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
                <p class = "font"; style = "font-size:40px; color: #606060;"><b>Post</b></p>
            </div>

            

            <p class = "font" style = "margin:30px 10px 10px 5px;">
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    request.setCharacterEncoding("UTF-8");
                    String post_id = request.getParameter("id");
                    String current_text = null;
                    String pwd = null;
                    String name = null;
                    String title = null;
                    Timestamp time = null;

                    try
                    {
                        Class.forName("com.mysql.jdbc.Driver");
                        String mysql_url = "jdbc:mysql://172.17.0.3:3306/forum?useSSL=false";
                        conn = (Connection)DriverManager.getConnection(mysql_url, "root", "mysql");
                        stmt = conn.createStatement();
                        if(stmt.execute("select * from post where _id=" + post_id)){rs = stmt.getResultSet();}
                        rs.next();
                        current_text = rs.getString("content");
                        pwd = rs.getString("pwd");
                        name = rs.getString("name");
                        title = rs.getString("title");
                        time = rs.getTimestamp("wdate");
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
            

            <div class = "sbody4" style = "background-color: #beb6f0; border: 1px solid black;">
                <div class = "font" style = "border-bottom: 1px solid black; padding: 10px 10px 10px 10px">
                    ID: <b><%=name%></b>
                </div>
                <div class = "font"style = "text-align:right; border-bottom: 1px solid black; padding: 10px 10px 10px 10px">
                    <form method="post" name = "fr" onsubmit = "return checkAll()">
                        <label for="pwd" class = "font">PWD:</label>
                        <input name="pwd" autocomplete="off" type="password" maxlength = 10 size = 10 onkeypress="if(event.keyCode=='13'){event.preventDefault();}"/>
                        <input id = "button" type="submit" value = "Update" onclick="return askUpdate()" formaction="Forum_update_post.jsp">
                        <input id = "button" type="submit" value = "Delete" onclick="return askDelete()" formaction="Forum_delete_post.jsp">
                        <input id = "button" type="button" value = "To List" onclick="toList()">
                        <input type = "hidden" name="id" value=<%=post_id%>>
                    </form>
                        
                </div>
                <div class = "font" style = "border-bottom: 1px solid black; padding: 10px 10px 10px 10px">
                    TITLE:
                </div>
                <div class = "font" style = "border-bottom: 1px solid black; padding: 5px 5px 5px 5px;">
                    <a style = "padding: 4px 0px 0px 3px; width: 680px; height: 25px; display:block; border: 1px solid black; background-color: white">
                        <%=title%>
                    </a>
                </div>
                <div class = "font"  style = "padding: 15px 10px 10px 10px;">
                    Content
                </div>
                <div class = "font" style = "padding: 15px 10px 10px 10px; text-align: right">
                    Last update: <%=time%>
                </div>
                <div class = "item1"  style = "font-family: 'Ubuntu', sans-serif; word-break:break-all; white-space: pre-line; overflow:auto; border-style: solid; border-width:10px; border-color:#beb6f0; background-color: white; padding: 10px 10px 10px 10px;"><%=current_text%></div>
            </div>


            <div>
                </br>
                <div>
                    <p class = "font"; style = "font-size:25px; color: #606060;"><b>Comment</b></p>
                </div>
               

                <p class = "font" style = "margin:30px 10px 10px 5px;">
                    <%
                        Connection conn_comment = null;
                        Statement stmt_comment = null;
                        ResultSet rs_comment = null;
                        String correct_pwd = null;
                        int comment_id = 0;

                        try
                        {
                            Class.forName("com.mysql.jdbc.Driver");
                            String mysql_url = "jdbc:mysql://172.17.0.3:3306/forum?useSSL=false";
                            conn_comment = (Connection)DriverManager.getConnection(mysql_url, "root", "mysql");
                            stmt_comment = conn_comment.createStatement();
                            String select_query = "select * from comment where _post_id=" + post_id;

                            if(stmt_comment.execute(select_query)){rs_comment = stmt_comment.getResultSet();}
                            while(rs_comment.next())
                            {
                                comment_id = rs_comment.getInt("_id");
                                correct_pwd = rs_comment.getString("pwd");
                                String post_id_string = "<input type = \"hidden\" name=\"post_id\" value=" + post_id + ">";
                                String comment_id_string = "<input type = \"hidden\" name=\"comment_id\" value=" + comment_id + ">";
                                String correct_pwd_string = "<input type = \"hidden\" name=\"correct_pwd\" value=" + correct_pwd + ">";

                                out.write("<div style = \"width: 800px; border-bottom: 1px solid black;\">");
                                out.write("<table class=\"font\" width=800 border=0><tr bgcolor = #beb6f0 >");
                                out.write("<td width=130px> ID: ");
                                out.println(rs_comment.getString("name"));
                                out.write("</td>");

                                out.write("<td width=400px> Last updated date: ");
                                out.println(rs_comment.getTimestamp("wdate"));
                                out.write("</td>");

                                out.write("<td>");
                                out.write("<form method=\"post\" name = \"fr_comment_modify\" onsubmit = \"return checkAll_comment_modify()\">");
                                out.write("<label for=\"pwd\" class = \"font\">PWD:</label>");
                                out.write("<input name=\"comment_pwd\" autocomplete=\"off\" type=\"password\" maxlenth=10 size=10 onkeypress=\"if(event.keyCode=='13'){event.preventDefault();}\"/> ");
                                out.write("&nbsp");
                                out.write("<input id = \"button\" type=\"submit\" value = \"Update\" onclick=\"return askUpdate()\" formaction=\"Comment_update.jsp\">");
                                out.write("&nbsp");
                                out.write("<input id = \"button\" type=\"submit\" value = \"Delete\" onclick=\"return askDelete()\" formaction=\"Comment_delete.jsp\">");
                                out.write(post_id_string);
                                out.write(comment_id_string);
                                out.write(correct_pwd_string);

                                out.write("</form>");

                                out.write("</td>");

                                
                                out.write("</tr>");
                                
                                out.write("<tr style = \"word-break:break-all; white-space: pre-line; height: 50px;\">");

                                out.write("<td colspan=3 style = \"height:50px\">");
                                out.println(rs_comment.getString("content"));
                                out.write("</td>");

                                out.write("</tr></table>");
                                out.write("</div>");
                            }
                            
                        }
                        catch(Exception e)
                        {
                            out.write("error");
                            out.write("@@ " + e);
                        }
                        finally
                        {
                            if(rs_comment != null)
                                rs_comment.close();
                            if(stmt_comment != null)
                                stmt_comment.close();
                            if(conn_comment != null)
                                conn_comment.close();
                        }
                            
                    %> 
                </p>
            </div>

            <div style = "width: 800px; background-color: #beb6f0; border: 1px solid black;">
                <div class="font" style = "padding: 10px 10px 10px 10px; font-size:20px">
                    Leave Comment
                </div>
                <form style = "margin:5px 10px 10px 10px;" action = "Comment_insert.jsp" method="post" name = "fr_comment_insert" onsubmit="return checkAll_comment_insert()">
                    <div>
                        <label for="user" class = "font">ID: </label>
                        <input name="user" autocomplete="off" type="text" maxlength = 10 size = 10 onkeypress="if(event.keyCode=='13'){event.preventDefault();}"/>

                        <label for="pwd" class = "font">PWD: </label>
                        <input name="pwd" autocomplete="off" type="password" maxlength = 10 size = 10 onkeypress="if(event.keyCode=='13'){event.preventDefault();}"/>
                        <input type = "hidden" name="post_id" value=<%=post_id%>>
                    </div>
                    <div>
                        <textarea class = "font" name = "text" placeholder = "Input text(1~100 word)" maxlength = "100" style = "margin:10px 10px 0px 0px; width: 90%; height: 5em"></textarea>
                        <button id = button type="submit" >Submit</button>
                    </div>
                </form>
            </div>
        </div>

        
        
        <script>
            
            function checkAll()
            {
                var obj = document.fr;
                var alert_text = "Please input";
                var flag = true;
                var correct_pwd = <%=pwd%>;
                

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

                if(obj.pwd.value != correct_pwd)
                {
                    alert("Wrong password!");
                    return false;
                }
                    
                return true;
            }

            function checkAll_comment_insert()
            {
                var obj = document.fr_comment_insert;
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

            function checkAll_comment_modify()
            {
                return true;
            }

            function toList()
            {
                location.href = 'Forum.jsp';
            }

            function askDelete()
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
            function askUpdate()
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
    </body>
</html>