<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>nickname</title>
	<link rel="styleSheet" href="static/css/styles/common.css">
    <link rel="styleSheet" href="static/css/header.css">
    <link rel="styleSheet" href="static/css/footer.css">
    <link rel="styleSheet" href="static/css/index.css">
    <link rel="styleSheet" href="static/css/myPage.css">
</head>
<body>
	<jsp:include page="header.jsp" />
	<div class="root">
        <div class="circle"></div>
        <div class="wrap">
            <div class="wrap_inner">
                <section class="main">
                    <div class="top">
                        <div>
                            <div class="my_profile_img">
                                <img src="static/images/profile/${user.profile_img }">
                            </div>
                            <div class="profile">
                                <div class="myNickname">${user.nickname }</div>
                                <div class="email">${user.email }</div>
                                <div class="info_comment">${user.profile_msg }</div>
                            </div>
                        </div>
                        <button id="btn">프로필 수정</button>
                    </div>
                    <div class="middle">
                        <div class="rate_cnt">
                        	<a href="myRating.do?nickname=${user.nickname }&sortType=ratingDesc">
	                            <div class="count">${userData.rating_count }</div>
	                            <div class="cnt_tag">평가</div>
                            </a>
                        </div>
                        <div class="review_cnt">
                       		<a href="myComment.do?nickname=${user.nickname }&sortType=write_time">
	                            <div class="count">${userData.comment_count }</div>
	                            <div class="cnt_tag">코멘트</div>
                            </a>
                        </div>
                        <div class="rate_avg">
                            <div class="count"><fmt:formatNumber value="${avgRating}" pattern="#,##0.0" /></div>
                            <div class="cnt_tag">평균 별점</div>
                        </div>
                    </div>
                </section>
                <div class="calendar_wrap">
                    <div class="calendar_title">캘린더</div>
                    <div class="calendarHeader">
                        <div class="month_wrap">
                            <div class="month_btns">
                                <button class="go-prev" onclick="prevMonth()">&lt;</button>
                                <div class="curDate">
                                    <div class="curYear"></div>
                                    <div class="curMonth"></div>
                                </div>
                                <button class="go-next" onclick="nextMonth()">&gt;</button>
                            </div>
                        </div>
                        <button type="button" class="today" onclick="goToday()">오늘</button>
                    </div>
                    <div class="calendarBody">
                        <ul id="monthList">
                            <li>Jan</li>
                            <li>Feb</li>
                            <li>Mar</li>
                            <li>Apr</li>
                            <li>May</li>
                            <li>Jun</li>
                            <li>Jul</li>
                            <li>Aug</li>
                            <li>Sep</li>
                            <li>Oct</li>
                            <li>Nov</li>
                            <li>Dec</li>
                        </ul>
                        <div id="calendar"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<jsp:include page="footer.jsp"/>
    <script src="static/js/header.js"></script>
    <script src="static/js/modal.js"></script>
    <script src="static/js/myPage.js"></script>
</body>
</html>