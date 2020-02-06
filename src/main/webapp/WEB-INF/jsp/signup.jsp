%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url value="/" var="rootUrl" />
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html>
    <head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>ERP Standard Website - Login</title>
        <link rel="stylesheet" href="css/login.css" />
        <link rel="stylesheet" href="plugin/fontawesome-4.7.0/css/font-awesome.min.css" />

        <script type="text/javascript" src="webjars/jquery/3.0.0/jquery.min.js"></script>
        <script type="text/javascript" src="webjars/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    </head>
    <body>
        <div class="limiter">
            <div class="container-login100">
                <div class="wrap-login100 p-t-90 p-b-30">
                    <form name='f' method='POST' class="login100-form validate-form">
                        <span class="login100-form-title p-b-40">
                            Sign Up
                        </span>
                        <div class="wrap-input100 validate-input m-b-16" data-validate="Please enter email: ex@abc.xyz">
                            <input class="input100" type="text" name='username' placeholder="User Name">
                            <span class="focus-input100"></span>
                        </div>
                        <div class="wrap-input100 validate-input m-b-16" data-validate="Please enter email: ex@abc.xyz">
                            <input class="input100" type="email" name='email' placeholder="Email">
                            <span class="focus-input100"></span>
                        </div>

                        <div class="wrap-input100 validate-input m-b-16" data-validate = "Please enter password">
                            <input class="input100" type="password" name='password' placeholder="Password">
                            <span class="focus-input100"></span>
                        </div>
                        <div class="wrap-input100 validate-input m-b-16" data-validate = "Please enter password">
                            <input class="input100" type="password" name='pre_password' placeholder="Retype Password">
                            <span class="focus-input100"></span>
                        </div>

                        <div class="container-login100-form-btn">
                            <button class="login100-form-btn" name="submit" type="submit" value="SignUp">
                                Sign Up
                            </button>
                        </div>

                        <div class="flex-col-c p-t-50">
                            <span class="txt2 p-b-10">
                                Already have an account?
                            </span>
                            <a href="/login" class="txt3 bo1 hov1">
                                Sign In
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script>
            $( document ).ready(function() {
                var showPass = 0;
                $('.btn-show-pass').on('click', function(){
                    if(showPass == 0) {
                        $(this).next('input').attr('type','text');
                        $(this).find('i').removeClass('fa-eye');
                        $(this).find('i').addClass('fa-eye-slash');
                        showPass = 1;
                    }
                    else {
                        $(this).next('input').attr('type','password');
                        $(this).find('i').removeClass('fa-eye-slash');
                        $(this).find('i').addClass('fa-eye');
                        showPass = 0;
                    }
                });
            })
        </script>
   </body>
</html>