package com.grid.service;

import java.util.Set;

import com.grid.entity.QueryUserAndAdminParamBean;
import com.grid.entity.ResetPasswordBean;
import com.grid.entity.User;
import com.grid.exception.BgException;

import java.util.Set;

/**
 * Created by wanghuijian on 17/8/11.
 */
public interface UserService {
    String queryAllUserAndAdmin(String page, String rows) throws BgException;
    String queryAllUserAndAdminByParam(String page, String rows, QueryUserAndAdminParamBean paramBean) throws BgException;
    boolean saveAddUserAndAdmin(User user) throws BgException;
    boolean saveResetPassword(ResetPasswordBean resetPasswordBean) throws BgException;
    User getUserAndAdminDataByUid(String uid) throws BgException;
    boolean saveModifyUserAndAdmin(User user) throws BgException;
    boolean saveDeleteUserAndAdmin(String uid) throws BgException;
    boolean updatePassword(String uid, String password);

    User getUserByLoginname(String loginname);
    Set<String> getRoles(String username);
    Set<String> getPermissions(String username);
}
