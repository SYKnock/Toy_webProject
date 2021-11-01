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

        <div>
            <div>
                <p class = "font"; style = "font-size:40px; color: #606060;"><b>Post Edit</b></p>
            </div>

            <p class = "font" style = "margin:10px 10px 10px 5px;">
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    request.setCharacterEncoding("UTF-8");
                    String update_id = request.getParameter("id");
                    String current_text = null;
                    String name = null;
                    String title = null;

                    try
                    {
                        Class.forName("com.mysql.jdbc.Driver");
                        String mysql_url = "jdbc:mysql://172.17.0.3:3306/forum?useSSL=false";
                        conn = (Connection)DriverManager.getConnection(mysql_url, "root", "mysql");
                        stmt = conn.createStatement();
                        if(stmt.execute("select * from post where _id=" + update_id)){rs = stmt.getResultSet();}
                        rs.next();
                        current_text = rs.getString("content");
                        name = rs.getString("name");
                        title = rs.getString("title");
                        
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

            <div style = "background-color: #beb6f0; border: 1px solid black; width: 800px;">
                <form style = "margin:20px 10px 10px 5px;" action = "Forum_update_post_pro.jsp" method="post" name = "fr" onsubmit="return checkAll()">
                    <div class = "font">
                        <label for="user" class = "font"><b>ID: <%=name%></b> </label>
                        </br></br>
                        <label for="title" class = "font"><b>TITLE: </b></label>
                        <input name="title" value = "<%=title%>" autocomplete="off" type="text" maxlength = 50 style ="width: 580px" onkeypress="if(event.keyCode=='13'){event.preventDefault();}"/>
                    </div>
                    <div class = "font">
                        </br> <b>Content</b> </br>
                        <textarea class = "font" name = "text" maxlength = "1000" style = "height: 30em; margin:10px 10px 0px 0px;"><%=current_text%></textarea>
                        <button id = button type="submit" >Submit</button>
                        <button id = button type="button" onclick="return cancle()">Cancle</button>
                        <input type = "hidden" name="id" value=<%=update_id%>>
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
                
                if(obj.text.value == "")
                {
                    alert_text = alert_text + " [TEXT]";
                    flag = false;
                }
                if(obj.title.value == "")
                {
                    alert_text = alert_text + " [TITLE]";
                    flag = false;
                }

                if(flag == false)
                {
                    alert(alert_text);
                    return false;
                }
                    
                return true;
            }
            function cancle()
            {
                if(confirm("Cancle it?") == false)
                {
                    return false;
                }
                else
                {
                    location.href = "Forum_post.jsp?id=" + <%=update_id%>;
                }
                return true;
            }
        </script>
    </body>
</html>