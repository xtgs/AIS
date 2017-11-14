<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(function(){
        $("#modifyUserAndAdminForm").form("load", "<%=request.getContextPath()%>/user/getUserAndAdminData.do" +
            "?uid=<%=request.getAttribute("uid").toString()%>&randomid=" + Math.random());
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
        $('#loginnameInModify').textbox({
            required: true,
            validType: ['maxLenWithoutTrim[20]','numberAndLetter'],
            missingMessage:'最多输入20个字符',
            prompt:'请输入登录名'
        });
        $('#nameInModify').textbox({
            required: true,
            validType: 'maxLen[20]',
            missingMessage:'最多输入20个字符',
            prompt:'请输入姓名'
        });
        $('#mphoneInModify').textbox({
            required: true,
            validType: ['maxLenWithoutTrim[11]','mphone'] ,
            missingMessage:'以1开头的11位数字',
            prompt:'请输入手机号码'
        });
        $('#department').textbox({
            required: true,
            validType: 'maxLen[20]',
            missingMessage:'最多输入20个字符',
            prompt:'请输入所在中心(部门)'
        });
        $('#ugroup').textbox({
            required: true,
            validType: 'maxLen[20]',
            missingMessage:'最多输入20个字符',
            prompt:'请输入所在班组'
        });
        $('#telphone').textbox({
            required: false,
            validType: ['maxLen[13]'] ,
            missingMessage:'固定电话',
            prompt:'请输入固定电话'
        });
//        $('#remarksInModify').textbox({
//            required: true,
//            validType: 'maxLen[300]',
//            missingMessage:'最多输入300个字符',
//            prompt:'请输入备注'
//        });
        $('#type').on
    });
    function checkMoidfyUserAndAdminFormBeforeSubmit(){
        if($("#loginnameInModify").val().length == 0){
            MsgBox.show("请输入登录名");
            return false;
        }
        var reg_loginname = /^[0-9a-zA-Z]*$/g;
        if(!reg_loginname.test($("#loginnameInModify").val())){
            MsgBox.show("登录名格式不正确，只能为字母或数字组合");
            return false;
        }
        if(StringUtil.getCharNumber($("#loginnameInModify").val()) > 20){
            MsgBox.show("登录名过长，最长20个字符");
            return false;
        }
        if($.trim($("#nameInModify").val()).length == 0){
            MsgBox.show("请输入姓名");
            return false;
        }
        if(StringUtil.getCharNumber($.trim($("#nameInModify").val())) > 20){
            MsgBox.show("姓名过长，最长20个字符");
            return false;
        }
        if($("#mphoneInModify").val().length == 0){
            MsgBox.show("请输入手机号码");
            return false;
        }
        var reg_mphone = /^1\d{10}$/;
        if (!reg_mphone.test($("#mphoneInModify").val())) {
            MsgBox.show("手机号码格式不正确，只能为以1开头的11位数字");
            return false;
        }
        if(StringUtil.getCharNumber($("#remarksInModify").val()) > 300){
            MsgBox.show("备注超长，最多输入300个字符");
            return false;
        }
        if($.trim(($("#department").val())).length == 0){
            MsgBox.show("请输入中心(部门)");
            return false;
        }
        if(StringUtil.getCharNumber($.trim($("#department").val())) > 20){
            MsgBox.show("中心(部门)过长，最长20个字符");
            return false;
        }

        if($.trim(($("#ugroup").val())).length == 0){
            MsgBox.show("请输入班组");
            return false;
        }
        if(StringUtil.getCharNumber($.trim($("#ugroup").val())) > 20){
            MsgBox.show("班组过长，最长20个字符");
            return false;
        }

        return true;
    }
    function submitModifyUserAndAdminForm() {
        if(!checkMoidfyUserAndAdminFormBeforeSubmit()){
            return;
        }
        $.ajax({
            url:"<%=request.getContextPath()%>/user/saveModifyUserAndAdmin.do",
            data:$('#modifyUserAndAdminForm').serialize(),
            type:'post',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                MsgBox.show(data);
                $('#modifyUserAndAdminDialog').dialog('close');
                $('#userAndAdminList').datagrid('reload');
            }
        });
    }
