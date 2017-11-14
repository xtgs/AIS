package com.grid;

import com.grid.service.UserService;
import org.junit.Test;

import javax.annotation.Resource;

/**
 * Created by wanghuijian on 17/9/7.
 */
public class UserServiceTest extends BaseTest {
    @Resource
    private UserService userService;

    @Test
    public void updatePasswordTest() {
        userService.updatePassword("12", "123");
    }
}
