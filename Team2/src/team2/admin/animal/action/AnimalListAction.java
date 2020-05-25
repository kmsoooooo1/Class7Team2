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
		
		String category = "all";
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
	
		int pageSize = 15;
		
		Criteria cri = new Criteria();
		
		cri.setPage(currentPage);
		cri.setPerpageNum(pageSize);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		
		
		List<AnimalDTO> admin_animalList = adao.getAnimalList(category, sub_category, sub_category_index, cri);

		System.out.println("total : "+total);
		total = adao.animalTotalCount(category, "all", "all");

		pageMaker.setTotalCount(total);
		System.out.println("total : "+total);
		
		System.out.println(cri);
		System.out.println(pageMaker);
		
		request.setAttribute("admin_animalList", admin_animalList);
		request.setAttribute("cri", cri);
		request.setAttribute("pageMaker", pageMaker);
		request.setAttribute("pageNum", currentPage);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./admin/admin_animal_list.jsp");
		forward.setRedirect(false);
		return forward;
	}
	
}
