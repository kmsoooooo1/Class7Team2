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
 
</head>
<body>

	 <jsp:include page="/include/header.jsp" />
	

	<h1>WebContent/board/board_review.jsp</h1>
	
	<%
		ArrayList boardList = (ArrayList)request.getAttribute("boardList");
		
		//페이징 필요 값
		Criteria cri = (Criteria)request.getAttribute("cri");
		PageMaker pageMaker = (PageMaker)request.getAttribute("pageMaker");
		String pageNum = (String)request.getAttribute("pageNum");
	
		//카테고리별 필요 값
		String category = request.getParameter("category");
		String sub_category = request.getParameter("sub_category");
		
	%>
	
		 <h2><a href="./Insert.bo"> 글 쓰기  </a></h2>
		 <h2><a href="./BoardMain.bo"> 메인  </a></h2>

<div class="board">
	<div class="wrap">
	<div class="img-col">	
		<ul>
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

		    <li>
		   		<a href="./BoardContent.bo?num=<%=bdto.getB_idx()%>&pageNum=<%=cri.getPage()%>">
		    		<span class="thumb">
				    	<img src="<%=imgPath %>" width=180 height=150>
					  	<br><em><%=bdto.getB_title() %></em>
			    	</span>
			    </a>
			    <p>
			        작성자 <%=bdto.getB_writer() %>   
			    <br>
				
			        조회수 <%=bdto.getB_view() %>
			    </p>
		    </li>
	  <% } %>
	
		</ul>
	</div>
	</div>
	
	<div class="paging-div">
	<ul class="paging">
		<li>
			<a href='<c:url value="./BoardList.bo?category=${c }&pageNum=${pageMaker.startPage-1 }"/>'><i class="fa left">◀</i></a>	
		</li>
		<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum" >
		<li>
			<a href='<c:url value="./BoardList.bo?category=${c}&pageNum=${pageNum}"/>'><i class="fa">${pageNum }</i></a>
		</li>
		</c:forEach>
		<li>
			<a href='<c:url value="./BoardList.bo?category=${c }&pageNum=${pageMaker.endPage+1 }"/>'><i class="fa right">▶</i></a>
		</li>


	</ul>
	</div>

</div>
</body>
</html>