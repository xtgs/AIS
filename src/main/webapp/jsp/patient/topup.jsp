<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(function(){
        $("#topupForm").form("load", "<%=request.getContextPath()%>/patient/getPatientByPid.do" +
                "?pid=<%=request.getAttribute("pid").toString()%>&randomid=" + Math.random());
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
        $("#birthday").textbox({
            formatter:function(row){
                var unixTimestamp = new Date(row.value);
                var month = unixTimestamp.getMonth()+1;
                return unixTimestamp.getUTCFullYear()+"-"+ month +"-"+unixTimestamp.getDate();
            }
        });
//        $("#charge").textbox('textbox').css("font-size", "68px");
    });


    function checkMoidfyUserAndAdminFormBeforeSubmit(){
        if($.trim(($("#buildType").val())).length == 0){
            MsgBox.show("请输入建设类型");
            return false;
        }
        if($.trim(($("#operationGroup").val())).length == 0){
            MsgBox.show("请输入运维组");
            return false;
        }

        return true;
    }
    function submitTopup() {
//         if(!checkMoidfyUserAndAdminFormBeforeSubmit()){
//            return;
//         }
        $.ajax({
            url:"<%=request.getContextPath()%>/patient/saveTopup.do"+
            "?randomid=" + Math.random(),
            data:$('#topupForm').serialize(),
            type:'post',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                MsgBox.show(data);
                $('#topupDialog').dialog('close');
                $('#patientList').datagrid('reload');
            }
        });
    }
</script>
<div  style="width: 400px;margin: 0 auto;">
    <form id="topupForm">
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
                <td style="text-align: right">卡号:</td>
                <td>
                    <input id="pid" class="easyui-textbox" name="pid" style="width:260px" readonly/>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">身份证号:</td>
                <td>
                    <input id="cardId" class="easyui-textbox" name="cardId" style="width:260px" readonly/>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">姓名:</td>
                <td><input id="name" name="name" class="easyui-textbox" style="width:260px" readonly/></td>
            </tr>
            <tr>
                <td style="text-align: right">手机号:</td>
                <td><input id="mphone" name="mphone" class="easyui-textbox" style="width:260px" readonly/></td>
            </tr>
            <tr>
                <td style="text-align: right">余额:</td>
                <td><input id="balance" name="balance" class="easyui-textbox" style="width:260px" readonly/></td>
            </tr>
            <tr>
                <td></td>
                <td style="text-align: center; font-size: 26px;">充值金额:</td>
            </tr>
            <tr>
                <td></td>
                <td><input id="topup" name="topup" type="textbox"
                           style="width:260px; height: 50px; text-align: center; font-size: 40px" /></td>
                <td>元</td>
            </tr>
        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitTopup()">保存</a>
    </div>
</div>
