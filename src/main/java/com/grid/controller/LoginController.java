package com.grid.controller;

import com.google.gson.JsonObject;
import com.grid.entity.LoginUserBean;
import com.grid.exception.BgException;
import com.grid.service.LoginService;
import com.grid.util.Constant;
import com.grid.util.GlobalUtils;
import com.grid.util.ResponseUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by Administrator on 17-8-10.
 */
@Controller
@RequestMapping("/login")
public class LoginController {
    @Resource
    private LoginService loginService;

    @RequestMapping(value="/doLoginCheck.do", method= RequestMethod.POST)
    public void doLoginCheck(@RequestParam("loginname") String loginName,
                             @RequestParam("password") String passWord,
                             HttpServletRequest resq,
                             HttpServletResponse resp){
//        try {
//            JsonObject jsonObj = new JsonObject();
//            if(!loginService.checkIsLoginnameExists(loginName)){
//                ResponseUtil.writeFailMsgToBrowse(resp, "用户名不存在");
//            }else if(!loginService.checkPassword(loginName, passWord)){
//                ResponseUtil.writeFailMsgToBrowse(resp, "用户名或者密码错误");
//            }else{
//                jsonObj.addProperty("msg", "登录成功");
//                LoginUserBean userBean = loginService.getUserInfoByLoginname(loginName);
//                jsonObj.addProperty("redirectUrl" , resq.getContextPath()+"/user/fwdUserMainPage.do");
////                if(userBean.getUtype().equals(Constant.UserType_User)){
////                    jsonObj.addProperty("redirectUrl" , resq.getContextPath()+"/user/fwdUserMainPage.do");
////                }else if(userBean.getUtype().equals(Constant.UserType_Admin)){
////                    jsonObj.addProperty("redirectUrl", resq.getContextPath()+"/user/fwdAdminMainPage.do");
////                } else if(userBean.getUtype().equals(Constant.UserType_Auditor)) {
////                    jsonObj.addProperty("redirectUrl", resq.getContextPath()+"/user/fwdAuditorMainPage.do");
////                }
//
//
//                HttpSession session = resq.getSession(true);
//                session.setAttribute(Constant.LoginUserKey, userBean);
//                ResponseUtil.writeMsg(resp,jsonObj.toString());
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，登录失败");
//        }

        JsonObject jsonObj = new JsonObject();
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = null;
        LoginUserBean loginUserBean = null;
        try {
            loginUserBean = loginService.getUserInfoByLoginname(loginName);
            String finallyPassword = GlobalUtils.hex_md5(loginUserBean.getUid() + passWord);
            token = new UsernamePasswordToken(loginName, finallyPassword);
            subject.login(token);

            jsonObj.addProperty("msg", "登录成功");

            jsonObj.addProperty("redirectUrl" , resq.getContextPath()+"/user/fwdUserMainPage.do");

            HttpSession session = resq.getSession(true);
            session.setAttribute(Constant.LoginUserKey, loginUserBean);
            ResponseUtil.writeMsg(resp,jsonObj.toString());
        }catch (AuthenticationException e) {
            ResponseUtil.writeFailMsgToBrowse(resp, "用户名或者密码错误,请重新输入！");
            System.err.println("用户名或者密码错误,请重新输入！");
        }catch (BgException e) {
            e.printStackTrace();
            System.err.println(e.getMessage());
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，登录失败");
        }
    }

    @RequestMapping("/exitLogin.do")
    public void exitLogin(HttpServletRequest resq, HttpServletResponse resp){
        HttpSession session = resq.getSession(false);
        if(session != null || isSessionContainsLoginUser(session)) {
            session.removeAttribute(Constant.LoginUserKey);
        }
        String loginPageUrl = resq.getContextPath()+ "/login.jsp";
        String javaScriptSegment = "<script id=\"script_exe\" defer=\"defer\">location.href=\""+ loginPageUrl + "\";</script>";
        ResponseUtil.writeJavaScript(resp, javaScriptSegment);
    }
    private boolean isSessionContainsLoginUser(HttpSession session){
        Object loginUserObj = session.getAttribute(Constant.LoginUserKey);
        if(loginUserObj == null){
            return false;
        }else{
            LoginUserBean userBean = (LoginUserBean)loginUserObj;
            if(userBean.getUid() == null || userBean.getUname() == null || userBean.getUtype() == null){
                return false;
            }
            return true;
        }
    }
}
