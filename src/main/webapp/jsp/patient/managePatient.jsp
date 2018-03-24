<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><html>
<%@ page import="com.grid.entity.LoginUserBean" %>
<%@ page import="com.grid.util.Constant" %>
<%@ page import="java.net.URLEncoder" %>
    <%
    HttpSession sessionObj = request.getSession(false);
    LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
%>
<script>
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
                { field: 'pid', title: '卡号', width: '16%', sortable:'true', align: 'center'},
                { field: 'cardId', title: '身份证号', width: '16%', sortable:'true', align: 'center'},
                { field: 'name', title: '姓名', width: '7%', sortable:'true', align: 'center'},
                { field: 'birthday', title: '年龄', width: '5%', sortable:'true', align: 'center',
                    formatter:function(date){
                        var unixTimestamp = new Date(date);
                        var nowTime = new Date();
                        return nowTime.getUTCFullYear() - unixTimestamp.getUTCFullYear();
                    }
                },
                { field: 'mphone', title: '手机号', width: '10%', sortable:'true', align: 'center'},
                { field: 'gender', title: '性别', width: '5%', sortable:'true', align: 'center',
                    formatter: function (value) {
                        if(value == "1") {
                            return "男";
                        } else if (value == "2") {
                            return "女";
                        } else {
                            return "未知"
                        }
                    }
                },
                { field: 'balance', title: '余额',width: '7%', sortable:'true', align: 'center'},
                { field: 'createDate', title: '建卡时间', width: '10%', sortable:'true', align: 'center',
                    formatter:function(date){
                        var unixTimestamp = new Date(date);
                        var month = unixTimestamp.getMonth()+1;
                        return unixTimestamp.getUTCFullYear()+"."+ month +"."+unixTimestamp.getDate();
                    }
                },
                <% if(userBean.getUtype().equals("2")) {%>
                { field: "operateAuth", title: '操作',width:'15%', align: 'center',
                    formatter: function (value, rowData, rowIndex) {
                        return '<a href="javascript:void(0)" onclick="fwdChargePage(' + rowIndex + ')">消费</a>&nbsp&nbsp' +
                                '<a href="javascript:void(0)" onclick="fwdTopupPage(' + rowIndex + ')">充值</a>&nbsp&nbsp' +
                                '<a href="javascript:void(0)" onclick="fwdModifyPatientPage(' + rowIndex + ')">修改</a>&nbsp&nbsp' +
                                '<a href="javascript:void(0)" onclick="deletePatient(' + rowIndex + ')">删除</a>';
                    }
                },
                <% } else if (userBean.getUtype().equals("3")) {%>
                { field: "operateAuth", title: '操作',width:'15%', align: 'center',
                    formatter: function (value, rowData, rowIndex) {
                        return '<a href="javascript:void(0)" onclick="fwdChargePage(' + rowIndex + ')">消费</a>&nbsp&nbsp' +
                                '<a href="javascript:void(0)" onclick="fwdTopupPage(' + rowIndex + ')">充值</a>&nbsp&nbsp' +
                                '<a href="javascript:void(0)" onclick="fwdModifyPatientPage(' + rowIndex + ')">修改</a>';
                    }
                },
                <% } else if (userBean.getUtype().equals("1")) {%>
                { field: "operateAuth", title: '操作',width:'15%', align: 'center',
                    formatter: function (value, rowData, rowIndex) {
                        return '<a href="javascript:void(0)" onclick="fwdChargePage(' + rowIndex + ')">消费</a>&nbsp&nbsp' +
                                '<a href="javascript:void(0)" onclick="fwdModifyPatientPage(' + rowIndex + ')">修改</a>';
                    }
                },
                <% }%>
                { field: 'remark', title: '备注', width: '15%', sortable:'true', align: 'center'}
            ]],
            pagination: true
        });
        $('#patientList').datagrid('getPager').pagination({
            pageSize: 10,
            pageNumber: 1,
            pageList: [10,50,100],
            beforePageText: '第',
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示{from} - {to}条,共 {total} 条记录'
        });
    });

    function forwardAddPatientPage(){
        $('#addPatientAndDialog').dialog({
            title: '添加客户',
            width: 500,
            height: 450,
            closed: true,
            cache: false,
            href: "<%=request.getContextPath()%>/patient/fwdAddPatientPage.do?random_id=" + Math.random(),
            modal: true
        });
        $("#addPatientAndDialog").dialog({
            onClose:function(){
                $("#addDevAndDialog").empty();
            }
        });
        $('#addPatientAndDialog').dialog("open");
    }

    function fwdModifyPatientPage(index){
        $('#patientList').datagrid('selectRow',index);// 关键在这里
        var row = $('#patientList').datagrid('getSelected');
        if (row){
            $('#modifyPatientDialog').dialog({
                title: '修改客户信息',
                width: 500,
                height: 450,
                closed: true,
                cache: false,
                modal: true
            });
            $("#modifyPatientDialog").dialog({
                onClose:function(){
                    $("#modifyPatientDialog").empty();
                }
            });
            $('#modifyPatientDialog').dialog("open");
            $("#modifyPatientDialog").dialog("refresh", "<%=request.getContextPath()%>/patient/fwdModifyPatientPage.do?pid="+row.pid);
        }
    }

    function fwdChargePage(index) {
        $('#patientList').datagrid('selectRow',index);// 关键在这里
        var row = $('#patientList').datagrid('getSelected');
        if (row){
            $('#chargeDialog').dialog({
                title: '消费信息',
                width: 500,
                height: 450,
                closed: true,
                cache: false,
                modal: true
            });
            $("#chargeDialog").dialog({
                onClose:function(){
                    $("#chargeDialog").empty();
                }
            });
            $('#chargeDialog').dialog("open");
            $("#chargeDialog").dialog("refresh", "<%=request.getContextPath()%>/patient/fwdChargePage.do?pid="+row.pid);
        }
    }

    function fwdTopupPage(index) {
        $('#patientList').datagrid('selectRow',index);// 关键在这里
        var row = $('#patientList').datagrid('getSelected');
        if (row){
            $('#topupDialog').dialog({
                title: '充值信息',
                width: 500,
                height: 450,
                closed: true,
                cache: false,
                modal: true
            });
            $("#topupDialog").dialog({
                onClose:function(){
                    $("#topupDialog").empty();
                }
            });
            $('#topupDialog').dialog("open");
            $("#topupDialog").dialog("refresh", "<%=request.getContextPath()%>/patient/fwdTopupPage.do?pid="+row.pid);
        }
    }

    function deletePatient(index){
        $('#patientList').datagrid('selectRow',index);// 关键在这里
        var row = $('#patientList').datagrid('getSelected');
        if(row){
            $.messager.confirm('确认','您确认想要删除【' + row.name + '】该账户吗？',function(r){
                if (r){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/patient/deletePatient.do?pid=" + row.pid+"&random_id="+Math.random(),
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
            pageList: [10,50,100]
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
            pageList: [10,50,100]
        });
        $("#patientList").datagrid("reload");
    }

</script>
<div style="padding:2px 0;">
    <div id="viewUserAndAdminDialog" style="text-align: center;"></div>
    <div id="addPatientAndDialog" style="text-align: center;"></div>
    <div id="modifyPatientDialog" style="text-align: center;"></div>
    <div id="chargeDialog" style="text-align: center;"></div>
    <div id="topupDialog" style="text-align: center;"></div>
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
                    <td nowrap="nowrap">性别:</td>
                    <td>
                        <select name="gender" id="gender" class="easyui-combobox"
                                editable="false"  style="width:90%">
                            <option value="" selected>全部</option>
                            <option value="1">男</option>
                            <option value="2">女</option>
                        </select>
                    </td>

                    <td nowrap="nowrap">手机号:</td>
                    <td>
                        <input id="mphone" class="easyui-textbox" name="mphone"
                               data-options="prompt:'手机号'" />
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