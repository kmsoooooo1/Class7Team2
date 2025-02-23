<%@page import="team2.board.action.PageMaker"%>
<%@page import="team2.board.action.Criteria"%>
<%@page import="java.util.ArrayList"%>
<%@page import="team2.board.db.BoardDTO"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/myBoard.css">
</head>
<body>
	<!-- Header -->
	<jsp:include page="/include/header.jsp" />
<%
	List<BoardDTO> list = (ArrayList<BoardDTO>)request.getAttribute("list");
	Criteria cri = (Criteria)request.getAttribute("cri");
	PageMaker pageMaker = (PageMaker)request.getAttribute("pageMaker");

	//페이지번호 & 카테고리번호
	String pageNum = (String)request.getAttribute("pageNum");

	
%>
	<!-- content -->
	<div class="container">
		<div class="top">
			
		</div>
		<div class="table_wrap">
			<table class="list">
				<colgroup>
					<col width="5%" />
					<col width="40%" />
					<col width="15%" />
					<col width="20%" />
					<col width="10%" />
				</colgroup>
				<thead>
				  <tr>
				    <th>분류</th>
				    <th>제목</th>
				    <th>글쓴이</th>
				    <th>날짜</th>
				    <th>조회</th>
				  </tr>
			  	</thead>
			  <%
			  if(list.size()>0){
				  for(BoardDTO bdto:list){
			  %>
				<tbody>
				  <tr>
				    <td><%=bdto.getB_category() %></td>
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
			  <%}
			  }else{
				%>
				<tr>
				    <td colspan="5">
				    	등록된 게시글이 없습니다.
				    </td>
				  </tr>
			<%} %>
			</table>
		</div>
		
		<div class="paging-div">
			<ul class="paging">
			<c:if test="${pageMaker.prev }">
				<li>
					<a href='<c:url value="./myBoard.bo?category=${c}&pageNum=${pageMaker.startPage-1 }&search=${search}"/>'><i class="fa left">◀</i></a>	
				</li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum" >
				<li>
					<a href='<c:url value="./myBoard.bo?category=${c}&pageNum=${pageNum}&search=${search}&pageSize=${pageSize }"/>'><i class="fa">${pageNum }</i></a>
				</li>
				</c:forEach>
				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				<li>
					<a href='<c:url value="./myBoard.bo?category=${c}&pageNum=${pageMaker.endPage+1 }&search=${search}"/>'><i class="fa right">▶</i></a>
				</li>
			</c:if>
			</ul>
		</div>
	</div>
	<!-- FOOTER -->
	<jsp:include page="/include/footer.jsp"/>
</body>
</html>