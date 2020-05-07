<%@page import="team2.board.db.ProductDTO"%>
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
	    document.fr.b_category.disabled="";
	    document.fr.submit();
	};
</script>
</head>
<body>
<%
	String c_str = request.getParameter("C");

	System.out.println("c_str : " + c_str);
	int c = -1;
	if(c_str!=null){
		c = Integer.parseInt(c_str);
	}else{
		cSet set = (cSet)session.getAttribute("cset");
		System.out.println(set);
		c = set.getC();
	}
	
	System.out.println("c : " + c );
	
	String p_code = request.getParameter("CODE");
%>
<h1><%=cSet.Category[c] %> 작성</h1>

	<form name="fr" action="./InsertAction.bo" method="post" enctype="multipart/form-data">
		카테고리
		<select name="b_category" disabled="disabled">
			<%for(int i = 0; i<cSet.Category.length; i++){ %>
				<option value=<%=cSet.Category[i] %> 
				<%if(i==c){ %>
					selected="selected"
				<%} %>
				><%=cSet.Category[i]%></option>
			<%} %>
		</select><br>
<!-- 		세부카테고리 -->
<!-- 		<select name="b_p_cate"> -->
<%-- 			<%for(int i = 0; i<cSet.p_Category.length; i++){ %> --%>
<%-- 				<option value=<%=cSet.p_Category[i] %>><%=cSet.p_Category[i] %></option> --%>
<%-- 			<%} %> --%>
<!-- 		</select><br> -->
<%	if(!(c<1)){ %>
		상품코드 : <input type="text" name="b_p_code" value=<%=p_code %> readonly="readonly">
<%		if(p_code==null){ %>
			<button type="button" onclick="">상품검색</button><br>
<%		}else{
		
			ProductDTO dto = new ProductDTO(p_code);
			System.out.println(dto);
%>
		<br>
		<table>
			<tr>
				<td><img src="./upload/multiupload/<%=dto.getImg_src()%>" width="500" height="500"></td>
				<td><%=dto.getCategory() %></td>
				<td><%=dto.getSub_category() %></td>
				<td><%=dto.getSub_category_idx() %></td>
				<td><%=dto.getName() %></td>
			</tr>
		</table>
<%		}
	} %>
	
	
		글제목<input type="text" name="b_title"><br>
		내용<textarea name="ir1" id="ir1" rows="10" cols="100">에디터에 기본으로 삽입할 글(수정 모드)이 없다면 이 value 값을 지정하지 않으시면 됩니다.</textarea>
		첨부파일<input type="file" name="file" multiple="multiple"><br>
		<input type="button" onclick="return save();" value="확인"/>
		<button type="button" onclick="">목록으로</button>
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