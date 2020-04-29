<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>

	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	
	
	<!-- Main Content -->
	<h1>WebContent/admin/admin_goods_add.jsp</h1>
	
	<h2> 관리자 사육용품 등록 페이지</h2>
	
	<form action="./GoodsAddAction.ag" method="post" name="fr" enctype="multipart/form-data">
		<table border="1">
		  <tr>
		   <td>카테고리</td>
		   <td> 
		     <!-- 사육용품 카테고리 -->
		     <select name="category" onchange="categoryChange(this)">
		     	<option value="">종류를 선택하세요</option>
		     
		     
		     
		   </td> 
		  </tr>
		  <tr> 
		   <td>상품 이름</td>
		   <td><input type="text" name="g_name"></td>
		  </tr>
		  <tr>
		   <td>상품 코드</td>
		   <td><input type="text" name="g_code"></td>
		  </tr>
		  <tr> 
		   <td>상품 기본 이미지(5장)</td>
		   <td><input type="text" name="category"></td> <!-- 임시@@@@@@@@@ -->
		  </tr>
		  <tr> 
		   <td>상품 개수</td>
		   <td><input type="text" name="g_amount"></td>
		  </tr>
		  <tr> 
		   <td>상품 가격</td>
		   <td><input type="text" name="g_price"></td>
		  </tr> 
		
		
		  
		 
		
		</table>
	</form>
	
	
	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>

</body>
</html>