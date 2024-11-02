<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MovieHub</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="styleSheet" href="static/css/styles/common.css">
    <link rel="styleSheet" href="static/css/header.css">
    <link rel="styleSheet" href="static/css/footer.css">
    <link rel="styleSheet" href="static/css/index.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>
    <jsp:include page="header.jsp" />
    <div class="root">
        <div class="wrap">
            <section>
                <div class="search_outer">
                    <div class="search_inner">
                        <div class="search_contents">
                            <input type="text" id="searchKeyword" placeholder="원하는 영화를 검색해보세요">
                            <button type="button" id="search_btn">Search</button>
                        </div>
                        <div class="search_wrap">
                            <ul class="search_ul search_hide">
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="gradient">
                    <div id="title_img">
                        <img alt="image" src="static/images/hugo.jpg">
                    </div>
                </div>
            </section>
            <div class="box">
                <div class="items">
                    <div class="item_title">박스오피스(Now Playing)</div>
                    <ul class="contents">
                        <div class="lists">
                        	<c:forEach var="movie" items="${boxofficeList }" varStatus="loop">
                        		<li class="content">
	                                <a class="image" href="content.do?movie_id=${movie.movie_id }">
	                                	<div class="movieRating">${loop.index + 1 }</div>
	                                    <div class="poster">
	                                        <img src="${movie.poster_path }" alt="poster">
	                                    </div>
	                                </a>
	                                <div class="movieInfo">
	                                    <div class="title">${movie.title }</div>
	                                    <div class="year">
	                                        ${movie.release_year }&nbsp;<span class="middle_dot">·</span>&nbsp;
	                                        <span class="production_countries">${movie.production_countries }</span>
	                                    </div>
	                                    <div class="vote_average">${movie.vote_count }명&nbsp;<span>★</span>${movie.vote_average }</div>
	                                </div>
	                            </li>
                        	</c:forEach>
                        </div>
                        <div class="boxofficeBtns buttons">
                            <div class="leftBtns">
                                <i class="bi bi-arrow-left-circle-fill"></i>
                            </div>
                            <div class="rightBtns">
                                <i class="bi bi-arrow-right-circle-fill"></i>
                            </div>
                        </div>
                    </ul>
                </div>
                <div class="items">
                    <div class="item_title">Netflix top10</div>
                    <ul class="contents">
                        <div class="lists">
                            <c:forEach var="movie" items="${netflixList }" varStatus="loop">
                        		<li class="content">
	                                <a class="image" href="content.do?movie_id=${movie.movie_id }">
	                                	<div class="movieRating">${loop.index + 1 }</div>
	                                    <div class="poster">
	                                        <img src="${movie.poster_path }" alt="poster">
	                                    </div>
	                                </a>
	                                <div class="movieInfo">
	                                    <div class="title">${movie.title }</div>
	                                    <div class="year">
	                                        ${movie.release_year }&nbsp;<span class="middle_dot">·</span>&nbsp;
	                                        <span class="production_countries">${movie.production_countries }</span>
	                                    </div>
	                                    <div class="vote_average">${movie.vote_count }명&nbsp;<span>★</span>${movie.vote_average }</div>
	                                </div>
	                            </li>
                        	</c:forEach>
                        </div>
                    </ul>
                    <div class="netflixBtns buttons">
                        <div class="leftBtns">
                            <i class="bi bi-arrow-left-circle-fill"></i>
                        </div>
                        <div class="rightBtns">
                            <i class="bi bi-arrow-right-circle-fill"></i>
                        </div>
                    </div>
                </div>
                <div class="items">
                    <div class="item_title">Watcha top10</div>
                    <ul class="contents">
                        <div class="lists">
                            <c:forEach var="movie" items="${watchaList }" varStatus="loop">
                        		<li class="content">
	                                <a class="image" href="content.do?movie_id=${movie.movie_id }">
	                                	<div class="movieRating">${loop.index + 1 }</div>
	                                    <div class="poster">
	                                        <img src="${movie.poster_path }" alt="poster">
	                                    </div>
	                                </a>
	                                <div class="movieInfo">
	                                    <div class="title">${movie.title }</div>
	                                    <div class="year">
	                                        ${movie.release_year }&nbsp;<span class="middle_dot">·</span>&nbsp;
	                                        <span class="production_countries">${movie.production_countries }</span>
	                                    </div>
	                                    <div class="vote_average">${movie.vote_count }명&nbsp;<span>★</span>${movie.vote_average }</div>
	                                </div>
	                            </li>
                        	</c:forEach>
                        </div>
                    </ul>
                    <div class="watchaBtns buttons">
                        <div class="leftBtns">
                            <i class="bi bi-arrow-left-circle-fill"></i>
                        </div>
                        <div class="rightBtns">
                            <i class="bi bi-arrow-right-circle-fill"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp"/>
    <script src="static/js/header.js"></script>
    <script src="static/js/modal.js"></script>
    <script src="static/js/modal_inval.js"></script>
    <script src="static/js/index.js"></script>
    <script src="static/js/indexSearch.js"></script>
</body>

</html>