package com.grid.controller;

import com.google.gson.Gson;
import com.grid.entity.*;
import com.grid.exception.BgException;
import com.grid.service.LoginService;
import com.grid.service.UserScoreService;
import com.grid.service.UserService;
import com.grid.util.Constant;
import com.grid.util.GlobalUtils;
import com.grid.util.ResponseUtil;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by Administrator on 17-8-10.
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserService userService;

    @Resource
    private LoginService loginService;

    @Resource
    private UserScoreService userScoreService;

    /**
     * 转向 普通用户主页面
     * @param resq
     * @param resp
     * @return
     */
    @RequestMapping("/fwdUserMainPage.do")
    public String forwardUserMainPage(HttpServletRequest resq, HttpServletResponse resp){
        return "userMain";
    }

    /**
     * 转向管理员主页面
     * @param resq
     * @param resp
     * @return
     */
    @RequestMapping("/fwdAdminMainPage.do")
    public String forwardAdminMainPage(HttpServletRequest resq, HttpServletResponse resp){
        return "adminMain";
    }

    @RequestMapping("/fwdManageUserAndAdminPage.do")
    public String fwdManageUserPage(){
        return "/user/manageUserAndAdmin";
    }

    @RequestMapping("/fwdAuditorMainPage.do")
    public String fwdAuditorMainPage(HttpServletRequest resq, HttpServletResponse resp) {
        return "auditorMain";
    }

    @RequestMapping("/fwdUserScorePage")
    public String fwdUserScorePage(HttpServletRequest request, HttpServletResponse response) {
        return "/user/userScore";
    }


    @RequestMapping("/queryAllUserAndAdmin.do")
    public void queryAllUserAndAdmin(HttpServletRequest resq, HttpServletResponse resp) {
        try {
            //UserService userService = new UserServiceImpl();
            String page = resq.getParameter("page");
            String rows = resq.getParameter("rows");
            String result = null;
            String queryByParamFlag = resq.getParameter("queryByParamFlag");
            if(queryByParamFlag == null || queryByParamFlag.equals("")){
                result = userService.queryAllUserAndAdmin(page, rows);
            }else{
                String typeCondition = resq.getParameter("typeCondition");
                String mphoneCondition = resq.getParameter("mphoneCondition");
                String nameCondition = resq.getParameter("nameCondition");
                String genderCondition = resq.getParameter("genderCondition");
                String loginnameCondition = resq.getParameter("loginnameCondition");
                String starttimeCondition = resq.getParameter("starttimeCondition");
                String endtimeCondition = resq.getParameter("endtimeCondition");
                String departCondition = resq.getParameter("departCondition");
                String groupCondition = resq.getParameter("groupCondition");
                String telphoneCondition = resq.getParameter("telphoneCondition");
                QueryUserAndAdminParamBean paramBean = new QueryUserAndAdminParamBean();
                paramBean.setTypeCondition(typeCondition);
                paramBean.setMphoneCondition(mphoneCondition);
                paramBean.setNameCondition(nameCondition);
                paramBean.setGenderCondition(genderCondition);
                paramBean.setStarttimeCondition(starttimeCondition);
                paramBean.setEndtimeCondition(endtimeCondition);
                paramBean.setLoginnameCondition(loginnameCondition);
                paramBean.setDepartCondition(departCondition);
                paramBean.setGroupCondition(groupCondition);
                paramBean.setTelphoneCondition(telphoneCondition);
                result = userService.queryAllUserAndAdminByParam(page, rows, paramBean);
            }
            ResponseUtil.writeMsg(resp, result);
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询所有用户和管理员信息失败");
        }
    }

    @RequestMapping("/queryAllUserScore")
    public void queryAllUserScore(HttpServletRequest request, HttpServletResponse response, QueryUserScoreBean queryUserScoreBean) {
        try {
            String page = request.getParameter("page");
            String rows = request.getParameter("rows");
            String result = userScoreService.getUserScoreByParam(queryUserScoreBean, page, rows);
            ResponseUtil.writeMsg(response, result);
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(response, "出现异常，查询用户业绩信息信息失败");
        }
    }


    @RequestMapping("/fwdAddUserAndAdminPage.do")
    public String fwdAddUserAndAdminPage(){
        return "user/addUserAndAdmin";
    }

    @RequestMapping("/saveAddUserAndAdmin.do")
    public void saveAddUserAndAdmin(HttpServletResponse resp, User user) {
        try{
            //UserService userService = new UserServiceImpl();
            boolean result = userService.saveAddUserAndAdmin(user);
            if(result){
                ResponseUtil.writeMsg(resp,"添加成功");
            }else{
                ResponseUtil.writeMsg(resp,"添加失败");
            }
        }catch (BgException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，新增用户和管理员失败");
        }
    }

    /**
     * 重置用户的登录密码
     * @param resq
     * @param resp
     */
    @RequestMapping("/saveResetPassword.do")
    public void saveResetPassword(HttpServletRequest resq, HttpServletResponse resp){
        //UserService userService = new UserServiceImpl();
        try {
            ResetPasswordBean resetPasswordBean = getResetPasswordBean(resq);
            boolean result = userService.saveResetPassword(resetPasswordBean);
            if(result){
                ResponseUtil.writeMsg(resp, "重置密码成功");
            }else{
                ResponseUtil.writeMsg(resp, "重置密码失败");
            }
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }

    }
    private ResetPasswordBean getResetPasswordBean(HttpServletRequest resq) throws BgException {
        String uid = resq.getParameter("uid");
        if(uid == null || uid.equals("")){
            throw new BgException("传入的uid为空，重置失败");
        }
        String password = resq.getParameter("password");
        if(password == null || password.equals("")){
            throw new BgException("传入的password为空，重置失败");
        }
        ResetPasswordBean resetPasswordBean = new ResetPasswordBean();
        resetPasswordBean.setUid(uid);
        String finallyPassword = GlobalUtils.hex_md5(uid + password);
        resetPasswordBean.setPassword(finallyPassword);
        return resetPasswordBean;
    }
    @RequestMapping("/fwdModifyUserAndAdminPage.do")
    public String fwdModifyUserAndAdminPage(@RequestParam("uid") String uid, HttpServletRequest resq, HttpServletResponse resp){
        resq.setAttribute("uid", uid);
        return "user/modifyUserAndAdmin";
    }
    @RequestMapping("/getUserAndAdminData.do")
    public void getUserAndAdminData(@RequestParam("uid") String uid, HttpServletResponse resp){
        try{
            //UserService userService = new UserServiceImpl();
            User user = userService.getUserAndAdminDataByUid(uid);
            Gson gson = new Gson();
            String userJson = gson.toJson(user);
            ResponseUtil.writeMsg(resp, userJson);
        }catch (BgException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询指定用户和管理员信息失败");
        }
    }

    @RequestMapping("/saveModifyUserAndAdmin.do")
    public void saveModifyUserAndAdmin(HttpServletRequest resq, HttpServletResponse resp, User user){
        //UserService userService = new UserServiceImpl();
        boolean result = false;
        try {
//            User user = new User();
//            user.setUid(resq.getParameter("uid"));
//            user.setName(resq.getParameter("name"));
//            user.setLoginname(resq.getParameter("loginname"));
//            user.setLoginnameorginal(resq.getParameter("loginnameorginal"));
//            user.setGender(resq.getParameter("gender"));
//            user.setRemarks(resq.getParameter("remarks"));
//            user.setType(resq.getParameter("type"));
//            user.setMphone(resq.getParameter("mphone"));
//            user.setDepartment(resq.getParameter("department"));
//            user.setUgroup(resq.getParameter("ugroup"));
//            user.setTelphone(resq.getParameter("telphone"));
//            user.setUauth(resq.getParameter("uauth"));
//            user.setManagegroup(resq.getParameter("managegroup"));
            result = userService.saveModifyUserAndAdmin(user);

            if(result){
                ResponseUtil.writeMsg(resp, "修改成功");
            }else{
                ResponseUtil.writeMsg(resp, "修改失败");
            }
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            ResponseUtil.writeFailMsgToBrowse(resp,"出现异常，修改管理员信息失败");
        }
    }
    @RequestMapping("/saveDeleteUserAndAdmin.do")
    public void saveDeleteAdmin(@RequestParam("uid") String uid, HttpServletResponse resp){
        try{
            // UserService userService = new UserServiceImpl();
            if(userService.saveDeleteUserAndAdmin(uid)){
                ResponseUtil.writeMsg(resp, "删除成功");
            }
        }catch (BgException e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，删除失败");
        }
    }

    @RequestMapping("/fwdModifyPasswordPage.do")
    public String fwdModifyPasswordPage(HttpServletRequest resq, HttpServletResponse resp){
        return "modifyPassword";
    }


    @RequestMapping("/saveNewPassword.do")
    public void saveNewPassword(@Param("password") String password,
                                @Param("oldPassword") String oldPassword,
                                HttpServletRequest resq, HttpServletResponse resp) throws BgException {

        HttpSession sessionObj = resq.getSession(false);
        LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
        String uid = userBean.getUid();

        if (!loginService.checkPassword(userBean.getLoginname(), oldPassword)) {
            ResponseUtil.writeMsg(resp, "原密码输入错误!");
            return;
        }

        String finalPassword = GlobalUtils.hex_md5(uid + password);

        boolean result = userService.updatePassword(uid, finalPassword);
        if (result == true) {
            ResponseUtil.writeMsg(resp, "密码修改成功");
        } else {
            ResponseUtil.writeMsg(resp, "密码修改失败");
        }

    }


}
