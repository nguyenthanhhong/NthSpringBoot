package com.nth.standard.controller;

import com.nth.standard.common.utility.Constants;
import com.nth.standard.service.MenuService;
import com.nth.standard.service.UserService;
import com.nth.standard.common.utility.MessageUtil;
import com.nth.standard.common.utility.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

/**
 *  @class MainController
 *  @author Hong Nguyen
 *  @version 1.0
 */
@Controller
public class MainController {

    @Autowired
    UserService userService;
    @Autowired
    MenuService menuService;

    @RequestMapping("/")
    public String welcomePage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String userId = request.getRemoteUser();
        HashMap param = new HashMap();
        param.put("userId", userId);
        if(session.getAttribute("u_userId") == null) {
            if (null != userId && !"".equals(userId)) {
                processAfterLoginSuccess(session, param);
            }
        }
        param.put("LANG_CD", StringUtil.toString(session.getAttribute("u_langCd")));
        model.addAttribute("ds_menuList",menuService.getUserMenuList(param));
        model.addAttribute("message1", MessageUtil.getMessage("user.cd"));
        model.addAttribute("message2", MessageUtil.getMessage("user.nm"));

        return "main";
    }

    @RequestMapping("/main")
    public String mainPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        if(session.getAttribute("u_userId") == null) {
            String userId = request.getRemoteUser();
            HashMap param = new HashMap();
            param.put("userId", userId);

            if (null != userId && !"".equals(userId)) {
                processAfterLoginSuccess(session, param);
                param.put("LANG_CD", StringUtil.toString(session.getAttribute("u_langCd")));
                model.addAttribute("ds_menuList",menuService.getUserMenuList(param));
            }
        }
        model.addAttribute("u_userId", StringUtil.toString(session.getAttribute("u_userId")));
        model.addAttribute("u_langCd", StringUtil.toString(session.getAttribute("u_langCd")));
        return "main";
    }

    @RequestMapping("/homePage")
    public String contact(Map<String, Object> model) {
        return "homePage";
    }

    @RequestMapping("/test")
    public String test(Map<String, Object> model) {
        return "homePage";
    }

    @RequestMapping("/user")
    @ResponseBody
    public HashMap user() {
        HashMap param = new HashMap();
        param.put("userId", "001");
        return userService.getUser(param);
    }

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String adminPage(Model model, Principal principal) {

        User loginedUser = (User) ((Authentication) principal).getPrincipal();

        String userInfo = loginedUser.getUsername();
        model.addAttribute("userInfo", userInfo);

        return "admin";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage(Model model) {
        return "login";
    }

    @RequestMapping(value = "main/signinsucessfully", method = RequestMethod.GET)
    public String signinsucessfully(HttpServletRequest req, HttpSession session) {
        String userId = req.getRemoteUser();
        HashMap param = new HashMap();
        param.put("userId", userId);

        if (null != userId && !"".equals(userId)) {
            processAfterLoginSuccess(session, param);
            return "redirect:/";
        } else {
            return "login";
        }
    }

    private void processAfterLoginSuccess(HttpSession session, HashMap param) {
        // prefix u mean user
        // prefix l mean local
        HashMap user = userService.getUser(param);
        session.setAttribute("u_userId", param.get("userId"));
        session.setAttribute("u_langCd", user.get("LANG_CD"));

        HashMap local = menuService.getLocalSetting();
        String numFM = StringUtil.nvl(local.get("NUM_FORMAT"), Constants.NUM_FORMAT);
        String numGroupSeparator = StringUtil.nvl(local.get("NUM_GROUP_SEPARATOR"), Constants.NUMBER_GROUP_SEPARATOR);
        String numRadixPoint = StringUtil.nvl(local.get("NUM_RADIX_POINT"), Constants.NUMBER_RADIX_POINT);
        String currFm = StringUtil.nvl(local.get("CURR_FORMAT"), Constants.CURR_FORMAT);
        String currRadix = StringUtil.nvl(local.get("CURR_RADIX"), Constants.CURR_RADIX);

        session.setAttribute("l_langCd", local.get("LANG_CD"));
        session.setAttribute("l_langNm", local.get("LANG_NM"));
        session.setAttribute("l_dateFm", StringUtil.nvl(local.get("DATE_FORMAT"), Constants.DATE_FORMAT));
        session.setAttribute("l_dayFm", StringUtil.nvl(local.get("DAY_FORMAT"), Constants.DAY_FORMAT));
        session.setAttribute("l_monthFm", StringUtil.nvl(local.get("MONTH_FORMAT"), Constants.MONTH_FORMAT));
        session.setAttribute("l_timeFm", StringUtil.nvl(local.get("TIME_FORMAT"), Constants.TIME_FORMAT));
        session.setAttribute("l_roundCd", StringUtil.nvl(local.get("ROUND_TYPE"), Constants.ROUND_TYPE));
        session.setAttribute("l_roundNm", local.get("ROUND_TYPE_NM"));
        session.setAttribute("l_dbDateFm", Constants.DB_DATE_FORMAT);

        session.setAttribute("l_currCd", StringUtil.nvl(local.get("CURR_CD"), Constants.CURR_CD));
        session.setAttribute("l_currNm", local.get("CURR_NM"));
        session.setAttribute("l_currRadix", currRadix);
        session.setAttribute("l_currFm", currFm);
        if("01".equals(local.get("CURR_PLACE"))) {
            session.setAttribute("l_currPrefix",currRadix + " ");
            session.setAttribute("l_currSuffix","");
        } else {
            session.setAttribute("l_currPrefix","");
            session.setAttribute("l_currSuffix"," " + currRadix);
        }

        session.setAttribute("l_numFm", numFM);
        session.setAttribute("l_numGroupSeparator", numGroupSeparator);
        session.setAttribute("l_numRadixPoint", numRadixPoint);
        if(numRadixPoint.isEmpty()) {
            session.setAttribute("l_numDigits", 0);

        } else {
            String numRp = numFM.indexOf(numRadixPoint) < 0 ? "" : numFM.substring(numFM.indexOf(numRadixPoint));
            session.setAttribute("l_numDigits", numRp.length() - 1);

            String currRp = currFm.indexOf(numRadixPoint) < 0 ? "" : currFm.substring(currFm.indexOf(numRadixPoint));
            session.setAttribute("l_currDigits", currRp.length() - 1);
        }
    }

    @RequestMapping(value = "/signup", method = RequestMethod.GET)
    public String signupPage(Model model) {
        return "signup";
    }

    @RequestMapping(value = "/logoutSuccessful", method = RequestMethod.GET)
    public String logoutSuccessfulPage(Model model) {
        model.addAttribute("title", "Logout");
        return "login";
    }

}
