<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(function(){
        $("#modifyItemForm").form("load", "<%=request.getContextPath()%>/item/getItemById.do" +
                "?iid=<%=request.getAttribute("iid").toString()%>&randomid=" + Math.random());
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
        $('#buildType').textbox({
            required: true,
            prompt:'请输入建设类型'
        });

    });
    function checkMoidfyUserAndAdminFormBeforeSubmit(){
        if($.trim(($("#name").val())).length == 0){
            MsgBox.show("请输入项目名称");
            return false;
        }
        if($.trim(($("#price").val())).length == 0){
            MsgBox.show("请输入项目价格");
            return false;
        }
        return true;
    }

    function submitmodifyItemForm() {
         if(!checkMoidfyUserAndAdminFormBeforeSubmit()){
            return;
         }
        $.ajax({
            url:"<%=request.getContextPath()%>/item/update.do"+
            "?randomid=" + Math.random(),
            data:$('#modifyItemForm').serialize(),
            type:'post',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                MsgBox.show(data);
                $('#modifyItemDialog').dialog('close');
                $('#itemList').datagrid('reload');
            }
        });
    }
</script>
<div  style="width: 400px;margin: 0 auto;">
    <form id="modifyItemForm">
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="2" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">修改项目信息</div>
                    </div>
                </td>
            </tr>

            <tr>
                <td style="text-align: right">ID:</td>
                <td><input id="iid" name="iid" class="easyui-textbox" style="width:260px" readonly/></td>
            </tr>

            <tr>
                <td style="text-align: right">名称:</td>
                <td><input id="name" name="name" class="easyui-textbox" style="width:260px"/></td>
            </tr>

            <tr>
                <td style="text-align: right">价格:</td>
                <td><input id="price" name="price" class="easyui-textbox" style="width:260px"/></td>
            </tr>

        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitmodifyItemForm()">保存</a>
    </div>
</div>
