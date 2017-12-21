package com.grid.util;


import com.grid.entity.LoginUserBean;

import java.math.BigDecimal;
import java.security.MessageDigest;

/**
 * Created by Administrator on 2017/3/16.
 */
public class GlobalUtils {
    public static Double bytes2kb(long bytes) {
        BigDecimal filesize = new BigDecimal(bytes);
        BigDecimal megabyte = new BigDecimal(1024 * 1024);
        Double returnValue = filesize.divide(megabyte, 2, BigDecimal.ROUND_UP)
                .doubleValue();
        return returnValue;
    }
    public static String hex_md5(String plainText) {
        String str_MD5 = plainText;
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(plainText.getBytes());
            byte b[] = md.digest();

            int i;

            StringBuffer buf = new StringBuffer("");
            for (int offset = 0; offset < b.length; offset++) {
                i = b[offset];
                if (i < 0)
                    i += 256;
                if (i < 16)
                    buf.append("0");
                buf.append(Integer.toHexString(i));
            }
            str_MD5 = buf.toString();
        } catch (Exception e) {
           e.printStackTrace();
        }
        return str_MD5;
    }

    /**
     *  检测用户是否拥有某个权限
     * @param permission 要判定的权限
     * @param userBean  要判定权限的用户
     * @return 当前用户是否拥有改权限，true拥有，false没有
     */
    public static boolean checkUserPermission(String permission, LoginUserBean userBean){

        return true;
    }
}
