<%@page import="team2.board.db.ProductDTO"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.net.URI"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.File"%>
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
<link href="${pageContext.request.contextPath}/css/boardUpdate.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

var conPath = "<%=request.getContextPath()+"/upload/board"%>";
//img저장 경로
var old_files = []; //DB에 저장된 파일
var img_files = []; //추가할 파일

	$(document).ready(function() {
		$("#input_imgs").on("change", addFiles);
		
		if(old_files != ""){
//			alert("old_files : "+old_files);
			for(var index=0; index<old_files.length; index++){
				var html = "<a href=\"javascript:void(0);\" onclick=\"deleteOldFiles("+index+")\" id=\"old_img_id_"+index+"\"><img src=" + conPath +"/"+old_files[index]+"  width='150' height='120' ></a>";
		 	   $(".imgs_wrap").append(html);
			}
		}
	
	});
	
</script>
</head>
<body>
	<jsp:include page="/include/header.jsp" />
<%
	String id2 = (String)session.getAttribute("id");
	if(id2==null){%>
		<script type="text/javascript">
			alert("로그인이 필요한 페이지입니다.");
			history.back();
		</script>	
<%	}
		BoardDTO bdto = (BoardDTO)request.getAttribute("bdto");
		String pageNum = request.getParameter("pageNum");

		String p_code = bdto.getB_p_code();
		String category = bdto.getB_category();
		
		cSet cset = new cSet();
		
		cset.setCategory(category);
		
		int c = cset.getC();
		
		String files[] = null;
		//DB에 저장된 파일 확인 후 불러오기		
		if(bdto.getB_file()!=null){
			files = bdto.getB_file().split(","); 
		}
		System.out.println("files.length 값 : "+files.length);
		
 		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath("/upload/board/");

		
		for(int i=0; i<files.length; i++){

			File upFile = new File(realPath+files[i]);
		
			System.out.println("upFile : " +upFile);
			
			%>
				<script type="text/javascript">
				
					old_files.push("<%=files[i]%>");
					
				</script>
			
			<%
		}
		
	%>
<div class="board">

	<div class="top">
		<div class="boardname">
	 	<h2>
	  		게시물 수정
	 	</h2>
		</div>	
	</div>
	
	<form name= "fr" id="fr" action="./BoardUpdateAction.bo" method="post">
		<input type="hidden" name="num" value="<%=bdto.getB_idx() %>">	
		<input type="hidden" name="pageNum" value="<%=pageNum %>">	
		<input type="hidden" name="b_category" value="<%=bdto.getB_category() %>">	
	<table class="notice">
	
	<tr>
		<th class="thleft">글번호</th> <td><%=bdto.getB_idx() %></td> 
	</tr>
	<tr>
		<th class="thleft">카테고리</th> <td><%=bdto.getB_category()%></td>			
	</tr>	
			<%

				if(!p_code.equals("null")){
			%>
		<tr>
			<th>상품 </th> 
			<%		
							
					ProductDTO dto = new ProductDTO(p_code);
					System.out.println(dto);
			%>
			<td>
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
				<th>상품</th> <td></td>
				<%	
			}
	
			%>
			</tr>
			
			<tr>
			
				<th>제목</th> <td><input type="text" name="b_title" value="<%=bdto.getB_title()%>"></td>
			</tr>
			<tr>
			<td colspan="2">
			<textarea name="b_content" id="b_content">
			<%=bdto.getB_content()%>
			</textarea>
			</td>
			</tr>
				
		</table>
		</form>
				
		<div class="bottom">
				<div class="button">
				<input type="button" value="이미지 첨부하기" onclick="filesumit()"> 
				<input type="button" onclick="return save();" value="수정하기"/>			
				<input type="button" value="뒤로가기"
					onclick="location.href='javascript:history.back()'">
				<input type="button" value="목록이동"
					onclick="location.href='./BoardMain.bo'">
				</div>
		</div>
	
	<div class="inputfile">
			<div class="input_wrap">
			<input type="file" name="file[]" id="input_imgs" multiple><br>
			
			</div>
			
	        <div class="imgs_wrap">
	            <img id="img"/>
	        </div>
			
			<br>
	</div>
	
	
	</div> <!-- board div 끝 -->
</body>

<script type="text/javascript">
	

	
	function filesumit() {
		$("#input_imgs").trigger('click');
	}

	//파일 추가
	function addFiles(e) {

// 		$(".imgs_wrap").empty();

// 		alert("img_files.length" +img_files.length);
		
// 		alert("old_files.length" +old_files.length);
	
		for(var i=0; i < img_files.length+1; i++){
			deleteFiles(i);
		}
		
		img_files = [];
	
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		var index = 0;		
        filesArr.forEach(function(f) {
            if(!f.type.match("image.*")) {
//                 alert("확장자는 이미지파일만 가능합니다.");
                return;
            }
	        
	        img_files.push(f);
	        
// 	        alert("img_files" + img_files);
	        var reader = new FileReader();
	        reader.onload = function(e) {
                var html = "<a href=\"javascript:void(0);\" onclick=\"deleteFiles("+index+")\" id=\"img_id_"+index+"\"><img src=\"" + e.target.result + "\" data-file='"+f.name+"' class='selProductFile' width='150' height='120' ></a>";
	        	$(".imgs_wrap").append(html);
	            index++;
            }
            reader.readAsDataURL(f);
            
        });
  	  
	}
    
	//추가할 파일 삭제
    function deleteFiles(index) {
//     	alert("index delete : "+index);

    	img_files.splice(index, 1);

        var img_id = "#img_id_"+index;
        $(img_id).remove(); 
               
    }
    
	//저장된 파일 삭제
    function deleteOldFiles(index) {
//     	alert("index delete : "+index);

    	old_files.splice(index, 1);

        var old_img_id = "#old_img_id_"+index;
        $(old_img_id).remove(); 
               
    }

	function save(){
	    oEditors.getById["b_content"].exec("UPDATE_CONTENTS_FIELD", []);
// 	    document.fr.submit();


		var form = $('#fr')[0];
		var formData = new FormData(form);
		
		if(old_files!="" && old_files!=null){
			for(var i=0; i < old_files.length; i++){
// 				alert("test : " + old_files[i]);
				formData.append('old', old_files[i]);
			}
		}
	
		for(var index=0; index < img_files.length; index++){
// 			alert("test : " + img_files[index]);
			formData.append('files', img_files[index]);
		}
		
		$.ajax({
			type : "POST",
			enctype : 'multipart/form-data',
            processData : false,
            contentType : false,
            url : './BoardUpdateAction.bo',
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


/* --------------------------------------------------	 */
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	 oAppRef: oEditors,
	 elPlaceHolder: "b_content",
	 sSkinURI: "${pageContext.request.contextPath}/editor/SmartEditor2Skin.html",
	 
// 	 컨텐츠 이미지 업로드
// 		fOnAppLoad:function(){
// 			 oEditors.getById["b_content"].exec("PASTE_HTML", [content.getValue()]);
		 
// 	 },

	 fCreator: "createSEditor2"
	});

	
</script>
</html>