<%@page import="com.hhlb.model.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String user_id = request.getParameter("userId").trim();

	UserDAO dao = UserDAO.getInstance();
	
	int result = dao.idCheck(user_id);
	
	out.println(result);
%>
