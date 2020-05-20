<%@page import="team2.board.action.cSet"%>
<%@page import="team2.board.db.BoardDTO"%>
<%@page import="team2.board.action.PageMaker"%>
<%@page import="team2.board.action.Criteria"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/imgList.css" rel="stylesheet">
 <script type="text/javascript">

function doAction(){
	
	alert("doAction");
	
	document.fr.submit();
	
};
</script>	
</head>
<body>
	 <jsp:include page="/include/header.jsp" />
	
	<%
		ArrayList boardList = (ArrayList)request.getAttribute("boardList");
		Criteria cri = (Criteria)request.getAttribute("cri");
		PageMaker pageMaker = (PageMaker)request.getAttribute("pageMaker");
	
		//페이지번호 & 카테고리번호
		String pageNum = (String)request.getAttribute("pageNum");
		String category = (String)request.getAttribute("category");
		String search = (String)request.getAttribute("search");
		
		System.out.println("pageMaker : " +pageMaker+"/pageNum : "+pageNum);
		
	%>
<div class="board">
		 
		 <div class="top">
		 	<div class="boardname">
			 <h2>
				상품 후기
			 </h2>
			</div>
	
		<!-- 게시판 검색 -->		 
		<form name="fr" id="fr" action="./BoardList.bo" method="POST">	
			<input type="hidden" value="1" name="category">
		
			<input type="text" name="search" />
			
			<input type="button" onclick="doAction()" value="검색" />	
		</form>
		<!-- 게시판 검색 -->		
		</div>


	<div class="wrap">	
		<ul class="ul_list">
		  <%
		    for(int i=0;i<boardList.size();i++){ 
	             BoardDTO bdto = (BoardDTO) boardList.get(i);
	             
	             String image = bdto.getB_file();
	             
	             if(image == null){
	            	 image = "no.jpg";
	             }
	             
	        	 String array[] = image.split(",");
	        	 
	             String conPath = request.getContextPath()+"/upload/board";
	
	             String imgPath = conPath+"\\"+array[0];
	             
	       
		  %>

		    <li class="li_list">
		   		<ul>
		   			<li class="imgli">
			   		<a href="./BoardContent.bo?num=<%=bdto.getB_idx()%>&pageNum=<%=cri.getPage()%>">
			    		<span class="thumb">
					    	<img src="<%=imgPath %>" width=220 height=180>
				    	</span>
				    </a>
				    </li>
				    <li class="desc">
				    	<h4 class="subject">
				    	<a href="./BoardContent.bo?num=<%=bdto.getB_idx()%>&pageNum=<%=cri.getPage()%>">
				    	<%=bdto.getB_title() %></a></h4>
				    	
				    	<div class="info">
				     	<span class="writer">작성자 <%=bdto.getB_writer() %></span>   
				       	<span class="view">조회 <%=bdto.getB_view() %></span>
				       	</div>
				    </li>
			    </ul>
		    </li>
	  <% } %>
	
		</ul>
	</div>
	
	<div class="bottom">
		<div class="button">
		<input type="button" value="글 쓰기" onclick="window.open('${pageContext.request.contextPath}/board/searchItem.jsp?C=1','_blank','width=600,height=700',false);">
		</div>
	<ul class="paging">
		<c:if test="${pageMaker.prev }">
		<li>
			<a href='<c:url value="./BoardList.bo?category=${c }&pageNum=${pageMaker.startPage-1 }&search=${search}"/>'><i class="fa left">◀</i></a>	
		</li>
		</c:if>
		<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum" >
		<li>
			<a href='<c:url value="./BoardList.bo?category=${c}&pageNum=${pageNum}&search=${search}"/>'><i class="fa">${pageNum }</i></a>
		</li>
		</c:forEach>
		<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
		<li>
			<a href='<c:url value="./BoardList.bo?category=${c }&pageNum=${pageMaker.endPage+1 }&search=${search}"/>'><i class="fa right">▶</i></a>
		</li>
		</c:if>
	</ul>
	</div> 
</div>
	
	<jsp:include page="/include/footer.jsp"/>	
</body>
</html>