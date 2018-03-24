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
            title:"部门业绩列表",
            url:"<%=request.getContextPath()%>/department/departmentScore.do?random_id="+Math.random(),
            rownumbers:false,
            singleSelect:true,
            fitColumns:true,
            loadMsg:"正在加载用户数据...",
            columns: [[
                { field: 'time', title: '时间', width: '20%', align: 'center'},
                { field: 'totalCharge', title: '客户总消费金额', width: '40%', align: 'center'},
                { field: 'totalTopup', title: '客户总充值金额', width: '40%', align: 'center'}
            ]],
            pagination: false
        });
    });

    function SearchUserAndAdminByParams() {

        var dateStart = $('#dateStart').datebox('getValue');
        var dateEnd = $('#dateEnd').datebox('getValue');
        if(dateStart && dateEnd){
            if(dateStart > dateEnd){
                MsgBox.show("起始时间大于结束时间，无法检索");
                return;
            }
        }
        var queryParameter = $('#userAndAdminList').datagrid("options").queryParams;
        queryParameter.dateStart = dateStart;
        queryParameter.dateEnd = dateEnd;
        queryParameter.name = name;
        queryParameter.queryByParamFlag = Math.random();
        $('#userAndAdminList').datagrid({
            pageNumber: 1,
            pageList: [10,50,100]
        });
        $("#userAndAdminList").datagrid("reload");
    }
    function clearUserAndAdminSearchParams(){
        var queryParameter = $('#userAndAdminList').datagrid("options").queryParams;
        queryParameter.dateStart = null;
        queryParameter.dateEnd = null;
        queryParameter.name = null;
        queryParameter.queryByParamFlag = Math.random();
        $('#userAndAdminList').datagrid({
            pageNumber: 1,
            pageList: [10,50,100]
        });
        $("#userAndAdminList").datagrid("reload");
    }

</script>
<div style="padding:2px 0;">
    <div id="viewUserAndAdminDialog" style="text-align: center;"></div>
    <div id="addUserAndDialog" style="text-align: center;"></div>
    <div id="modifyUserAndAdminDialog" style="text-align: center;"></div>
    <%--<div style="margin:0px auto;width: 950px;">--%>
        <%--<form id="queryUserAndAdminParamsForm">--%>
            <%--<table cellpadding="5">--%>
                <%--<tr>--%>
                    <%--<td colspan="8" >--%>
                        <%--<div class="formTitle" style="background-color:#f2f2f2;">--%>
                            <%--<div class="formTitle-icon">--%>
                            <%--</div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">条件筛选</div>--%>
                        <%--</div>--%>
                    <%--</td>--%>
                <%--</tr>--%>
                <%--<tr>--%>
                    <%--<td nowrap="nowrap">时间段:</td>--%>
                    <%--<td><input id="dateStart" name="dateStart" class="easyui-datebox" style="width:100%" value=""--%>
                               <%--data-options="prompt:'起始时间',currentText:'当前时间',closeText:'关闭',okText:'确定'" editable="false"></td>--%>
                    <%--<td nowrap="nowrap">至</td>--%>
                    <%--<td><input id="dateEnd" name="dateEnd" class="easyui-datebox" style="width:100%" value=""--%>
                               <%--data-options="prompt:'结束时间',currentText:'当前时间',closeText:'关闭',okText:'确定'" editable="false" ></td>--%>

                    <%--<td align="center" colspan="2">--%>
                        <%--<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="SearchUserAndAdminByParams()">检索</a>--%>
                        <%--<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="clearUserAndAdminSearchParams()">清空条件</a>--%>
                    <%--</td>--%>
                <%--</tr>--%>
            <%--</table>--%>
            <%--<tr>--%>
                <%--<td align="center">(注:选择搜索时间段,该时间段内的业绩将显示在"指定日期业绩"中)</td>--%>
            <%--</tr>--%>
        <%--</form>--%>
    <%--</div>--%>
    <table id="userAndAdminList" style="width: auto;height: auto;">
    </table>
</div>