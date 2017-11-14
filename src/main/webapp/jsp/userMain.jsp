<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.grid.util.Constant" %>
<%@ page import="com.grid.entity.LoginUserBean" %>
<%
    HttpSession sessionObj = request.getSession(false);
    LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
    <title>设备台账管理系统</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/themes/default/easyui.css?_=<%=Constant.FrontEndVersion%>">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/themes/icon.css?_=<%=Constant.FrontEndVersion%>">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/easyui/demo/demo.css?_=<%=Constant.FrontEndVersion%>">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/OBM.css?_=<%=Constant.FrontEndVersion%>">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/loadingMaskLayer.css?_=<%=Constant.FrontEndVersion%>">
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/jquery.min.js?_=<%=Constant.FrontEndVersion%>"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/jquery.easyui.min.js?_=<%=Constant.FrontEndVersion%>"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/locale/easyui-lang-zh_CN.js?_=<%=Constant.FrontEndVersion%>"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/StringUtil.js?_=<%=Constant.FrontEndVersion%>"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.md5.js?_=<%=Constant.FrontEndVersion%>"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/json2.js?_=<%=Constant.FrontEndVersion%>"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/MsgBox.js?_=<%=Constant.FrontEndVersion%>"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/LoadingMaskLayer.js?_=<%=Constant.FrontEndVersion%>"></script>
    <script>
        $(function(){
            $('#menu-tree').tree({
                onClick: function(node){
                    $("#center_oper_area").panel({title: node.text});
                    forwardUserManage(node.id);
                }
            });
            $('#content_panel').panel({
                href:"<%=request.getContextPath() %>/dev/fwdDevMainPage.do?random_id="+Math.random(),
                onLoad:function () {
                }
            });
        });
        function forwardUserManage(nodeid){
            switch (nodeid){
                case 'dev_manage':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/dev/fwdDevMainPage.do?random_id="+Math.random(),
                        onLoad:function () {
                        }
                    });
                    break;
                case 'dev_auditing':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/audit/fwdToBeAuditPage.do?random_id="+Math.random(),
                        onLoad:function () {
                        }
                    });
                    break;
                case 'dev_audited':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/audit/fwdBeAuditedPage.do?random_id="+Math.random(),
                        onLoad:function () {
                        }
                    });
                    break;
                case 'auditor_auditing':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/audit/fwdToMakeAuditPage.do?random_id="+Math.random(),
                        onLoad:function () {
                        }
                    });
                    break;
                case 'auditor_audited':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/audit/fwdMakeAuditedPage.do?random_id="+Math.random(),
                        onLoad:function () {
                        }
                    });
                    break;
                case 'user_manage':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/user/fwdManageUserAndAdminPage.do?random_id="+Math.random(),
                        onLoad:function(){
                        }
                    });
                    break;
                case 'audit_tree':
                    break;
                case 'label_print':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/label/fwdManageLabelPage.do?random_id="+Math.random(),
                        onLoad:function(){
                        }
                    });
                    break;
                case 'room_space':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/space/fwdManageSpacePage.do?random_id="+Math.random(),
                        onLoad:function(){
                        }
                    });
                    break;
                case 'computer_manage':
                    break;
                case 'pc_manage':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/computer/fwdManagePCPage.do?random_id="+Math.random(),
                        onLoad:function(){
                        }
                    });
                    break;
                case 'note_manage':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/computer/fwdManageNotePage.do?random_id="+Math.random(),
                        onLoad:function(){
                        }
                    });
                    break;
                default:
                    MsgBox.show("功能正在开发，敬请期待！");
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/demo/fwdSuspensionInfor.do?random_id="+Math.random()
                    });
            }
        }

        function modifyPassword(){

            $('#modifyPasswordDialog').dialog({
                title: '修改密码',
                width: 500,
                height: 450,
                closed: true,
                cache: false,
                modal: true
            });
            $("#modifyPasswordDialog").dialog({
                onClose:function(){
                    $("#modifyPasswordDialog").empty();
                }
            });
            $('#modifyPasswordDialog').dialog("open");
            $("#modifyPasswordDialog").dialog("refresh", "<%=request.getContextPath()%>/user/fwdModifyPasswordPage.do"+"?randomid="+Math.random());

        }
    </script>
</head>
<body class="easyui-layout">
<div data-options="region:'north',border:false" style="height:66px;background:#E4EEFF;text-align: center">
    <div style="font-size: 30px;float:left; margin-left: 8px; margin-top: 3px; margin-bottom: 3px">
        <img src="<%=request.getContextPath()%>/image/page/sdgrid_logo.png" width="181.5px" height="60px" />
    </div>
    <div style="font-size: 30px;float:left;margin-top: 10px">
        设备台账管理系统
    </div>
    <div style="height:40px;font-size: 16px;line-height:20px;float: right;margin-right: 10px;margin-top: 5px">
        <%=userBean.getUname()%>|<%=userBean.getUtypeStr()%><br/>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="modifyPassword()" >修改密码</a>
        <a href="<%=request.getContextPath()%>/login/exitLogin.do" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" >退出</a>
    </div>
</div>
<div id="center_oper_area" data-options="region:'center',title:'工作面板 '">
    <div id="content_panel" class="easyui-panel"style="padding:10px;text-align: center"
         data-options="fit:true,border:false">
        <div style="height: 200px;"></div>
        <div style="height:100px;font-size: 30px;line-height: 60px;">欢迎使用设备台账管理系统</div>
    </div>
</div>
<div data-options="region:'west',split:false,title:'导航菜单',collapsible:false" style="width:180px;padding:10px;">
    <div style="margin:20px 0;"></div>
    <div id="modifyPasswordDialog"></div>
    <div class="easyui-panel" style="padding:5px; border: 0px;) ">
        <ul id="menu-tree" class="easyui-tree">
            <%--<li id="dev_manage">台账管理</li>--%>

            <li id="audit_tree">
                <span>台账管理</span>
                <ul>
                    <li id="dev_manage">台账管理</li>
                </ul>
            </li>
            <%--<li id="dev_auditing">待审核</li>--%>

            <li id="audit_tree">
                <span>审核进度</span>
                <ul>
                    <li id="dev_auditing">待审核</li>
                    <li id="dev_audited">已审核</li>
                </ul>
            </li>

            <% if(userBean.getUtypeStr().equals("审核员")){%>
                <li id="audit_tree">
                    <span>审核管理</span>
                    <ul>
                        <li id="auditor_auditing">待审核</li>
                        <li id="auditor_audited">已审核</li>
                    </ul>
                </li>
            <% } %>

            <% if(userBean.getUtypeStr().equals("管理员")){%>
                <li id="audit_tree">
                    <span>审核管理</span>
                    <ul>
                        <li id="auditor_auditing">待审核</li>
                        <li id="auditor_audited">已审核</li>
                    </ul>
                </li>
                <li id="audit_tree">
                    <span>用户管理</span>
                    <ul>
                        <li id="user_manage">用户管理</li>
                    </ul>
                </li>
            <% } %>
                <li id="audit_tree">
                    <span>其他</span>
                    <ul>
                        <li id="label_print">标签打印</li>
                        <li id="room_space">机房空间</li>
                    </ul>
                </li>

                <% if(userBean.getLoginname().equals("yangguanqun")){%>
                <li id="computer_manage">
                    <span>电脑管理</span>
                    <ul>
                        <li id="pc_manage">台式机管理</li>
                        <li id="note_manage">笔记本管理</li>
                    </ul>
                </li>
                <% } %>

        </ul>
    </div>
</div>
</body>
</html>