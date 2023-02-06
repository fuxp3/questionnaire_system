package com.project.survey.user;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;

@Slf4j
@Controller
@RequestMapping("/user")
public class UserDoController {
    private final UserService userService;

    @Autowired
    public UserDoController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/register.do")
    public String register(String username, String password, HttpSession session) {
        if(username.equals("") || username.equals(" ") || password.equals("") || password.equals(" ")){
            log.debug("用户名或密码为空");
            return "redirect:/user/register.html";
        }
        User user = userService.check(username, password);
        log.debug("用户: {}", user);
        if (user == null) {
            return "redirect:/user/register.html";
        }
        log.debug("用户: {}", user);
        session.setAttribute("currentUser", user);
        return "redirect:/user/login.html";
    }

    @PostMapping("/login.do")
    public String login(String username, String password, HttpSession session) {
        if(username.equals("") || password.equals("")){
            log.debug("用户名或密码为空");
            return "redirect:/user/login.html";
        }
        User user = userService.login(username, password);
        log.debug("用户: {}", user);
        if (user == null) {
            return "redirect:/user/login.html";
        }
        session.setAttribute("currentUser", user);
        return "redirect:/";
    }

    @GetMapping("/quit.do")
    public String quit(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.removeAttribute("currentUser");
        }

        return "redirect:/";
    }
}
