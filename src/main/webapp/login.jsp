<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="easyui/demo/demo.css">
    <script type="text/javascript" src="easyui/jquery.min.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="javascript/jquery.md5.js"></script>
    <script type="text/javascript" src="javascript/json2.js"></script>
    <script type="text/javascript" src="javascript/MsgBox.js"></script>
    <style>
        html{
            width: 100%;
            height: 100%;
            margin:0px;
            padding: 0px;
        }
        body{
            width: 100%;
            height: 100%;
            margin:0px;
            padding: 0px;
            text-align: center;
            background-image:url(image/login/login_bg1.jpg);
            background-attachment: fixed;
            background-repeat: no-repeat;
            background-size: cover;
            /*background-size:100%, 100%;*/
            /*background-repeat: no-repeat;*/
        }
        .formTitle {
            height: 55px;
        }
        .formTitle-text {
            height: 100%;
            float: left;
            font: bold 30px/55px "宋体";
        }
    </style>
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
    <div style="height: 70px;width: 100%;"></div>
    <div style="margin: 0 auto;width:380px;height:300px;padding:10px;background:#fafafa;">
        <form id="loginform">
            <br/>
            <table cellpadding="5">
                <tr>
                    <td colspan="2" >
                        <div style="font-size: 30px;float:left;"><img src="<%=request.getContextPath()%>/image/page/sdgrid_logo.png" width="138px" height="45.6px"/>

                        </div>
                        <div style="font-weight:bold; font-size: 20px;float:left;margin-top: 15px;margin-left: 5px">
                              信通台账设备管理系统
                        </div>

                        <%--<div class="formTitle">--%>
                            <%--<div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">信通台账设备管理系统</div>--%>
                        <%--</div>--%>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 20px;"></td>
                </tr>
                <tr>
                    <td style="text-align: right" nowrap="nowrap">用户名:</td>
                    <td><input id="userNameInput" style="width:280px;height: 40px;font: 20px/40px '宋体';" /></td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 20px;"></td>
                </tr>
                <tr>
                    <td style="text-align: right"  nowrap="nowrap">密码:</td>
                    <td><input id="userPwdInput" type="password" style="width:280px;height: 40px;font: 20px/40px '宋体';" /></td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 20px;"></td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center;height: 40px;">
                        <a href="javascript:void(0)" style="font: 20px/40px '宋体'" class="easyui-linkbutton"
                           data-options="iconCls:'icon-save',width:'120px',height:'35px'" onclick="onLogin()">登     录</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>