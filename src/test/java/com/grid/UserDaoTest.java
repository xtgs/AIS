package com.grid;

import com.grid.dao.UserDao;
import com.grid.entity.SingleValueBean;
import org.junit.Test;

import javax.annotation.Resource;

/**
 * Created by wanghuijian on 17/8/11.
 */
public class UserDaoTest extends BaseTest{

    @Resource
    private UserDao userDao;

    @Test
    public void checkIsLoginnameExistsTest() {
        SingleValueBean singleValueBean = userDao.checkIsLoginnameExists("admin");
        System.out.println(singleValueBean);
    }

    @Test
    public void updatePasswordTest() {
        userDao.updatePassword("12", "123");
    }
}
