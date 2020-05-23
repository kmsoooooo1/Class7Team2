package team2.admin.animal.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.animal.db.AnimalDAO;
import team2.animal.db.AnimalDTO;
import team2.board.action.Criteria;
import team2.board.action.PageMaker;

public class AnimalListAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		AnimalDAO adao = new AnimalDAO();
		
		String category = request.getParameter("category");
		String sub_category = "";
		String sub_category_index = "";
		
		//total 게시판 글 수
		int total = 0;
		
		//  ----페이징 처리-----
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null){
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
	
		int pageSize = 8;
		
		Criteria cri = new Criteria();
		
		cri.setPage(currentPage);
		cri.setPerpageNum(pageSize);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(total);
		
		List<AnimalDTO> admin_animalList = adao.getAnimalList(category, sub_category, sub_category_index, cri);
		
		request.setAttribute("admin_animalList", admin_animalList); 
		
		ActionForward forward = new ActionForward();
		forward.setPath("./admin/admin_animal_list.jsp");
		forward.setRedirect(false);
		return forward;
	}
	
}
