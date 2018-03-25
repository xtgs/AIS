<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
    $(function(){
        $("#chargeForm").form("load", "<%=request.getContextPath()%>/patient/getPatientByPid.do" +
                "?pid=<%=request.getAttribute("pid").toString()%>&randomid=" + Math.random());
        $.extend($.fn.validatebox.defaults.rules, {
            maxLen:{
                validator: function (value, param) {
                    var result = true;
                    if(StringUtil.getCharNumber($.trim(value)) > param[0]){
                        result = false;
                    }
                    return result;
                },
                message:'已超长，最多输入{0}个字符'
            },
            maxLenWithoutTrim:{
                validator: function (value, param) {
                    var result = true;
                    if(StringUtil.getCharNumber(value) > param[0]){
                        result = false;
                    }
                    return result;
                },
                message:'已超长，最多输入{0}个字符'
            },
            numberAndLetter:{
                validator: function (value, param) {
                    var reg_loginname = /^[0-9a-zA-Z]*$/g;
                    return reg_loginname.test(value);
                },
                message:'格式不正确，只能为字母或数字组合'
            },
            number:{
                validator: function (value, param) {
                    var reg_loginname = /^[0-9]*$/g;
                    return reg_loginname.test(value);
                },
                message:'格式不正确，只能为数字'
            },
            mphone:{
                validator: function (value, param) {
                    var reg = /^1\d{10}$/;
                    return reg.test(value);
                },
                message:'格式不正确，只能为以1开头的11位数字'
            }
        });
        $("#birthday").textbox({
            formatter:function(row){
                var unixTimestamp = new Date(row.value);
                var month = unixTimestamp.getMonth()+1;
                return unixTimestamp.getUTCFullYear()+"-"+ month +"-"+unixTimestamp.getDate();
            }
        });
//        $('input.item').click(function(){
//            alert(this.checked?"勾上了":"取消了勾选")
//        });
        var price;
        var discount;
        $("#item").combobox({
            onChange: function(iid) {
                var curValue=$('#item').combobox('getValue');
                if(curValue == undefined)
                    return '';
                var list = curValue.split(":");
                price = list[1];
                if (discount == undefined)
                    $('#charge').textbox('setValue', price);
                else
                    $('#charge').textbox('setValue', changeTwoDecimal_f(price * discount /100));

//                $('#charge').setValue(curValue);
//                alert(curValue);
            }
        });

        $('#discount').textbox({
            required: true,
            validType: ['maxLenWithoutTrim[3]','number'],
            prompt:'请输入折扣'
        });

        $("#discount").textbox("setValue", "100");

        $("#discount").textbox({
            onChange: function(dc) {
                discount = dc;
                var finalPrice = changeTwoDecimal_f(price * discount / 100);
                $('#charge').textbox('setValue', finalPrice);
//                $('#charge').setValue(curValue);
//                alert(curValue);
            }
        });
//        $("#charge").textbox('textbox').css("font-size", "68px");
    });

    function fomatFloat(src,pos){
        return Math.round(src*Math.pow(10, pos))/Math.pow(10, pos);
    }

    function changeTwoDecimal_f(x) {
        var f_x = parseFloat(x);
        if (isNaN(f_x)) {
            alert('function:changeTwoDecimal->parameter error');
            return false;
        }
        var f_x = Math.round(x * 100) / 100;
        var s_x = f_x.toString();
        var pos_decimal = s_x.indexOf('.');
        if (pos_decimal < 0) {
            pos_decimal = s_x.length;
            s_x += '.';
        }
        while (s_x.length <= pos_decimal + 2) {
            s_x += '0';
        }
        return s_x;
    }


    function formatDate(val, row){
        var unixTimestamp = new Date(val);
        var month = unixTimestamp.getMonth()+1;
        var final_date = unixTimestamp.getUTCFullYear()+"-"+ month +"-"+unixTimestamp.getDate();
        $("#birthday").textbox("setText","1-1-1");
        return final_date;
    }

    function submitCharge() {
         if(!checkChargeBeforeSubmit()){
            return;
         }
        $.ajax({
            url:"<%=request.getContextPath()%>/patient/saveCharge.do"+
            "?randomid=" + Math.random(),
            data:$('#chargeForm').serialize(),
            type:'post',
            async:false,
            error:function(data){
                MsgBox.show(data.responseText);
            },
            success:function(data){
                MsgBox.show(data);
                $('#chargeDialog').dialog('close');
                $('#patientList').datagrid('reload');
            }
        });
    }
    
    function checkChargeBeforeSubmit() {
        if($.trim(($("#discount").val())).length == 0){
            MsgBox.show("请输入折扣");
            return false;
        }
        return true;
    }
</script>
<div  style="width: 400px;margin: 0 auto;">
    <form id="chargeForm">
        <br/>
        <table cellpadding="5">
            <tr>
                <td colspan="2" >
                    <div class="formTitle" style="background-color:#f2f2f2;">
                        <div class="formTitle-icon">
                        </div><div class="formTitle-text" style="font-weight:bold;text-decoration:none;font-style:normal;text-align:left;">修改管理员信息</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">卡号:</td>
                <td>
                    <input id="pid" class="easyui-textbox" name="pid" style="width:260px" readonly/>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">身份证号:</td>
                <td>
                    <input id="cardId" class="easyui-textbox" name="cardId" style="width:260px" readonly/>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">姓名:</td>
                <td><input id="name" name="name" class="easyui-textbox" style="width:260px" readonly/></td>
            </tr>
            <tr>
                <td style="text-align: right">手机号:</td>
                <td><input id="mphone" name="mphone" class="easyui-textbox" style="width:260px" readonly/></td>
            </tr>
            <tr>
                <td style="text-align: right">余额:</td>
                <td><input id="balance" name="balance" class="easyui-textbox" style="width:260px" readonly/></td>
            </tr>

            <tr>
                <td style="text-align: right">项目:</td>
                <td>
                    <input id="item" class="easyui-combobox" name="item"
                           data-options="url:'<%=request.getContextPath()%>/item/getItemList.do',
                               prompt:'项目',valueField:'id_price',textField:'name',panelHeight:'auto'" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right">折扣:</td>
                <td><input id="discount" name="discount" class="easyui-textbox" style="width:260px"/></td>
                <td>%</td>
            </tr>


            <tr>
                <td></td>
                <td style="text-align: center; font-size: 26px;">收费金额:</td>
            </tr>
            <tr>
                <td></td>
                <td><input id="charge" name="charge" class="easyui-textbox" type="text"
                           style="width:260px; height: 50px; text-align: center; font-size: 40px" /></td>
                <td>元</td>
            </tr>
        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitCharge()">保存</a>
    </div>
</div>
