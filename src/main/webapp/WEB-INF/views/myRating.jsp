<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>${user.nickname }님의 영화 평가</title>
	<link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
	<link rel="styleSheet" href="static/css/styles/common.css">
    <link rel="styleSheet" href="static/css/header.css">
    <link rel="styleSheet" href="static/css/footer.css">
    <link rel="styleSheet" href="static/css/myRating.css">
</head>
<body>
	<jsp:include page="header.jsp" />
	<div class="root">
        <div class="wrap">
            <div class="wrap_inner">
                <div class="wrap_header">
                    ${user.nickname }님이 평가한 작품들
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
                                <a href="myRating.do?nickname=${user.nickname }&sortType=ratingDesc">
                                    <div class="sortByCommentCnt">평점 순</div>
                                </a>
                                <a href="myRating.do?nickname=${user.nickname }&sortType=wordAsc">
                                    <div class="sortByCommentViews">가나다 순</div>
                                </a>
                            </div>
                        </div>
                        <div class="allMyRatingList">
                            <c:forEach var="ratingList" items="${ratingLists }">
                            	<div class="myRatingMovie">
	                                <div class="poster">
	                                    <a href="content.do?movie_id=${ratingList.movie_id }">
	                                    	<img src="${ratingList.poster_path }" alt="poster">
	                                    </a>
	                                </div>
	                                <div class="title">${ratingList.title }</div>
	                                <div class="ratingDesc">
	                                    <div class="ratingWord">평가함&nbsp;★&nbsp;</div>
	                                    <div class="rating">${ratingList.rating }</div>
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