package com.nth.standard.service;

import com.nth.standard.mapper.MySQLMapper.UserServiceMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * @class UserService
 * @author Hong Nguyen
 * @version 1.0
 */
@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserServiceMapper userServiceMapper;

    public HashMap getUser(HashMap params) {
        return userServiceMapper.getUser(params);
    }

    @Override
    public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
        HashMap params = new HashMap();
        params.put("username",userName);
        HashMap appUser = userServiceMapper.findUserAccount(userName);

        if (appUser == null) {
            System.out.println("User not found! " + userName);
            throw new UsernameNotFoundException("User " + userName + " was not found in the database");
        }

        System.out.println("Found User: " + appUser);

        // [ROLE_USER, ROLE_ADMIN,..]
        List<String> roleNames = userServiceMapper.getUserRoles(appUser.get("USER_ID").toString());

        List<GrantedAuthority> grantList = new ArrayList<GrantedAuthority>();
        if (roleNames != null) {
            for (String role : roleNames) {
                GrantedAuthority authority = new SimpleGrantedAuthority(role);
                grantList.add(authority);
            }
        }

        UserDetails userDetails = (UserDetails) new User(appUser.get("USER_ID").toString(), //
                appUser.get("USER_PW").toString(), grantList);

        return userDetails;
    }

    public String getAllRoles() {
        List<String> roleNames = userServiceMapper.getAllRoles();
        String roles="";
        for (String i : roleNames) {
            roles += "'" + i + "'";
        }
        roles = roles.replaceAll("''","', '");
        return roles;
    }
}
