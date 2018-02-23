<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.grid.util.Constant" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
  <title>考勤管理系统</title>
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
  <style>
      .dg-cell{
          display:inline-block;
          width:100%;
          height:100%;
      }
      a:link, a:visited {
          color: #545454;
          text-decoration: none;
      }
      #left:hover {
          background: url(image/left-blue.png) !important;
          cursor: pointer;
      }
      #right:hover {
          background: url(image/right-blue.png) !important;
          cursor: pointer;
      }
  </style>
</head>
<body style="background: #ffffff url(image/body.jpg) repeat-x; padding-top: 0px">
    <div class="wraper">
        <div style="background: #fff url(image/header_ws1.jpg) no-repeat right top; width: 100%; height: 110px; text-align: right; overflow: hidden;">
            <div class="logo">
                <div class="logo_img">
                    <img src="image/b43f9064-3c40-412b-8d0d-f21ca0afdc5f.png" border="0">
                </div>
            </div>
            <div style="float: right">
                <a href="/obm/login.jsp" class="user-ico" title="请点击登录"><i class="u-ico"></i></a>
            </div>
        </div>
        <div style="width:1500px;" class="header">
            <div class="nav">
            </div>
        </div>
        <div style="height: 100%; text-align: center">
            <h1 style="color: red">您无权访问本页，请联系管理员！</h1>
        </div>
    </div>
</body>
</html>