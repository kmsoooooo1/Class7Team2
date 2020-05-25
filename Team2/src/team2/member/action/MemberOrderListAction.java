package team2.member.action;

import java.util.ArrayList;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

		
		//request 영역에 저장
		request.setAttribute("orderList", orderList);
		request.setAttribute("productInfoList", productInfoList);
//		request.setAttribute("check", check);
		request.setAttribute("sdata", sdata);
		
		System.out.println("sdata =======" + sdata);
		
		forward.setPath("./member/memberPage.jsp");
		forward.setRedirect(false); //forwarding 해야한다.
		return forward;

	}

}
