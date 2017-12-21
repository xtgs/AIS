<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(function(){
        $("#modifyDevForm").form("load", "<%=request.getContextPath()%>/dev/getDevData.do" +
                "?id=<%=request.getAttribute("id").toString()%>&randomid=" + Math.random());
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
        $('#operationGroup').textbox({
            required: true,
            prompt:'请输入运维组'
        });
        $('#deployedSystem').textbox({
            required: true,
            prompt:'请输入部署应用系统'
        });
        $('#devName').textbox({
            required: true,
            prompt:'请输入设备名称'
        });
        $('#operationDepart').textbox({
            required: true,
            prompt:'请输入运维部门'
        });
        $('#machineRoom').textbox({
            required: true,
            prompt:'请输入所在机房'
        });
        $('#devNum').textbox({
            required: true,
            validType: ['maxLenWithoutTrim[20]','numberAndLetter'],
            prompt:'请输入机柜设备编号'
        });
        $('#installLocationFrom').textbox({
            required: true,
            validType: ['maxLenWithoutTrim[20]','numberAndLetter'],
            prompt:'起始U数'
        });
        $('#installLocationTo').textbox({
            required: true,
            validType: ['maxLenWithoutTrim[20]','numberAndLetter'],
            prompt:'终止U数'
        });
        $('#devType').textbox({
            required: true,
            prompt:'请输入设备类型'
        });
        $('#devModel').textbox({
            required: true,
            prompt:'请输入设备型号'
        });
        $('#brand').textbox({
            required: true,
            prompt:'请输入品牌'
        });
        $('#devManagePerson').textbox({
            required: true,
            prompt:'请输入设备负责人'
        });
        $('#devManagePhone').textbox({
            required: true,
            validType: ['maxLenWithoutTrim[20]','numberAndLetter'] ,
            prompt:'请输入设备负责人联系方式'
        });
        $('#businessMan').textbox({
            required: false,
            prompt:'请输入业务部门联系人'
        });
        $('#businessPhone').textbox({
            required: false,
            validType: ['maxLenWithoutTrim[20]','numberAndLetter'] ,
            prompt:'请输入业务部门联系方式'
        });
        $('#serviceLinkman').textbox({
            required: false,
            prompt:'请输入服务商联系人'
        });
        $('#servicePhone').textbox({
            required: false,
            validType: ['maxLenWithoutTrim[20]','numberAndLetter'] ,
            prompt:'请输入服务商联系方式'
        });
        $('#powerNum').textbox({
            required: false,
            validType: ['maxLenWithoutTrim[20]','numberAndLetter'],
            prompt:'请输入电源数量'
        });
        $('#power').textbox({
            required: false,
            prompt:'请输入电源功率'
        });
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
        if($.trim(($("#deployedSystem").val())).length == 0){
            MsgBox.show("请输入部署应用系统");
            return false;
        }
        if($.trim(($("#devName").val())).length == 0){
            MsgBox.show("请输入设备名称");
            return false;
        }
        if($.trim(($("#operationDepart").val())).length == 0){
            MsgBox.show("请输入运维部门");
            return false;
        }
        if($.trim(($("#machineRoom").val())).length == 0){
            MsgBox.show("请输入所在机房");
            return false;
        }
        if($.trim(($("#devNum").val())).length == 0){
            MsgBox.show("请输入机柜设备编号");
            return false;
        }
        if($.trim(($("#installLocationFrom").val())).length == 0){
            MsgBox.show("请输入安装位置的起始位置");
            return false;
        }
        if($.trim(($("#installLocationTo").val())).length == 0){
            MsgBox.show("请输入安装位置的终止位置");
            return false;
        }
        if($.trim(($("#devType").val())).length == 0){
            MsgBox.show("请输入设备类型");
            return false;
        }
        if($.trim(($("#devModel").val())).length == 0){
            MsgBox.show("请输入设备型号");
            return false;
        }
        if($.trim(($("#brand").val())).length == 0){
            MsgBox.show("请输入设备品牌");
            return false;
        }
        if($.trim(($("#devManagePerson").val())).length == 0){
            MsgBox.show("请输入设备负责人");
            return false;
        }
        if($.trim(($("#devManagePhone").val())).length == 0){
            MsgBox.show("请输入设备负责人联系方式");
            return false;
        }
        return true;
    }
    function submitModifyDevForm() {
         if(!checkMoidfyUserAndAdminFormBeforeSubmit()){
            return;
         }
        $.ajax({
            url:"<%=request.getContextPath()%>/dev/saveModifyDev.do"+
            "?id=<%=request.getAttribute("id").toString()%>&randomid=" + Math.random(),
            data:$('#modifyDevForm').serialize(),
            type:'post',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                MsgBox.show(data);
                $('#modifyDevDialog').dialog('close');
                $('#devList').datagrid('reload');
            }
        });
    }
