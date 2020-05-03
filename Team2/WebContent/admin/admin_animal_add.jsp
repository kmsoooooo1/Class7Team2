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
	
	<h2> 관리자 동물등록 페이지 </h2>
	
	<form name="fr" action="./AnimalAddAction.aa" method="post" enctype="multipart/form-data"> 
		<table border="1">
			<tr>
				<td> 카테고리 </td>
				<td>
					<!-- 동물 카테고리 -->
					<select name="category" onchange="categoryChange(this)">
						<option value="default"> 종을 선택해주세요 </option>
						<option value="파충류"> 파충류 </option>
						<option value="양서류"> 양서류 </option>
					</select>
					<!-- 동물 서브 카테고리 -->
					<select name="sub_category" id="sub_category" onchange="sub_categoryChange(this)">
						<option> 서브 종을 선택해주세요 </option>
					</select>
					<!-- 동물 최종 카테고리 -->
					<select name="sub_category_index" id="sub_category_index">
						<option> 서서브 종을 선택해주세요 </option>
					</select>
				</td>
			</tr>
			<tr>
				<td> 동물 모프 (종의 이름)  </td>
				<td> <input type="text" name="a_morph"> </td>
			</tr>
			<tr>
				<td> 동물 성별 </td>
				<td> 
					<select name="a_sex">
						<option value="default"> 성별을 선택해주세요 </option>
						<option value="암컷"> 암컷 </option>
						<option value="수컷"> 수컷 </option>
						<option value="성별없음"> 성별없음 </option>
					</select> 
				</td>
			</tr>
			<tr>
				<td> 
					동물 상태 <br>
					(ex. 성체, 베이비, 해당사항 없으면 빈칸 유지)
				</td>
				<td> <input type="text" name="a_status"> </td>
			</tr>
			<tr>
				<td> 동물 코드 </td>
				<td> <input type="text" name="a_code"> </td>
			</tr>
			<tr>
				<td> 동물 썸네일용 이미지 </td>
				<td> <input type="file" name="a_thumbnail"> </td>
			</tr>
			<tr>
				<td> 동물 보유 수량 </td>
				<td> <input type="text" name="a_amount"> </td>
			</tr>
			<tr>
				<td rowspan="3"> 동물 가격 </td>
				<td> 판매가(할인전) :  <input id="a_price_origin_val" type="text" name="a_price_origin" value="" onkeyup="calMileage()">원 </td>
			</tr>
			<tr>
				<td> 할인율(없으면 0 기재) :  <input id="a_discount_rate_val" type="text" name="a_discount_rate" onkeyup="calDiscount()">%</td>
			</tr>
			<tr>
				<td> 판매가(할인후) :  <input id="a_price_sale_val" type="text" name="a_price_sale">원 </td>
			</tr>
			<tr>
				<td> 적립금 </td>
				<td> <input id="a_mileage_val" type="text" name="a_mileage">원 </td>
			</tr>
			<tr>
				<td colspan="2"> 
					<textarea name="ir1" id="ir1" rows="10" cols="100">
						<br>
							<span style="font-weight: bold"> 학명 </span> : <br>
							<span style="font-weight: bold"> 서식지 </span> : <br>
							<span style="font-weight: bold"> 수명 </span> : <br>
							<span style="font-weight: bold"> 크기 </span> : <br>		
							<span style="font-weight: bold"> 습성  </span> : <br>
							<span style="font-weight: bold"> 온도 </span> : <br>
							<span style="font-weight: bold"> 습도 </span> : <br>	
							<span style="font-weight: bold"> 특징 </span> : <br><br>
						<br>
					</textarea> 
				</td>
			</tr>
			<tr>
				<td colspan="2"> 
					<input type="button" onclick="return save();" value="추가하기"/>
					<button type="button">취소</button>
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
		var animal_p = ["서브 종을 선택해주세요", "도마뱀", "뱀", "거북"]; 	//파충류 선택했을시 나오는 리스트
		var animal_y = ["서브 종을 선택해주세요", "프로그", "살라맨더", "팩맨"];	//양서류 선택했을시 나오는 리스트
		
		var empty_sub_category = ["서브 종을 선택해주세요"];					//빈 리스트, 서브 카테고리에 뿌려주기 위한 빈 리스트
		var empty_sub_category_index = ["서서브 종을 선택해주세요"];			//빈 리스트, 서서브 카테고리에 뿌려주기 위한 빈 리스트
		
		var target = document.getElementById("sub_category");			//타겟: 서브 카테고리
		var target2 = document.getElementById("sub_category_index");	//타겟: 서서브 카테고리

		//카테고리에서 '종을 선택해주세요'를 선택했을시
		if(e.value == "default"){
			var d = empty_sub_category; 			//서브에 뿌려줄 빈 리스트
			var em = empty_sub_category_index;		//서서브에 뿌려줄 빈 리스트
		}
		//카테고리에서 파충류를 선택했을시
		else if(e.value == "파충류") {	
			var d = animal_p; 
			var em = empty_sub_category_index; 		//서서브에 뿌려줄 빈 리스트
		}
		//카테고리에서 양서류를 선택했을시
		else if(e.value == "양서류") {
			var d = animal_y;
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
		var animal_Do = ["서서브 종을 선택해주세요", "리자드/모니터", "레오파드 게코", "크레스티드 게코", "카멜레온"]; 	//게코 도마뱀을 선택했을시 나오는 리스트
		var animal_snake = ["서서브 종을 선택해주세요", "콘스네이크", "킹스네이크", "파이톤", "기타 애완뱀"];			//뱀을 선택했을시 나오는 리스트
		var animal_turtle = ["서서브 종을 선택해주세요", "육지거북 ", "수생/습지 거북"];	//거북을 선택했을시 나오는 리스트
		var empty_sub_category_index = ["-"];	//관리자가 양서류를 선택했을시 나오는 empty 리스트
		
		var target = document.getElementById("sub_category_index");

		if(e.value == "도마뱀") {
			var d = animal_Do;
		}
		else if(e.value == "뱀") {
			var d = animal_snake;
		}
		else if(e.value == "거북") {
			var d = animal_turtle;
		}
		//관리자가 양서류를 선택했을시(양서류는 서서브 카테고리가 없기 때문에 empty'-' 리스트로 보여줘야한다.)
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
	
	//판매가격 입력시 할인율 계산하는 함수
	function calDiscount() {
    	var origin_price = $('#a_price_origin_val').val(); 		// 오리지날 판매가격 12000
        var discount_rate = $('#a_discount_rate_val').val();	// 할인율 10
        var dec = (discount_rate / 100).toFixed(2);				// 0.01
        var mult = origin_price * dec; 							// 12000 * 0.01
        var discount = origin_price - mult;						// 12000 - (12000*0.01)
        $('#a_price_sale_val').val(discount);
	}
	
	//판매가격 입력시 적립금 계산하는 함수
	function calMileage() {
		var origin_price = $('#a_price_origin_val').val();
		var mileage_rate = "1.4";
        var dec = (mileage_rate / 100).toFixed(3);				// 0.014(1.4%) 적립
        var mult = Math.floor(origin_price * dec);				// 12000 * 0.014
        $('#a_mileage_val').val(Math.round(mult/100) * 100);	// 둘째자리부터 반올림해서 표시 1260 이면 1300으로
	}
    
</script>
	

</html>