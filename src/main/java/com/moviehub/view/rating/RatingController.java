package com.moviehub.view.rating;

import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.moviehub.biz.rating.MyRatingVO;
import com.moviehub.biz.rating.RatingVO;
import com.moviehub.biz.rating.impl.RatingService;
import com.moviehub.biz.user.LoginUserVO;

@Controller
public class RatingController {
	@Autowired
	private RatingService ratingService;
	
	@RequestMapping("/myRating.do")
	public String viewMyRating(HttpSession session, LoginUserVO user, Model model, MyRatingVO rating,
			@RequestParam String sortType) {
		user = (LoginUserVO) session.getAttribute("user_id");
		rating.setUser_id(user.getUser_id());
		rating.setSortType(sortType);
		model.addAttribute("ratingLists", ratingService.getAllRating(rating));
		
		return "myRating";
		
	}
	@RequestMapping("/insertStar.do")
	public String insertStar(HttpSession session, Model model, RatingVO rating, LoginUserVO user, @RequestParam int movie_id) {
		user = (LoginUserVO) session.getAttribute("user_id");
		if(user != null) {
			rating.setRating_id(UUID.randomUUID().toString());
			
			rating.setUser_id(user.getUser_id());
			rating.setMovie_id(movie_id);
			ratingService.insertStar(rating);
		}
		return "content.do";
	}
	
	@RequestMapping("/updateStar.do")
	public String updateStar(HttpSession session, Model model, RatingVO rating, LoginUserVO user, @RequestParam int movie_id) {
		user = (LoginUserVO) session.getAttribute("user_id");
		if(user != null) {
			rating.setUser_id(user.getUser_id());
			rating.setMovie_id(movie_id);
			ratingService.updateStar(rating);
		}
		return "content.do";
	}
}
