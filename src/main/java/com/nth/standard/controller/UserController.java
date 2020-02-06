package com.nth.standard.controller;

import com.nth.standard.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.security.Principal;
import java.util.HashMap;

/**
 * @class UserController
 * @author Hong Nguyen
 * @version 1.0
 */
@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    UserService userService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String userInfo(Model model, Principal principal) {
        // After user login successfully.
        // Sau khi user login thanh cong se co principal
        String userName = principal.getName();

        System.out.println("User Name: " + userName);

        User loginedUser = (User)((Authentication) principal).getPrincipal();

        String userInfo = loginedUser.getUsername();
        model.addAttribute("userInfo", userInfo);

        return "userInfo";
    }

    @RequestMapping(value = "/requestNew", method = RequestMethod.POST)
    public HashMap requestNew(Model model, Principal principal) {

        return null;
    }
    @RequestMapping(value = "/UpdateUser", method = RequestMethod.POST)
    public HashMap UpdateUser(Model model, Principal principal) {

        return null;
    }
}
