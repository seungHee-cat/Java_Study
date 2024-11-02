<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body>
    <div class="header">
        <div class="header_container">
            <div class="header_inner">
                <div class="header_left">
                    <div class="header_icon"><a href="index.do">MovieHub</a></div>
                </div>
                <div class="header_right">
                	<c:if test="${user == null}" >
	                	<button id="login" onclick="loginFunc()" >로그인</button>
	                	<button id="register" onclick="registerFunc()">회원가입</button>
	                </c:if>
                	<c:if test="${user != null}">
	                    <div class="profile_img">
	                        <img src="static/images/profile/${user.profile_img }">
	                    </div>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="profile_menu profile_hide">
            <div class="menu_top">
                <div class="userNickname">${user.nickname }</div>
                <div class="profile_link"><a href="myProfile.do">프로필 보기</a></div>
            </div>
            <div class="menu_bottom">
                <div class="settings"><i class="bi bi-gear-wide-connected"></i><span>설정</span></div>
                <div class="help"><i class="bi bi-info-circle"></i><span>고객센터</span></div>
                <div class="logout">
                    <a href="logout.do">
                        <i class="bi bi-box-arrow-right"></i><span>로그아웃</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="loginModal login_black-bg login_hide">
        <div class="login_white-bg">
            <div class="logo">MovieHub</div>
            <div>로그인</div>
            <form action="login.do" name="loginForm" method="post">
                <div>
                    <input type="text" name="user_id" id="loginId" placeholder="아이디" maxlength="15" required>
                </div>
                <div>
                    <input type="password" name="password" id="loginPw" placeholder="비밀번호" maxlength="40" required>
                </div>
                <div>
                    계정이 없으신가요?&nbsp;<span id="register_btn">회원가입</span>
                </div>
                <input type="button" class="btn" id="login_close" value="로그인">
            </form>
        </div>
    </div>
    <div class="registerModal register_black-bg register_hide">
        <div class="register_white-bg">
            <div class="logo">MovieHub</div>
            <div>회원가입</div>
            <form id="registerForm" action="register.do" method="post">
                <div>
                    <input type="text" name="user_id" id="regId" placeholder="아이디" required>
                    <div id="idCheck"></div>
                </div>
                <div>
                    <input type="password" name="password" id="regPw" placeholder="비밀번호" required>
                    <div id="pwCheck"></div>
                </div>
                <div>
                    <input type="email" name="email" id="regEmail" placeholder="이메일" required>
                    <div id="emailCheck"></div>
                </div>
                <div>
                    이미 계정이 있으신가요?&nbsp;<span id="login_btn">로그인</span>
                </div>
                <input type="button" class="btn" id="register_close" value="회원가입">
            </form>
        </div>
    </div>
    <div class="settingModal setting_black-bg setting_hide">
        <div class="setting_white-bg">
            <div class="setting_menu">
                <div>프로필 편집</div>
                <div class="menu_list">
                    <div class="information">프로필 정보</div>
                    <div class="pw_confirm">비밀번호 변경</div>
                    <div class="delete_info">회원탈퇴</div>
                </div>
            </div>
            <div class="setting_contents">
                <div class="setting_info">
                    <form action="modifyUser.do" method="post" enctype="multipart/form-data">
                    	<div class="info_top">
                    		<div>정보 변경</div>
                    		<div id="setting_close">X</div>
                    	</div>
	                    <div class="info_middle">
	                        <div class="profile_img info_img">
	                        	<c:if test="${user != null }">
	                        		<img src="static/images/profile/${user.profile_img }">
	                        	</c:if>
	                        </div>
	                        <div class="info_btns">
	                            <input type="file" name="file" class="form-control info_btn" accept=".jpg, .gif, .png">
	                            <div class="pic_desc">
	                                JPG, GIF or PNG 최대 사이즈 500K
	                            </div>
	                        </div>
	                    </div>
	                    <div class="info_bottom">
	                        <div class="info_id_nickname">
	                        	<div>
	                        		<div class="user_id">아이디</div>
	                            	<input type="text" name="user_id" value="${user.user_id }" readonly required>
	                        	</div>
	                            <div>
	                        		<div class="user_nickname">닉네임</div>
	                            	<input type="text" name="nickname" maxlength="15" value="${user.nickname }" required>
	                        	</div>
	                        </div>
	                        <div class="info_email">
	                            <div class="email">이메일 주소</div>
	                            <input type="email" name="email" maxlength="45" value="${user.email }" required>
	                            <div class="emailCheck"></div>
	                        </div>
	                        <div class="info_intro">
	                            <div class="introduce">자기소개</div>
	                            <textarea name="profile_msg" maxlength="300" placeholder="&nbsp;소개를 적어보세요.">${user.profile_msg }</textarea>
	                        </div>
	                    </div>
	                    <div class="info_save">
	                        <input type="submit" class="btn btn-primary" value="저장"></input>
	                    </div>
                    </form>
                </div>
                <div class="password_info hide">
                    <form action="changePw.do" method="post">
                    	<div>
	                        <div>현재 비밀번호</div>
	                        <div class="password_wrapper">
	                            <input type="password" name="password" class="password" required>
	                            <span class="pw_btn">보기</span>
	                        </div>
	                    </div>
	                    <div>
	                        <div>새 비밀번호</div>
	                        <div class="password_wrapper">
	                            <input type="password" name="checkedPw" class="password" required>
	                            <span class="pw_btn">보기</span>
	                        </div>
	                    </div>
	                    <div class="password_save">
	                        <input type="submit" class="btn btn-primary" value="저장">
	                    </div>
                    </form>
                </div>
                <div class="withdrawl_info hide">
                    <div>회원 탈퇴를 진행하시겠습니까?</div>
                    <div>
                        <p>만약 서비스 이용 중 어려움이나 문제가 발생하면, 언제든<br>고객센터로 문의해주세요. <a href="#">고객센터</a></p>
                    </div>
                    <p>
                    <p>회원 탈퇴를 하게 되면</p>
                    <ul>
                        <li>✅ 지금까지 평가한 별점이 사라집니다.</li>
                        <li>✅ 좋아요와 댓글이 모두 지워집니다.</li>
                        <li><strong>✅ 회원 탈퇴는 영구적으로, 되돌릴 수 없습니다.</strong></li>
                    </ul>
                    <form action="widthrawl.do" method="post">
                    	<input type="submit" class="btn btn-primary" value="회원 탈퇴">
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
</body>

</html>