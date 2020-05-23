<%@page import="team2.board.db.ProductDTO"%>
<%@page import="team2.board.action.cSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/insert.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">	
</script>
</head>
<body>
<jsp:include page="../include/header.jsp"/>
<%
	String id2 = (String)session.getAttribute("id");
	if(id2==null){%>
		<script type="text/javascript">
			alert("로그인이 필요한 페이지입니다.");
			history.back();
		</script>	
<%	}

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
	<div id="container">
		<h1><%=cSet.Category[c] %></h1>
		<span class="board_title"></span>
		<form name="fr" id="fr" action="./InsertAction.bo" method="post" enctype="multipart/form-data">
			<input type="hidden" name="b_category" value=<%=cSet.Category[c] %>>
	<%	if(c==1 || c==2 && p_code!=null){ %>
			<div class="input_wrap">
				<span class="board_title">상품코드</span>
				<input type="text" name="b_p_code" value=<%=p_code %> readonly="readonly">
		<%		if(p_code!=null){
							
					ProductDTO dto = new ProductDTO(p_code);
					System.out.println(dto);
		%>
				<br>
				<table>
					<tr>
						<td><img src="./upload/multiupload/<%=dto.getImg_src()%>" width="100" height="100"></td>
						<td><%=dto.getCategory() %></td>
						<td><%=dto.getSub_category() %></td>
						<td><%=dto.getSub_category_idx() %></td>
						<td><%=dto.getName() %></td>
					</tr>
				</table>
			</div>
	<%		}
		} %>
			<div class="input_wrap">
				<span class="board_title">제목</span><input class="input_text" type="text" name="b_title"><br>
			</div>
			<div class="input_wrap">
				<textarea name="ir1" id="ir1" style="width:100%;min-width:260px;">에디터에 기본으로 삽입할 글(수정 모드)이 없다면 이 value 값을 지정하지 않으시면 됩니다.</textarea>
			</div>
			
			<div class="input_wrap">
				<span class="board_title">첨부파일</span>
				<input type="button" value="이미지 첨부하기" onclick="filesumit()"> 
		
			<!-- 첨부파일 버튼 숨김 -->
			<div class="hidden_file">	
				<input type="file" name="file[]" id="input_imgs" multiple="multiple"><br>
			</div>
			<!-- 첨부파일 버튼 숨김 -->
		
			</div>
	        <div class="imgs_wrap">
	            <img id="img"/>
	        </div>
	        <div class="btn_wrap">
				<button class="input_btn" type="button" onclick="return save();">등록하기</button>
				<button class="input_btn" type="button" onclick="">목록으로</button>
			</div>
        </form>
	</div>
	<jsp:include page="/include/footer.jsp"/>	
</body>

<script type="text/javascript">

var img_files = []; //추가할 파일

	$(document).ready(function() {
		$("#input_imgs").on("change", addFiles);
				
	}); 
	
	function filesumit() {
		$("#input_imgs").trigger('click');
	}
	
	//파일 추가
	function addFiles(e) {
		
		img_files = [];
	
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		var index = 0;		
	    filesArr.forEach(function(f) {
	        if(!f.type.match("image.*")) {
	            alert("확장자는 이미지파일만 가능합니다.");
	            return;
	        }
	        
	        img_files.push(f);

	        var reader = new FileReader();
	        reader.onload = function(e) {
	            var html = "<a href=\"javascript:void(0);\" onclick=\"deleteFiles("+index+")\" ><img src=\"" + e.target.result + "\" data-file='"+f.name+"' class='selProductFile' width='150' height='120' id=\"img_id_"+index+"\"></a>";
	        	$(".imgs_wrap").append(html);
	            index++;
	        }
	        reader.readAsDataURL(f);
	        
	    });
		  
	}
	
	//추가할 파일 삭제
	function deleteFiles(index) {
		alert("index delete : "+img_files[index]);
	
		img_files.splice(index, 1);
	
	    var img_id = "#img_id_"+index;
	    $(img_id).remove(); 
	           
	}
	
	function save(){
	    oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
	    		
	//		document.fr.submit();
		
		var form = $('#fr')[0];
		var formData = new FormData(form);
		
		for(var index=0; index < img_files.length; index++){
			formData.append('files', img_files[index]);
		}
	
		$.ajax({
			type : "POST",
			enctype : 'multipart/form-data',
	        processData : false,
	        contentType : false,
	        url : './InsertAction.bo',
	        data : formData,
	        success : function(result) {
				alert("글 등록에 성공하였습니다.");
				location.href="./BoardList.bo?category=<%=c%>";
	        },
		
	        error: function(e) {
	            alert("에러발생"+e);
	          }    
			//전송실패 미구현
		});
		
	
	};


	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	 oAppRef: oEditors,
	 elPlaceHolder: "ir1",
	 sSkinURI: "${pageContext.request.contextPath}/editor/SmartEditor2Skin.html",
	 fCreator: "createSEditor2"
	});
</script>

</html>