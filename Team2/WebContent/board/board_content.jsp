<%@page import="team2.board.db.ProductDTO"%>
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
<style>
	.commentUpdate{
		display:none;
	}
</style>
</head>
<body>
 <jsp:include page="/include/header.jsp" /> 
 
	<%
		BoardDTO bdto = (BoardDTO)request.getAttribute("bdto");
		String pageNum = (String)request.getParameter("pageNum");
		String num = request.getParameter("num");
		String id2 = (String)session.getAttribute("id");
		CommentDAO cdao = new CommentDAO();
		List<CommentDTO> list = cdao.getList(Integer.parseInt(num));
		cdao.closeDB();

		String p_code = bdto.getB_p_code();
		String category = bdto.getB_category();
	%>
		
		
	글번호 <%=bdto.getB_idx() %><br>
	제목 <%=bdto.getB_title() %><br>
	조회수 <%=bdto.getB_view() %> <br>
	카테고리 <%=category %> <br>

	<%
		if(category.equals("Review")){	
			if(!p_code.equals("null")){
	%>
		상품코드 : <input type="text" name="b_p_code" value=<%=p_code %> readonly="readonly">
	<%		
						
				ProductDTO dto = new ProductDTO(p_code);
				System.out.println(dto);
	%>
		<table>
			<tr>
				<td><img src="./upload/multiupload/<%=dto.getImg_src()%>" width="100" height="100"></td>
				<td><%=dto.getCategory() %></td>
				<td><%=dto.getSub_category() %></td>
				<td><%=dto.getSub_category_idx() %></td>
				<td><%=dto.getName() %></td>
			</tr>
		</table>
	<%
		}else{
			%>
			상품코드 : <input type="text" name="b_p_code" value="상품코드 미입력" readonly="readonly"> <br>
			<%	
		}
	}
		%>

		
			내용 <br>
			<textarea name="ir1" id="ir1" rows="10" cols="100" readonly><%=bdto.getB_content() %></textarea>
			
			<br>
			첨부파일

			<%String files[] = bdto.getB_file().split(","); %>
			<c:set var="files" value="<%=files %>" />
			<c:set var="getContextPath" value="<%=request.getContextPath()%>" />
		
			 <c:forEach var="file" items="${files}">
			<a href="${getContextPath}/downloadAction.bo?file=${file} ">
 			${file}</a>
			 </c:forEach>

	<table>
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

	<div class="comment_wrap">
	<div>
		<form name="fr" action="./InsertCommentAction.bo?num=<%=num %>&pageNum=<%=pageNum %>" method="post">
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
			System.out.println(list.toString());
			int cnt = 0;
			for(CommentDTO dto : list){ %>
			
			<li>
				<div class="comment_wrap comment<%=dto.getC_idx()%>">
						작성자 : <%=dto.getC_id() %><br>
						댓글 
						<div class="commentInfo comment<%=cnt%>info">
							 <%=dto.getC_comment() %><br>
						</div>
						<div class="commentUpdate comment<%=cnt%>update">
							<form name="updatefr" action="./updateCommentAction.bo" method="post">
								<input type="hidden" name="num" value=<%=num%>>
								<input type="hidden" name="pageNum" value=<%=pageNum%>>
								<input type="hidden" name="cnum" value=<%=dto.getC_idx() %>>
								<textarea name="comment"><%=dto.getC_comment()%></textarea>
								<button type="button" type="button" onclick="return updateCommentCheck(<%=cnt%>)">수정</button>
								<button type="button" type="button" onclick="updateCommentCancle(<%=cnt%>)">취소</button>
							</form>
						</div>
						IP : <%=dto.getIp_addr() %><br>
						작성일자 : <%=dto.getC_regdate() %>	
					
					
					<button onclick="deleteComment(<%=dto.getC_idx()%>);">삭제</button>
				<%if(id2!=null && id2.equals(dto.getC_id())){ %>
					<button onclick="updateComment(<%=cnt %>)">수정</button>
				<%} %>
				</div>
			</li>
			
		<%	cnt++;
			} 
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
	
	function updateComment(c_idx){
 		document.getElementsByClassName('comment'+c_idx+'info')[0].style.display = "none";
 		document.getElementsByClassName('comment'+c_idx+'update')[0].style.display = "block";
	}
	
	function updateCommentCancle(c_idx){
		document.getElementsByClassName('comment'+c_idx+'info')[0].style.display = "block";
 		document.getElementsByClassName('comment'+c_idx+'update')[0].style.display = "none";
	}
	
	function deleteComment(c_idx){
		if(confirm("댓글을 삭제하시겠습니까?")){
			location.href="./deleteCommentAction.bo?num=<%=num%>&pageNum=<%=pageNum%>&cnum="+c_idx;
		}
	}
	

</script>
</html>