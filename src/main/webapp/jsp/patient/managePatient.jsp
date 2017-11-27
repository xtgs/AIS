<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><html>
<%@ page import="com.grid.entity.LoginUserBean" %>
<%@ page import="com.grid.util.Constant" %>
<%@ page import="java.net.URLEncoder" %>
    <%
    HttpSession sessionObj = request.getSession(false);
    LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
%>
<script>
    function forwardAddPatientPage(){
        $('#addPatientAndDialog').dialog({
            title: '添加客户',
            width: 500,
            height: 450,
            closed: true,
            cache: false,
            href: "<%=request.getContextPath()%>/dev/fwdAddPatientPage.do?random_id=" + Math.random(),
            modal: true
        });
        $("#addPatientAndDialog").dialog({
            onClose:function(){
                $("#addDevAndDialog").empty();
            }
        });
        $('#addPatientAndDialog').dialog("open");
    }
    $(function () {
        $("#patientList").datagrid({
            title:"客户列表",
            url:"<%=request.getContextPath()%>/patient/queryPatientByParam.do?random_id="+Math.random(),
            rownumbers:true,
            singleSelect:true,
            nowrap:false,//允许换行
            fitColumns:true,
            loadMsg:"正在加载用户数据...",
            columns: [[
                { field: 'pid', title: '卡号', width: '16%', sortable:'true'},
                { field: 'cardId', title: '身份证号', width: '16%', sortable:'true'},
                { field: 'name', title: '姓名', width: '7%', sortable:'true'},
                { field: 'birthday', title: '年龄', width: '4%', sortable:'true',
                    formatter:function(date){
                        var unixTimestamp = new Date(date);
                        var nowTime = new Date();
                        return nowTime.getUTCFullYear() - unixTimestamp.getUTCFullYear();
                    }
                },
                { field: 'mphone', title: '手机号', width: '10%', sortable:'true'},
                { field: 'gender', title: '性别', width: '3%', sortable:'true' },
                { field: 'balance', title: '余额',width: '7%', sortable:'true' },
                { field: 'createDate', title: '建卡时间', width: '9%', sortable:'true',
                    formatter:function(date){
                        var unixTimestamp = new Date(date);
                        var month = unixTimestamp.getMonth()+1;
                        return unixTimestamp.getUTCFullYear()+"."+ month +"."+unixTimestamp.getDate();
                    }
                },
                { field: 'remark', title: '备注', width: '15%', sortable:'true' },
                { field: "operateAuth", title: '操作',width:'10%', align: 'center',
                    formatter: function (value, rowData, rowIndex) {
                        if (value == "0") {
                            return "无操作权限";
                        } else if (value == "1") {
                            return '<a href="javascript:void(0)" onclick="fwdModifyPatientPage(' + rowIndex + ')">修改</a>&nbsp&nbsp' +
                                    '<a href="javascript:void(0)" onclick="deletePatient(' + rowIndex + ')">删除</a>';
                        } else {
                            return "数据错误!";
                        }
                    }
                }
            ]],
            pagination: true
        });
        $('#patientList').datagrid('getPager').pagination({
            pageSize: 10,
            pageNumber: 1,
            pageList: [10,20,30],
            beforePageText: '第',
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示{from} - {to}条,共 {total} 条记录'
        });
    });
    function SearchUserAndAdminByParams() {
        var pid = $("#pid").val();
        var cardId = $("#cardId").val();
        var name = $("#name").val();
        var age = $("#age").val();
        var mphone = $("#mphone").val();
        var gender = $("#gender").val();
        var balanceFrom = $("#balanceFrom").val();
        var balanceTo = $("#balanceTo").val();

        var queryParameter = $('#patientList').datagrid("options").queryParams;
        queryParameter.pid = pid;
        queryParameter.cardId = cardId;
        queryParameter.name = name;
        queryParameter.age = age;
        queryParameter.mphone = mphone;
        queryParameter.gender = gender;
        queryParameter.balanceFrom = balanceFrom;
        queryParameter.balanceTo = balanceTo;
        $('#patientList').datagrid({
            pageNumber: 1,
            pageList: [10,100,1000]
        });
        $("#patientList").datagrid("reload");
    }
    function clearUserAndAdminSearchParams(){
        var queryParameter = $('#patientList').datagrid("options").queryParams;
        queryParameter.pid = null;
        queryParameter.cardId = null;
        queryParameter.name = null;
        queryParameter.age = null;
        queryParameter.mphone = null;
        queryParameter.gender = null;
        queryParameter.balanceFrom = null;
        queryParameter.balanceTo = null;
        $("#queryUserAndAdminParamsForm").form('clear');
        $('#patientList').datagrid({
            pageNumber: 1,
            pageList: [10,100,1000]
        });
        $("#patientList").datagrid("reload");
    }
    function saveResetPassword(index){
        $('#userAndAdminList').datagrid('selectRow',index);
        var row = $('#userAndAdminList').datagrid('getSelected');
        if(row){
            $.messager.confirm('提示信息', '确定要重置[' + row.name +']密码为123456', function(r){
                if (r){
                    var md5Pw = $.md5("123456");
                    $.ajax({
                        url:"<%=request.getContextPath()%>/user/saveResetPassword.do?uid=" + row.uid + "&password=" + md5Pw + "&random_id="+Math.random(),
                        type:'get',
                        async:false,
                        error:function(data){
                            MsgBox.show(data.responseText);
                        },
                        success:function(data){
                            MsgBox.show(data);
                        }
                    });
                }
            });
        }
    }
    function fwdModifyPatientPage(index){
        $('#patientList').datagrid('selectRow',index);// 关键在这里
        var row = $('#patientList').datagrid('getSelected');
        if (row){
            $('#modifyPatientDialog').dialog({
                title: '修改台账信息',
                width: 500,
                height: 450,
                closed: true,
                cache: false,
                modal: true
            });
            $("#modifyPatientDialog").dialog({
                onClose:function(){
                    $("#modifyDevDialog").empty();
                }
            });
            $('#modifyPatientDialog').dialog("open");
            $("#modifyPatientDialog").dialog("refresh", "<%=request.getContextPath()%>/dev/fwdModifyDevPage.do?id="+row.vid);
        }
    }

    function deletePatient(index){
        $('#patientList').datagrid('selectRow',index);// 关键在这里
        var row = $('#patientList').datagrid('getSelected');
        if(row){
            $.messager.confirm('确认','您确认想要删除【' + row.deployedSystem + '】吗？',function(r){
                if (r){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/dev/deleteDev.do?vid=" + row.vid+"&random_id="+Math.random(),
                        type:'post',
                        async:false,
                        error:function(data){
                            MsgBox.show(data.responseText);
                        },
                        success:function(data){
                            MsgBox.show(data);
                            $('#patientList').datagrid('reload');
                        }
                    });
                }
            });
        }
    }

