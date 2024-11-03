package com.config;

import java.util.Objects;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.moviehub.sys.login.entity.LoginSession;

@Slf4j
public class HttpLogInterceptor implements HandlerInterceptor {

    @Value(value = "${movie.login.url}")
    private String loginUrl;
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        String requestUrl = request.getRequestURL().toString();
		String queryString = request.getQueryString();

		// 로그인 세션 체크
		HttpSession session = request.getSession();
		LoginSession mbrDetail = (LoginSession) session.getAttribute("loginSession");
		if (mbrDetail == null) {
			boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
			if ( ajax ) {
				response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
			} else {
				response.sendRedirect(loginUrl);
			}
			return false;
		}

		// 로깅
		if (Objects.equals(request.getMethod(), "POST")) {
			log.info("############################################");
			log.info("요청 URL: " + requestUrl);
			log.info("############################################");
		} else {
			log.info("############################################");
			log.info("요청 URL: " + requestUrl);
			log.info("요청 정보: " + queryString);
			log.info("############################################");
		}
	    return true;
	}
	
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
    	
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
    	
    }
}
