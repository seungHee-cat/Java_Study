package com.moviehub.sys.login.entity;

import lombok.Data;

@Data
public class LoginSession {
    // 사용자 (USER)
    private String user_id      = null; // 사용자ID
    private String nickname     = null; // 사용자 닉네임
    private String password     = null; // 사용자 비밀번호
    private String email        = null; // 사용자 이메일
    private String auth         = null; // 사용자 권한
}
