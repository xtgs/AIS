package com.grid.dao;

import com.grid.entity.*;

import java.util.List;

/**
 * Created by wanghuijian on 17/8/15.
 */
public interface UserDao {

    int saveAddUserAndAdmin(User user);

    SingleValueBean checkLoginname(String name);

    SingleValueBean getAllUserAndAdminCount();

    List<User> listAllUserAndAdmin(PaginationParamBean paginationParamBean);

    int saveResetPassword(ResetPasswordBean resetPasswordBean);

    User checkUidIsExists(String uid);

    User getUserAndAdminById(String id);

    int saveModifyUserAndAdmin(User user);

    int saveDeleteUserAndAdmin(String id);

    SingleValueBean getAllUserAndAdminCountByParam(QueryUserAndAdminParamBean queryUserAndAdminParamBean);

    List<User> listAllUserAndAdminByParam(QueryUserAndAdminParamBean queryUserAndAdminParamBean);

    SingleValueBean checkIsLoginnameExists(String name);

    SingleValueBean checkPassword(LoginBean loginBean);

    LoginUserBean getUserInfoByLoginname(String name);

    int updatePassword(String uid, String password);
}
