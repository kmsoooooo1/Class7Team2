<%@page import="team2.board.action.PageMaker"%>
<%@page import="team2.board.action.Criteria"%>
<%@page import="java.util.ArrayList"%>
<%@page import="team2.board.action.cSet"%>
<%@page import="team2.board.db.BoardDTO"%>
<%@page import="team2.board.db.BoardDAO"%>
<%@page import="team2.board.action.BoardListAction"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>

<link href="${pageContext.request.contextPath}/css/boardAdmin.css" rel="stylesheet">
<script type="text/javascript">

function doList(selectObject){
	
	var chk = selectObject.value;
			
	document.fr.submit();
	
};

function doAction(){
	
	document.fr.submit();
	
};

function doDelete(){
	
	alert("삭제 완료");
	document.fr2.submit();
	
};
</script>	
</head>
<body>
	<jsp:include page="/include/header.jsp" />
	
<%

	ArrayList boardList = (ArrayList)request.getAttribute("getList");
	Criteria cri = (Criteria)request.getAttribute("cri");
	PageMaker pageMaker = (PageMaker)request.getAttribute("pageMaker");

	//페이지번호 & 카테고리번호
	String pageNum = (String)request.getAttribute("pageNum");
	String category = (String)request.getAttribute("category");
	String search = (String)request.getAttribute("search");
	
	int c = 0;
	int pageSize = 10;
	
	try{
		 c = (int)request.getAttribute("c");
		 pageSize = (int)request.getAttribute("pageSize");
	}catch(Exception e){
		System.out.println(e);
	}
		
	
	System.out.println("pageMaker : " +pageMaker+"/pageNum : "+pageNum);
	System.out.println("category : " +category+"/c : "+c);

	
%>
<div class="board">

	<div class="top">
		<div class="boardname">
		 <h2>
			게시판 관리
		 </h2>
		</div>
	<!-- 게시판 검색 -->		 
	<form name="fr" id="fr" action="./SearchBoard.bo" method="POST">	
		
		 <select name="pageSize" onchange="doList(this)">
		 	<option value="10"
				<c:if test="${pageSize eq 10}">selected </c:if>> 10</option>
		 	<option value="5"
		 		<c:if test="${pageSize eq 5}">selected </c:if>>5</option>
		 	<option value="7"
		 		<c:if test="${pageSize eq 7}">selected </c:if>>7</option>
		 	<option value="20"
		 		<c:if test="${pageSize eq 20}">selected </c:if>>20</option>
		 </select>	
		 
		 <c:set var="ca_cset" value="<%=c%>" />
		 
		<select name="category" id="test">
			<%for(int i = 0; i<cSet.Category.length; i++){ %>
			<c:set var="ca_val" value="<%=i%>" />
				<option value=<%=i%> 
				<c:if test="${ca_val eq ca_cset}">selected</c:if>>

				<%=cSet.Category[i]%>
				</option>
			<%} %>
		</select>
		<input type="text" name="search" />
		<input type="button" onclick="doAction()" value="검색" />	
	</form>
	<!-- 게시판 검색 -->		 
	</div>	
		
	<div class="list-div">
	
	<form name ="fr2" id="fr2" action="./BoardDelete.bo" method="post">
	<table class="list">
		<colgroup>
			<col width="5%" />
			<col width="40%" />
			<col width="15%" />
			<col width="20%" />
			<col width="10%" />
			<col width="10%" />
		</colgroup>
		<thead>
		  <tr>
		    <th>번호</th>
		    <th>제목</th>
		    <th>작성자</th>
		    <th>작성일</th>
		    <th>조회수</th>
		    <th><input type="button" onclick="doDelete()" value="삭제" /></th>
		  </tr>
	  	</thead>
	  <%
	  if(boardList!=null) {
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
		    <td><input type="checkbox" name="chk" value="<%=bdto.getB_idx() %>"></td>
		  </tr>
		 </tbody>
	  <% } }%>
	
	</table>
	</form>
	
	</div>
	
	<div class="paging-div">
	<ul class="paging">
	<c:if test="${pageMaker.prev }">
		<li>
			<a href='<c:url value="./SearchBoard.bo?category=${c}&pageNum=${pageMaker.startPage-1 }&search=${search}"/>'><i class="fa left">◀</i></a>	
		</li>
		</c:if>
		<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum" >
		<li>
			<a href='<c:url value="./SearchBoard.bo?category=${c}&pageNum=${pageNum}&search=${search}&pageSize=${pageSize }"/>'><i class="fa">${pageNum }</i></a>
		</li>
		</c:forEach>
		<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
		<li>
			<a href='<c:url value="./SearchBoard.bo?category=${c}&pageNum=${pageMaker.endPage+1 }&search=${search}"/>'><i class="fa right">▶</i></a>
		</li>
	</c:if>
	</ul>
	</div>
	
</div>

	

	
	
	<!-- FOOTER -->
	<jsp:include page="/include/footer.jsp"/>	

</body>
</html>