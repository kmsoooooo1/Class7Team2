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
<link href="${pageContext.request.contextPath}/css/boardList.css" rel="stylesheet">
<script type="text/javascript">

function doAction(){
	
	alert("doAction");
	
	document.fr.submit();
	
};
</script>	
</head>
<body>
	<jsp:include page="/include/header.jsp" />

	<h1>QnA 게시판</h1>

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
	
		 <h2><a onclick="window.open('${pageContext.request.contextPath}/board/searchItem.jsp?C=2','_blank','width=500,height=400',false);"> 글 쓰기 (스마트에디터)  </a></h2>
		 <h2><a href="./BoardMain.bo"> 메인  </a></h2>
	
	<!-- 게시판 검색 -->		 
		<form name="fr" id="fr" action="./BoardList.bo" method="POST">	
			<input type="hidden" value="2" name="category">

			<input type="text" name="search" />
			
			<input type="button" onclick="doAction()" value="검색" />	
		</form>
		<!-- 게시판 검색 -->		
	
<div class="board">
	<div class="list-div">
	<table class="list">
		<colgroup>
			<col width="10%" />
			<col width="60%" />
			<col width="10%" />
			<col width="12%" />
			<col width="8%" />
		</colgroup>
		<thead>
		  <tr>
		    <th>번호</th>
		    <th>제목</th>
		    <th>작성자</th>
		    <th>작성일</th>
		    <th>조회수</th>
		  </tr>
	  	</thead>
	  <%
	    for(int i=0; i<boardList.size(); i++){ 
             BoardDTO bdto = (BoardDTO) boardList.get(i);
	  %>
		<tbody>
		  <tr>
		    <td><%=bdto.getB_idx() %></td>
		    <td class="title">
		    <a href="./BoardContent.bo?num=<%=bdto.getB_idx()%>&pageNum=<%=cri.getPage()%>">
		    	<%=bdto.getB_title() %>
		    	</a>
		    </td>
		    
		    <td><%=bdto.getB_writer() %></td>
		    <td><%=bdto.getB_reg_date() %></td>
		    <td><%=bdto.getB_view() %></td>
		  </tr>
		 </tbody>
	  <% } %>
	
	</table>
	</div>
	
	<div class="paging-div">
	<ul class="paging">
	<c:if test="${pageMaker.prev }">
		<li>
			<a href='<c:url value="./BoardList.bo?category=${c}&pageNum=${pageMaker.startPage-1 }&search=${search}"/>'><i class="fa left">◀</i></a>	
		</li>
		</c:if>
		<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum" >
		<li>
			<a href='<c:url value="./BoardList.bo?category=${c}&pageNum=${pageNum}&search=${search}"/>'><i class="fa">${pageNum }</i></a>
		</li>
		</c:forEach>
		<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
		<li>
			<a href='<c:url value="./BoardList.bo?category=${c}&pageNum=${pageMaker.endPage+1 }&search=${search}"/>'><i class="fa right">▶</i></a>
		</li>
	</c:if>
	</ul>
	</div>
	
</div>

</body>
</html>