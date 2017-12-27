<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><html>
<%@ page import="com.grid.util.Constant" %>
<%@ page import="com.grid.entity.LoginUserBean" %>
<%
    HttpSession sessionObj = request.getSession(false);
    LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
%>
<script>
    $(function () {
        $("#userAndAdminList").datagrid({
            title:"员工列表",
            url:"<%=request.getContextPath()%>/user/queryAllUserAndAdmin.do?random_id="+Math.random(),
            rownumbers:true,
            singleSelect:true,
            fitColumns:true,
            loadMsg:"正在加载用户数据...",
            columns: [[
                { field: 'uid', title: 'ID', width: '10%'},
                { field: 'name', title: '姓名', width: '7%'},
                { field: 'loginname', title: '登录名', width: '12%'},
                { field: 'department', title: '部门',width: '10%' },
                { field: 'gender', title: '性别', width: '4%'},
                { field: 'mphone', title: '手机号码', width: '10%'},
                { field: 'telphone', title: '固定电话', width: '10%'},
                { field: 'type', title: '身份类型', width: '7%' },
                { field: 'operateID', title: '操作',width:'15%', align: 'center',
                    formatter: function (value, rowData, rowIndex) {
                        return '<a href="javascript:void(0)" onclick="saveResetPassword('+rowIndex+')">重置密码</a>&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="fwdModifyUserAndAdminPage('+rowIndex+')">修改</a>&nbsp&nbsp' +
                            '<a href="javascript:void(0)" onclick="saveDeleteUserAndAdmin('+rowIndex+')">删除</a>';
                    }
                },
                { field: 'createDatestr', title: '创建时间',width: '17%' },
                { field: 'remarks', title: '备注', width: '15%' }
            ]],
            pagination: true
        });
        $('#userAndAdminList').datagrid('getPager').pagination({
            pageSize: 10,
            pageNumber: 1,
            pageList: [10,20,30],
            beforePageText: '第',
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示{from} - {to}条,共 {total} 条记录'
        });
    });
    function forwardAddUserAndAdminPage(){
        $('#addUserAndDialog').dialog({
            title: '新增用户和管理员',
            width: 500,
            height: 450,
            closed: true,
            cache: false,
            href: "<%=request.getContextPath()%>/user/fwdAddUserAndAdminPage.do?random_id=" + Math.random(),
            modal: true
        });
        $("#addUserAndDialog").dialog({
            onClose:function(){
                $("#addUserAndDialog").empty();
            }
        });
        $('#addUserAndDialog').dialog("open");
    }
    function SearchUserAndAdminByParams() {
        var mphoneCondition = $("#mphoneCondition").val();
        var nameCondition = $("#nameCondition").val();
        var loginnameCondition = $("#loginnameCondition").val();
        var genderCondition = $("#genderCondition").val();
        var typeCondition = $("#typeCondition").val();
        var starttimeCondition = $('#starttimeCondition').datetimebox('getValue');
        var endtimeCondition = $('#endtimeCondition').datetimebox('getValue');
        var departCondition = $("#departCondition").val();
        var groupCondition = $("#groupCondition").val();
        var telphoneCondition = $("#telphoneCondition").val();
        if(starttimeCondition && endtimeCondition){
            if(starttimeCondition > endtimeCondition){
                MsgBox.show("起始时间大于结束时间，无法检索");
                return;
            }
        }
        var queryParameter = $('#userAndAdminList').datagrid("options").queryParams;
        queryParameter.mphoneCondition = mphoneCondition;
        queryParameter.nameCondition = nameCondition;
        queryParameter.loginnameCondition = loginnameCondition;
        queryParameter.genderCondition = genderCondition;
        queryParameter.typeCondition = typeCondition;
        queryParameter.starttimeCondition = starttimeCondition;
        queryParameter.endtimeCondition = endtimeCondition;
        queryParameter.departCondition = departCondition;
        queryParameter.groupCondition = groupCondition;
        queryParameter.telphoneCondition = telphoneCondition;
        queryParameter.queryByParamFlag = Math.random();
        $('#userAndAdminList').datagrid({
            pageNumber: 1,
            pageList: [10,20,30]
        });
        $("#userAndAdminList").datagrid("reload");
    }
    function clearUserAndAdminSearchParams(){
        var queryParameter = $('#userAndAdminList').datagrid("options").queryParams;
        queryParameter.mphoneCondition = null;
        queryParameter.nameCondition = null;
        queryParameter.loginnameCondition = null;
        queryParameter.genderCondition = null;
        queryParameter.starttimeCondition = null;
        queryParameter.typeCondition = null;
        queryParameter.endtimeCondition = null;
        queryParameter.departCondition = null;
        queryParameter.groupCondition = null;
        queryParameter.telphoneCondition = null;
        queryParameter.queryByParamFlag = Math.random();
        $("#queryUserAndAdminParamsForm").form('clear');
        $("#genderCondition").combobox('setValue','0');
        $("#typeCondition").combobox('setValue','0');
        $('#userAndAdminList').datagrid({
            pageNumber: 1,
            pageList: [10,20,30]
        });
        $("#userAndAdminList").datagrid("reload");
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
    function fwdModifyUserAndAdminPage(index){
        $('#userAndAdminList').datagrid('selectRow',index);// 关键在这里
        var row = $('#userAndAdminList').datagrid('getSelected');
        if (row){
            $('#modifyUserAndAdminDialog').dialog({
                title: '修改管理员信息',
                width: 500,
                height: 450,
                closed: true,
                cache: false,
                modal: true
            });
            $("#modifyUserAndAdminDialog").dialog({
                onClose:function(){
                    $("#modifyUserAndAdminDialog").empty();
                }
            });
            $('#modifyUserAndAdminDialog').dialog("open");
            $("#modifyUserAndAdminDialog").dialog("refresh", "<%=request.getContextPath()%>/user/fwdModifyUserAndAdminPage.do?uid="+row.uid);
        }
    }
    function saveDeleteUserAndAdmin(index){
        $('#userAndAdminList').datagrid('selectRow',index);// 关键在这里
        var row = $('#userAndAdminList').datagrid('getSelected');
        if(row){
            $.messager.confirm('确认','您确认想要删除【' + row.name + '】吗？',function(r){
                if (r){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/user/saveDeleteUserAndAdmin.do?uid=" + row.uid+"&random_id="+Math.random(),
                        type:'get',
                        async:false,
                        error:function(data){
                            MsgBox.show(data.responseText);
                        },
                        success:function(data){
                            MsgBox.show(data);
                            $('#userAndAdminList').datagrid('reload');
                        }
                    });
                }
            });
        }
    }
