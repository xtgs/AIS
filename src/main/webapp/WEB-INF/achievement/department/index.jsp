<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.grid.util.Constant" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.grid.util.GlobalUtils" %>
<%@ page import="java.util.Set" %>

<%
  String smonth = request.getParameter("month");
  String syear = request.getParameter("year");


  int month = 0;
  if(smonth == null) {
    month = Calendar.getInstance().get(Calendar.MONTH)+1;
  } else {
      try {
        month = Integer.parseInt(smonth);
      } catch (Exception e) {
        month = Calendar.getInstance().get(Calendar.MONTH)+1;
      }

  }


  int year = 0;
  if(syear == null) {
      year = Calendar.getInstance().get(Calendar.YEAR);
  } else {
      try {
        year = Integer.parseInt(syear);
      } catch (Exception e) {
        year = Calendar.getInstance().get(Calendar.YEAR);
      }

  }

  int day = 0;

  switch (month) {
    case 1:
    case 3:
    case 5:
    case 7:
    case 8:
    case 10:
    case 12:
        day = 31;
        break;
    case 4:
    case 6:
    case 9:
    case 11:
        day = 30;
        break;
    case 2:
        if((year%400==0)||(year%4==0&&year%400!=0))
            day = 29;
        else
            day = 28;
        break;
    default:
        day = 31;
        break;
  }

  Set<Integer> holidays = GlobalUtils.getHoliday(year, month, day);
%>
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
  <script>
      function fieldFormatter(value, row, index) {
          if(value == undefined)
              return '';
          var value_message = value.split("__");
          return '<span title=\"' + value_message[1] + '\" class=\"dg-cell\">' + value_message[0] + '</span>';
      }

