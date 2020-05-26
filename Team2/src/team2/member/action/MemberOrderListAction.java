package team2.member.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.board.action.Criteria;
import team2.board.action.PageMaker;
import team2.board.action.cSet;
import team2.board.db.BoardDAO;
import team2.board.db.BoardDTO;
import team2.member.db.MemberDAO;
import team2.order.db.OrderDTO;
import team2.product.db.ProductDTO;

public class MemberOrderListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		System.out.println(" @@@ MemberOrderListAction_excute()");
		
		// 세션값 처리
		// 로그인 여부, 관리자 여부
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		ActionForward forward = new ActionForward();
		if( id == null ){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			
			return forward;
		}
		
		//--------------주문 상품 정보---------------------
		MemberDAO mdao = new MemberDAO();
		
		Vector vec = mdao.getMemberOrderList(id); 
				
		ArrayList orderList = (ArrayList) vec.get(0);
		ArrayList productInfoList = (ArrayList) vec.get(1);
		
		
		OrderDTO odto = new OrderDTO();
		
		//주문 처리 현황 o_status에 따른 값 배열로 저장
		int[] data = {0,0,0,0};

			ArrayList checkList = (ArrayList) mdao.getStatusMember(id);			
		
			for (int i = 0; i < checkList.size(); i++){
				odto = (OrderDTO) checkList.get(i);
				System.out.println("checkList ===========" + odto.getO_status());
			
				switch (odto.getO_status()) {
				case 0:	data[0] +=1;
					
					break;
				case 1: data[1] +=1;
					
					break;
				case 2: data[2] +=1;
					
					break;
				case 3:	data[3] +=1;
					
					break;

				default:
					break;
				}

			}
			String sdata = "";
			for(int i=0; i<data.length; i++){
				if(i==0){ 
					sdata += data[i];
				}else{
					sdata += ","+data[i];
				}
			}
		//--------------주문 상품 정보---------------------
		
			
		//--------------내 게시글-----------------------
			
		BoardDAO dao = new BoardDAO(); 	
			
		int c = 3;
		int pageSize = 5;
		
		try{
			 c = Integer.parseInt(request.getParameter("category"));
			 pageSize = Integer.parseInt(request.getParameter("pageSize"));
		}catch(Exception e){
			System.out.println(e);
		}	
			
		cSet set = new cSet();
		set.setC(c);	
		
		System.out.println("category : "+c);
		
		System.out.println("cset = "+set);
		
		int total = dao.getWriterCount(id, set);
		
		//  ----페이징 처리-----
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null){
			pageNum = "1";
		}
		
		int currentPage = Integer.parseInt(pageNum);
					
		Criteria cri = new Criteria();
		
		cri.setPage(currentPage);
		cri.setPerpageNum(pageSize);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(total);
		
		System.out.println(pageMaker.getStartPage());
		System.out.println(pageMaker.getEndPage());
		
	// ----페이징 처리-----
		
		List<BoardDTO> myBoardlist = dao.getMyBoard(id,set,cri);
						
		//--------------내 게시글-----------------------
		
		//내 게시글
		request.setAttribute("myBoardlist", myBoardlist);
		request.setAttribute("cri", cri);
		request.setAttribute("pageMaker", pageMaker);
		request.setAttribute("pageNum", pageNum);
		//카테고리별 전송 값
		request.setAttribute("c", set.getC());
		request.setAttribute("category", set.getCategory());
		
			
		//주문상품정보
		request.setAttribute("orderList", orderList);
		request.setAttribute("productInfoList", productInfoList);
		request.setAttribute("sdata", sdata);
		
		dao.closeDB();
		
		forward.setPath("./member/memberPage.jsp");
		forward.setRedirect(false); //forwarding 해야한다.
		return forward;

	}

}
