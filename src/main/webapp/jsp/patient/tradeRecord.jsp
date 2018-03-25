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
        $("#recordList").datagrid({
            title:"交易记录",
            url:"<%=request.getContextPath()%>/patient/queryTradeRecordByParam.do?random_id="+Math.random(),
            rownumbers:true,
            singleSelect:true,
            nowrap:false,//允许换行
            fitColumns:true,
            loadMsg:"正在加载用户数据...",
            columns: [[
                { field: 'tradeType', title: '交易类型', width: '7%', sortable:'true',
                    formatter: function (value) {
                        if (value == "1") {
                            return "消费";
                        } else if (value == "2") {
                            return "充值";
                        } else {
                            return "未知";
                        }
                    }
                },
                { field: 'pid', title: '卡号', width: '10%', sortable:'true'},
                { field: 'patientCardId', title: '身份证号', width: '16%', sortable:'true'},
                { field: 'patientName', title: '客户姓名', width: '7%', sortable:'true'},
                { field: 'patientPhone', title: '手机号', width: '10%', sortable:'true'},
                { field: 'itemName', title: '项目名称', width: '10%', sortable:'true'},
                { field: 'originalPrice', title: '原价', width: '10%', sortable:'true'},
                { field: 'discount', title: '折扣', width: '10%', sortable:'true',
                    formatter:function (value) {
                        if (value == undefined)
                            return '';
                        else
                            return value + "%"
                    }
                },
                { field: 'amount', title: '交易金额',width: '8%', sortable:'true' },
                { field: 'afterBalance', title: '交易后余额',width: '8%', sortable:'true' },
                { field: 'uid', title: '医生编号', width: '10%', sortable:'true'},
                { field: 'userName', title: '医生姓名', width: '7%', sortable:'true'},
                { field: 'createTime', title: '交易时间', width: '15%', sortable:'true',
                    formatter:function(date){
                        return formatDateTime(date);
                    }
                },
                { field: 'remark', title: '备注', width: '15%', sortable:'true' }
            ]],
            pagination: true
        });
        $('#recordList').datagrid('getPager').pagination({
            pageSize: 10,
            pageNumber: 1,
            pageList: [10,50,100],
            beforePageText: '第',
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示{from} - {to}条,共 {total} 条记录'
        });
    });

    function formatDateTime(inputTime) {
        var date = new Date(inputTime);
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        m = m < 10 ? ('0' + m) : m;
        var d = date.getDate();
        d = d < 10 ? ('0' + d) : d;
        var h = date.getHours();
        h = h < 10 ? ('0' + h) : h;
        var minute = date.getMinutes();
        var second = date.getSeconds();
        minute = minute < 10 ? ('0' + minute) : minute;
        second = second < 10 ? ('0' + second) : second;
        return y + '-' + m + '-' + d+' '+h+':'+minute+':'+second;
    };

    function SearchUserAndAdminByParams() {
        var tradeType = $("#tradeType").val();
        var pid = $("#pid").val();
        var patientCardId = $("#patientCardId").val();
        var patientName = $("#patientName").val();
        var patientPhone = $("#patientPhone").val();
        var amount = $("#amount").val();
        var afterBalance = $("#afterBalance").val();
        var uid = $("#uid").val();
        var userName = $("#userName").val();
        var createTimeFrom = $("#createTimeFrom").val();
        var createTimeTo = $("#createTimeTo").val();

        var queryParameter = $('#recordList').datagrid("options").queryParams;
        queryParameter.tradeType = tradeType;
        queryParameter.pid = pid;
        queryParameter.patientCardId = patientCardId;
        queryParameter.patientName = patientName;
        queryParameter.patientPhone = patientPhone;
        queryParameter.amount = amount;
        queryParameter.afterBalance = afterBalance;
        queryParameter.uid = uid;
        queryParameter.userName = userName;
        queryParameter.createTimeFrom = createTimeFrom;
        queryParameter.createTimeTo = createTimeTo;

        $('#recordList').datagrid({
            pageNumber: 1,
            pageList: [10,50,100]
        });
        $("#recordList").datagrid("reload");
    }
    function clearUserAndAdminSearchParams(){
        var queryParameter = $('#recordList').datagrid("options").queryParams;
        queryParameter.tradeType = null;
        queryParameter.pid = null;
        queryParameter.patientCardId = null;
        queryParameter.patientName = null;
        queryParameter.patientPhone = null;
        queryParameter.amount = null;
        queryParameter.afterBalance = null;
        queryParameter.uid = null;
        queryParameter.userName = null;
        queryParameter.createTimeFrom = null;
        queryParameter.createTimeTo = null;
        $("#queryUserAndAdminParamsForm").form('clear');
        $('#recordList').datagrid({
            pageNumber: 1,
            pageList: [10,50,100]
        });
        $("#recordList").datagrid("reload");
    }

