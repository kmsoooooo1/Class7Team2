package team2.admin.animal.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.animal.db.AnimalDAO;
import team2.animal.db.AnimalDTO;

public class AnimalNewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		AnimalDAO adao = new AnimalDAO();
		
		String category = request.getParameter("category");
		String sub_category = "";
		String sub_category_index = "";
		
		List<AnimalDTO> admin_animalList = adao.ImageNew();
		
		System.out.println("admin_animalList_size "+ admin_animalList.size());
		
		request.setAttribute("admin_animalList", admin_animalList); 
		
		ActionForward forward = new ActionForward();
		forward.setPath("./board/main_page.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
