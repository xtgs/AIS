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
            title:"业绩列表",
            url:"<%=request.getContextPath()%>/user/queryAllUserScore.do?random_id="+Math.random(),
            rownumbers:true,
            singleSelect:true,
            fitColumns:true,
            loadMsg:"正在加载用户数据...",
            columns: [[
                { field: 'uid', title: 'ID', width: '10%'},
                { field: 'name', title: '姓名', width: '10%'},
                { field: 'todayScore', title: '今日业绩', width: '10%'},
                { field: 'yesterdayScore', title: '昨日业绩', width: '10%'},
                { field: 'currentMonthScore', title: '本月业绩', width: '10%'},
                { field: 'lastMonthScore', title: '上月业绩', width: '10%'},
                { field: 'currentYearScore', title: '今年业绩', width: '10%'},
                { field: 'lastYearScore', title: '去年业绩', width: '10%'},
                { field: 'somedayScore', title: '指定日期业绩', width: '10%'}
//                { field: 'remarks', title: '备注', width: '15%' }
            ]],
            pagination: true
        });
        $('#userAndAdminList').datagrid('getPager').pagination({
            pageSize: 10,
            pageNumber: 1,
            pageList: [10,50,100],
            beforePageText: '第',
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示{from} - {to}条,共 {total} 条记录'
        });
    });

    function SearchUserAndAdminByParams() {

        var dateStart = $('#dateStart').datebox('getValue');
        var dateEnd = $('#dateEnd').datebox('getValue');
        var name = $("#name").val();

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
                    <td><input class="easyui-textbox" data-options="prompt:'姓名'" id="name" name="name"/></td>
                    <td nowrap="nowrap">时间段:</td>
                    <td><input id="dateStart" name="dateStart" class="easyui-datebox" style="width:100%" value=""
                               data-options="prompt:'起始时间',currentText:'当前时间',closeText:'关闭',okText:'确定'" editable="false"></td>
                    <td nowrap="nowrap">至</td>
                    <td><input id="dateEnd" name="dateEnd" class="easyui-datebox" style="width:100%" value=""
                               data-options="prompt:'结束时间',currentText:'当前时间',closeText:'关闭',okText:'确定'" editable="false" ></td>

                    <td align="center" colspan="2">
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="SearchUserAndAdminByParams()">检索</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="clearUserAndAdminSearchParams()">清空条件</a>
                    </td>
                </tr>
            </table>
            <tr>
                <td align="center">(注:选择搜索时间段,该时间段内的业绩将显示在"指定日期业绩"中)</td>
            </tr>
        </form>
    </div>
    <table id="userAndAdminList" style="width: auto;height: auto;">
    </table>
</div>