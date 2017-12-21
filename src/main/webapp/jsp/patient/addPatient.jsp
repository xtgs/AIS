<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        $('#mphone').textbox({
            required: false,
            validType: ['maxLenWithoutTrim[20]','numberAndLetter'],
            prompt:'请输入联系方式'
        });
        $('#powerNum').textbox({
            required: false,
            validType: ['maxLenWithoutTrim[20]','numberAndLetter'],
            prompt:'请输入电源数量'
        });
    });
    function checkAddUserAndAdminFormBeforeSubmit(){
        if($.trim(($("#buildType").val())).length == 0){
            MsgBox.show("请输入建设类型");
            return false;
        }
        return true;
    }
    function submitPatientForm(){
//         if(!checkAddUserAndAdminFormBeforeSubmit()){
//            return;
//        }
        $.ajax({
            url:"<%=request.getContextPath()%>/patient/saveAddPatient.do",
            data:$('#PatientForm').serialize(),
            type:'post',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                MsgBox.show(data);
                $('#addPatientAndDialog').dialog('close');
                $('#patientList').datagrid('reload');
            }
        });
    }
</script>
<div style="width: 450px;margin: 0 auto;">
    <form id="PatientForm">
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="2" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">填写台账信息</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">卡号:<span style="color:red">*</span></td>
                <td>
                    <input id="pid" class="easyui-textbox" name="pid" style="width:260px"/>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">身份证号:<span style="color:red">*</span></td>
                <td>
                    <input id="cardId" class="easyui-textbox" name="cardId" style="width:260px"/>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">姓名:<span style="color:red">*</span></td>
                <td><input id="name" name="name" class="easyui-textbox" style="width:260px" /></td>
            </tr>
            <tr>
                <td style="text-align: right">手机号:<span style="color:red">*</span></td>
                <td><input id="mphone" name="mphone" class="easyui-textbox" style="width:260px" /></td>
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
                <td style="text-align: right">余额:</td>
                <td><input id="balance" name="balance" class="easyui-textbox" style="width:260px" /></td>
            </tr>
            <tr>
                <td style="text-align: right">备注:</td>
                <td style="text-align: left;"><input class="easyui-textbox" id="remark" name="remark" data-options="multiline:true" style="width:260px;height:60px"/></td>
            </tr>
        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitPatientForm()">保存</a>
    </div>
</div>