<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>${curComment.nickname }님이 ${movie.title }(${movie.release_year })에 남긴 코멘트</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
	        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="styleSheet" href="static/css/styles/common.css">
    <link rel="styleSheet" href="static/css/header.css">
    <link rel="styleSheet" href="static/css/footer.css">
    <link rel="styleSheet" href="static/css/movieComment.css">
</head>
<body>
	<jsp:include page="header.jsp" />
	<div class="replyModal replyModal_black-bg replyModal_hide">
        <div class="replyModal_white-bg">
            <div>
                <div>댓글</div>
                <div id="replyModal_close">X</div>
            </div>
            <div>
                <form action="insertReply.do" method="get">
                	<input type="hidden" name="comment_id" value="${curComment.comment_id }">
                    <input type="hidden" name="user_id" value="${user.id }">
                    <input type="hidden" name="movie_id" value="${movie.movie_id }">
                    <textarea name="content" id="text_1"></textarea>
                    <div>
                        <div class="textCnt">
                            <span class="charCount_1">0</span>/10000
                        </div>
                        <input type="submit" class="btn" class="replySave" value="저장">
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="root">
        <div class="wrap">
            <div class="review_wrapper">
                <ul class="reviewList">
                    <li class="reviewItem">
                        <div class="item">
                            <div class="review_header">
                                <div class="pic_div">
                                    <div>
                                    	<div id="user_pic">
	                                        <img src="static/images/profile/${curComment.profile_img }" alt="pic">
	                                    </div>
	                                    <div id="nickname">${curComment.nickname }</div>
                                    </div>
                                    <div class="movieTitle">${movie.title }</div>
                                    <div class="star_div">
                                        <div id="user_star">
                                            <span>★</span>
                                            <span>${curComment.rating }</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="poster_path">
                                    <img src="${movie.poster_path }" alt="poster">
                                </div>
                            </div>
                            <div class="review_content">
                                <div id="movie_comment">
                                    ${curComment.comment }
                                </div>
                                <div class="commentCnt">
                                	<div>댓글</div>
                                	<span>${curComment.comment_cnt }</span>
                                </div>
                            </div>
                            <div class="block">
                            	<div class="reply_btn">
                            		<i class="bi bi-chat-fill"></i>
                                	<span>댓글 달기</span>
                            	</div>
                            </div>
                        </div>
                    </li>
                </ul>
                <ul class="replyLists replyList_hide">
                    <li class="replyList">
                    	<c:if test="${user != null }">
                    		<c:if test="${curReply == null }">
                    			<div class="reply_wrap" style="display: none;">
		                            <div class="img_wrap">
		                                <div class="profile_img">
		                                    <img src="static/images/profile/${curReply.profile_img }" alt="pic">
		                                </div>
		                            </div>
		                            <div class="reply_wrap_right">
		                                <div class="user_nickname">${curReply.nickname }</div>
		                                <div class="reply_content">
		                                    ${curReply.content }
		                                </div>
		                            </div>
		                        </div>
                    		</c:if>
                    		<c:if test="${curReply != null }">
                    			<div class="reply_wrap">
		                            <div class="img_wrap">
		                                <div class="profile_img">
		                                    <img src="static/images/profile/${curReply.profile_img }" alt="pic">
		                                </div>
		                            </div>
		                            <div class="reply_wrap_right">
		                                <div class="user_nickname">${curReply.nickname }</div>
		                                <div class="reply_content">
		                                    ${curReply.content }
		                                </div>
		                            </div>
		                        </div>
                    		</c:if>
	                    </c:if>
                        <div>
                            <div class="write_time">${curReply.write_time }</div>
                            <div class="re_reply">답글 보기</div>
                        </div>
                        <div class="re_reply_container">
                            <div class="re_reply_block">
                                <!-- 답글 내용 -->
                                <input type="text" placeholder="${nickname} (으)로 답글 달기">
                                <input type="submit" value="게시">
                            </div>
                            <!-- 최신순 정렬 -->
                            <div class="re_reply_section">
                                <!-- 누르면 해당 유저 프로필로 이동 -->
                                <div class="user_nickname">reply_nickname</div>
                                <div class="re_reply_content">
                                    <div>공감합니다.</div>
                                    <div class="write_time">yyyy년mm월dd일</div>
                                </div>
                            </div>
                            <div class="re_reply_section">
                                <!-- 누르면 해당 유저 프로필로 이동 -->
                                <div class="user_nickname">reply_nickname</div>
                                <div class="re_reply_content">
                                    <div>공감합니다.</div>
                                    <div class="write_time">yyyy년mm월dd일</div>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp"/>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="static/js/header.js"></script>
    <script src="static/js/modal.js"></script>
    <script src="static/js/jQuery.js"></script>
    <script src="static/js/reply.js"></script>
</body>
</html>