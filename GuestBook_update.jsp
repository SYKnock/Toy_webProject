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

        <div class ="sbody3">
            <div>
                <p class = "font"; style = "font-size:40px; color: #606060;"><b>Guest Book</b></p>
            </div>

            <div style = "background-color: #beb6f0; border: 1px solid black;">
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    request.setCharacterEncoding("UTF-8");
                    String update_id = request.getParameter("id");
                    String current_text = null;
                    String pwd = null;
                    String id = null;

                    try
                    {
                        
                        Class.forName("com.mysql.jdbc.Driver");
                        String mysql_url = "jdbc:mysql://172.17.0.2:3306/guest_book?useSSL=false";
                        conn = (Connection)DriverManager.getConnection(mysql_url, "root", "mysql");
                        stmt = conn.createStatement();
                        if(stmt.execute("select * from content where _id=" + update_id)){rs = stmt.getResultSet();}
                        rs.next();
                        current_text = rs.getString("content");
                        pwd = rs.getString("pwd");
                        id = rs.getString("name");
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
                <form style = "margin:30px 10px 10px 5px;" action = "GuestBook_update_pro.jsp" method="post" name = "fr" onsubmit="return checkAll()">
                    <div class = "font">
                        ID: <b><%=id%></b>&nbsp&nbsp
                        <label for="pwd" class = "font">PWD: </label>
                        <input name="pwd" autocomplete="off" type="password" maxlength = 10 size = 10 onkeypress="if(event.keyCode=='13'){event.preventDefault();}"/>
                    </div>
                    <div>
                        
                        <textarea name = "text" maxlength = "50" style = "margin:10px 10px 0px 0px;"><%=current_text%></textarea>
                        <input type = "hidden" name="update_id" value=<%=update_id%>>
                        <button id = button type="submit" >Submit</button>
                        <button id = button type="button" onclick="cancel()">Cancel</button>
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
                
                if(obj.text.value == "")
                {
                    alert_text = alert_text + " [TEXT]";
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

                if(obj.pwd.value != correct_pwd)
                {
                    alert("Wrong password!");
                    return false;
                }
                    
                return true;
            }
            function cancel()
            {
                location.href = 'GuestBook.jsp';
            }
        </script>
    </body>
</html>