package com.grid.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.grid.dao.UserDao;
import com.grid.entity.*;
import com.grid.exception.BgException;
import com.grid.service.UserService;
import com.grid.util.*;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;

/**
 * Created by Administrator on 17-8-11.
 */
@Service
public class UserServiceImpl implements UserService{
    private static final Logger LOG = LoggerFactory.getLogger(UserServiceImpl.class);
    @Resource
    private UserDao userDao;

    public String queryAllUserAndAdmin(String page, String rows) throws BgException {
        // SqlSession sqlSession = null;
        List<User> userBeans = null;
        Integer totalCount = 0;
        try{
            // sqlSession = MyBatisUtil.createSession();
            SingleValueBean allMasterCountValue = userDao.getAllUserAndAdminCount(); //sqlSession.selectOne("com.grid.entity.User.getAllUserAndAdminCount");
            if(allMasterCountValue == null || allMasterCountValue.getValueInfo() == null){
                throw new BgException("获取用户和管理员数据总条数出错");
            }
            totalCount = Integer.parseInt(allMasterCountValue.getValueInfo());
            PaginationParamBean paramBean = PaginationUtil.getPaginationParamBean(page,rows);
            userBeans = userDao.listAllUserAndAdmin(paramBean); //sqlSession.selectList("com.grid.entity.User.listAllUserAndAdmin", paramBean);
            for(User user : userBeans) {
                if (user.getUauth()!=null && user.getUauth().length()>0) {
                    user.setUauth(user.getUauth().replace("3", "部门审核"));
                    user.setUauth(user.getUauth().replace("4", "班组审核"));
                    user.setUauth(user.getUauth().replace("5", "机房审核"));
                    user.setUauth(user.getUauth().replace("6", "台账审核"));
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询所有用户和管理员信息失败");
        }finally {
            // MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", totalCount);
        jsonObject.put("rows", userBeans);
        return jsonObject.toString();
    }
    public String queryAllUserAndAdminByParam(String page, String rows, QueryUserAndAdminParamBean paramBean) throws BgException {
        SqlSession sqlSession = null;
        List<User> userBeans = null;
        Integer totalCount = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean allMasterCountValue = userDao.getAllUserAndAdminCountByParam(paramBean); //sqlSession.selectOne("com.grid.entity.User.getAllUserAndAdminCountByParam", paramBean);
            if(allMasterCountValue == null || allMasterCountValue.getValueInfo() == null){
                throw new BgException("获取用户和管理员数据总条数出错");
            }
            totalCount = Integer.parseInt(allMasterCountValue.getValueInfo());
            PaginationParamBean paginationParamBean = PaginationUtil.getPaginationParamBean(page,rows);
            paramBean.setStartnum(paginationParamBean.getStartnum());
            paramBean.setGetrows(paginationParamBean.getGetrows());
            userBeans = userDao.listAllUserAndAdminByParam(paramBean); //sqlSession.selectList("com.grid.entity.User.listAllUserAndAdminByParam", paramBean);
            for(User user : userBeans) {
                if (user.getUauth()!=null && user.getUauth().length()>0) {
                    user.setUauth(user.getUauth().replace("3", "部门审核"));
                    user.setUauth(user.getUauth().replace("4", "班组审核"));
                    user.setUauth(user.getUauth().replace("5", "机房审核"));
                    user.setUauth(user.getUauth().replace("6", "台账审核"));
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询所有用户和管理员信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", totalCount);
        jsonObject.put("rows", userBeans);
        return jsonObject.toString();
    }

    public boolean saveAddUserAndAdmin(User user) throws BgException {
        user.setMphone(user.getMphone().trim());
        user.setPassword(user.getPassword().trim());
        user.setLoginname(user.getLoginname().trim());
        user.setName(user.getName().trim());
        int result = 0;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean value = userDao.checkLoginname(user.getLoginname()); //sqlSession.selectOne("com.grid.entity.User.checkLoginname", userBean.getLoginname());
            boolean checkLoginNameresult;
            if(value == null){
                checkLoginNameresult = false;
            }else{
                checkLoginNameresult = value.getValueInfo() == null? false:true;
            }
            if(checkLoginNameresult){
                throw new BgException("登录名已经存在，新增用户和管理员失败");
            }
            user.setUid(new IdUtils().getUid());
            //密码加密规则，是loginname+password明文之后，md5

            String md5password = GlobalUtils.hex_md5(user.getPassword());
            String finallypassword = GlobalUtils.hex_md5(user.getUid() + md5password);

            user.setPassword(finallypassword);

            result = userDao.saveAddUserAndAdmin(user); // sqlSession.insert("com.grid.entity.User.saveAddUserAndAdmin", userBean);
            sqlSession.commit();
        }catch (BgException e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch (Exception e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException("出现异常，新增用户和管理员失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }
    /**
     * 重置用户密码
     * @param resetPasswordBean
     * @return
     */
    public boolean saveResetPassword(ResetPasswordBean resetPasswordBean) throws BgException {
        User user = userDao.checkUidIsExists(resetPasswordBean.getUid());
        if (user == null) {
            throw new BgException("传入的uid在数据库中不存在");
        }

        int result = 0;
        try{
            // sqlSession = MyBatisUtil.createSession();
            result = userDao.saveResetPassword(resetPasswordBean); //sqlSession.update("com.grid.entity.User.saveResetPassword", resetPasswordBean);
            // sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            // sqlSession.rollback();
            throw new BgException("出现异常，重置密码失败");
        }finally {
           //  MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }

    public User getUserAndAdminDataByUid(String uid) throws BgException {
        SqlSession sqlSession = null;
        User user = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            user = userDao.getUserAndAdminById(uid); //sqlSession.selectOne("com.grid.entity.User.getUserAndAdminById", uid);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询指定用户和管理员信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return user;
    }
    public boolean saveModifyUserAndAdmin(User user) throws BgException {
        user.setMphone(user.getMphone().trim());
//        user.setLoginname(user.getLoginname().trim());
        user.setName(user.getName().trim());
//        SqlSession sqlSession = null;
        int result = 0;
//        try{
//            sqlSession = MyBatisUtil.createSession();
//            String loginanme = user.getLoginname();
//            String loinameOrginal = user.getLoginnameorginal();
//            if(!loginanme.equals(loinameOrginal)){
//                SingleValueBean value = userDao.checkLoginname(user.getLoginname()); //sqlSession.selectOne("com.grid.entity.User.checkLoginname", user.getLoginname());
//                boolean checkLoginNameresult;
//                if(value == null){
//                    checkLoginNameresult = false;
//                }else{
//                    checkLoginNameresult = value.getValueInfo() == null? false:true;
//                }
//                if(checkLoginNameresult){
//                    throw new BgException("登录名已经存在，修改用户和管理员信息失败");
//                }
//            }
            result = userDao.saveModifyUserAndAdmin(user); //sqlSession.update("com.grid.entity.User.saveModifyUserAndAdmin", user);
//            sqlSession.commit();
//        }
//        catch (BgException e){
//            sqlSession.rollback();;
//            e.printStackTrace();
//            throw new BgException(e.getMessage());
//        }catch (Exception e){
//            sqlSession.rollback();;
//            e.printStackTrace();
//            throw new BgException("出现异常，修改用户和管理员信息失败");
//        }finally {
//            MyBatisUtil.closeSession(sqlSession);
//        }
        return result == 1;
    }
    public boolean saveDeleteUserAndAdmin(String uid) throws BgException {
        int result = 0;
//        SqlSession sqlSession = null;
        try{
//            sqlSession = MyBatisUtil.createSession();
            result = userDao.saveDeleteUserAndAdmin(uid); //sqlSession.update("com.grid.entity.User.saveDeleteUserAndAdmin", uid);
//            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
//            sqlSession.rollback();
            throw new BgException("出现异常，删除管理员失败");
        }finally {
//            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }

    @Override
    public boolean updatePassword(String uid, String password) {
        userDao.updatePassword(uid, password);
        return true;
    }

    public User getUserByLoginname(String loginname) {
        return userDao.getUserByLoginName(loginname);
    }

    public Set<String> getRoles(String loginname) {
        return userDao.getRoles(loginname);
    }

    public Set<String> getPermissions(String loginname) {
        return userDao.getPermissions(loginname);
    }
}
