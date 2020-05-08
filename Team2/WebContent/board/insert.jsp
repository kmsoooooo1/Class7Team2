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
	
var sel_files = [];
	
	$(document).ready(function() {
		$("#input_imgs").on("change", handleImgsFileSelect);
	}); 
	
	function fileUploadAction() {
		alert("fileUploadAction");
		$("#input_imgs").trigger('click');
	}
	
	function handleImgsFileSelect(e) {
       
        sel_files = [];
        $(".imgs_wrap").empty();

        var files = e.target.files;
        var filesArr = Array.prototype.slice.call(files);
        
        var index = 0;
        filesArr.forEach(function(f) {
            if(!f.type.match("image.*")) {
                alert("확장자는 이미지파일만 가능합니다.");
                return;
            }

            sel_files.push(f);

            var reader = new FileReader();
            reader.onload = function(e) {
                var html = "<a href=\"javascript:void(0);\" onclick=\"deleteImageAction("+index+")\" id=\"img_id_"+index+"\"><img src=\"" + e.target.result + "\" data-file='"+f.name+"' class='selProductFile' width='100' height='100' title='Click to remove'></a>";
                $(".imgs_wrap").append(html);
                index++;

            }
            reader.readAsDataURL(f);
            
        });
    }
	
    function deleteImageAction(index) {
    	alert("index : "+index);

        sel_files.splice(index, 1);

    	alert("sel length 후 : "+sel_files.length);

        var files = e.target.files;
        var filesArr = Array.prototype.slice.call(files);
    	alert("filesArr"+filesArr);
    	
        var img_id = "#img_id_"+index;
        $(img_id).remove(); 
        
    }
    
	function save(){
	    oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
	    document.fr.b_category.disabled="";

	    alert("첨부된 사진"+sel_files.length);
	  	var data = new FormData();
	  	
        for(var i=0, len=sel_files.length; i<len; i++) {
            var name = "image_"+i;
            data.append(name, sel_files[i]);
        }
        data.append("image_count", sel_files.length);
        
        if(sel_files.length < 1) {
            alert("썸네일이 없습니다.");
            return;
        }  
	    document.fr.submit();
	};
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
				<td><img src="./upload/multiupload/<%=dto.getImg_src()%>" width="100" height="100"></td>
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
		
		<div class="input_wrap">
		첨부파일 (첫번째 사진이 썸네일) <br>
		<input type="file" name="file" id="input_imgs" multiple="multiple"><br>
		
		</div>
		
        <div class="imgs_wrap">
            <img id="img"/>
        </div>
		
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