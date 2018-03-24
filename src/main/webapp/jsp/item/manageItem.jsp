<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><html>
<%@ page import="com.grid.util.Constant" %>
<%@ page import="com.grid.entity.LoginUserBean" %>
<%
    HttpSession sessionObj = request.getSession(false);
    LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
%>
<script>
    $(function () {
        $("#itemList").datagrid({
            title:"项目列表",
            url:"<%=request.getContextPath()%>/item/getItemList.do?random_id="+Math.random(),
            rownumbers:false,
            singleSelect:true,
            fitColumns:true,
            loadMsg:"正在加载用户数据...",
            columns: [[
                { field: 'iid', title: 'ID', width: '25%', align: 'center'},
                { field: 'name', title: '名称', width: '25%', align: 'center'},
                { field: 'price', title: '价格', width: '25%', align: 'center'},
                { field: "operateAuth", title: '操作',width:'25%', align: 'center',
                    formatter: function (value, rowData, rowIndex) {
                        return '<a href="javascript:void(0)" onclick="fwdModifyItemPage(' + rowIndex + ')">修改</a>&nbsp&nbsp' +
                                '<a href="javascript:void(0)" onclick="deleteItem(' + rowIndex + ')">删除</a>';
                    }
                }
            ]],
            pagination: true
        });
        $('#itemList').datagrid('getPager').pagination({
            pageSize: 10,
            pageNumber: 1,
            pageList: [10,50,100],
            beforePageText: '第',
            afterPageText: '页    共 {pages} 页',
            displayMsg: '当前显示{from} - {to}条,共 {total} 条记录'
        });
    });

    function fwdModifyItemPage(index){
        $('#itemList').datagrid('selectRow',index);// 关键在这里
        var row = $('#itemList').datagrid('getSelected');
        if (row){
            $('#modifyItemDialog').dialog({
                title: '修改项目信息',
                width: 500,
                height: 450,
                closed: true,
                cache: false,
                modal: true
            });
            $("#modifyItemDialog").dialog({
                onClose:function(){
                    $("#modifyDevDialog").empty();
                }
            });
            $('#modifyItemDialog').dialog("open");
            $("#modifyItemDialog").dialog("refresh", "<%=request.getContextPath()%>/item/fwdModifyItemPage.do?iid="+row.iid);
        }
    }

    function deleteItem(index){
        $('#itemList').datagrid('selectRow',index);// 关键在这里
        var row = $('#itemList').datagrid('getSelected');
        if(row){
            $.messager.confirm('确认','您确认想要删除【' + row.name + '】吗？',function(r){
                if (r){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/item/delete.do?iid=" + row.iid+"&random_id="+Math.random(),
                        type:'post',
                        async:false,
                        error:function(data){
                            MsgBox.show(data.responseText);
                        },
                        success:function(data){
                            MsgBox.show(data);
                            $('#itemList').datagrid('reload');
                        }
                    });
                }
            });
        }
    }

    function forwardAddItemPage(){
        $('#addItemDialog').dialog({
            title: '添加项目',
            width: 500,
            height: 450,
            closed: true,
            cache: false,
            href: "<%=request.getContextPath()%>/item/fwdAddItemPage.do?random_id=" + Math.random(),
            modal: true
        });
        $("#addItemDialog").dialog({
            onClose:function(){
                $("#addItemDialog").empty();
            }
        });
        $('#addItemDialog').dialog("open");
    }

</script>
<div style="padding:2px 0;">
    <div id="viewUserAndAdminDialog" style="text-align: center;"></div>
    <div id="addItemDialog" style="text-align: center;"></div>
    <div id="modifyItemDialog" style="text-align: center;"></div>
    <table id="itemList" style="width: auto;height: auto;">
    </table>
    <br/>
    <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="forwardAddItemPage()">新增一条项目信息</a>
    <br/>
</div>