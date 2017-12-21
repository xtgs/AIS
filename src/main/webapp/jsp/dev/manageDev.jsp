<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><html>
<%@ page import="com.grid.entity.LoginUserBean" %>
<%@ page import="com.grid.util.Constant" %>
<%@ page import="java.net.URLEncoder" %>
    <%
    HttpSession sessionObj = request.getSession(false);
    LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
%>
<script>
    function forwardAddDevPage(){
        $('#addDevAndDialog').dialog({
            title: '添加设备',
            width: 500,
            height: 450,
            closed: true,
            cache: false,
            href: "<%=request.getContextPath()%>/dev/fwdAddDevPage.do?random_id=" + Math.random(),
            modal: true
        });
        $("#addDevAndDialog").dialog({
            onClose:function(){
                $("#addDevAndDialog").empty();
            }
        });
        $('#addDevAndDialog').dialog("open");
    }
    $(function () {
        $("#devList").datagrid({
            title:"台账列表",
            url:"<%=request.getContextPath()%>/dev/queryDevByParam.do?random_id="+Math.random(),
            rownumbers:true,
            singleSelect:true,
            nowrap:false,//允许换行
            fitColumns:true,
            loadMsg:"正在加载用户数据...",
            columns: [[
                { field: 'vid', title: '编号', width: '0%', hidden:'true'},
                { field: 'buildType', title: '建设类型', width: '7%', sortable:'true'},
                { field: 'operationGroup', title: '运维组', width: '10%', sortable:'true'},
                { field: 'deployedSystem', title: '部署应用系统', width: '12%', sortable:'true'},
                { field: 'devName', title: '设备名称', width: '21%', sortable:'true'},
                { field: 'operationDepart', title: '运维部门', width: '10%', sortable:'true' },
                { field: 'machineRoom', title: '所在机房',width: '10%', sortable:'true' },
                { field: 'devNum', title: '机柜设备编号', width: '10%', sortable:'true' },
                { field: 'installLocation', title: '安装位置', width: '10%', sortable:'true' },
                { field: 'devType', title: '设备类型', width: '10%', sortable:'true' },
                { field: 'devModel', title: '设备型号', width: '10%', sortable:'true' },
                { field: 'brand', title: '品牌', width: '10%', sortable:'true' },
                { field: 'devManagePerson', title: '设备负责人', width: '10%', sortable:'true' },
                { field: 'devManagePhone', title: '设备负责人联系方式', width: '10%', sortable:'true' },
                { field: 'businessMan', title: '业务部门联系人', width: '10%', sortable:'true' },
                { field: 'businessPhone', title: '业务部门联系方式', width: '10%', sortable:'true' },
                { field: 'serviceLinkman', title: '服务商联系人', width: '10%', sortable:'true' },
                { field: 'servicePhone', title: '服务商联系方式', width: '10%', sortable:'true' },
                { field: 'power', title: '电源功率', width: '10%', sortable:'true' },
                { field: 'powerNum', title: '电源数量', width: '10%', sortable:'true' },
                { field: "operateAuth", title: '操作',width:'10%', align: 'center',
                    formatter: function (value, rowData, rowIndex) {
                        if (value == "0") {
                            return "无操作权限";
                        } else if (value == "1") {
                            return '<a href="javascript:void(0)" onclick="fwdModifyDevPage(' + rowIndex + ')">修改</a>&nbsp&nbsp' +
                                    '<a href="javascript:void(0)" onclick="deleteDev(' + rowIndex + ')">删除</a>';
                        } else {
                            return "数据错误!";
                        }
                    }
                }
            ]],
            pagination: true
        });
        $('#devList').datagrid('getPager').pagination({
            pageSize: 10,
            pageNumber: 1,
            pageList: [10,20,30],
            beforePageText: '第',
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示{from} - {to}条,共 {total} 条记录'
        });
    });
    function SearchUserAndAdminByParams() {
        var buildTypeCondition = $("#buildTypeCondition").val();
        var operationGroupCondition = $("#operationGroupCondition").val();
        var deployedSystemCondition = $("#deployedSystemCondition").val();
        var devNameCondition = $("#devNameCondition").val();
        var operationDepartCondition = $("#operationDepartCondition").val();
        var machineRoomCondition = $("#machineRoomCondition").val();
        var devNumCondition = $("#devNumCondition").val();
        var installLocationCondition = $("#installLocationCondition").val();
        var devPersonCondition = $("#devPersonCondition").val();
        var brandCondition = $("#brandCondition").val();
        var devModelCondition = $('#devModelCondition').val();
        var devTypeCondition = $('#devTypeCondition').val();

        var queryParameter = $('#devList').datagrid("options").queryParams;
        queryParameter.buildTypeCondition = buildTypeCondition;
        queryParameter.operationGroupCondition = operationGroupCondition;
        queryParameter.deployedSystemCondition = deployedSystemCondition;
        queryParameter.devNameCondition = devNameCondition;
        queryParameter.operationDepartCondition = operationDepartCondition;
        queryParameter.machineRoomCondition = machineRoomCondition;
        queryParameter.devNumCondition = devNumCondition;
        queryParameter.installLocationCondition = installLocationCondition;
        queryParameter.devPersonCondition = devPersonCondition;
        queryParameter.brandCondition = brandCondition;
        queryParameter.devModelCondition = devModelCondition;
        queryParameter.devTypeCondition = devTypeCondition;
        queryParameter.auditState = <%=Constant.devAudited %>;
        queryParameter.queryByParamFlag = Math.random();
        $('#devList').datagrid({
            pageNumber: 1,
            pageList: [10,20,30]
        });
        $("#devList").datagrid("reload");
    }
    function clearUserAndAdminSearchParams(){
        var queryParameter = $('#devList').datagrid("options").queryParams;
        queryParameter.buildTypeCondition = null;
        queryParameter.operationGroupCondition = null;
        queryParameter.deployedSystemCondition = null;
        queryParameter.devNameCondition = null;
        queryParameter.operationDepartCondition = null;
        queryParameter.machineRoomCondition = null;
        queryParameter.devNumCondition = null;
        queryParameter.installLocationCondition = null;
        queryParameter.devPersonCondition = null;
        queryParameter.brandCondition = null;
        queryParameter.devModelCondition = null;
        queryParameter.devTypeCondition = null;
        queryParameter.queryByParamFlag = Math.random();
        $("#queryUserAndAdminParamsForm").form('clear');
        $("#bulidTypeCondition").combobox('setValue','');
        $('#devList').datagrid({
            pageNumber: 1,
            pageList: [10,20,30]
        });
        $("#devList").datagrid("reload");
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
    function fwdModifyDevPage(index){
        $('#devList').datagrid('selectRow',index);// 关键在这里
        var row = $('#devList').datagrid('getSelected');
        if (row){
            $('#modifyDevDialog').dialog({
                title: '修改台账信息',
                width: 500,
                height: 450,
                closed: true,
                cache: false,
                modal: true
            });
            $("#modifyDevDialog").dialog({
                onClose:function(){
                    $("#modifyDevDialog").empty();
                }
            });
            $('#modifyDevDialog').dialog("open");
            $("#modifyDevDialog").dialog("refresh", "<%=request.getContextPath()%>/dev/fwdModifyDevPage.do?id="+row.vid);
        }
    }

    function deleteDev(index){
        $('#devList').datagrid('selectRow',index);// 关键在这里
        var row = $('#devList').datagrid('getSelected');
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
                            $('#devList').datagrid('reload');
                        }
                    });
                }
            });
        }
    }

    function test() {
        $.ajax({
            url:"<%=request.getContextPath()%>/file/test.do?hello="+"你好",
            type:'post',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                MsgBox.show(data);
            }
        });
    }

    function uploadExcel(){

        $('#uploadForm').form('submit', {
            url: "<%=request.getContextPath()%>/file/upload.do" + "?random_id="+Math.random(),
            type:'post',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                MsgBox.show(data);
                $('#devList').datagrid('reload');
            }
        });

    }

    function downloadExcel() {

        $('#downloadForm').form('submit', {
            url: "<%=request.getContextPath()%>/file/download.do"
            + "?buildTypeCondition=" + $("#buildTypeCondition").val()
            + "&operationGroupCondition=" + $("#operationGroupCondition").val()
            + "&deployedSystemCondition=" + $("#deployedSystemCondition").val()
            + "&devNameCondition=" + $("#devNameCondition").val()
            + "&operationDepartCondition=" + $("#operationDepartCondition").val()
            + "&machineRoomCondition=" + $("#machineRoomCondition").val()
            + "&devNumCondition=" + $("#devNumCondition").val()
            + "&installLocationCondition=" + $("#installLocationCondition").val()
            + "&devTypeCondition=" + $("#devTypeCondition").val()
            + "&devModelCondition=" + $("#devModelCondition").val()
            + "&brandCondition=" + $("#brandCondition").val()
            + "&devPersonCondition=" + $("#devPersonCondition").val()
            + "&random_id=" + Math.random(),

            type: 'post',
            async: false,
            error: function (data) {
                MsgBox.show(data.responseText);
            },
            success: function (data) {
                MsgBox.show(data);
                // $('#devList').datagrid('reload');
            }
        });
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
                    <td nowrap="nowrap">建设类型:</td>
                    <td>
                        <input id="buildTypeCondition" class="easyui-combobox" name="buildTypeCondition"
                               data-options="url:'<%=request.getContextPath()%>/data/query_buildType_data.json',
                               prompt:'建设类型',valueField:'id',textField:'text',panelHeight:'auto'" />
                    </td>

                    <td nowrap="nowrap">运维组:</td>
                    <td>
                        <input id="operationGroupCondition" class="easyui-combobox" name="operationGroupCondition"
                               data-options="url:'<%=request.getContextPath()%>/data/query_operationGroup_data.json',
                               prompt:'运维组',valueField:'id',textField:'text',panelHeight:'auto'" />
                    </td>

                    <td nowrap="nowrap">部署应用系统:</td>
                    <td>
                        <input class="easyui-textbox" data-options="prompt:'部署应用系统'" id="deployedSystemCondition" name="deployedSystemCondition"/>
                    </td>

                    <td nowrap="nowrap">设备名称:</td>
                    <td>
                        <input class="easyui-textbox" data-options="prompt:'设备名称'" id="devNameCondition" name="devNameCondition"/>
                    </td>

                    </tr>
                <tr>
                    <td nowrap="nowrap">运维部门:</td>
                    <td>
                        <input id="operationDepartCondition" class="easyui-combobox" name="operationDepartCondition"
                               data-options="url:'<%=request.getContextPath()%>/data/query_operationDepart_data.json',
                               prompt:'运维部门',valueField:'id',textField:'text',panelHeight:'auto'" />
                    </td>

                    <td nowrap="nowrap">所在机房:</td>
                    <td>
                        <input id="machineRoomCondition" class="easyui-combobox" name="machineRoomCondition"
                               data-options="url:'<%=request.getContextPath()%>/data/query_machineRoom_data.json',
                               prompt:'所在机房',valueField:'id',textField:'text',panelHeight:'auto'" />
                    </td>

                    <td nowrap="nowrap">机柜设备编号:</td>
                    <td>
                        <input class="easyui-textbox" data-options="prompt:'机柜设备编号'" id="devNumCondition" class="easyui-combobox" name="devNumCondition"/>
                    </td>

                    <td nowrap="nowrap">安装位置:</td>
                    <td>
                        <input class="easyui-textbox" data-options="prompt:'安装位置'" id="installLocationCondition" class="easyui-combobox" name="installLocationCondition"/>
                    </td>
                </tr>

                <tr>
                    <td nowrap="nowrap">设备类型:</td>
                    <td>
                        <input id="devTypeCondition" class="easyui-combobox" name="devTypeCondition"
                               data-options="prompt:'设备类型',valueField:'id',textField:'text',url:'<%=request.getContextPath()%>/data/query_devType_data.json'" />
                    </td>

                    <td nowrap="nowrap">设备型号:</td>
                    <td>
                        <input id="devModelCondition" class="easyui-combobox" name="devModelCondition"
                               data-options="prompt:'设备型号',valueField:'id',textField:'text',url:'<%=request.getContextPath()%>/data/query_devModel_data.json'" />
                    </td>

                    <td nowrap="nowrap">品牌:</td>
                    <td>
                        <input id="brandCondition" class="easyui-combobox" name="brandCondition"
                               data-options="prompt:'品牌',valueField:'id',textField:'text',url:'<%=request.getContextPath()%>/data/query_brand_data.json'" />
                    </td>

                    <td nowrap="nowrap">设备负责人:</td>
                    <td><input class="easyui-textbox" data-options="prompt:'设备负责人'" id="devPersonCondition" name="devPersonCondition"/></td>
                </tr>

                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td align="center" colspan="2">
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="SearchUserAndAdminByParams()">检索</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="clearUserAndAdminSearchParams()">清空条件</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <table id="devList" style="width: auto;height: auto;">
    </table>
    <br/>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddDevPage()">新增一条台账信息</a>
    <br/>
    <br/>
    <form id="uploadForm"  method="post" enctype="multipart/form-data">
        选择上传文件路径：　<input id="uploadExcel" name="uploadExcel" class="easyui-filebox" style="width:200px" data-options="prompt:'请选择文件...'">
        <a href="#" class="easyui-linkbutton"  onclick="uploadExcel()" >批量导入台账信息</a>
    </form>

    <form id="downloadForm"  method="post" >
        <a href="#" class="easyui-linkbutton"  onclick="downloadExcel()" >批量导出台账信息</a>
    </form>

    <%--<br/>--%>
    <%--<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="test()">测试</a>--%>


</div>