//      function getDayOfMonth(month, year) {
//          if(month==1 || month==3 || month==5 || month==7 || month==8 || month==10 || month==12)
//              return 31;
//          if(month==4 || month==6 || month==9 || month==11)
//              return 30;
//          if((year%400==0) || (year%4==0&&year%400!=0))
//              return 29;
//          else
//              return 28;
//      }
//
//      function getFields(dayOfMonth) {
//          var columnsdata = new Array();
//
//          var name = {};
//          name["field"] = "name";
//          name["title"] = "姓名";
//          name["width"] = "4%";
//          columnsdata.push(name);
//
//          var department = {};
//          department["field"] = "department";
//          department["title"] = "班组";
//          department["width"] = "4%";
//          columnsdata.push(department);
//
//          for(var i=1; i<=dayOfMonth; i++) {
//              var day = {};
//              day["field"] = "day"+i;
//              day["title"] = i;
//              day["width"] = "3%";
//              day["formatter"] = fieldFormatter;
//              columnsdata.push(day);
//          }
//
//          var columns = new Array();
//          columns.push(columnsdata);
//          console.log(columns);
//
//          return columns;
//      }

      function preMonth() {
          var timeStr = $('#time').html();
          var year = timeStr.split("年")[0];
          var month = timeStr.split("年")[1].split("月")[0];

          if(month == 1) {
              year --;
              month = 12;
          } else {
              month --;
          }

          window.location.href = "/obm/index.jsp?month=" + month + "&year=" + year + "&random_id=" + Math.random();

//          $('#time').html(year+"年"+month+"月");
//
//          $('#officeBussinessTable').datagrid("options").url = "/obm/officeBussinessOverview/queryOfficeBussinessOverview.action?month=" + month + "&year=" + year + "&random_id="+Math.random();
//          $('#officeBussinessTable').datagrid("options").columns = getFields(getDayOfMonth(month, year));
//          $('#officeBussinessTable').datagrid("reload");
      }

      function nextMonth() {
          var timeStr = $('#time').html();
          var year = timeStr.split("年")[0];
          var month = timeStr.split("年")[1].split("月")[0];

          if(month == 12) {
              year ++;
              month = 1;
          } else {
              month ++;
          }

          window.location.href = "/obm/index.jsp?month=" + month + "&year=" + year + "&random_id=" + Math.random();

//          $('#time').html(year+"年"+month+"月");
//
//          $('#officeBussinessTable').datagrid("options").url = "/obm/officeBussinessOverview/queryOfficeBussinessOverview.action?month=" + month + "&year=" + year + "&random_id="+Math.random();
//          $('#officeBussinessTable').datagrid("reload");
      }

      $(function () {
          $("#officeBussinessTable").datagrid({
              url:"<%=request.getContextPath()%>/officeBussinessOverview/queryOfficeBussinessOverview.action?month=" + <%=month%> + "&year=" + <%=year%> + "&random_id="+Math.random(),
              rownumbers:true,
              singleSelect:true,
              fitColumns:true,
              loadMsg:"正在加载用户数据...",
              rowStyler: function(index, row) {
                  if(row.isforbidden == '1') {
                      return 'background-color:#b9b6b6';
                  }
              },
              columns: [[
                  { field: 'name', title: '姓名', width: '4%'},
                  { field: 'department', title: '班组', width: '5%'},
                  <% for(int i=0; i<day; i++) {
                      if(holidays.contains(i+1)) { %>
                  { field: 'day<%=i+1%>', title: '<%=i+1%>', width: '3%', align: 'center', formatter:fieldFormatter,
                    styler: function () {
                      return 'background-color:#ffc800';
                    }},
                      <% } else { %>
                  { field: 'day<%=i+1%>', title: '<%=i+1%>', width: '3%', align: 'center', formatter:fieldFormatter},
                      <% }
                  } %>
              ]],
              pagination: false,
              onLoadSuccess: function (data) {
              }
          });
//          $('#officeBussinessTable').datagrid('getPager').pagination({
//              pageSize: 10,
//              pageNumber: 1,
//              pageList: [10,20,30],
//              beforePageText: '第',
//              afterPageText: '页    共 {pages} 页',
//              displayMsg: '当前显示{from} - {to}条,共 {total} 条记录'
//          });
      });
  </script>
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
            <ul class="mininav">
                <li class="last">
                    <a target="_blank" href="/obm/vaction.jsp">年假信息
                    </a>
                </li>
            </ul>
        </div>
        <div style="width:1200px;" class="header">
            <div class="nav">
            </div>
        </div>
        <div style="margin-top: 50px">
            <h1 style="text-align: center">
                调控中心<span title="前一月" id="left" style="background: url(image/left-black.png)"><img src="image/white.png" onclick="preMonth()"></span><span id="time"><%=year%>年<%=month%>月</span><span id="right" title="后一月" style="background: url(image/right-black.png)"><img src="image/white.png" onclick="nextMonth()"></span>考勤信息汇总
            </h1>
        </div>
        <div style="margin:0px auto;width: 800px;">
            <form id="queryUserAndAdminParamsForm">
                <table cellpadding="5">
                    <tr>
                        <td><img src="image/traveltype/节假日.png"></td>
                        <td>节假日</td>
                        <td><img src="image/traveltype/出差.png"></td>
                        <td>出差</td>
                        <td><img src="image/traveltype/公休.png"></td>
                        <td>公休</td>
                        <td><img src="image/traveltype/培训.png"></td>
                        <td>培训</td>
                        <td><img src="image/traveltype/换休.png"></td>
                        <td>换休</td>
                        <td><img src="image/traveltype/病假.png"></td>
                        <td>病假</td>
                        <td><img src="image/traveltype/婚假.png"></td>
                        <td>婚假</td>
                        <td><img src="image/traveltype/产假.png"></td>
                        <td>产假</td>
                        <td><img src="image/traveltype/事假.png"></td>
                        <td>事假</td>
                        <td><img src="image/traveltype/丧假.png"></td>
                        <td>丧假</td>
                    </tr>
                </table>
            </form>
        </div>
        <div style="padding:2px 15px;">
            <table id="officeBussinessTable" style="width: auto;height: 600px;">
            </table>
        </div>
    </div>
</body>
</html>