</script>
<div style="padding:2px 0;">
    <div id="viewUserAndAdminDialog" style="text-align: center;"></div>
    <div id="addDevAndDialog" style="text-align: center;"></div>
    <div id="modifyDevDialog" style="text-align: center;"></div>
    <div style="margin:0px auto;width: 950px;">
        <form id="queryUserAndAdminParamsForm">
            <table cellpadding="5">
                <tr>
                    <td colspan="8" >
                        <div class="formTitle" style="background-color:#f2f2f2;">
                            <div class="formTitle-icon">
                            </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">条件筛选</div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">卡号:</td>
                    <td>
                        <input id="pid" class="easyui-textbox" name="pid" data-options="prompt:'卡号'" />
                    </td>

                    <td nowrap="nowrap">身份证号:</td>
                    <td>
                        <input id="cardId" class="easyui-textbox" name="cardId"
                               data-options="prompt:'身份证号'" />
                    </td>

                    <td nowrap="nowrap">姓名:</td>
                    <td>
                        <input class="easyui-textbox" data-options="prompt:'姓名'" id="name" name="name"/>
                    </td>

                    <td nowrap="nowrap">年龄:</td>
                    <td>
                        <input class="easyui-textbox" data-options="prompt:'年龄'" id="age" name="age"/>
                    </td>

                </tr>
                <tr>
                    <td nowrap="nowrap">手机号:</td>
                    <td>
                        <input id="mphone" class="easyui-textbox" name="mphone"
                               data-options="prompt:'手机号'" />
                    </td>

                    <td nowrap="nowrap">性别:</td>
                    <td>
                        <select name="gender" id="gender" class="easyui-combobox"
                                editable="false"  style="width:100%">
                            <option value="" selected>全部</option>
                            <option value="1">男</option>
                            <option value="2">女</option>
                        </select>
                    </td>

                    <td nowrap="nowrap">余额:</td>
                    <td>
                        <input class="easyui-textbox" data-options="prompt:'起始金额'" id="balanceFrom" class="easyui-combobox" style="width: 30%" name="balance"/>
                        -
                        <input class="easyui-textbox" data-options="prompt:'终止金额'" id="balanceTo" class="easyui-combobox" style="width: 30%" name="balance"/>
                    </td>

                    <td align="center" colspan="2">
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="SearchUserAndAdminByParams()">检索</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="clearUserAndAdminSearchParams()">清空条件</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <table id="patientList" style="width: auto;height: auto;">
    </table>
    <br/>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddPatientPage()">新增一条客户信息</a>
    <br/>


</div>