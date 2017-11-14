<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.grid.util.Constant" %>
<%@ page import="com.grid.entity.LoginUserBean" %>
<%
    HttpSession sessionObj = request.getSession(false);
    LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
%>
<script type="text/javascript">
    $(function () {
        $.extend($.fn.validatebox.defaults.rules, {
            maxLen:{
                validator: function (value, param) {
                    var result = true;
                    if(StringUtil.getCharNumber($.trim(value)) > param[0]){
                        result = false;
                    }
                    return result;
                },
                message:'已超长，最多输入{0}个字符'
            },
            maxLenWithoutTrim:{
                validator: function (value, param) {
                    var result = true;
                    if(StringUtil.getCharNumber(value) > param[0]){
                        result = false;
                    }
                    return result;
                },
                message:'已超长，最多输入{0}个字符'
            },
            numberAndLetter:{
                validator: function (value, param) {
                    var reg_loginname = /^[0-9a-zA-Z]*$/g;
                    return reg_loginname.test(value);
                },
                message:'格式不正确，只能为字母或数字组合'
            },
            mphone:{
                validator: function (value, param) {
                    var reg = /^1\d{10}$/;
                    return reg.test(value);
                },
                message:'格式不正确，只能为以1开头的11位数字'
            }
        });

        $('#password').textbox({
            required: true,
            validType: ['maxLenWithoutTrim[20]','numberAndLetter'],
            missingMessage:'最多输入20个字符'
//            prompt:'请输入密码'
        });
        $('#password2').textbox({
            required: true,
            validType: ['maxLenWithoutTrim[20]','numberAndLetter'],
            missingMessage:'最多输入20个字符'
//            prompt:'请再次输入密码'
        });
        $('#oldPassword').textbox({
            required: true,
            validType: ['maxLenWithoutTrim[20]','numberAndLetter'],
            missingMessage:'最多输入20个字符'
//            prompt:'请再次输入密码'
        });
    });
    function checkAddUserAndAdminFormBeforeSubmit(){
        if($("#oldPassword").val().length == 0){
            MsgBox.show("请输入原密码");
            return false;
        }

        if($("#password").val().length == 0){
            MsgBox.show("请输入新密码");
            return false;
        }
        if($("#password2").val().length == 0){
            MsgBox.show("请再次输入新密码");
            return false;
        }
        if($("#password").val() != $("#password2").val()){
            MsgBox.show("两次输入的新密码不同!");
            return false;
        }

        return true;
    }
    function submitAddUserAndAdminForm(){
        if(!checkAddUserAndAdminFormBeforeSubmit()){
            return;
        }
        var md5Pw = $.md5($("#password").val());
        var md5OldPw = $.md5($("#oldPassword").val());
        $.ajax({
            url:"<%=request.getContextPath()%>/user/saveNewPassword.do",
            data:{oldPassword:md5OldPw, password:md5Pw},
            type:'post',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                MsgBox.show(data);
                $('#modifyPasswordDialog').dialog('close');
            }
        });
    }
</script>
<div style="width: 400px;margin: 0 auto;">
    <form id="addUserAndAdminForm">
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="2" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">修改密码</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">姓名:<span style="color:red">*</span></td>
                <td><%=userBean.getUname()%></td>
            </tr>
            <tr>
                <td style="text-align: right">输入原密码:<span style="color:red">*</span></td>
                <td><input type="password" id="oldPassword" name="oldPassword"
                           style="width:260px" /></td>
            </tr>

            <tr>
                <td style="text-align: right">输入新密码:<span style="color:red">*</span></td>
                <td><input type="password" id="password" name="password"
                           style="width:260px" /></td>
            </tr>
            <tr>
                <td style="text-align: right">重复新密码:<span style="color:red">*</span></td>
                <td><input type="password" id="password2" name="password2" style="width:260px" /></td>
            </tr>
        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitAddUserAndAdminForm()">保存</a>
    </div>
</div>