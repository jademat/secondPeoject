package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hhlb.controller.Action;
import com.hhlb.controller.ActionForward;
import com.hhlb.model.CategoryDAO;
import com.hhlb.model.CategoryDTO;

public class CategoryListAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        
    	
    	CategoryDAO dao = CategoryDAO.getInstance();
        
        List<CategoryDTO> categoryList = dao.getCategoryList();
     
        System.out.println("Category List Size: " + categoryList.size());

        request.setAttribute("categoryList", categoryList);
        
        ActionForward forward = new ActionForward();
        forward.setRedirect(false); 
        forward.setPath("/admin/category_list.jsp");
        
        return forward;
    }
}
