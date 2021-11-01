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
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                request.setCharacterEncoding("UTF-8");
                String delete_id = request.getParameter("id");
                String pwd = null;
                try
                {
                        
                    Class.forName("com.mysql.jdbc.Driver");
                    String mysql_url = "jdbc:mysql://172.17.0.3:3306/guest_book?useSSL=false";
                    conn = (Connection)DriverManager.getConnection(mysql_url, "root", "mysql");
                    stmt = conn.createStatement();
                    if(stmt.execute("select * from content where _id=" + delete_id)){rs = stmt.getResultSet();}
                    rs.next();
                    pwd = rs.getString("pwd");
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
                <form style = "margin:30px 10px 10px 5px;" action = "GuestBook_delete_pro.jsp" method="post" name = "fr" onsubmit="return checkAll()">
                    <div class = "font">
                        <label for="pwd" class = "font">PWD: </label>
                        <input name="pwd" autocomplete="off" type="password" maxlength = 10 size = 10"/>
                        <input type = "hidden" name="delete_id" value=<%=delete_id%>>
                        <button id = button type="submit" >Submit</button>
                        <button id = button type="button" onclick="cancle()">Cancle</button>
                    </div>
                </form>
            
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
                    alert("Wrong password!")
                    return false;
                }
                    
                return true;
            }
            function cancle()
            {
                location.href = 'GuestBook.jsp';
            }
        </script>
    </body>
</html>