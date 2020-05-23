<%@page import="team2.board.action.PageMaker"%>
<%@page import="team2.board.action.Criteria"%>
<%@page import="team2.goods.db.GoodsDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${pageContext.request.contextPath}/css/memberList.css" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>

	
	<%
		//GoodsListAction 객체에서 저장된 정보 저장
		List<GoodsDTO> goodsList = (List<GoodsDTO>) request.getAttribute("goodsList");
	
		//paging 사용 객체
// 		Criteria cri = (Criteria)request.getAttribute("cri");
// 		PageMaker pageMaker = (PageMaker)request.getAttribute("pageMaker");
// 		String pageNum = (String)request.getAttribute("pageNum");
		
// 		System.out.println("pageMaker : " +pageMaker+"/pageNum : "+pageNum);
	
	
	%>
	
	<!-- Header -->
	<jsp:include page="/include/header.jsp" />
	
	<!-- Main Content -->
 <div class="board">
	
  <div class="top">
   <div class="boardname">
    <h2>
     	전체 상품 리스트
    </h2>
   </div>
   <div class="list-div">
	<table class="list">
	 <colgroup> 
	  <col width="2%" />	
	  <col width="4%" />	
	  <col width="5%" />	
	  <col width="7%" />	
	  <col width="8%" />	
	  <col width="7%" />	
	  <col width="5%" />	
	  <col width="3%" />	
	  <col width="4%" />	
	  <col width="4%" />	
	  <col width="6%" />	
	  <col width="4%" />	
	  <col width="5%" />	
	  <col width="3%" />	
	  <col width="5%" />	
	  <col width="4%" />	
	  <col width="5%" />
	  <col width="4%" />
	  <col width="4%" />
	 </colgroup>
	 <thead>
	  <tr> 	
		   <th>No.</th>
		   <th>썸네일</th>
		   <th>카테고리</th>
		   <th>서브 카테고리</th>
		   <th>서-서브 카테고리</th>
		   <th>상품 이름</th>
		   <th>상품 코드</th>
		   <th>수량</th>
		   <th>판매가</th>
		   <th>할인율(%)</th>
		   <th>할인 판매가</th>
		   <th>적립금</th>
		   <th>배송 방법</th>
		   <th>옵션</th>
		   <th>추가 가격</th>
		   <th>조회수</th>
		   <th>등록일자</th>
		   <th>수정하기</th>
		   <th>삭제하기</th>
	  </tr>
	 </thead>
	
		<%
			for(int i=0; i<goodsList.size(); i++){
				GoodsDTO gdto = goodsList.get(i);
		%>
	   <tbody>
		<tr>
		   <td><%=gdto.getNum() %></td>
		   <td><img src="./upload/multiupload/<%=gdto.getG_thumbnail()%>" width="50" height="50"></td>
		   <td><%=gdto.getCategory() %></td>
		   <td><%=gdto.getSub_category() %></td>
		   <td><%=gdto.getSub_category_index() %></td>
		   <td><%=gdto.getG_name() %></td>
		   <td><%=gdto.getG_code() %></td>
		   <td><%=gdto.getG_amount() %></td>
		   <td><%=gdto.getG_price_origin() %></td>
		   <td><%=gdto.getG_discount_rate()%></td>
		   <td><%=gdto.getG_price_sale() %></td>
		   <td><%=gdto.getG_mileage() %></td>
		   <td><%=gdto.getG_delivery() %></td>
		   <td><%=gdto.getG_option() %></td>
		   <td><%=gdto.getG_option_price() %></td>
		   <td><%=gdto.getG_view_count() %></td>
		   <td><%=gdto.getDate() %></td>
		   <td><a href="./GoodsModify.ag?num=<%=gdto.getNum()%>"><button type="button"> 수정 </button></a></td>
		   <td><a href="./GoodsDeleteAction.ag?num=<%=gdto.getNum()%>"><button type="button"> 삭제 </button></a></td>
		</tr>
	   </tbody>
		<%} %>
		
	</table>
	</div>	
	<a href="./GoodsAdd.ag"><button>상품 추가하기</button></a>
  </div>
 </div>
 
 
  <!-- FOOTER -->
  <jsp:include page="/include/footer.jsp"/>
</body>
</html>