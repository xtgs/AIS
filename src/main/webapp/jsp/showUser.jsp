<%--
  Created by IntelliJ IDEA.
  User: v_wanghuijian
  Date: 2016/7/18
  Time: 14:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="com.grid.util.Constant" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
    <title>台账管理系统</title>
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
    <script type="text/javascript">

        //绑定省份、城市、行政区信息
//        function BindProvinceCity() {
//            var province = $('#Province').combobox({
//                valueField: 'Value', //值字段
//                textField: 'Text', //显示的字段
////                url: '/Province/GetAllProvince',
//                editable: true,
//                onChange: function (newValue, oldValue) {
//                    $.get('/City/GetCitysByProvinceName', { provinceName: newValue }, function (data) {
//                        city.combobox("clear").combobox('loadData', data);
//                        district.combobox("clear")
//                    }, 'json');
//                }
//            });
//
//            var city = $('#City').combobox({
//                valueField: 'Value', //值字段
//                textField: 'Text', //显示的字段
//                editable: true,
//                onChange: function (newValue, oldValue) {
//                    $.get('/District/GetDistrictByCityName', { cityName: newValue }, function (data) {
//                        district.combobox("clear").combobox('loadData', data);
//                    }, 'json');
//                }
//            });
//
//            var district = $('#District').combobox({
//                valueField: 'Value', //值字段
//                textField: 'Text', //显示的字段
//                editable: true
//            });
//        }



//        $(‘#Department‘).combobox({
//            onChange:function(){
//                if ($(‘#AccType‘).combobox(‘getValue‘)=="CCA"){ //假如账户类型文本框中的值等于公司结算账号
//                    $("#YesNo_sfczfzhgl").combobox({readonly:"readonly"});
//                    $("#YesNo_sfczfzhgl").combobox(‘setValue‘,"2");
//                }else{
//                    $("#YesNo_sfczfzhgl").combobox({readonly:false});
//                }
//
//            }
//        })
//
//        $('#cc').combobox({
//            data: [
//                { "id": 1, "value": "条目1" },
//                { "id": 2, "value": "条目2" },
//                { "id": 3, "value": "条目3" },
//                { "id": 4, "value": "条目4" },
//                { "id": 5, "value": "条目5" }
//            ],
//            valueField: 'id',
//            textField: 'value',
//            selectOnNavigation: false,
//            filter: function (q, row) {   //filter函数 传连个参数，第一个参数是你要过滤的字符串，第二个是行参数
//                var opts = $(this).combobox('options');//获取的是textbox对象
//                return row[opts.textField].toLowerCase().indexOf(q.toLowerCase()) == 0;
//            },
//            onSelect: function (k) {                 //onSelect方法传的参数是一个数组
//                selectValueId.value = k["value"];
//                selectValueId.id = k["id"];
//                var opts = $(this).combobox('panel'); //获取的是下拉框对象
//            }
//        });




//        $(document).ready(function() {
//
//            $("#mainTabs").tabs({
//
//                tabPosition:"bottom",
//                fit:true
//            });
//
//            $("#channel").combobox({
//                method:"get",
//                url:"{% url 'getchannel'%}",
//                valueField:'id',
//                textField:'channelName',
//                editable:false
//
//            });
//
//            $("#title").validatebox({
//
//                required:true,
//                missingMessage:"必须输入文章标题"
//            });
//            {%block script_document_ready%}{%endblock%}
//        });
//
//


        $('#cc').combobox({
            url:'combobox_data.json',
            valueField:'id',
            textField:'text'
        });
    </script>


</head>

<body>
<tr>
    <%--<th>--%>
        <%--<label for="Department">中心(部门)：</label>--%>
    <%--</th>--%>
    <%--<td>--%>
        <%--<select class="easyui-combobox" id="Department" name="Department" editable="true" style="width:100px;">--%>
            <%--<option value="" selected>所在中心</option>--%>
            <%--<option value="调控中心">调控中心</option>--%>
            <%--<option value="运检中心">运检中心</option>--%>
            <%--<option value="工程中心">工程中心</option>--%>
        <%--</select>--%>
    <%--</td>--%>
    <%--<th>--%>
        <%--<label for="City">城市：</label>--%>
    <%--</th>--%>
    <%--<td>--%>
        <%--<select class="easyui-combobox" id="City" name="City"  style="width:120px;"></select>--%>
    <%--</td>--%>
<%--</tr>--%>
<%--<tr>--%>
    <%--<th>--%>
        <%--<label for="District">所在行政区：</label>--%>
    <%--</th>--%>
    <%--<td>--%>
        <%--<select class="easyui-combobox" id="District" name="District"  style="width:120px;"></select>--%>
    <%--</td>--%>
    <%--<th>--%>
        <%--<label for="Hometown">籍贯：</label>--%>
    <%--</th>--%>
    <%--<td>--%>
        <%--<select class="easyui-combobox" id="Hometown" name="Hometown"  style="width:120px;"></select>--%>
    <%--</td>--%>

    <%--<br/>--%>
    <%--<br/>--%>
    <%--<input id="cc1" class="easyui-combobox" data-options="--%>
    <%--valueField: 'id',--%>
    <%--textField: 'text',--%>
    <%--&lt;%&ndash;url: 'get_data1.php',&ndash;%&gt;--%>
    <%--url:"<%=request.getContextPath()%>/name/getDepartment.do?random_id="+Math.random(),--%>

    <%--onSelect: function(rec){--%>
    <%--var url = 'get_data2.php?id='+rec.id;--%>
    <%--$('#cc2').combobox('reload', url);--%>
    <%--}">--%>
    <%--<input id="cc2" class="easyui-combobox" data-options="valueField:'id',textField:'text'">--%>

    <%--<td>--%>
        <%--<input id="cc" name="dept">--%>
    <%--</td>--%>

        <input id="cc" class="easyui-combobox" name="dept"
               data-options="valueField:'id',textField:'text',url:'data/city_data.json'" />

    <%--<td>--%>
        <%--<form id="addArticleForm" method="post" style="margin: 5px;padding: 5px;">--%>
            <%--<div>--%>
                <%--<label for="channel">频道选择</label>--%>
                <%--<input id="channel"  name="channel" class="channelSelect"/>--%>
            <%--</div>--%>

            <%--<div>--%>
                <%--<label for="title">文章标题</label>--%>
                <%--<input id="title" name="title" class="textInput"/>--%>
            <%--</div>--%>
        <%--</form>--%>
    <%--</td>--%>

    <%--<form id="ff" method="post">--%>
        <%--<table>--%>
            <%--<tr>--%>
                <%--<td>Name:</td>--%>
                <%--<td><input type="text" name="name" style="width:350px;"/></td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td>Address:</td>--%>
                <%--<td><input type="text" name="address" style="width:350px;"/></td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td>City:</td>--%>
                <%--<td><input class="easyui-combobox" url="data/city_data.json" name="city" style="width:156px;" editable="true"/></td>--%>
            <%--</tr>--%>
        <%--</table>--%>
    <%--</form>--%>

</tr>
</body>
</html>
