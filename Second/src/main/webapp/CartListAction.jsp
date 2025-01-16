	// 세션에서 로그인 중인 회원의 id 받기
		String user_id = (String)session.getAttribute("user_id");
		
        // 로그인되지 않았으면 로그인 페이지로 리디렉션
        if (user_id == null ) {
            ActionForward forward = new ActionForward();
            forward.setPath("user_login.go");
            forward.setRedirect(true);  // 리디렉션 처리
            return forward;
        } 
        
		CartDAO dao = CartDAO.getInstance();

		List<CartDTO> cartList = dao.getCartList(user_id);