package com.moviehub.view.movie;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.moviehub.biz.comment.CommentVO;
import com.moviehub.biz.comment.CurCommentVO;
import com.moviehub.biz.comment.impl.CommentService;
import com.moviehub.biz.movie.MovieVO;
import com.moviehub.biz.movie.impl.MovieService;
import com.moviehub.biz.rating.RatingVO;
import com.moviehub.biz.rating.impl.RatingService;
import com.moviehub.biz.user.LoginUserVO;

@Controller
public class MovieController {
	@Autowired
	private MovieService movieService;
	@Autowired
	private CommentService commentService;
	@Autowired
	private RatingService ratingService;
	
	@RequestMapping("/test.do")
	public String saveMovie() {
       movieService.saveMovie();
       return "index.jsp";
	}
	@RequestMapping(value="/getSearchMovieTitle.do", method = RequestMethod.GET)
	@ResponseBody
	public List<String> getSearchMovieTitle(@RequestParam String searchKeyword) {
		return movieService.getSearchMovieTitle(searchKeyword);
	}
	@RequestMapping("/index.do")
	public String getMovieList(Model model) {
		model.addAttribute("boxofficeList", movieService.getMovieList("boxoffice"));
	    model.addAttribute("netflixList", movieService.getMovieList("netflix"));
	    model.addAttribute("watchaList", movieService.getMovieList("watcha"));

	    return "index.jsp";
	}
	
	@RequestMapping(value="/content.do")
	public String getContentView(HttpSession session, LoginUserVO user, Model model, 
			MovieVO movie, CommentVO comment, CommentVO commentList, CurCommentVO curComment, RatingVO rating) {
		
		user = (LoginUserVO) session.getAttribute("user");
		if(user != null) {
			model.addAttribute("movie", movieService.getMovie(movie));
			String user_id = user.getId();
		    int movie_id = movieService.getMovie(movie).getMovie_id();
			
		    comment.setUser_id(user_id);
		    comment.setMovie_id(movie_id);
		    
		    if(commentService.getComment(comment) != null) {
		    	model.addAttribute("commentLength", commentService.getComment(comment).getComment().length());
		    	model.addAttribute("comment", commentService.getComment(comment));
		    }else {
		    	model.addAttribute("comment_null", "이 작품에 대한 코멘트를 남겨주세요.");
		    	System.out.println("comment null 발생");
		    }
			rating.setUser_id(user_id);
			rating.setMovie_id(movie_id);
			model.addAttribute("rating", ratingService.getRating(rating));
		}else {
			model.addAttribute("movie", movieService.getMovie(movie));
			model.addAttribute("comment_null", "이 작품에 대한 코멘트를 남겨주세요.");
		}
		
		curComment.setMovie_id(movieService.getMovie(movie).getMovie_id());
		List<CurCommentVO> commentLists = commentService.getCommentList(curComment);
		model.addAttribute("commentCnt", commentLists.size());
		model.addAttribute("commentLists", commentLists);
		
		return "content.jsp";
	}
}