</script>
<div style="padding:2px 0;">
    <div id="viewUserAndAdminDialog" style="text-align: center;"></div>
    <div id="addPatientAndDialog" style="text-align: center;"></div>
    <div id="modifyPatientDialog" style="text-align: center;"></div>
    <div id="chargeDialog" style="text-align: center;"></div>
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
                    <td nowrap="nowrap">交易类型:</td>
                    <td>
                        <select name="tradeType" id="tradeType" class="easyui-combobox"
                                editable="false"  style="width:90%">
                            <option value="" selected>全部</option>
                            <option value="1">消费</option>
                            <option value="2">充值</option>
                        </select>
                    </td>
                    <td nowrap="nowrap">卡号:</td>
                    <td>
                        <input id="pid" class="easyui-textbox" name="pid" data-options="prompt:'卡号'" />
                    </td>

                    <td nowrap="nowrap">身份证号:</td>
                    <td>
                        <input id="patientCardId" class="easyui-textbox" name="patientCardId"
                               data-options="prompt:'身份证号'" />
                    </td>

                    <td nowrap="nowrap">姓名:</td>
                    <td>
                        <input class="easyui-textbox" data-options="prompt:'姓名'" id="patientName" name="patientName"/>
                    </td>

                </tr>
                <tr>
                    <td nowrap="nowrap">手机号:</td>
                    <td>
                        <input id="patientPhone" class="easyui-textbox" name="patientPhone"
                               data-options="prompt:'手机号'" />
                    </td>

                    <td nowrap="nowrap">金额:</td>
                    <td>
                        <input class="easyui-textbox" data-options="prompt:'交易金额'" id="amount" name="amount"/>
                    </td>

                    <td nowrap="nowrap">余额:</td>
                    <td>
                        <input class="easyui-textbox" data-options="prompt:'交易后余额'" id="afterBalance" name="afterBalance"/>
                    </td>

                    <td nowrap="nowrap">医生编号:</td>
                    <td>
                        <input class="easyui-textbox" data-options="prompt:'医生编号'" id="uid" name="uid"/>
                    </td>
                </tr>

                <tr>
                    <td nowrap="nowrap">医生姓名:</td>
                    <td>
                        <input class="easyui-textbox" data-options="prompt:'医生编号'" id="userName" name="userName"/>
                    </td>

                    <%--<td nowrap="nowrap">余额:</td>--%>
                    <%--<td>--%>
                        <%--<input class="easyui-textbox" data-options="prompt:'起始金额'" id="balanceFrom" class="easyui-combobox" style="width: 30%" name="balance"/>--%>
                        <%-----%>
                        <%--<input class="easyui-textbox" data-options="prompt:'终止金额'" id="balanceTo" class="easyui-combobox" style="width: 30%" name="balance"/>--%>
                    <%--</td>--%>

                    <td nowrap="nowrap">交易时间:</td>
                    <td><input id="createTimeFrom" name="createTimeFrom" class="easyui-datetimebox" style="width:100%" value=""
                               data-options="prompt:'起始时间',currentText:'当前时间',closeText:'关闭',okText:'确定'" editable="false"></td>
                    <td nowrap="nowrap">至</td>
                    <td><input id="createTimeTo" name="createTimeTo" class="easyui-datetimebox" style="width:100%" value=""
                               data-options="prompt:'结束时间',currentText:'当前时间',closeText:'关闭',okText:'确定'" editable="false" ></td>

                    <td align="center" colspan="2">
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="SearchUserAndAdminByParams()">检索</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="clearUserAndAdminSearchParams()">清空条件</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <table id="recordList" style="width: auto;height: auto;">
    </table>


</div>