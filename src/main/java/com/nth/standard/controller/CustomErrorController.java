package com.nth.standard.controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;

/**
 * @class CustomErrorController
 * @author Hong Nguyen
 * @version 1.0
 */
@Controller
public class CustomErrorController implements ErrorController {
    @RequestMapping("/error")
    public ModelAndView handleError(HttpServletResponse response) {
        ModelAndView modelAndView = new ModelAndView();

        if(response.getStatus() == HttpStatus.NOT_FOUND.value()) {
            modelAndView.setViewName("error/404");
        }
        else if(response.getStatus() == HttpStatus.FORBIDDEN.value()) {
            modelAndView.setViewName("error/403");
        }
        else if(response.getStatus() == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
            modelAndView.setViewName("error/500");
        }
        else if(response.getStatus() == HttpStatus.SERVICE_UNAVAILABLE.value()) {
            modelAndView.setViewName("error/503");
        }
        else {
            modelAndView.setViewName("error/error");
        }

        return modelAndView;
    }

    @Override
    public String getErrorPath() {
        return "/error";
    }
}
