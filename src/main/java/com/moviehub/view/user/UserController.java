package com.moviehub.view.user;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.moviehub.biz.user.LoginUserVO;
import com.moviehub.biz.user.UserCommentVO;
import com.moviehub.biz.user.UserDetailVO;
import com.moviehub.biz.user.UserVO;
import com.moviehub.biz.user.impl.UserService;

@Controller
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	private PasswordEncoder bCryptPasswordEncoder;

	@RequestMapping(value="/myProfile.do", method=RequestMethod.GET)
	public String viewProfile(HttpSession session, Model model, LoginUserVO loginUser, LoginUserVO user) {
		loginUser = (LoginUserVO) session.getAttribute("user_id");
		user.setUser_id(loginUser.getUser_id());
		user.setPassword(loginUser.getPassword());
		model.addAttribute("userData", userService.getUserData(user));
		
		Double avgRating = userService.getAvgRating(user);
		model.addAttribute("avgRating", (avgRating != null && !Double.isNaN(avgRating)) ? avgRating : 0.0);	
		return "myPage";
	}
	@RequestMapping("/getUserComment.do")
	@ResponseBody
	public List<UserCommentVO> getUserComment(HttpSession session, LoginUserVO loginUser, UserCommentVO userComment) {
		loginUser = (LoginUserVO) session.getAttribute("user_id");
		if(loginUser != null) {
			userComment.setUser_id(loginUser.getUser_id());
		}
		List<UserCommentVO> result = userService.getUserCommentList(userComment);

		return result;
	}
	
	@RequestMapping("/modifyUser.do")
	public String modifyUser(HttpSession session, LoginUserVO user, LoginUserVO loginUser) {
		loginUser = (LoginUserVO) session.getAttribute("user_id");
		userService.modifyUser(user, loginUser);
		return "index.do";
	}
	
	@RequestMapping("/widthrawl.do")
	public String withdrawlUser(HttpSession session, UserVO user) {
		user = (UserVO) session.getAttribute("user_id");
	    userService.widthdrawlUser(user.getUser_id());
	    session.invalidate();
		return "index.do";
	}

	@RequestMapping(value="/register.do", method=RequestMethod.POST)
	public String registerUser(@RequestBody UserVO user, UserDetailVO detail) {
		detail.setUser_id(user.getUser_id());
		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
		userService.registerUser(user, detail);
		return "index.do";
	}
	
	@RequestMapping("/idCheck.do")
	@ResponseBody
	public String idCheck(@RequestBody String id) {	
		int check = userService.idCheck(id);
		
		if(check == 1) return "duplicated";
		else return "available";
	}
	
	@RequestMapping("/loginCheck.do")
	@ResponseBody
	public String loginCheck(@RequestBody LoginUserVO user, LoginUserVO login, HttpSession session) {
		user.setUser_id(user.getUser_id());
		user.setPassword(user.getPassword());
		login = userService.loginCheck(user);
		
		if(login != null) {
			session.setAttribute("user_id", login);
			return "index.do";
		}else if(user.getUser_id().equals("admin") && user.getPassword().equals("admin1234")) {
			session.setAttribute("admin", login);
			return "admin_main.do";
		}else{
			return "none";
		}
	}
	@RequestMapping("/emailCheck.do")
	@ResponseBody
	public String emailCheck(@RequestBody String email) {
		int check = userService.emailCheck(email);
		
		if(check == 1) return "duplicated";
		else return "available";
	}
	@RequestMapping("/login.do")
	public String login(HttpSession session , UserVO user, @RequestParam String id, @RequestParam String password) {
		user = userService.getUser(id);
		if (user == null || !bCryptPasswordEncoder.matches(password, user.getPassword())) {
            return "index.do";
        }
		session.setAttribute("user_id", user);
		return "index.do";
	}
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "index.do";
	}
}
