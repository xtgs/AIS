package com.grid.controller;

import com.google.gson.Gson;
import com.grid.entity.*;
import com.grid.service.ChargeService;
import com.grid.service.PatientService;
import com.grid.service.TopupService;
import com.grid.util.Constant;
import com.grid.util.ResponseUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.math.BigDecimal;

/**
 * Created by wanghuijian on 17/11/16.
 */
@Controller
@RequestMapping("/patient")
public class PatientController {

    @Resource
    private PatientService patientService;

    @Resource
    private ChargeService chargeService;

    @Resource
    private TopupService topupService;

    @RequestMapping("/fwdPatientMainPage")
    public String fwdPatientMainPage(HttpServletRequest request, HttpServletResponse response) {
        return "/patient/managePatient";
    }

    @RequestMapping("/fwdModifyPatientPage")
    public String fwdModifyPatientPage(HttpServletRequest request, HttpServletResponse response, @RequestParam("pid") String pid) {
        request.setAttribute("pid", pid);
        return "/patient/modifyPatient";
    }

    @RequestMapping("/fwdAddPatientPage")
    public String fwdAddPatientPage(HttpServletRequest request, HttpServletResponse response) {
        return "/patient/addPatient";
    }

    @RequestMapping("/fwdChargePage")
    public String fwdChargePage(HttpServletRequest request, HttpServletResponse response, @RequestParam("pid") String pid) {
        request.setAttribute("pid", pid);
        return "/patient/charge";
    }

    @RequestMapping("/fwdTopupPage")
    public String fwdTopupPage(HttpServletRequest request, HttpServletResponse response, @RequestParam("pid") String pid) {
        request.setAttribute("pid", pid);
        return "/patient/topup";
    }

    @RequestMapping("/fwdTradeRecordPage")
    public String fwdTradeRecordPage(HttpServletRequest request, HttpServletResponse response) {
        return "/patient/tradeRecord";
    }

    @RequestMapping("/queryPatientByParam")
    public void queryPatientByParam(HttpServletRequest request, HttpServletResponse response) {
        try {
            LoginUserBean userBean = getLoginUserBean(request); //LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
            String loginName = userBean.getLoginname();

            String page = request.getParameter("page");
            String rows = request.getParameter("rows");
            String sort = request.getParameter("sort");
            String order = request.getParameter("order");
            QueryPatientParamBean queryPatientParamBean = new QueryPatientParamBean();
            String pid = request.getParameter("pid");
            if (pid != null && pid.length() > 0) {
                queryPatientParamBean.setPid(pid);
            }

            String cardId = request.getParameter("cardId");
            if (cardId != null && cardId.length() > 0) {
                queryPatientParamBean.setCardId(cardId);
            }

            String name = request.getParameter("name");
            if (name != null && name.length() > 0) {
                queryPatientParamBean.setName(name);
            }

            String age = request.getParameter("age");
            if (age != null && age.length() > 0) {
                queryPatientParamBean.setAge(Integer.parseInt(age));
            }

            String mphone = request.getParameter("mphone");
            if (mphone != null && mphone.length() > 0) {
                queryPatientParamBean.setMphone(mphone);
            }

            String gender = request.getParameter("gender");
            if (gender != null && gender.length() > 0) {
                queryPatientParamBean.setGender(gender);
            }

            String balanceFrom = request.getParameter("balanceFrom");
            if (balanceFrom != null && balanceFrom.length() > 0) {
                queryPatientParamBean.setBalanceFrom(new BigDecimal(balanceFrom));
            }
            String balanceTo = request.getParameter("balanceTo");
            if (balanceTo != null && balanceTo.length() > 0) {
                queryPatientParamBean.setBalanceTo(new BigDecimal(balanceTo));
            }

            String  result = patientService.getPatientByParam(queryPatientParamBean, page, rows, sort, order);

            ResponseUtil.writeMsg(response, result);
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(response, "出现异常，查询所有用户和管理员信息失败");
        }
    }

    @RequestMapping("/queryTradeRecordByParam")
    public void queryTradeRecordByParam(HttpServletRequest request, HttpServletResponse response, QueryTradeRecordBean queryTradeRecordBean) {
        try {
            String page = request.getParameter("page");
            String rows = request.getParameter("rows");
            String sort = request.getParameter("sort");
            String order = request.getParameter("order");
//            QueryChargeBean queryChargeBean = new QueryChargeBean();
//            String result = chargeService.queryChargeReord(queryChargeBean);
            String result = patientService.getTradeRecordByParam(queryTradeRecordBean, page, rows, sort, order);
            ResponseUtil.writeMsg(response, result);
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(response, "出现异常，查询所有用户和管理员信息失败");
        }
    }

