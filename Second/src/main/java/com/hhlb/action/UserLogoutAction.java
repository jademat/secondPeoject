package com.hhlb.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;

public class UserLogoutAction implements Action {

@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		HttpSession session = request.getSession(false);
        
        // 세션이 있으면 무효화
        if (session != null) {
        	
  
            // 로그아웃 시 세션에서 user_id 삭제

            session.invalidate();
            
        }
        
        // 로그아웃 후 홈 페이지로 리디렉션
        response.sendRedirect( "user_main.go");
        
        return null;
    }

}