package com.grid.service.impl;


import com.grid.dao.UserDao;
import com.grid.entity.LoginBean;
import com.grid.entity.LoginUserBean;
import com.grid.entity.SingleValueBean;
import com.grid.exception.BgException;
import com.grid.service.LoginService;
import com.grid.util.GlobalUtils;
import com.grid.util.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by Administrator on 2017/3/17.
 */
@Service
public class LoginServiceImpl implements LoginService {
    private static final Logger LOG = LoggerFactory.getLogger(LoginServiceImpl.class);

    @Resource
    UserDao userDao;

    @Override
    public boolean checkIsLoginnameExists(String loginname) throws BgException {
        boolean result = false;
        SqlSession sqlSession = null;
        try{
            // sqlSession = MyBatisUtil.createSession();
            SingleValueBean value = userDao.checkIsLoginnameExists(loginname); //sqlSession.selectOne("com.grid.entity.Login.checkIsLoginnameExists", loginname);
            if(value == null){
                return false;
            }
            result = value.getValueInfo() == null? false:true;
        } catch (Exception e) {
            e.printStackTrace();
            throw new BgException("出现异常，登录失败");
        }finally {
            // MyBatisUtil.closeSession(sqlSession);
        }
        return result;
    }

    @Override
    public boolean checkPassword(String loginname, String password) throws BgException {
        boolean result = false;
        SqlSession sqlSession = null;
        try {
            // sqlSession = MyBatisUtil.createSession();
            LoginUserBean userBean = userDao.getUserInfoByLoginname(loginname); //sqlSession.selectOne("com.grid.entity.Login.getUserInfoByLoginname", loginname);
            if(userBean == null || userBean.getUid() == null || userBean.getUname() == null || userBean.getUtype() == null){
                throw new BgException("获取登录用户的信息出错");
            }

            LoginBean loginBean = new LoginBean();
            loginBean.setLoginname(loginname);
            String finallyPassword = GlobalUtils.hex_md5(userBean.getUid() + password);
            loginBean.setPassword(finallyPassword);
            SingleValueBean value = userDao.checkPassword(loginBean); //sqlSession.selectOne("com.grid.entity.Login.checkPassword", loginBean);
            if(value == null){
                return false;
            }
            result = value.getValueInfo() == null? false:true;
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，登录失败");
        }finally {
            // MyBatisUtil.closeSession(sqlSession);
        }
        return result;
    }
    @Override
    public LoginUserBean getUserInfoByLoginname(String loginname) throws BgException {
        SqlSession sqlSession = null;
        LoginUserBean userBean = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            userBean = userDao.getUserInfoByLoginname(loginname); //sqlSession.selectOne("com.grid.entity.Login.getUserInfoByLoginname", loginname);
            if(userBean == null || userBean.getUid() == null || userBean.getUname() == null || userBean.getUtype() == null){
                throw new BgException("获取登录用户的信息出错");
            }
        }catch(BgException e){
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch(Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，获取登录用户信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return userBean;
    }

}