</script>
<div  style="width: 400px;margin: 0 auto;">
    <form id="modifyUserAndAdminForm">
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="2" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">修改管理员信息</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">ID:</td>
                <td><input class="easyui-textbox" readonly id="uid" name="uid"
                           style="width:260px"/></td>
            </tr>
            <tr>
                <td style="text-align: right">登录名:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" readonly id="loginnameInModify"
                           name="loginname" style="width:260px"
                /></td>
                <%--<input type="hidden" id="lognnameOrginalInModifyAdmin"--%>
                       <%--name="loginnameorginal">--%>
            </tr>
            <tr>
                <td style="text-align: right">姓名:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" style="width:260px" id="nameInModify" name="name" /></td>
            </tr>
            <tr>
                <td style="text-align: right">中心(部门):<span style="color:red">*</span></td>
                <td>
                    <input class="easyui-combobox" id="department" name="department" style="width:260px"
                           data-options="url:'<%=request.getContextPath()%>/data/operationDepart_data.json',
                           prompt:'中心(部门)',valueField:'id',textField:'text',panelHeight:'auto'" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right">班组:<span style="color:red">*</span></td>
                <%--<td><input class="easyui-textbox" type="text" id="ugrouup" name="ugroup" style="width:260px" /></td>--%>
                <td>
                    <input id="ugroup" class="easyui-combobox" name="ugroup" style="width:260px"
                           data-options="url:'<%=request.getContextPath()%>/data/operationGroup_data.json',
                           prompt:'班组',valueField:'id',textField:'text',panelHeight:'auto'" />
                </td>
            </tr>

            <tr>
                <td style="text-align: right">性别:</td>
                <td>
                    <span class="radioSpan">
                        <input type="radio" name="gender" value="1" checked="checked">男</input>
                        <input type="radio" name="gender" value="2">女</input>
                    </span>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">手机号码:<span style="color:red">*</span></td>
                <td><input class="easyui-textbox" style="width:260px" id="mphoneInModify" name="mphone" /></td>
            </tr>
            <tr>
                <td style="text-align: right">固定电话:</td>
                <td><input class="easyui-textbox" id="telphone" name="telphone" style="width:260px" /></td>
            </tr>

            <tr>
                <td style="text-align: right;">身份类型:</td>
                <td style="text-align: left;">
                        <span class="radioSpan">
                            <input type="radio" name="type" value="1" checked="checked">普通用户</input>
                            <input type="radio" name="type" value="3">审核员</input>
                            <input type="radio" name="type" value="2">管理员</input>
                        </span>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">审核权限(仅限审核员身份):<span style="color:red">*</span></td>
                <td>
                    <input class="easyui-combobox" id="uauth" name="uauth" style="width:260px"
                           data-options="url:'<%=request.getContextPath()%>/data/auditorAuth_data.json',
                           prompt:'审核权限,默认为空',valueField:'id',textField:'text',multiple:'true',panelHeight:'auto'" />
                </td>
            </tr>
            <%--<tr>--%>
                <%--<td style="text-align: right">管理班组(仅限审核员身份):<span style="color:red">*</span></td>--%>
                <%--<td>--%>
                    <%--<input class="easyui-combobox" id="managegroup" name="managegroup" style="width:260px"--%>
                           <%--data-options="url:'<%=request.getContextPath()%>/data/operationGroup_data.json',--%>
                           <%--prompt:'管理班组,默认只管理自身所在班组',valueField:'id',textField:'text',multiple:'true',panelHeight:'auto'" />--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<input type="hidden" name="type" value="1"/>--%>
            <tr>
                <td style="text-align: right">备注:</td>
                <td><input class="easyui-textbox" id="remarksInModify" name="remarks" data-options="multiline:true" style="width:260px;height:60px;"/></td>
            </tr>
        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitModifyUserAndAdminForm()">保存</a>
    </div>
</div>
