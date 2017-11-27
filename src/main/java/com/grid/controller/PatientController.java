package com.grid.controller;

import com.grid.entity.LoginUserBean;
import com.grid.entity.QueryPatientParamBean;
import com.grid.service.PatientService;
import com.grid.util.Constant;
import com.grid.util.ResponseUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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

    @RequestMapping("/fwdPatientMainPage")
    public String fwdPatientMainPage(HttpServletRequest request, HttpServletResponse response) {
        return "/patient/managePatient";
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


    public LoginUserBean getLoginUserBean(HttpServletRequest resq) {
        HttpSession sessionObj = resq.getSession(false);
        LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
        return userBean;
    }
}
