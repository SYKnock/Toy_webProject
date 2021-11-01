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

            <div style = "width: 800px; background-color: #beb6f0; border: 1px solid black;">
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    request.setCharacterEncoding("UTF-8");
                    String update_id = request.getParameter("comment_id");
                    String post_id = request.getParameter("post_id");
                    String correct_pwd = request.getParameter("correct_pwd");
                    String comment_pwd = request.getParameter("comment_pwd");
                    String current_text = null;
                    String id = null;

                    if(comment_pwd =="")
                    {
                %>
                        <script>
                            alert("Please input [PWD]");
                            location.href = "Forum_post.jsp?id=" + <%=post_id%>;
                        </script>
                <%
                    }
                    else
                    {
                        if(comment_pwd.equals(correct_pwd))
                        {
                            try
                            {

                                Class.forName("com.mysql.jdbc.Driver");
                                String mysql_url = "jdbc:mysql://172.17.0.3:3306/forum?useSSL=false";
                                conn = (Connection)DriverManager.getConnection(mysql_url, "root", "mysql");
                                stmt = conn.createStatement();
                                if(stmt.execute("select * from comment where _id=" + update_id)){rs = stmt.getResultSet();}
                                rs.next();
                                current_text = rs.getString("content");
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
                        }
                        else
                        {
                %>
                            <script>
                                alert("Wrong password!");
                                location.href = "Forum_post.jsp?id=" + <%=post_id%>;
                            </script>
                <%
                        }
                    }
                            
                %> 
                <div class="font" style = "padding: 10px 10px 10px 10px; font-size:20px">
                    Edit Comment
                </div>
                <form style = "margin:5px 10px 10px 10px;" action = "Comment_update_pro.jsp" method="post" name = "fr_comment_update" onsubmit="return checkAll_comment_update()">
                    <div>
                        <label for="user" class = "font">ID: <%=id%></label>
                        <input type = "hidden" name="post_id" value=<%=post_id%>>
                        <input type = "hidden" name="id" value=<%=update_id%>>
                    </div>
                    <div>
                        <textarea class = "font" name = "text" maxlength = "100" style = "margin:10px 10px 0px 0px; width: 80%; height: 5em"><%=current_text%></textarea>
                        <button id = button type="submit" >Submit</button>
                        <button id = button type="button" onclick="cancle()">Cancle</button>
                    </div>
                </form>
            </div>
            
        </div>
        <script>
            function checkAll_comment_update()
            {
                var obj = document.fr_comment_update;
                var alert_text = "Please input";
                var flag = true;
                

                if(obj.text.value == "")
                {
                    alert_text = alert_text + " [TEXT]";
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
                location.href = "Forum_post.jsp?id=" + <%=post_id%>;
            }
        </script>
    </body>
</html>