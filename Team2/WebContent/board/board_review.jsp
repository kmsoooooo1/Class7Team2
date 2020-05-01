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
 <style type="text/css">
  ul{ list-style: none;}
  li{ float:left;
  	  font-style: normal;
  	}
 
 </style>
</head>
<body>
	<h1>WebContent/board/board_review.jsp</h1>
	
	<%
		ArrayList boardList = (ArrayList)request.getAttribute("boardList");
		Criteria cri = (Criteria)request.getAttribute("cri");
		PageMaker pageMaker = (PageMaker)request.getAttribute("pageMaker");
		String pageNum = (String)request.getAttribute("pageNum");
	%>
	
		 <h2><a href="./Insert.bo"> 글 쓰기 (스마트에디터)  </a></h2>
		 <h2><a href="./BoardMain.bo"> 메인  </a></h2>
	
	<table border="1">
	  <tr>
	    <td>번호</td>
	    <td>제목</td>
	    <td>작성자</td>
	    <td>사진</td>
	    <td>날짜</td>
	    <td>조회수</td>
	    <td>IP</td>
	  </tr>
	  
	  <%
	    for(int i=0;i<boardList.size();i++){ 
             BoardDTO bdto = (BoardDTO) boardList.get(i);
             
             String image = bdto.getB_file();
             
             if(image == null){
            	 image = "no.jpg";
             }
             
             String array[] = image.split(",");
             
             String conPath = request.getContextPath()+"/upload";
             
             String imgPath = conPath+"\\"+array[0];
             
	  %>
		  <tr>
		    <td><%=bdto.getB_idx() %></td>
		    <td><%=bdto.getB_title() %></td>
		    
		    <td><%=bdto.getB_writer() %></td>
		    <td>
		     <a href="./BoardContent.bo?num=<%=bdto.getB_idx()%>&pageNum=<%=cri.getPage()%>">
		    	<img src="<%=imgPath %>" width=180 height=150>
		    	</a>
		    </td>
		    <td><%=bdto.getB_reg_date() %></td>
		    <td><%=bdto.getB_view() %></td>
		    <td><%=bdto.getIp_addr() %></td>
		  </tr>
	  <% } %>
	
	</table>
	
		<ul class="btn-group paging">
	<c:if test="${pageMaker.prev }">
	<li>
		<a href='<c:url value="./review.bo?pageNum=${pageMaker.startPage-1 }"/>'><i class="fa left">[이전]</i></a>	
	</li>
	</c:if>
	<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum" >
	<li>
		<a href='<c:url value="./review.bo?pageNum=${pageNum}"/>'><i class="fa">[${pageNum }]</i></a>
	</li>
	</c:forEach>
	<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
	<li>
		<a href='<c:url value="./review.bo?pageNum=${pageMaker.endPage+1 }"/>'><i class="fa right">[다음]</i></a>
	</li>
	</c:if>

	</ul>

</body>
</html>