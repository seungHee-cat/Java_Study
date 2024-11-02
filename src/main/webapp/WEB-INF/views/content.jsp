<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>${movie.title }(${movie.release_year })</title>
	<link rel="styleSheet" href="static/css/styles/common.css">
    <link rel="styleSheet" href="static/css/header.css">
    <link rel="styleSheet" href="static/css/footer.css">
    <link rel="styleSheet" href="static/css/content.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.css">
</head>
<body>
	<jsp:include page="header.jsp" />
	<div class="commentModal comment_black-bg comment_hide">
        <div class="comment_white-bg">
            <div>
                <div>${movie.title }</div>
                <div id="comment_close">X</div>
            </div>
            <div>
                <form action="insertComment.do" method="post">
                	<input type="hidden" name="movie_id" value="${movie.movie_id }">
                    <textarea name="comment" id="text_1" placeholder="이 작품에 대한 코멘트를 남겨주세요."></textarea>
                    <div>
                        <div class="textCnt_1">
                            <span class="charCount_1">0</span>/10000
                        </div>
                        <input type="submit" class="btn" class="commentSave" value="저장">
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="commentModifyModal commentModify_black-bg commentModify_hide">
        <div class="commentModify_white-bg">
            <div>
                <div>${movie.title }</div>
                <div id="commentModify_close">X</div>
            </div>
            <div>
                <form action="modifyComment.do" method="post">
                	<input type="hidden" name="user_id" value="${user.user_id }">
                	<input type="hidden" name="movie_id" value="${movie.movie_id }">
                    <textarea name="comment" id="text_2" >${comment.comment }</textarea>
                    <div>
                        <div class="textCnt_2">
                            <span class="charCount_2">${commentLength }</span>/10000
                        </div>
                        <input type="submit" class="btn" class="commentSave" value="수정">
                    </div>
                </form>
            </div>
        </div>
    </div>
	<div class="root">
        <div class="wrap">
            <div class="movie_info">
                <div class="backdrop_path">
                    <div id="gradient">
                        <img src="${movie.backdrop_path }" alt="backdrop_path">
                    </div>
                </div>
                <div class="movie_desc">
                    <div id="title">${movie.title }</div>
                    <div class="desc_detail">
                        <div id="original_title">${movie.original_title }</div>
                        <div class="spans_div">
                            <div id="release_date">${movie.release_year }&nbsp;<span class="middle_dot">·</span>&nbsp;</div>
                            <div class="genres">
                                <div class="genre">${movie.genre_ids }</div>
                            </div>
                            &nbsp;<span class="middle_dot">·</span>&nbsp;
                            <div id="production_countries">${movie.production_countries }</div>
                        </div>
                        <div id="runtime">${movie.runtime }</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="section_1">
            <section>
                <div class="box">
                    <div class="box_left">
                        <div class="poster">
                            <img src="${movie.poster_path }" alt="poster">
                        </div>
                    </div>
                    <div class="box_right">
                        <div class="user_rate">
                            <div class="vote_divs">
                                <div class="rate_star_div">
                                    <c:if test="${user != null }">
	                                    <div class="rate_star">
	                                    	<input type="hidden" name="rating" value="${rating.rating }">
	                                    	<input type="hidden" name="movie_id" value="${movie.movie_id }">
	                                        <div class="half-star-ratings" data-rateyo-half-star="true"></div>
	                                    </div>
	                                </c:if>
	                                <c:if test="${user == null }">
	                                    <div class="rate_star">
	                                        <div class="half-star-ratings" data-rateyo-half-star="true" id="starRating"></div>
	                                    </div>
	                                </c:if>
                                    <div>평가하세요!</div>
                                </div>
                                <div class="vote_count">
                                    <div>${movie.vote_average }</div>
                                    <div>평균 평점(${movie.vote_count}명)</div>
                                </div>
                            </div>
                            <div class="rate_btns">
                                <c:if test="${user != null }">
                                	<c:if test="${comment == null and empty comment.comment}">
		                                <button class="comment" onclick="commentFunc()">comment</button>
		                                <div class="wishList">wishList</div>
	                                </c:if>
	                                <c:if test="${comment != null and not empty comment.comment}">
           								 <button class="comment" onclick="modifyComment()">comment</button>
           								 <div class="wishList">wishList</div>
        							</c:if>
                                </c:if>
                                <c:if test="${user == null }">
	                                <button class="comment" onclick="return loginRequire()">comment</button>
	                                <div class="wishList" onclick="return loginRequire()">wishList</div>
	                            </c:if>
                            </div>
                        </div>
                        <c:if test="${comment != null }">
	                        <div class="comment_divs">
	                            <div id="comment_title">
	                                내가 남긴 코멘트
	                            </div>
	                            <div class="my_comment">
	                                <div class="my_comment_inner">
	                                	${comment.comment }
	                                </div>
	                                <div class="comment_btns">
	                                    <div id="comment_remove" onclick="return deleteComment()">
	                                    	<a href="deleteComment.do?user_id=${comment.user_id }&movie_id=${comment.movie_id}">삭제</a>
	                                    </div>
	                                    <div id="comment_modify" onclick="modifyComment()">수정</div>
	                                </div>
	                            </div>
	                        </div>
                        </c:if>
                        <c:if test="${comment == null }">
                        	<div class="comment_divs">
                        		<c:if test="${user == null }">	
                        			<div class="my_comment">${comment_null } <button onclick="return loginRequire()">코멘트 남기기</button></div>
                        		</c:if>
                        		<c:if test="${user != null }">	
                        			<div class="my_comment">${comment_null } <button onclick="commentFunc()">코멘트 남기기</button></div>
                        		</c:if>
                        	</div>
                        </c:if>
                        <div class="storyline">
                            <div id="tagline">
                                ${movie.tagline }
                            </div>
                            <div id="overview">
                                ${movie.overview }
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <div class="section_2">
            <section>
                <div class="review_div">
                    <div class="review_info">
                        <div id="review_title">
                            코멘트&nbsp;<span class="review_tot">${commentCnt }</span><span>+</span>
                        </div>
                        <div id="review_btn">
                            <a href="comments.do?movie_id=${movie.movie_id }">더보기</a>
                        </div>
                    </div>
                    <div class="review_list">
                    	<c:if test="${commentCnt == 0 }">
                    		아직 등록된 코멘트가 없습니다.
                    	</c:if>
                    	<c:if test="${commentCnt != 0 }">
	                        <c:forEach var="commentList" items="${commentLists }" varStatus="loop">
	                        	<c:if test="${loop.index < 4}">
			                        <div class="review_item">
			                            <div class="review_header">
			                                <div class="pic_div">
			                                    <div id="user_pic">
			                                        <img src="static/images/profile/${commentList.profile_img }" alt="pic">
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
			                                <div id="movie_comment"><a href="movieComment.do?comment_id=${commentList.comment_id }&movie_id=${movie.movie_id }">${commentList.comment }</a></div>
			                            </div>
			                            <div class="review">
			                                <div>
			                                	<i class="bi bi-chat-fill"></i>
			                                	<span>${commentList.reply_cnt }</span>
			                                </div>
			                            </div>
			                        </div>
			                    </c:if>
	                        </c:forEach>
	                    </c:if>
                    </div>	
                </div>
            </section>
        </div>
    </div>
	<jsp:include page="footer.jsp"/>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.js"></script>
    <script src="static/js/header.js"></script>
    <script src="static/js/modal.js"></script>
    <script src="static/js/modal_inval.js"></script>
    <script src="static/js/content.js"></script>
    <script src="static/js/rateYo.js"></script>
</body>
</html>