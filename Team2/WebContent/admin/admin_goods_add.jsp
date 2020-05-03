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
		     <!-- 상품 카테고리 -->
		     <select name="category" onchange="categoryChange(this)">
		     	<option value="default">종류를 선택하세요</option>
		     	<option value="먹이">먹이</option>
		     	<option value="사육용품">사육용품</option>
		     </select>	
		     <!-- 상품 서브 카테고리 -->
		     <select name="sub_category" id="sub_category" onchange="sub_categoryChange(this)">
		     	<option>서브 상품을 선택하세요</option>
		     </select>
		     <!-- 상품 최종 카테고리 -->
		      <select name="sub_category_index" id="sub_category_index">
		     	<option>최종 서브 상품을 선택하세요</option>
		     </select>
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
		   <td rowspan="5">상품 기본 이미지(5장)</td>
		   <td><input type="file" name="file1"></td>
		  </tr>
		  <tr>
		   <td><input type="file" name="file2"></td>
		  </tr>
		  <tr>
		   <td><input type="file" name="file3"></td>
		  </tr>
		  <tr>
		   <td><input type="file" name="file4"></td>
		  </tr>
		  <tr>
		   <td><input type="file" name="file5"></td>
		  </tr>
		  
		  <tr> 
		   <td>상품 개수</td>
		   <td><input type="text" name="g_amount"></td>
		  </tr>
		  
		  <tr> 
		   <td>상품 가격</td>
		   <td><input type="text" name="g_price"></td>
		  </tr> 
		
		  <tr> <!-- content -->
		   <td colspan="2"><textarea name="ir1" id="ir1" rows="10" cols="100">에디터에 기본으로 삽입할 글(수정 모드)이 없다면 이 value 값을 지정하지 않으시면 됩니다.</textarea></td>
		  </tr>
		  <tr>
			<td colspan="2"> 
				<input type="button" onclick="return save();" value="추가하기"/>
				<button type="reset">취소</button>
			</td>
		</tr>
		  
		 
		
		</table>
	</form>
	
	
	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>

</body>

<script type="text/javascript">
	
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	 oAppRef: oEditors,
	 elPlaceHolder: "ir1",
	 sSkinURI: "editor/SmartEditor2Skin.html",
	 fCreator: "createSEditor2"
	});
	
	function save(){
	    oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
	    document.fr.submit();
	};
	
	//첫번째 카테고리를 선택했을시
	function categoryChange(e){
		var goods_f = ["서브 상품을 선택하세요", "생먹이", "냉동먹이", "인공사료", "칼슘/약품"]; 	//먹이 선택했을시 나오는 리스트
		var goods_g = ["서브 상품을 선택하세요", "사육장", "장식/그릇", "램프", "바닥재", "온/습도 관련", "보조용품", "수족관"];	//사육용품 선택했을시 나오는 리스트
		
		var empty_sub_category = ["서브 상품을 선택하세요"];					//빈 리스트, 서브 카테고리에 뿌려주기 위한 빈 리스트
		var empty_sub_category_index = ["최종 서브 상품을 선택하세요"];			//빈 리스트, 서서브 카테고리에 뿌려주기 위한 빈 리스트
		
		var target = document.getElementById("sub_category");			//타겟: 서브 카테고리
		var target2 = document.getElementById("sub_category_index");	//타겟: 서서브 카테고리
	
		//카테고리에서 '종류를 선택하세요'를 선택했을시
		if(e.value == "default"){
			var d = empty_sub_category; 			//서브에 뿌려줄 빈 리스트
			var em = empty_sub_category_index;		//서서브에 뿌려줄 빈 리스트
		}
		//카테고리에서 먹이를 선택했을시
		else if(e.value == "먹이") {	
			var d = goods_f; 
			var em = empty_sub_category_index; 		//서서브에 뿌려줄 빈 리스트
		}
		//카테고리에서 사육용품을 선택했을시
		else if(e.value == "사육용품") {
			var d = goods_g;
			var em = empty_sub_category_index; 		//서서브에 부려줄 빈 리스트
		}
	
		target.options.length = 0;
		target2.options.length = 0;
	
		//서브 카테고리에 뿌려주는 for loop
		for (i in d) {
			var opt = document.createElement("option");
			opt.value = d[i];
			opt.innerHTML = d[i];
			target.appendChild(opt);
		}
		
		//서서브 카테고리에 뿌려주는 for loop
		//만약 관리자가 다시 카테고리를 선택했을시 서서브 카테고리를 아무것도 없는 상태로 초기화 시켜야한다. 
		//여기서는 카테고리가 바뀔때마다 empty_list의 리스트를 서서브 select에 뿌려준다. 
		for(j in em) {
			var opt = document.createElement("option");
			opt.value = em[j];
			opt.innerHTML = em[j];
			target2.appendChild(opt);
		}
	}
	
	//두번째 카테고리를 선택했을시
	function sub_categoryChange(e){
		var goods_cage = ["최종 서브 상품을 선택하세요", "유리/테라리움", "플라스틱"]; 	//사육장을 선택했을시 나오는 리스트
		var goods_bowl = ["최종 서브 상품을 선택하세요", "장식", "은신처", "물/먹이그릇"];	//장식/그릇을 선택했을시 나오는 리스트
		var goods_lamp = ["최종 서브 상품을 선택하세요", "UVB/스팟 ", "소켓", "악세사리"];	//램프를 선택했을시 나오는 리스트
		var goods_floor = ["최종 서브 상품을 선택하세요", "건계", "습계"]; // 바닥재를 선택했을시 나오는 리스트
		var goods_dgree = ["최종 서브 상품을 선택하세요", "온습도계", "온도조절기", "습도조절기"]; // 온/습도 선택했을시 나오는 리스트 
		var goods_supplies = ["최종 서브 상품을 선택하세요", "위생/청소", "안전/치료", "브리딩", "기타"]; // 보조용품 선택했을시 나오는 리스트
		var goods_fish = ["최종 서브 상품을 선택하세요", "수질안정제", "여과기", "히터기", "거북이육지", "기타"]; // 수족관 선택했을시 나오는 리스트
		var empty_sub_category_index = ["-"];	//관리자가 먹이를 선택했을시 나오는 empty 리스트
		
		var target = document.getElementById("sub_category_index");

		if(e.value == "사육장") {
			var d = goods_cage;
		}
		else if(e.value == "장식/그릇") {
			var d = goods_bowl;
		}
		else if(e.value == "램프") {
			var d = goods_lamp;
		}
		else if(e.value == "바닥재") {
			var d = goods_floor;
		}
		else if(e.value == "온/습도 관련") {
			var d = goods_dgree;
		}
		else if(e.value == "보조용품") {
			var d = goods_supplies;
		}
		else if(e.value == "수족관") {
			var d = goods_fish;
		}
		//관리자가 먹이를 선택했을시(먹이는 서서브 카테고리가 없기 때문에 empty'-' 리스트로 보여줘야한다.)
		else {
			var d = empty_sub_category_index;
		}

		target.options.length = 0;

		for (i in d) {
			var opt = document.createElement("option");
			opt.value = d[i];
			opt.innerHTML = d[i];
			target.appendChild(opt);
		}	
	}
	

</script>



</html>