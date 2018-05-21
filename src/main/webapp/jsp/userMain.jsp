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
    <title>客户信息管理系统</title>
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
                href:"<%=request.getContextPath() %>/patient/fwdPatientMainPage.do?random_id="+Math.random(),
                onLoad:function () {
                }
            });
        });
        function forwardUserManage(nodeid){
            switch (nodeid){
                case 'patient_manage':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/patient/fwdPatientMainPage.do?random_id="+Math.random(),
                        onLoad:function() {
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
                case 'item_manage':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/item/fwdManageItemPage.do?random_id="+Math.random(),
                        onLoad:function(){
                        }
                    });
                    break;
                case 'trade_record':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/patient/fwdTradeRecordPage.do?random_id="+Math.random(),
                        onLoad:function(){
                        }
                    });
                    break;
                case 'user_score':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/user/fwdUserScorePage.do?random_id="+Math.random(),
                        onLoad:function(){
                        }
                    });
                    break;
                case 'department_score':
                    $('#content_panel').panel({
                        href:"<%=request.getContextPath() %>/department/fwdDepartmentScorePage.do?random_id="+Math.random(),
                        onLoad:function(){
                        }
                    });
                    break;
                case 'user_tree':
                    break;
                case 'patient_tree':
                    break;
                case 'department_tree':
                    break;
                case 'item_tree':
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
<div data-options="region:'north',border:false" style="height:135px;background: #04564a url(../image/page/logo.PNG) repeat-x;text-align: center">
    <div style="padding: 20px 0 0 25px; float: left; position: relative; overflow: hidden;">
        <img src="<%=request.getContextPath()%>/image/page/logo2.png" width="250px" height="60px"/>
    </div>
    <div style="float: left; padding: 20px 0 0 50px">
        <h1>客户信息管理系统</h1>
    </div>
    <div style="height:80px;font-size: 16px;line-height:20px;float: right;padding: 20px 50px 0 0;">
        <%=userBean.getUname()%>|<%=userBean.getUtypeStr()%><br/>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="modifyPassword()" >修改密码</a>
        <a href="<%=request.getContextPath()%>/login/exitLogin.do" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" >退出</a>
    </div>
    <%--<div style="height:40px;font-size: 16px;line-height:20px;float: right;margin-right: 10px;margin-top: 5px">--%>
        <%--<%=userBean.getUname()%>|<%=userBean.getUtypeStr()%><br/>--%>
        <%--<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="modifyPassword()" >修改密码</a>--%>
        <%--<a href="<%=request.getContextPath()%>/login/exitLogin.do" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" >退出</a>--%>
    <%--</div>--%>
    <div style="width:100%;" class="header">
        <div class="nav">
        </div>
    </div>
</div>
<div id="center_oper_area" data-options="region:'center',title:'客户管理'">
    <div id="content_panel" class="easyui-panel"style="padding:10px 20px;text-align: center"
         data-options="fit:true,border:false">
        <div style="height: 200px;"></div>
        <div style="height:100px;font-size: 30px;line-height: 60px;">欢迎使用客户信息管理系统</div>
    </div>
</div>
<div data-options="region:'west',split:false,collapsible:false" style="width:200px;padding:10px;background: url(<%=request.getContextPath()%>/image/left_bg.gif)">
    <div style="margin:20px 0;"></div>
    <div id="modifyPasswordDialog"></div>
    <div class="easyui-panel" style="border: 0px; background: transparent;">
        <ul id="menu-tree" class="easyui-tree">
            <li id="patient_tree">
                <span>客户管理</span>
                <ul>
                    <li id="patient_manage">客户信息</li>
                    <li id="trade_record">交易记录</li>
                </ul>
            </li>
            <% if(userBean.getUtypeStr().equals("管理员") || userBean.getUtypeStr().equals("审核员")){%>
            <li id="user_tree">
                <span>员工管理</span>
                <ul>
                    <li id="user_manage">员工信息</li>
                    <li id="user_score">员工业绩</li>
                </ul>
            </li>
            <li id="item_tree">
                <span>项目管理</span>
                <ul>
                    <li id="item_manage">项目管理</li>
                </ul>
            </li>
            <li id="department_tree">
                <span>部门管理</span>
                <ul>
                    <li id="department_score">部门业绩</li>
                </ul>
            </li>
            <% } %>
        </ul>
    </div>
</div>
</body>
</html>