</script>
<div  style="width: 400px;margin: 0 auto;">
    <form id="modifyDevForm">
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
                <td style="text-align: right">建设类型:<span style="color:red">*</span></td>
                <td>
                    <input id="buildType" class="easyui-combobox" name="buildType" style="width:200px"
                           data-options="valueField:'id',textField:'text',url:'<%=request.getContextPath()%>/data/buildType_data.json'" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right">运维组:<span style="color:red">*</span></td>
                <td>
                    <input id="operationGroup" class="easyui-combobox" name="operationGroup" style="width:200px"
                           data-options="valueField:'id',textField:'text',url:'<%=request.getContextPath()%>/data/operationGroup_data.json'" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right">部署应用系统:<span style="color:red">*</span></td>
                <td><input id="deployedSystem" name="deployedSystem" style="width:260px" /></td>
            </tr>
            <tr>
                <td style="text-align: right">设备名称:<span style="color:red">*</span></td>
                <td><input id="devName" name="devName" style="width:260px" /></td>
            </tr>
            <tr>
                <td style="text-align: right">运维部门:<span style="color:red">*</span></td>
                <td>
                    <input id="operationDepart" name="operationDepart" class="easyui-combobox" style="width:200px"
                           data-options="valueField:'id',textField:'text',url:'<%=request.getContextPath()%>/data/operationDepart_data.json'" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right">所在机房:<span style="color:red">*</span></td>
                <td>
                    <input id="machineRoom" name="machineRoom" class="easyui-combobox" style="width:200px"
                           data-options="valueField:'id',textField:'text',url:'<%=request.getContextPath()%>/data/machineRoom_data.json'" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right">机柜设备编号:<span style="color:red">*</span></td>
                <td><input id="devNum" name="devNum" style="width:260px" /></td>
            </tr>
            <tr>
                <td style="text-align: right">安装位置:<span style="color:red">*</span></td>
                <td>
                    <input id="installLocationFrom" name="installLocationFrom" style="width:80px" />
                    <span> - </span>
                    <input id="installLocationTo" name="installLocationTo" style="width:80px" />
                    <span>u</span>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">设备类型:<span style="color:red">*</span></td>
                <td>
                    <input id="devType" name="devType" class="easyui-combobox" style="width:200px"
                           data-options="valueField:'id',textField:'text',url:'<%=request.getContextPath()%>/data/devType_data.json'" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right">设备型号:<span style="color:red">*</span></td>
                <td>
                    <input id="devModel" name="devModel" class="easyui-combobox" style="width:200px"
                           data-options="valueField:'id',textField:'text',url:'<%=request.getContextPath()%>/data/devModel_data.json'" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right">品牌:<span style="color:red">*</span></td>
                <td>
                    <input id="brand" name="brand" class="easyui-combobox" style="width:200px"
                           data-options="valueField:'id',textField:'text',url:'<%=request.getContextPath()%>/data/brand_data.json'" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right">设备负责人:<span style="color:red">*</span></td>
                <td><input id="devManagePerson" name="devManagePerson" style="width:260px" /></td>
            </tr>
            <tr>
                <td style="text-align: right">设备负责人联系方式:<span style="color:red">*</span></td>
                <td><input id="devManagePhone" name="devManagePhone" style="width:260px" /></td>
            </tr>
            <tr>
                <td style="text-align: right">业务部门联系人:<span style="color:red">*</span></td>
                <td><input id="businessMan" name="businessMan" style="width:260px" /></td>
            </tr>
            <tr>
                <td style="text-align: right">业务部门联系方式:<span style="color:red">*</span></td>
                <td><input id="businessPhone" name="businessPhone" style="width:260px" /></td>
            </tr>
            <tr>
                <td style="text-align: right">服务商联系人:</td>
                <td><input id="serviceLinkman" name="serviceLinkman" style="width:260px" /></td>
            </tr>
            <tr>
                <td style="text-align: right">服务商联系方式:</td>
                <td><input id="servicePhone" name="servicePhone" style="width:260px" /></td>
            </tr>
            <tr>
                <td style="text-align: right">电源数量:</td>
                <td><input id="powerNum" name="powerNum" style="width:260px" /></td>
            </tr>
            <tr>
                <td style="text-align: right">电源功率:</td>
                <td><input id="power" name="power" style="width:260px" /></td>
            </tr>
        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitModifyDevForm()">保存</a>
    </div>
</div>
