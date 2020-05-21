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
<link href="${pageContext.request.contextPath}/css/boardContent.css" rel="stylesheet">
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
	<div id="container">
		<div class="board_wrap">
			<div class="title">
			 	<h2>
			  		<%=bdto.getB_category() %>
			 	</h2>
			</div>
			<div class="table_wrap">
				<table class="content_table">
					<tr class="content_tr">
						<th>제목</th><td class="table_td1" colspan="3"><%=bdto.getB_title() %></td>
					</tr>
					<tr class="content_tr">
						<th>작성자</th><td class="table_td1" colspan="3"><%=bdto.getB_writer() %></td>
					</tr>
					<tr class="content_tr">
						<th>작성일</th><td class="table_td2"><%=bdto.getB_reg_date() %></td><th>조회수</th><td class="table_td2"><%=bdto.getB_view() %></td>
					</tr>
				<%
					if(category.equals("Review")){	
						if(!p_code.equals("null")){
				%>
					<tr class="product_tr">
						<th>상품 </th> 
					
				<%		
									
							ProductDTO dto = new ProductDTO(p_code);
							System.out.println(dto);
				%>
					<td class="table_td1" colspan="3">
					<table class="item">
						<tr>
							<td><img src="./upload/multiupload/<%=dto.getImg_src()%>" width="100" height="100"></td>
							<td><%=dto.getCategory() %></td>
							<td><%=dto.getSub_category() %></td>
							<td><%=dto.getSub_category_idx() %></td>
							<td><%=dto.getName() %></td>
						</tr>
					</table>
					</td>
				<%
					}else{
						%>
						<th>상품</th> <td colspan="3"> </td>
						<%	
					}
				}
					%>
						</tr>
						<tr>
							<td colspan="4">
								<div class="content"><%=bdto.getB_content() %></div>
							</td>
						</tr>
						<tr  class="content_tr">
						<th>첨부파일</th>
						<td class="table_td1" colspan="3">
							<%String files[] = bdto.getB_file().split(","); %>
							<c:set var="files" value="<%=files %>" />
							<c:set var="getContextPath" value="<%=request.getContextPath()%>" />
						
							 <c:forEach var="file" items="${files}">
							<a href="${getContextPath}/downloadAction.bo?file=${file} ">
				 			${file}</a>
							 </c:forEach>
						</td>
						</tr>
				</table>
				
				<div class="button">
					<input type="button" value="수정"
						onclick="location.href='./BoardUpdate.bo?pageNum=<%=pageNum%>&num=<%=bdto.getB_idx()%>'">
					<input type="button" value="삭제"
						onclick="location.href='./BoardDelete.bo?num=<%=bdto.getB_idx()%>&category=<%=bdto.getB_category() %>'">
					<input type="button" value="댓글"
						onclick="">
					<input type="button" value="목록이동"
						onclick="location.href='./BoardMain.bo'">
				</div>
			</div>
		</div>
		
		<div class="comment_total_wrap">
			
			<form name="fr" action="./InsertCommentAction.bo?num=<%=num %>&pageNum=<%=pageNum %>" method="post">
				<div class="comment_insert_wrap">
					<input type="hidden" name="c_category" value="board">
					<input type="hidden" name="c_b_idx" value=<%=bdto.getB_idx()%>>
					<textarea class="comment" name="comment"<%if(id2!=null){ %>placeholder="댓글을 입력해 주세요."<%}else{ %>placeholder="로그인이 필요합니다."disabled="disabled"<%} %>></textarea>
					<button class="comment_btn" type="button" onclick="return insertCommenctCheck()"<%if(id2==null){ %>disabled="disabled"<%} %>>등록</button>
				</div>
			</form>
			
			<div class="comment_list_wrap">
				<ul class="comment_list">	
				<%if(list.size()>0){
					System.out.println(list.toString());
					int cnt = 0;
					for(CommentDTO dto : list){ %>
					
					<li class="comment_list_li">
						<div class="comment_wrap comment<%=dto.getC_idx()%>">
							<div class="comment_writer">
								<span class="comment_info_title">Comment By.</span><span class="comment_info_writer"><%=dto.getC_id() %></span>
								<span class="comment_info_date"><%=dto.getC_regdate() %></span>
							</div>
							<div class="comment_content">
								<div class="commentInfo comment<%=cnt%>info">
									 <%=dto.getC_comment() %><br>
								</div>
							<form name="updatefr" action="./updateCommentAction.bo" method="post" style="height: 100%;">
								<div class="commentUpdate comment<%=cnt%>update">
									<input type="hidden" name="num" value=<%=num%>>
									<input type="hidden" name="pageNum" value=<%=pageNum%>>
									<input type="hidden" name="cnum" value=<%=dto.getC_idx() %>>
									<div class="comment_update_text_wrap">
										<textarea class="update_comment" name="comment"><%=dto.getC_comment()%></textarea>
									</div>
									<div class="comment_update_btn_wrap2">
										<button type="button" type="button" onclick="return updateCommentCheck(<%=cnt%>)">수정</button>
										<button type="button" type="button" onclick="updateCommentCancle(<%=cnt%>)">취소</button>
									</div>
								</div>
							</form>
							<%if(id2!=null && id2.equals(dto.getC_id())){ %>
								<div class="show_update_btn" onclick="showUpdate(<%=cnt%>);"></div>
								<div class="comment_update_btn_wrap1 update_btn_wrap<%=cnt%>">
									<button onclick="deleteComment(<%=dto.getC_idx()%>);">삭제</button>
									<button onclick="updateComment(<%=cnt %>)">수정</button>
								</div>
							<%} %>
							</div>
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
	</div>
		
	
	<jsp:include page="/include/footer.jsp"/>	
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
 		showUpdate(c_idx);
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
	function showUpdate(cnt){
		var update_wrap = document.getElementsByClassName('update_btn_wrap'+cnt)[0];
		if(update_wrap.style.display=="block"){
			update_wrap.style.display = "none";
		}else{
			update_wrap.style.display = "block";
		}
	}
	
	

</script>
</html>