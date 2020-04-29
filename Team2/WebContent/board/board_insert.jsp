<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>WebContent/board/board_insert.jsp</h1>
	
	<h1> 게시판 글쓰기(정보 입력) </h1>
	
	<fieldset>
	  <legend> 글쓰기  </legend>
	  <form action="./BoardWriteAction.bo" method="post" 
	  		enctype="multipart/form-data" >
	  		
	  <select name="category">
	   <option value="notice">공지사항</option>
	   <option value="review">상품후기</option>
	   <option value="qna">상품문의</option>
	  </select> <br>
	  
	  
	    글쓴이 : <input type="text" name="writer"> <br>
	    제목 : <input type="text" name="title"><br>
	    내용 : <br><textarea rows="10" cols="20" name="content"></textarea>  <br>
	  <hr>
	    파일1 <input type="file" name="file1"><br> 
	    파일2 <input type="file" name="file2"><br> 
	    파일3 <input type="file" name="file3"><br> 
	  
	  <input type="submit" value="글쓰기">
	  </form>	
	</fieldset>
	
</body>
</html>