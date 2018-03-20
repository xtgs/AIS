<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.grid.util.Constant" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/themes/default/easyui.css?_=<%=Constant.FrontEndVersion%>">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/themes/icon.css?_=<%=Constant.FrontEndVersion%>">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/demo/demo.css?_=<%=Constant.FrontEndVersion%>">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/OBM.css?_=<%=Constant.FrontEndVersion%>">
    <link type="text/css" rel="stylesheet" href="css/login.css?_=<%=Constant.FrontEndVersion%>">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/OBM.css?_=<%=Constant.FrontEndVersion%>" >
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/jquery.min.js?_=<%=Constant.FrontEndVersion%>"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/jquery.easyui.min.js?_=<%=Constant.FrontEndVersion%>"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.md5.js?_=<%=Constant.FrontEndVersion%>"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/json2.js?_=<%=Constant.FrontEndVersion%>"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/MsgBox.js?_=<%=Constant.FrontEndVersion%>"></script>
    <title>系统登录</title>
    <script type="text/javascript">
        function onLogin(){
            if(!($("#userNameInput").val())){
                MsgBox.show("请输入用户名");
                $("#userNameInput").focus();
                return;
            }
            var reg_loginname = /^[0-9a-zA-Z]*$/g;
            if(!reg_loginname.test($("#userNameInput").val())){
                MsgBox.show("登录名格式不正确，只能为字母或数字组合");
                return false;
            }
            if(!($("#userPwdInput").val())){
                MsgBox.show("请输入密码");
                $("#userPwdInput").focus();
                return;
            }
            var reg_password = /^[0-9a-zA-Z]*$/g;
            if(!reg_password.test($("#userPwdInput").val())){
                MsgBox.show("密码格式不正确，只能为字母或数字组合");
                return false;
            }
            var md5Pw = $.md5($("#userPwdInput").val());
            $.ajax({
                url:"<%=request.getContextPath()%>/login/doLoginCheck.do?random_id="+Math.random(),
                data: {loginname:$("#userNameInput").val(), password:md5Pw},
                type:'post',
                async:false,
                error:function(data){
                    MsgBox.show(data.responseText);
                },
                success:function(data){
                    var resultObj = JSON.parse(data);
                    location.href=resultObj.redirectUrl + "?random_id="+Math.random();
                }
            });
        }
        $(function(){
            $('#userNameInput').bind('keypress',function(event){
                if(event.keyCode == 13)
                {
                    onLogin();
                }
            });
            $('#userPwdInput').bind('keypress',function(event){
                if(event.keyCode == 13)
                {
                    onLogin();
                }
            });
        });

    </script>
</head>
<body>
<%-- 背景图片 --%>
<img class="dw-logon-bg" src="image/login/timg.jpg">
<%--<div class="dw-logon-logo"></div>--%>
<div class="dw-logon-form">
    <form id="loginform">
        <input type="text" id="userNameInput" class="dw-logon-form-loginname"/>
        <input type="password" id="userPwdInput" class="dw-logon-form-pwd"/>
        <input type="button" id="logonBtn" class="dw-logon-form-btnlogin" onclick="onLogin()"/>
    </form>
</div>
</body>
</html>