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
                <p class = "font"; style = "font-size:40px; color: #606060;"><b>Post Write</b></p>
            </div>

            <div style = "background-color: #beb6f0; border: 1px solid black; width: 800px;">
                <form style = "margin:30px 10px 10px 5px;" action = "Forum_make_post_pro.jsp" method="post" name = "fr" onsubmit="return checkAll()">
                    <div class = "font">
                        <label for="user" class = "font"><b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbspID:</b> </label>
                        <input name="user" autocomplete="off" type="text" maxlength = 10 size = 10 onkeypress="if(event.keyCode=='13'){event.preventDefault();}"/>

                        <label for="pwd" class = "font"><b>&nbsp&nbsp&nbsp&nbspPWD:</b> </label>
                        <input name="pwd" autocomplete="off" type="password" maxlength = 10 size = 10 onkeypress="if(event.keyCode=='13'){event.preventDefault();}"/>
                    </div>
                    <div class = "font">
                        </br>
                        <label for="title" class = "font"><b>TITLE: </b></label>
                        <input name="title" placeholder = "Input title(1~50 word)" autocomplete="off" type="text" maxlength = 50 style ="width: 580px" onkeypress="if(event.keyCode=='13'){event.preventDefault();}"/>
                    </div>
                    <div class = "font">
                        </br> <b>Content</b> </br>
                        <textarea class = "font" name = "text" placeholder = "Input text(1~1000 word)" maxlength = "1000" style = "height: 30em; margin:10px 10px 0px 0px;"></textarea>
                        <button id = button type="submit" >Submit</button>
                        <button id = button type="button" onclick="return cancle()">Cancle</button>
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
                if(confirm("Cancle it?") == true)
                {
                    location.href = 'Forum.jsp';
                }
                else
                {
                    return false;
                }
                return true;
            }
        </script>
    </body>
</html>