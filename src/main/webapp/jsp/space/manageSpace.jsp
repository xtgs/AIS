<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><html>
<%@ page import="com.grid.entity.LoginUserBean" %>
<%@ page import="com.grid.util.Constant" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%
    HttpSession sessionObj = request.getSession(false);
    LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
%>
<script>

    $(function () {
        $("#spaceList").datagrid({
            title:"台账列表",
            url:"<%=request.getContextPath()%>/space/querySpaceByParam.do?random_id="+Math.random(),
            rownumbers:false,
            fitColumns:true,
            loadMsg:"正在加载用户数据...",
            columns: [[
                { field: 'roomNum', title: '机房号', width: '4%'},
                { field: 'cabinetNum', title: '机柜号', width: '4%'},
                { field: 'u1', title: '1u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u2', title: '2u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u3', title: '3u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u4', title: '4u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u5', title: '5u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u6', title: '6u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u7', title: '7u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u8', title: '8u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u9', title: '9u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u10', title: '10u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u11', title: '11u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u12', title: '12u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u13', title: '13u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u14', title: '14u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u15', title: '15u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u16', title: '16u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u17', title: '17u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u18', title: '18u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u19', title: '19u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u20', title: '20u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u21', title: '21u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u22', title: '22u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u23', title: '23u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u24', title: '24u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u25', title: '25u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u26', title: '26u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u27', title: '27u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u28', title: '28u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u29', title: '29u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u30', title: '30u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u31', title: '31u', width: '3%', formatter:fieldFormatter, styler:fieldStyler},
                { field: 'u32', title: '32u', width: '3%', formatter:fieldFormatter, styler:fieldStyler}

            ]]
        });
    });

    function fieldFormatter(value, row, index) {
        if(value == undefined)
            return '';
        var value_message = value.split("__");
        return '<span title=\"' + value_message[1] + '\" class=\"dg-cell\">' + value_message[0] + '</span>';
    }

    function fieldStyler(value, row, index) {
        if (value == '0' || value == undefined) {
            return 'background-color:#FFFFFF';
        } else if (value == '1') {
            return 'background-color:#FFFF00';
        } else {
            return 'background-color:#FF0000';
        }
    }
</script>
<div style="padding:2px 0;">
    <table id="spaceList" style="width: auto;height: auto;">
    </table>

</div>