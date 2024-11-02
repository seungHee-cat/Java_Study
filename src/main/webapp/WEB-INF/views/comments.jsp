<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${movie.title }(${movie.release_year })</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
    <link rel="styleSheet" href="static/css/styles/common.css">
    <link rel="styleSheet" href="static/css/header.css">
    <link rel="styleSheet" href="static/css/footer.css">
    <link rel="styleSheet" href="static/css/comments.css">
</head>

<body>
    <jsp:include page="header.jsp" />
    <div class="root">
        <div class="wrap">
            <div class="wrap_inner">
                <aside class="left_side">
                    <div class="askBox">
                        <form action="comments.do" method="get">
                        	<i class="bi bi-search"></i>
                        	<input type="hidden" name="movie_id" value="${movie.movie_id }">
                        	<input type="text" name="searchKeyword" class="searchKeyword" placeholder="내용, 닉네임으로 검색하세요">
                        	<input type="submit" class="search_button" value="검색">
                        </form>
                    </div>
                </aside>
                <section>
                    <div class="order_div dropdown">
                        <button class="dropdown-btn" onclick="toggleDropdown()">
                            정렬
                            <span class="material-symbols-outlined expand-icon" onclick="toggleDropdown()">
                                expand_more
                            </span>
                        </button>
                        <div class="dropdown_content" id="myDropdown">
                            <a href="comments.do?movie_id=${movie.movie_id }&sortType=reply_cnt">
                                <div class="sortByCommentCnt">댓글 순</div>
                            </a>
                            <a href="comments.do?movie_id=${movie.movie_id }&sortType=views">
                                <div class="sortByCommentViews">조회 순</div>
                            </a>
                            <a href="comments.do?movie_id=${movie.movie_id }&sortType=write_time">
                                <div class="sortByCommentWriteTime">최신 순</div>
                            </a>
                        </div>
                    </div>
                    <div class="review_wrapper">
                        <ul class="reviewList">
                            <c:forEach var="commentList" items="${commentLists }">
                                <li class="reviewItem showBox">
                                    <div class="item">
                                        <div class="review_header">
                                            <div class="pic_div">
                                                <div id="user_pic">
                                                    <img src="static/images/profile/${commentList.profile_img }"
                                                        alt="pic">
                                                </div>
                                                <div id="nickname">${commentList.nickname }</div>
                                            </div>
                                            <div class="star_div">
                                                <div id="user_star">
                                                    <span>★</span>
                                                    <span>${commentList.rating }</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="review_content">
                                            <div id="movie_comment">
                                            	<a href="movieComment.do?comment_id=${commentList.comment_id }&movie_id=${movie.movie_id }">
                                            		${commentList.comment }
                                            	</a>
                                            </div>
                                        </div>
                                        <div class="likes">
                                            <div class="review_comment" data-commentId="${commentList.comment_id}">
                                                <span>댓글</span>&nbsp; <span>${commentList.reply_cnt }</span>
                                            </div>
                                        </div>
                                        <ul class="replyLists hide" data-commentId="${commentList.comment_id}">
	                                     <c:forEach var="replyList" items="${replyMap}">
                                     		<c:forEach var="reply" items="${replyList.value}">
                                     			<c:if test="${reply.comment_id eq commentList.comment_id}">
                                     				<li class="replyList">
			                                            <div class="replyList_wrap">                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
			                                                <div class="img_wrap">
			                                                    <div class="profile_img">
			                                                        <img src="static/images/profile/${reply.profile_img }" alt="pic">
			                                                    </div>
			                                                </div>
			                                                <div class="reply_wrap_right">
			                                                    <div class="user_nickname">${reply.nickname }</div>
			                                                    <div class="my_reply_content">${reply.content }</div>
			                                                    <div class="reply_writeTime">
			                                                        <div id="viewReply" class="viewReply" data-commentId="${reply.reply_id}">
			                                                            답글 보기
			                                                        </div>
			                                                        <div>
			                                                            <fmt:formatDate value="${reply.write_time}"
			                                                                pattern="yyyy.MM.dd. HH:mm" />
			                                                        </div>
			                                                    </div>
			                                                </div>
			                                            </div>
			                                            <!-- 대댓글 -->
			                                            <c:forEach var="reReply" items="${reReplyMaps[commentList.comment_id][reply.reply_id]}" >
	                                                		<div class="re_reply_section re_reply_hide" data-commentId="${reply.reply_id}">
		                                                        <div class="profile_img">
		                                                            <img src="static/images/profile/${reReply.profile_img}"
		                                                                alt="pic">
		                                                        </div>
		                                                        <div>
		                                                            <div class="user_nickname">${reReply.nickname}</div>
		                                                            <div class="re_reply_content">
		                                                                <div>${reReply.content}</div>
		                                                                <div class="write_time">
		                                                                    <fmt:formatDate value="${reReply.write_time}"
		                                                                        pattern="yyyy.MM.dd. HH:mm" />
		                                                                </div>
		                                                            </div>
		                                                            <c:if test="${user.user_id == reReply.user_id }">
		                                                            	<div id="reReplyRemove">삭제하기</div>
		                                                            </c:if>
		                                                        </div>
		                                                    </div>
			                                            </c:forEach>
			                                        </li>
                                     			</c:if>	
                                     		</c:forEach>
	                                    </c:forEach>
	                                	</ul>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </section>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="static/js/header.js"></script>
    <script src="static/js/modal.js"></script>
    <script src="static/js/modal_inval.js"></script>
    <script src="static/js/comments.js"></script>
</body>

</html>