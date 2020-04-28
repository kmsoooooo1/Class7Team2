<%@page import="team2.board.action.cSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function save(){
	    oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
	    document.fr.submit();
	};
</script>
</head>
<body>

<h1>글 작성</h1>

	<form name="fr" action="./InsertAction.bo" method="post">
		카테고리
		<select name="b_category">
			<%for(int i = 0; i<cSet.Category.length; i++){ %>
				<option value=<%=cSet.Category[i] %>><%=cSet.Category[i]%></option>
			<%} %>
		</select><br>
		세부카테고리
		<select name="b_p_cate">
			<%for(int i = 0; i<cSet.p_Category.length; i++){ %>
				<option value=<%=cSet.p_Category[i] %>><%=cSet.p_Category[i] %></option>
			<%} %>
		</select><br>
		글제목<input type="text" name="b_title"><br>
		내용<textarea name="ir1" id="ir1" rows="10" cols="100">에디터에 기본으로 삽입할 글(수정 모드)이 없다면 이 value 값을 지정하지 않으시면 됩니다.</textarea>
		첨부파일<input type="file" name="file"><br>
		<input type="button" onclick="return save();" value="확인"/><button type="button" onclick="">목록으로</button>
	</form>
	

</body>

<script type="text/javascript">
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	 oAppRef: oEditors,
	 elPlaceHolder: "ir1",
	 sSkinURI: "${pageContext.request.contextPath}/editor/SmartEditor2Skin.html",
	 fCreator: "createSEditor2"
	});
</script>

</html>