    @RequestMapping("/getPatientByPid")
    public void getPatientByPid(@RequestParam("pid") String pid, HttpServletResponse response) {
        PatientBean patientBean = patientService.getPatientById(pid);
//        patientBean.setBirthday(new SimpleDateFormat("yyyy-MM-dd").format(patientBean.getBalance()));
        Gson gson = new Gson();
        String patientJson = gson.toJson(patientBean);
        ResponseUtil.writeMsg(response, patientJson);
    }




    @RequestMapping("/saveModifyPatient")
    public void saveModifyPatient(HttpServletRequest request, HttpServletResponse response, PatientBean patientBean) {
        try {
            String result = patientService.saveModifyPatient(patientBean);
            ResponseUtil.writeMsg(response, result);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            ResponseUtil.writeFailMsgToBrowse(response, "出现异常，修改失败");
        }
    }

    @RequestMapping("/saveAddPatient")
    public void saveAddPatient(HttpServletRequest request, HttpServletResponse response, PatientBean patientBean) {
        try {
            String result = patientService.saveAddPatient(patientBean);
            ResponseUtil.writeMsg(response, result);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            ResponseUtil.writeFailMsgToBrowse(response, "出现异常，新增失败");
        }
    }

    @RequestMapping("/deletePatient")
    public void deletePatient(@RequestParam("pid") String pid, HttpServletRequest request, HttpServletResponse response) {
        try {
            String result = patientService.deletePatientById(pid);
            ResponseUtil.writeMsg(response, result);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            ResponseUtil.writeFailMsgToBrowse(response, "出现异常，删除失败");
        }
    }

    @RequestMapping("/saveCharge")
    public void saveCharge(HttpServletRequest request, HttpServletResponse response) {
        LoginUserBean loginUserBean = getLoginUserBean(request);
        ChargeBean chargeBean = new ChargeBean();
        chargeBean.setPid(request.getParameter("pid"));
        chargeBean.setUid(loginUserBean.getUid());
        String chargeString = request.getParameter("charge");
        if (chargeString == null) {
            ResponseUtil.writeMsg(response, "收费金额为空!");
            return;
        }
        BigDecimal chargeDecimal = new BigDecimal(chargeString);
        String itemIdAndPrice = request.getParameter("item");
        if(itemIdAndPrice != null && itemIdAndPrice.length() > 0) {
            String[] itemList = itemIdAndPrice.split(":");
            chargeBean.setIid(itemList[0]);
            chargeBean.setOriginalPrice(new BigDecimal(itemList[1]));
            String discount = request.getParameter("discount");
            if (discount != null && discount.length() > 0) {
                chargeBean.setDiscount(new BigDecimal(discount));
            } else {
                chargeBean.setDiscount(new BigDecimal(100));
            }
        }
        chargeBean.setRealPrice(chargeDecimal);
        String result1 = patientService.chargeInBalance(chargeBean);
        String result2 = chargeService.addOneChargeRecord(chargeBean);
        ResponseUtil.writeMsg(response, result1+","+result2);
    }

    @RequestMapping("/saveTopup")
    public void saveTopup(HttpServletRequest request, HttpServletResponse response) {
        LoginUserBean loginUserBean = getLoginUserBean(request);
        TopupBean topupBean = new TopupBean();
        topupBean.setPid(request.getParameter("pid"));
        topupBean.setUid(loginUserBean.getUid());
        String topupString = request.getParameter("topup");
        if (topupBean == null) {
            ResponseUtil.writeMsg(response, "充值金额为空!");
            return;
        }
        BigDecimal topupDecimal = new BigDecimal(topupString);
        topupBean.setAmount(topupDecimal);
        String result1 = patientService.topupInBalance(topupBean);
        String result2 = topupService.addOneTopupRecord(topupBean);
        ResponseUtil.writeMsg(response, result1+","+result2);
    }


    public LoginUserBean getLoginUserBean(HttpServletRequest request) {
        HttpSession sessionObj = request.getSession(false);
        LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
        return userBean;
    }
}
