<%@page import="java.io.File"%>
<%@page import="team2.board.db.CommentDTO"%>
<%@page import="java.util.List"%>
<%@page import="team2.board.db.CommentDAO"%>
<%@page import="team2.board.db.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/board/commentInsert.js"></script>

</head>
<body>
	<h1>WebContent/board/board_content.jsp</h1>
	
	<%
		BoardDTO bdto = (BoardDTO)request.getAttribute("bdto");
		String pageNum = (String)request.getParameter("pageNum");

		String id2 = (String)session.getAttribute("id");
		CommentDAO cdao = new CommentDAO();
		List<CommentDTO> list = cdao.getList(Integer.parseInt(request.getParameter("num")));
		cdao.closeDB();
		if(bdto!=null){			
	%>
	
	<table border ="1">
		<tr>
			<td>글번호</td><td><%=bdto.getB_idx() %></td>
			<td>조회수</td><td><%=bdto.getB_view() %></td>
		</tr>
		<tr>
			<td>카테고리</td><td><%=bdto.getB_category() %></td>
			<td>제목</td><td><%=bdto.getB_title() %></td>
		</tr>
	
		<tr>
			<td>내용</td><td colspan="3" height=400 width=500><%=bdto.getB_content() %></td>
	
		</tr>
		
		<tr>
			<td>첨부파일</td>
			<td>
			<%String files[] = bdto.getB_file().split(","); %>
			<c:set var="files" value="<%=files %>" />
			<c:set var="getContextPath" value="<%=request.getContextPath()%>" />
		
			 <c:forEach var="file" items="${files}">
			<a href="${getContextPath}/downloadAction.bo?file=${file} ">
 			${file}</a>
			 </c:forEach>
			 </td>
		</tr>
		
		<tr>
			<td colspan="4">
				<input type="button" value="수정"
					onclick="location.href='./BoardUpdate.bo?pageNum=<%=pageNum%>&num=<%=bdto.getB_idx()%>'">
				<input type="button" value="삭제"
					onclick="location.href='./BoardDelete.bo?num=<%=bdto.getB_idx()%>&category=<%=bdto.getB_category() %>'">
				<input type="button" value="댓글"
					onclick="">
				<input type="button" value="목록이동"
					onclick="location.href='./BoardMain.bo'">
			
			</td>
		</tr>
	</table>
	<%} %>
	<div class="comment_wrap">
	<div>
		<form name="fr" action="./InsertCommentAction.bo" method="post">
			<input type="hidden" name="c_category" value="board">
			<input type="hidden" name="c_b_idx" value=<%=bdto.getB_idx()%>>
			<textarea name="comment" 
				<%if(id2!=null){ %>
				placeholder="댓글을 입력해 주세요."
				<%}else{ %>
				placeholder="로그인이 필요합니다."
				disabled="disabled"
				<%} %>
				></textarea>
			<button type="button" onclick="return insertCommenctCheck()"
				<%if(id2==null){ %>
					disabled="disabled"
				<%} %>
			>등록</button>
		</form>
	</div>
	<div>
		<ul>	
		<%if(list.size()>0){
			for(CommentDTO dto : list){ %>
			
			<li>
				<div class="comment_wrap">
					작성자 : <%=dto.getC_id() %><br>
					댓글 : <%=dto.getC_comment() %><br>
					IP : <%=dto.getIp_addr() %><br>
					작성일자 : <%=dto.getC_regdate() %>
				</div>
			</li>
			
		<%	} 
		  }else{ %>
		  	<li>
		  		<div class="content_wrap">
		  			작성된 댓글이 없습니다.
		  		</div>
		  	</li>
	  <%  } %>
		</ul>
	</div>
</div>
		
	

</body>
<script type="text/javascript">
	function downFile(file){
		var contextPath = "<%=request.getContextPath()%>";
		var url = contextPath + "/downloadAction.bo?file="+file;
		location.href=url;	
	}
</script>
</html>