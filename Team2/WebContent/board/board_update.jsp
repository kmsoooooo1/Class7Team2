<%@page import="team2.board.action.cSet"%>
<%@page import="team2.board.db.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function save(){
	    oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	    document.fr.submit();
	};
</script>
</head>
<body>
	<h1>WebContent/board/board_update.jsp</h1>
	
	<%
		BoardDTO bdto = (BoardDTO)request.getAttribute("bdto");
		String pageNum = request.getParameter("pageNum");
		
	%>
	
	<form name= "fr" action="./BoardUpdateAction.bo?pageNum=${pageNum}" method="post">
		<input type="hidden" name="num" value="<%=bdto.getB_idx() %>">	
		<input type="hidden" name="pageNum" value="<%=pageNum %>">	
		<input type="hidden" name="b_category" value="<%=bdto.getB_category() %>">	
			글번호  <%=bdto.getB_idx() %> <br>
			조회수 <%=bdto.getB_view()%> <br>
			카테고리 <%=bdto.getB_category() %> <br>			

			제목 <input type="text" name="title" value="<%=bdto.getB_title()%>">
			<br>
			첨부파일  <br>
			<%
				//첨부된 파일 확인하여 불러오기
				String files[] = bdto.getB_file().split(","); 
				String ex = files[0];
			%>
			<c:set var="files" value="<%=files %>" />
			<c:set var="ex" value="<%=ex %>" />
			<c:if test="${ex ne null}">
			<c:forEach var="file" items="${files}">
			${file} <a href="${getContextPath}/deleteFileAction.bo?file=${file} ">
 			삭제하기 </a><br>
			 </c:forEach>
			 </c:if>
			<input type="file" name="file" >
			
			<br>

			내용
			<textarea name="content" id="content" rows="20" cols="140">
			<%=bdto.getB_content()%>
			</textarea> <br>

				<input type="button" onclick="return save();" value="수정하기"/>
		
				<input type="reset" value="다시 쓰기">
				
				<input type="button" value="뒤로가기"
					onclick="location.href='javascript:history.back()'">
				<input type="button" value="목록이동"
					onclick="location.href='./BoardMain.bo'">

	</form>
	
	
</body>

<script type="text/javascript">

	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	 oAppRef: oEditors,
	 elPlaceHolder: "content",
	 sSkinURI: "${pageContext.request.contextPath}/editor/SmartEditor2Skin.html",
	 
	 //컨텐츠 이미지 업로드
	 fOnAppLoad:function(){
		 oEditors.getById["content"].exec("PASTE_HTML", [content.getValue()]);
	 },

	 fCreator: "createSEditor2"
	});

	
</script>
</html>