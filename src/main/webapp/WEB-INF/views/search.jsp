<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>MovieHub</title>
	<link rel="styleSheet" href="static/css/styles/common.css">
    <link rel="styleSheet" href="static/css/header.css">
    <link rel="styleSheet" href="static/css/footer.css">
    <link rel="styleSheet" href="static/css/search.css">
</head>
<body>
	<jsp:include page="header.jsp" />
	<div class="root">
        <div class="wrap">
            <section class="search">
                <div class="search_result">"${searchKeyword }"의 검색 결과</div>
            </section>
            <section class="movie_wrapper">
                <div class="movie_box">
                	<c:forEach varStatus="loop" var="searchMovie" items="${searchMovieList }">
                		<c:if test="${loop.index < 5}">
	                		<div class="movie_list">
	                			<div class="movie_image">
	                				<a class="image" href="content.do?movie_id=${searchMovie.movie_id }">
		                                <img src="${searchMovie.poster_path }">
		                            </a>
	                			</div>
		                        <div class="movie_info">
		                            <div class="movie_title">${searchMovie.title }</div>
		                            <div class="movie_year">${searchMovie.release_year }&nbsp;<span class="middle_dot">·</span>&nbsp;${searchMovie.original_language }</div>
		                        </div>
		                    </div>
		                </c:if>
                	</c:forEach>
                </div>
            </section>
            <section class="desc_wrapper">
                <div class="description">
                    <p>검색 리스트</p>
                    <c:forEach var="searchMovie" items="${searchMovieList }">
                    	<div class="description_list">
	                        <div class="left_side">
	                            <a class="image" href="content.do?movie_id=${searchMovie.movie_id }">
	                                <img src="${searchMovie.poster_path }">
	                            </a>
	                        </div>
	                        <div class="right_side">
	                            <div class="title_year">
	                                <div class="description_title">${searchMovie.title }</div>
	                                <div class="description_year">${searchMovie.release_year }&nbsp;<span class="middle_dot">·</span>&nbsp;${searchMovie.original_language }</div>
	                            </div>
	                            <div class="plot">
	                                ${searchMovie.overview }
	                            </div>
	                        </div>
	                    </div>
                    </c:forEach>
                </div>
            </section>
        </div>
    </div>
	<jsp:include page="footer.jsp"/>
    <script src="static/js/header.js"></script>
    <script src="static/js/modal.js"></script>
    <script src="static/js/modal_inval.js"></script>
</body>
</html>