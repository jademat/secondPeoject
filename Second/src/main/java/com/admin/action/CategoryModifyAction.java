package com.admin.action;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.CategoryDAO;
import com.hhlb.model.CategoryDTO;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CategoryModifyAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
       
        
    	CategoryDAO dao = CategoryDAO.getInstance();
    	
     	List<CategoryDTO> list = dao.getCategoryList();
     	
     	request.setAttribute("categoryList", list);
     	
        ActionForward forward = new ActionForward();
        
        forward.setRedirect(false);
        
        forward.setPath("admin/category_modify.jsp");

        return forward;
    }
}
