package com.project.survey.user;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

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

    @PostMapping("/login")
    @ResponseBody
    public Map<String,String> loginWeChatApplet(@RequestBody UserVO user, HttpSession session){
        Map<String,String> map = new HashMap<>();
        map.put("data",user.getUsername());
        if(user == null || user.getUsername().equals("") || user.getPassword().equals("")){
            log.debug("用户名或密码为空");
            map.put("code","500");
            map.put("msg","用户名或密码为空");
            return map;
        }

        User dbUser = userService.login(user.getUsername(), user.getPassword());
        log.debug("用户: {}", dbUser);
        if (dbUser == null) {
            map.put("code","500");
            map.put("msg","用户名或密码错误");
            return map;
        }

        session.setAttribute("currentUser", user);
        map.put("code","200");
        map.put("msg","登录成功");
        return map;
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
