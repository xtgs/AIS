package com.grid.util;

/**
 * Created by Administrator on 17-8-11.
 */
public class PasswordUtil {
    public static void main(String[] args){
        String oldpasswod = "123456";
        String uid = "u170811004";
        String md5password = GlobalUtils.hex_md5(oldpasswod);
        String finallypassword = GlobalUtils.hex_md5(uid + md5password);
        System.out.println(finallypassword);
    }
}
