package team2.admin.animal.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.animal.db.AnimalDAO;

public class AnimalDeleteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		AnimalDAO adao = new AnimalDAO();
		
		adao.deleteAnimals(num);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./AnimalList.aa");
		forward.setRedirect(true);
		return forward;
	}

}
