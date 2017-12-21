package com.grid.service;


import com.grid.entity.LoginUserBean;
import com.grid.exception.BgException;

/**
 * Created by Administrator on 2017/3/17.
 */
public interface LoginService {
    boolean checkIsLoginnameExists(String loginname) throws BgException;

    boolean checkPassword(String loginname, String password) throws BgException ;

    LoginUserBean getUserInfoByLoginname(String loginname) throws BgException;

}
