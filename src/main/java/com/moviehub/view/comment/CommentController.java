package com.moviehub.view.comment;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.moviehub.biz.comment.CommentVO;
import com.moviehub.biz.comment.CurCommentVO;
import com.moviehub.biz.comment.MyCommentVO;
import com.moviehub.biz.comment.impl.CommentService;
import com.moviehub.biz.movie.MovieVO;
import com.moviehub.biz.movie.impl.MovieService;
import com.moviehub.biz.reply.CurReplyVO;
import com.moviehub.biz.reply.Impl.ReplyService;
import com.moviehub.biz.user.LoginUserVO;

@Controller
public class CommentController {
	@Autowired
	private CommentService commentService;
	@Autowired
	private MovieService movieService;
	@Autowired
	private ReplyService replyService;
	
	@RequestMapping("/myComment.do")
	public String myComment(HttpSession session, LoginUserVO user, Model model, MyCommentVO comment,
			@RequestParam String sortType) {
		user = (LoginUserVO) session.getAttribute("user_id");
		comment.setUser_id(user.getUser_id());
		comment.setSortType(sortType);
		model.addAttribute("commentList", commentService.getMyCommentList(comment));
		return "myComment";
	}
	@RequestMapping("/deleteComment.do")
	public String deleteComment(@RequestParam String user_id, @RequestParam int movie_id, CommentVO comment, HttpServletRequest request) {
		commentService.deleteComment(comment);
		String referer = request.getHeader("Referer");
		if (referer != null && !referer.isEmpty()) {
            return "redirect:" + referer;
        } else {
            return "content.do";
        }
	}
	@RequestMapping("/modifyComment.do")
	public String modifyComment(@RequestParam String user_id, @RequestParam int movie_id, CommentVO comment, HttpServletRequest request) {
		commentService.modifyComment(comment);
		String referer = request.getHeader("Referer");
		if (referer != null && !referer.isEmpty()) {
            return "redirect:" + referer;
        } else {
            return "content.do";
        }
	}
	@RequestMapping("/insertComment.do")
	public String insertComment(HttpSession session, HttpServletRequest request, LoginUserVO user, CommentVO comment) {
		user = (LoginUserVO) session.getAttribute("user_id");
	    comment.setUser_id(user.getUser_id());
	    comment.setComment_id(UUID.randomUUID().toString());
	    
	    commentService.insertComment(comment);
	    String referer = request.getHeader("Referer");
	    if (referer != null && !referer.isEmpty()) {
            return "redirect:" + referer;
        } else {
            return "content.do";
        }
	}
	@RequestMapping(value="/comments.do", method = RequestMethod.GET)
	public String movieReview(Model model, MovieVO movie, CurCommentVO curComment,
			CurReplyVO replyList, ArrayList<CurReplyVO> reReplyList,
			@RequestParam(name = "sortType", required = false) String sortType,
			@RequestParam(name = "searchKeyword", required = false) String searchKeyword) {
		model.addAttribute("movie", movieService.getMovie(movie));
		int movie_id = movieService.getMovie(movie).getMovie_id();
		curComment.setMovie_id(movie_id);
		
		if(sortType == null && searchKeyword != null) {
			curComment.setSearchKeyword(searchKeyword);
		}else if(searchKeyword == null) {
			curComment.setSortType(sortType);
		}else if(sortType != null || sortType == null) {
			curComment.setSortType(sortType);
		}
		List<CurCommentVO> commentLists = commentService.sortComments(curComment);
		model.addAttribute("commentLists", commentLists);
		
		Map<String, List<CurReplyVO>> replyMap = new HashMap<>();
		Map<String, Map<Integer, List<CurReplyVO>>> reReplyMaps = new HashMap<>();
		// 댓글
		for (CurCommentVO comment : commentLists) {
		    replyList.setComment_id(comment.getComment_id());
		    List<CurReplyVO> replyLists = replyService.getReplyList(replyList);
		    
		    replyMap.put(comment.getComment_id(), replyLists);
		    model.addAttribute("replyMap", replyMap);
		    
		    // 대댓글
		    Map<Integer, List<CurReplyVO>> reReplyMap = new HashMap<>();
		    for (CurReplyVO reply : replyLists) {
		        List<CurReplyVO> reReplyLists = replyService.getReReplyListByReplyId(reply.getReply_id());
		        
		        reReplyMap.put(reply.getReply_id(), reReplyLists);
		    }
		    reReplyMaps.put(comment.getComment_id(), reReplyMap);
		}
		model.addAttribute("reReplyMaps", reReplyMaps);
		return "comments";
	}
	@RequestMapping(value="/movieComment.do", method = RequestMethod.GET)
	public String movieCommentView(HttpSession session, Model model, MovieVO movie, CommentVO comment, 
			CurCommentVO curComment, CurReplyVO curReply, CurReplyVO replyList, ArrayList<CurReplyVO> reReplyList) {
		model.addAttribute("movie", movieService.getMovie(movie));
		int movie_id = movieService.getMovie(movie).getMovie_id();
		curComment.setMovie_id(movie_id);
		curComment = commentService.getCurComment(curComment);
		model.addAttribute("curComment", curComment);
		
		LoginUserVO user = (LoginUserVO) session.getAttribute("user_id");
		if(user != null) {
			curReply.setUser_id(user.getUser_id());
			curReply.setComment_id(curComment.getComment_id());
			
			CurReplyVO curReplyResult = replyService.getCurReply(curReply);
			model.addAttribute("curReply", curReplyResult);
			
			if (curReplyResult != null && curReplyResult.getContent() == null) {
			    System.out.println("reply null 발생");
			} else if (curReplyResult != null) {
			    model.addAttribute("curReplyContentCnt", curReplyResult.getContent().length());
			}
		}
		replyList.setComment_id(curComment.getComment_id());
		replyList.setMovie_id(movie_id);
		model.addAttribute("replyCnt", replyService.getReplyList(replyList).size());
		
		Map<Integer, List<CurReplyVO>> reReplyMap = new HashMap<>();
		List<CurReplyVO> replyLists = replyService.getReplyList(replyList);

		for (CurReplyVO reply : replyLists) {
		    List<CurReplyVO> reReplyLists = replyService.getReReplyListByReplyId(reply.getReply_id());
		    reReplyMap.put(reply.getReply_id(), reReplyLists);
		}
		model.addAttribute("replyList", replyLists);
		model.addAttribute("reReplyMap", reReplyMap);
		return "movieComment";
	}
}























