<%@page import="team2.board.action.Criteria"%>
<%@page import="team2.board.action.PageMaker"%>
<%@page import="team2.animal.db.AnimalDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${pageContext.request.contextPath}/css/memberList.css" rel="stylesheet">
<title>관리자 동물리스트 관리 페이지</title>
</head>
<body>

	<%
		//AnimalListAction 객체에서 저장된 정보를 저장 
		List<AnimalDTO> admin_animalList = (List<AnimalDTO>) request.getAttribute("admin_animalList");
	
	
		PageMaker pageMaker = (PageMaker)request.getAttribute("pageMaker");
		Criteria cri = (Criteria)request.getAttribute("cri");
		int pageNum = (int)request.getAttribute("pageNum");
		
		System.out.println("pm: " + pageMaker);
		System.out.println("cri :" + cri);
		
	%>
	
	<!-- Header -->
	<jsp:include page="/include/header.jsp" />
	
	<!-- Main Content -->
 <div class="board">
 	
  <div class="top">
   <div class="boardname">
    <h2>
    	전체 동물 리스트
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
	  <col width="5%" />	
	  <col width="4%" />	
	  <col width="6%" />	
	  <col width="4%" />	
	  <col width="5%" />	
	  <col width="5%" />	
	  <col width="5%" />	
	  <col width="4%" />	
	  <col width="5%" />
	  <col width="4%" />
	  <col width="4%" />
	 </colgroup>
	 <thead>
	  <tr>
			<th>NO.</th>
			<th> 썸네일 </th>
			<th> 카테고리 </th>
			<th> 서브 카테고리 </th>
			<th> 서-서브 카테고리 </th>
			<th> 모프(종 이름) </th>
			<th> 성별 </th>
			<th> 상태 </th>
			<th> 코드</th>
			<th> 수량 </th>
			<th> 판매가 </th>
			<th> 할인율(%) </th>
			<th> 할인판매가 </th>
			<th> 적립금 </th>
			<th> 조회수 </th>
			<th> 등록일자 </th>
			<th> 수정하기 </th>
			<th> 삭제하기 </th>
	  </tr>
	 </thead>
		<%
			for(int i=0; i<admin_animalList.size(); i++){
				AnimalDTO adto = admin_animalList.get(i);
		%>
	 	<tbody>
			<tr>
				<td><%=adto.getNum()%></td>
				<td><img src="./upload/multiupload/<%=adto.getA_thumbnail()%>" width="50" height="50"></td>
				<td><%=adto.getCategory()%></td>
				<td><%=adto.getSub_category()%></td>
				<td><%=adto.getSub_category_index()%></td>
				<td><%=adto.getA_morph()%></td>
				<td><%=adto.getA_sex()%></td>
				<td><%=adto.getA_status()%></td>
				<td><%=adto.getA_code()%></td>
				<td><%=adto.getA_amount()%></td>
				<td><%=adto.getA_price_origin()%></td>
				<td><%=adto.getA_discount_rate()%></td>
				<td><%=adto.getA_price_sale()%></td>
				<td><%=adto.getA_mileage()%></td>
				<td><%=adto.getA_view_count()%></td>
				<td><%=adto.getDate()%></td>
				<td> <a href="./AnimalModify.aa?num=<%=adto.getNum()%>"><button type="button"> 수정 </button></a> </td>
				<td> <a href="./AnimalDeleteAction.aa?num=<%=adto.getNum()%>"><button type="button"> 삭제 </button></a> </td>
			</tr>
		</tbody>
		<%}%>
	</table>
	</div>
  </div>
  
  <div class="bottom">
		<ul id="pageList">
			<%if(pageMaker.isPrev()){ %>
				<li onclick="location.href='./AnimalList.aa?&pageNum=<%=pageMaker.getStartPage()-1%>'">
					◀	
				</li>
			<%}
			for(int i = pageMaker.getStartPage(); i<=pageMaker.getEndPage(); i++){
			%>
				<li onclick="location.href='./AnimalList.aa?pageNum=<%=i%>'">
					<%=i %>
				</li>
			<%}
			if(pageMaker.isNext() && pageMaker.getEndPage() > 0){ %>
				<li onclick="location.href='./AnimalList.aa?&pageNum=<%=pageMaker.getEndPage()+1%>'">
					▶
				</li>
			<%} %>
		</ul>
	</div>
 </div>
	<!-- FOOTER -->
	<jsp:include page="/include/footer.jsp"/>
	
</body>
</html>