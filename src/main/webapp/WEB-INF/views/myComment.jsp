<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>${user.nickname }님의 영화 코멘트</title>
	<link rel="styleSheet" href="static/css/styles/common.css">
    <link rel="styleSheet" href="static/css/header.css">
    <link rel="styleSheet" href="static/css/footer.css">
    <link rel="styleSheet" href="static/css/myComment.css">
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
</head>
<body>
	<jsp:include page="header.jsp" />
	<div class="root">
        <div class="wrap">
            <div class="wrap_inner">
                <div class="wrap_header">
                    ${user.nickname }님의 코멘트
                </div>
                <div class="wrap_main">
                    <div class="main_section">
                        <div class="order_div dropdown">
                            <button class="dropdown-btn" onclick="toggleDropdown()">
                                정렬
                                <span class="material-symbols-outlined expand-icon" onclick="toggleDropdown()">
                                    expand_more
                                </span>
                            </button>
                            <div class="dropdown_content" id="myDropdown">
                                <a href="myComment.do?nickname=${user.nickname }&sortType=write_time">
                                    <div class="sortByWriteTime">최신 작성 순</div>
                                </a>
                                <a href="myComment.do?nickname=${user.nickname }&sortType=rating">
                                    <div class="sortByRatingDesc">별점 높은 순</div>
                                </a>
                                <a href="myComment.do?nickname=${user.nickname }&sortType=reply_cnt">
                                    <div class="sortByRatingAvg">댓글 순</div>
                                </a>
                            </div>
                        </div>
                        <div class="allMyCommentList">
                        	<c:forEach var="comment" items="${commentList }">
                        		<div class="myRatingMovie">
	                                <div class="poster_wrap">
	                                	<div class="poster">
		                                	<a href="content.do?movie_id=${comment.movie_id }">
		                                    	<img src="${comment.poster_path }" alt="poster">
		                                    </a>
		                                </div>
	                                </div>
	                                <div class="comment_tap">
	                                    <div class="title">${comment.title }</div>
	                                    <div class="release_year">${comment.release_year }</div>
	                                    <div class="comment">
	                                    	<a href="movieComment.do?comment_id=${comment.comment_id }&movie_id=${comment.movie_id }">
	                                    		${comment.comment }
	                                    	</a>
	                                    </div>
	                                    <div class="reply">
	                                    	<i class="bi bi-chat-fill"></i>&nbsp;
	                                    	<span class="replyCnt">${comment.reply_cnt }</span>
	                                    </div>
	                                </div>
	                            </div>
                        	</c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<jsp:include page="footer.jsp"/>
    <script src="static/js/header.js"></script>
    <script src="static/js/modal.js"></script>
    <script src="static/js/myRating.js"></script>
</body>
</html>