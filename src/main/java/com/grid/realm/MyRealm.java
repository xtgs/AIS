package com.grid.realm;

import com.grid.entity.User;
import com.grid.service.UserService;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import javax.annotation.Resource;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by hanxingwang on 2017/11/22.
 */
public class MyRealm extends AuthorizingRealm {
    @Resource
    private UserService userService;

    // 为当前登陆成功的用户授予权限和角色，已经登陆成功了
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        String  username = (String)principalCollection.getPrimaryPrincipal();
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();

        try {
            User user = userService.getUserByLoginname(username);
            Set<String> roles = new HashSet<String>();
            roles.add(user.getType());
            authorizationInfo.setRoles(roles);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return authorizationInfo;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        String username = (String) authenticationToken.getPrincipal();

        try {
            User user = userService.getUserByLoginname(username);

            if(user != null) {
                AuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(user.getLoginname(), user.getPassword(), "myrealm");
                return authenticationInfo;
            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
