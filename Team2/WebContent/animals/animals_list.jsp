<%@page import="team2.board.action.PageMaker"%>
<%@page import="team2.board.action.Criteria"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="team2.animal.db.AnimalDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/product_list.css"
	rel="stylesheet">
</head>
<body>

	<%
		String category = request.getParameter("category");
		String sub_category = request.getParameter("sub_category");
		String sub_category_index = request.getParameter("sub_category_index");
		if (sub_category_index == null) {
			sub_category_index = "all";
		}

		//AnimalListAction 객체에서 저장된 정보를 저장 
		List<AnimalDTO> animalList = (List<AnimalDTO>) request.getAttribute("animalList");

		//paging 사용 객체
		Criteria cri = (Criteria) request.getAttribute("cri");
		PageMaker pageMaker = (PageMaker) request.getAttribute("pageMaker");
		String pageNum = (String) request.getAttribute("pageNum");

		System.out.println("pageMaker : " + pageMaker + "/pageNum : " + pageNum);
	%>

	<!-- Header -->
	<jsp:include page="/include/header.jsp" />

	<!-- Main Content -->
	<div class="container">
		<%
			if (category.equals("파충류") && sub_category.equals("도마뱀")) {
		%>
		<div class="menu">
			<input type="button" value="전체보기" class="a_btn"
				onclick="location.href='./AnimalList.an?category=파충류&sub_category=도마뱀'"> <input
				type="button" value="리자드/모니터" class="a_btn"
				onclick="location.href='./AnimalList.an?category=파충류&sub_category=도마뱀&sub_category_index=리자드/모니터'">
			<input type="button" value="레오파드/게코" class="a_btn"
				onclick="location.href='./AnimalList.an?category=파충류&sub_category=도마뱀&sub_category_index=레오파드 게코'">
			<input type="button" value="크레스티드 게코" class="a_btn"
				onclick="location.href='./AnimalList.an?category=파충류&sub_category=도마뱀&sub_category_index=크레스티드 게코'">
			<input type="button" value="카멜레온" class="a_btn"
				onclick="location.href='./AnimalList.an?category=파충류&sub_category=도마뱀&sub_category_index=카멜레온'">
		</div>
		<%
			} else if (category.equals("파충류") && sub_category.equals("뱀")) {
		%>
		<div class="menu">
			<input type="button" value="전체보기" class="a_btn"
				onclick="location.href='./AnimalList.an?category=파충류&sub_category=뱀'"> <input
				type="button" value="콘/킹/소형뱀" class="a_btn"
				onclick="location.href='./AnimalList.an?category=파충류&sub_category=뱀&sub_category_index=콘/킹/소형뱀'">
			<input type="button" value="대형뱀" class="a_btn"
				onclick="location.href='./AnimalList.an?category=파충류&sub_category=뱀&sub_category_index=대형뱀'">
		</div>
		<%
			} else if (category.equals("파충류") && sub_category.equals("거북")) {
		%>
		<div class="menu">
			<input type="button" value="전체보기" class="a_btn"
				onclick="location.href='./AnimalList.an?category=파충류&sub_category=거북'"> <input
				type="button" value="육지거북" class="a_btn"
				onclick="location.href='./AnimalList.an?category=파충류&sub_category=거북&sub_category_index=육지거북'">
			<input type="button" value="수생/습지 거북" class="a_btn"
				onclick="location.href='./AnimalList.an?category=파충류&sub_category=거북&sub_category_index=수생/습지 거북'">
		</div>
		<%
			}
		%>
		<span class="a_amount"> Total <%=pageMaker.getTotalCount()%> items
		</span>
		<ul class="ul_wrap">

			<%
				if (animalList.size() > 0) {
					for (int i = 0; i < animalList.size(); i++) {
						AnimalDTO adto = animalList.get(i);
						//###,###,###원 표기하기 위해서 format 바꾸기
						DecimalFormat formatter = new DecimalFormat("#,###,###,###");
						String newformat_price_origin = formatter.format(adto.getA_price_origin());
						String newformat_price_sale = formatter.format(adto.getA_price_sale());
			%>
			<li>
				<div class="list_wrap">
					<div class="product_img_wrap">
						<a href='./AnimalDetail.an?a_code=<%=adto.getA_code()%>'><img class="list_img" src="./upload/multiupload/<%=adto.getA_thumbnail()%>"></a> 
					</div>
					<span class="product_name">
						<a href='./AnimalDetail.an?a_code=<%=adto.getA_code()%>'">
							<%=adto.getA_morph()%>/<%=adto.getA_sex()%>/<%=adto.getA_status()%>
						</a>
					</span>
					<span class="origin_price"><%=newformat_price_origin%>원</span>
					<div class="product_option_wrap">
					<%
						if (adto.getA_discount_rate() != 0) { //만약 할인율이 있으면
					%>
						<span class="sale_price"> 할인판매가 : <%=newformat_price_sale%>원 </span> 
					<%	}%>
						<!-- 만약 수량이 0이면 soldout 문구 띄우기 -->
					<%	if (adto.getA_amount() == 0) {	%>
						<span class="sold_out">SOLD OUT</span>
					<%	}%>
					</div>
				</div>
			</li>
			<%
				}
				} else {
			%>
			<li>
				<div class="list_wrap">해당되는 동물이 없습니다.</div>
			</li>
			<%
				}
			%>
		</ul>

		<div class="bottom">
			<ul id="pageList">
			<%if(pageMaker.isPrev()){ %>
				<li onclick="location.href='./AnimalList.an?category=<%=category%>&sub_category=<%=sub_category %>&sub_category_index=<%=sub_category_index %>&pageNum=<%=pageMaker.getStartPage()-1%>'">
					◀	
				</li>
			<%}
			for(int i = pageMaker.getStartPage(); i<=pageMaker.getEndPage(); i++){
			%>
				<li onclick="location.href='./AnimalList.an?category=<%=category%>&sub_category=<%=sub_category %>&sub_category_index=<%=sub_category_index %>&pageNum=<%=i%>'">
					<%=i %>
				</li>
			<%}
			if(pageMaker.isNext() && pageMaker.getEndPage() > 0){ %>
				<li onclick="location.href='./AnimalList.an?category=<%=category%>&sub_category=<%=sub_category %>&sub_category_index=<%=sub_category_index %>&pageNum=<%=pageMaker.getEndPage()+1%>'">
					▶
				</li>
			<%} %>
		</ul>
		</div>

	</div>
	<!-- FOOTER -->
	<jsp:include page="/include/footer.jsp" />

</body>
</html>