</script>
<div style="padding:2px 0;">
    <div id="viewUserAndAdminDialog" style="text-align: center;"></div>
    <div id="addUserAndDialog" style="text-align: center;"></div>
    <div id="modifyUserAndAdminDialog" style="text-align: center;"></div>
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
                    <td nowrap="nowrap">姓名:</td>
                    <td><input class="easyui-textbox" data-options="prompt:'姓名'" id="nameCondition" name="nameCondition"/></td>
                    <td nowrap="nowrap">登录名:</td>
                    <td><input class="easyui-textbox" data-options="prompt:'登录名'" id="loginnameCondition" name="loginnameCondition"/></td>
                    <td nowrap="nowrap">部门:</td>
                    <td>
                        <input id="departCondition" class="easyui-combobox" name="departCondition" data-options="prompt:'部门'" />
                    </td>
                    <td nowrap="nowrap">性别:</td>
                    <td>
                        <select name="genderCondition" id="genderCondition" class="easyui-combobox"
                                editable="false"  style="width:100%">
                            <option value="0" selected>全部</option>
                            <option value="1">男</option>
                            <option value="2">女</option>
                        </select>
                    </td>
                </tr>
                <tr>

                    <td nowrap="nowrap">手机号码:</td>
                    <td><input class="easyui-textbox" data-options="prompt:'手机号码'" id="mphoneCondition" name="mphoneCondition"/></td>
                    <td nowrap="nowrap">固定电话:</td>
                    <td><input class="easyui-textbox" data-options="prompt:'固定电话'" id="telphoneCondition" name="telphoneCondition"/></td>
                    <td nowrap="nowrap">身份:</td>
                    <td>
                        <select name="typeCondition" id="typeCondition" class="easyui-combobox"
                                editable="false"  style="width:100%">
                            <option value="0" selected>全部</option>
                            <option value="1">医生</option>
                            <option value="3">主任</option>
                            <option value="2">管理员</option>
                        </select>
                    </td>

                    <td align="right" colspan="2">
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="SearchUserAndAdminByParams()">检索</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="clearUserAndAdminSearchParams()">清空条件</a>
                    </td>
                </tr>
                <%--<tr>--%>
                    <%--<td nowrap="nowrap">创建时间:</td>--%>
                    <%--<td><input id="starttimeCondition" name="starttimeCondition" class="easyui-datetimebox" style="width:100%" value=""--%>
                               <%--data-options="prompt:'起始时间',currentText:'当前时间',closeText:'关闭',okText:'确定'" editable="false"></td>--%>
                    <%--<td nowrap="nowrap">至</td>--%>
                    <%--<td><input id="endtimeCondition" name="endtimeCondition" class="easyui-datetimebox" style="width:100%" value=""--%>
                               <%--data-options="prompt:'结束时间',currentText:'当前时间',closeText:'关闭',okText:'确定'" editable="false" ></td>--%>
                    <%----%>
                <%--</tr>--%>
            </table>
        </form>
    </div>
    <table id="userAndAdminList" style="width: auto;height: auto;">
    </table>
    <br/>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddUserAndAdminPage()">新增用户</a>
</div>