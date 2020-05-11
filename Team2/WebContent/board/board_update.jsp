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
<script type="text/javascript" src="${pageContext.request.contextPath}/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

	function save(){
	    oEditors.getById["b_content"].exec("UPDATE_CONTENTS_FIELD", []);
// 	    document.fr.submit();

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
            url : './BoardUpdateAction.bo',
            data : formData,
            success : function(result) {
                if (result === -1) {
                    alert('jpg, gif, png, bmp 확장자만 업로드 가능합니다.');
                    // 이후 동작 ...
                } else if (result === -2) {
                    alert('파일이 10MB를 초과하였습니다.');
                    // 이후 동작 ...
                } else {
                    alert('이미지 업로드 성공');
                    // 이후 동작 ...
                }
            },
		
	        error: function(e) {
	            alert("에러발생"+e);
	          }    
			//전송실패 미구현
		});
	
	};
	
	var img_files = [];
</script>
</head>
<body>
	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	
	<!-- Main Content -->
	<h1>WebContent/board/board_update.jsp</h1>
	
	<%
		BoardDTO bdto = (BoardDTO)request.getAttribute("bdto");
		String pageNum = request.getParameter("pageNum");

		//첨부된 파일 확인하여 불러오기
		String files[] = bdto.getB_file().split(","); 
// 		String p = request.getContextPath();
// 		String p1 = p.replace('/', '\\');
 		String AbsPath = request.getContextPath()+"upload//board";
 		String realPath = "D:\\workspace_jsp\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\Team2\\upload\\board";		

		

		for(int i=0; i<files.length; i++){
			
// 			if(files != null){
// 				filereader = new FileReader(realPath+"/"+files[i]);
// 					br = new BufferedReader(filereader);
// 					data[i] = br.readLine();
				
// 			}
			String filePath = AbsPath + "\\" + files[i];
			
			File data = new File(realPath+files[i]);
		
// 			System.out.println("data : " +data);
			
		    String fileList[] = data.list();
			%>
				<script type="text/javascript">
				


 
					img_files.push("<%=files[i]%>");
				</script>
			
			<%
		}
		
	%>

	
	<form name= "fr" id="fr" action="./BoardUpdateAction.bo" method="post">
		<input type="hidden" name="num" value="<%=bdto.getB_idx() %>">	
		<input type="hidden" name="pageNum" value="<%=pageNum %>">	
		<input type="hidden" name="b_category" value="<%=bdto.getB_category() %>">	
			글번호  <%=bdto.getB_idx() %> <br>
			조회수 <%=bdto.getB_view()%> <br>
			카테고리 <%=bdto.getB_category() %> <br>			
			상품코드 <%=bdto.getB_p_code() %> <br>

			제목 <input type="text" name="b_title" value="<%=bdto.getB_title()%>">

			<br>

			내용
			<textarea name="b_content" id="b_content" rows="20" cols="140">
			<%=bdto.getB_content()%>
			</textarea> <br>

				<input type="button" onclick="return save();" value="수정하기"/>
		
				<input type="reset" value="다시 쓰기">
				
				<input type="button" value="뒤로가기"
					onclick="location.href='javascript:history.back()'">
				<input type="button" value="목록이동"
					onclick="location.href='./BoardMain.bo'">

	</form>
	

			<div class="input_wrap">
			첨부파일 (첫번째 사진이 썸네일) <br>
			<input type="file" name="file[]" id="input_imgs" multiple="multiple"><br>
			
			</div>
			
	        <div class="imgs_wrap">
	            <img id="img"/>
	        </div>
			
			<br>
	
	
</body>

<script type="text/javascript">
	
var conPath = "<%=request.getContextPath()+"/upload/board"%>";

	$(document).ready(function() {
		$("#input_imgs").on("change", addFiles);
		alert("img_files : "+img_files);
		for(var index=0; index<img_files.length; index++){
			var html = "<a href=\"javascript:void(0);\" onclick=\"deleteFiles("+index+")\" id=\"img_id_"+index+"\"><img src=" + conPath +"/"+img_files[index]+"  width='100' height='100' title='Click to remove'></a>";
	 	   $(".imgs_wrap").append(html);
		}
	
	});

	function addFiles(e) {
	
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		var index = img_files.length+1;
			
        filesArr.forEach(function(f) {
            if(!f.type.match("image.*")) {
                alert("확장자는 이미지파일만 가능합니다.");
                return;
            }
	        
	        img_files.push(f);
	        
	        alert("img_files" + img_files);
	        var reader = new FileReader();
	        reader.onload = function(e) {
                var html = "<a href=\"javascript:void(0);\" onclick=\"deleteFiles("+index+")\" id=\"img_id_"+index+"\"><img src=\"" + e.target.result + "\" data-file='"+f.name+"' class='selProductFile' width='100' height='100' title='Click to remove'></a>";
	        	$(".imgs_wrap").append(html);
	            index++;
            }
            reader.readAsDataURL(f);
            
        });
  	  
	}
    
    function deleteFiles(index) {
    	alert("index delete : "+img_files[index]);

    	img_files.splice(index, 1);

        var img_id = "#img_id_"+index;
        $(img_id).remove(); 
               
    }



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