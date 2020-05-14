<%@page import="team2.board.db.BoardDTO"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@page import="team2.board.db.BoardDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="team2.animal.db.AnimalDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/product_detail.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<title>테스트</title>
</head>
<body>

	<%
		String id = (String) session.getAttribute("id");
		if (id == null) {
			id = "";
		}

		//AnimalDetailAction 객체에서 저장된 정보를 저장 
		AnimalDTO animalDetail = (AnimalDTO) request.getAttribute("animalDetail");

		//###,###,###원 표기하기 위해서 format 바꾸기
		DecimalFormat formatter = new DecimalFormat("#,###,###,###");
		String newformat_price_origin = formatter.format(animalDetail.getA_price_origin());
		String newformat_mileage = formatter.format(animalDetail.getA_mileage());
		String newformat_price_sale = formatter.format(animalDetail.getA_price_sale());

		// 상품에 대한 정보를 쿠키에 담기
		// 쿠키에 한글은 저장되지 않으므로 encode함수로 인코딩해야 한다.

		// 할인율 유무에 따라 최근 본 상품 페이지에 가격표시
		int price = 0;
		// 할인율이 있으면
		if (animalDetail.getA_discount_rate() != 0) {
			price = animalDetail.getA_price_sale();
			// 할인율이 없으면
		} else {
			price = animalDetail.getA_price_origin();
		}

		Cookie cook = new Cookie("item" + animalDetail.getA_code(), URLEncoder.encode(

				"<tr> <td> <a href='./AnimalDetail.an?a_code=" + animalDetail.getA_code()
						+ "'> <img src='./upload/multiupload/" + animalDetail.getA_thumbnail()
						+ "' width='150' height='150'></a> </td>" + "<td>" + animalDetail.getA_morph() + "</td>"
						+ "<td>" + price + "</td>"
						+ "<td> <select><option selected disabled>- [필수]배송방법을 선택해 주세요 -</option><option disabled> --------------- </option>"
						+ "<option> 일반포장 </option><option>퀵서비스(착불)</option><option>지하철택배(착불)</option>"
						+ "<option> 고속버스택배 (+14,000원) </option><option> 매장방문수령 </option></select> </td>"
						+ "<td> <input type='button' value='담기'><br> <input type='button' value='주문'><br> <input type='button' value='삭제'></td> </tr>",
				"UTF-8"));
		cook.setMaxAge(60 * 60); // 한시간 유지
		response.addCookie(cook);
	%>

	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>

	<!-- Main Content -->


	<div class="container">
		<!-- 상품 기본 정보 파트 ------------------------------------------------------------------------------------------ -->
		<div id="menu0" class="menu">
			<form action="" method="post" name="fr">
				<!-- hidden 값들(코드, 오리지날 판매가, 할인된 판매가, 할인율, 모프, 적립금  -->
				<input type="hidden" name="product_code"
					value="<%=animalDetail.getA_code()%>"> <input type="hidden"
					id="a_price_origin" name="a_price_origin"
					value="<%=animalDetail.getA_price_origin()%>"> <input
					type="hidden" id="a_price_sale" name="a_price_sale"
					value="<%=animalDetail.getA_price_sale()%>"> <input
					type="hidden" id="a_discount_rate" name="a_discount_rate"
					value="<%=animalDetail.getA_discount_rate()%>"> <input
					type="hidden" id="a_morph" name="a_morph"
					value="<%=animalDetail.getA_morph()%>"> <input
					type="hidden" id="a_mileage" name="a_mileage"
					value="<%=animalDetail.getA_mileage()%>">

				<!-- 사용자가 추가한 배송방법들의 value들을 모두 저장하는 input hidden -->
				<input type="hidden" id="selectedValues" name="selectedValues"
					value="">

				<!-- 사용자가 추가한 배송방법들의 수량들 예를 들어 일반배송의 수량(실시간으로 수정할수도 있으니)을 저장하는 input hidden -->
				<input type="hidden" id="selectedAmounts" name="selectedAmounts"
					value="">

				<div class="info_table">
					<div class="info_img">
						<img src="./upload/multiupload/<%=animalDetail.getA_thumbnail()%>"
							style="width: 100%">
					</div>
					<div class="info_desc">
						<!-- 종 이름 -->
						<%
							if (animalDetail.getA_amount() == 0) {
						%>
						<span> SOLD OUT </span>
						<h4>
							<%=animalDetail.getA_morph()%>
						</h4>
						<%
							} else {
						%>
						<h4>
							<%=animalDetail.getA_morph()%>
						</h4>
						<%
							}
						%>
						<!-- 판매가, 적립금, 할인판매가 -->
						<table class="detail_table">
							<tr class="detail_tr">
								<td class="detail_td">판매가</td>
								<td class="detail_td"><%=newformat_price_origin%>원 <%
									if (animalDetail.getA_discount_rate() != 0) {//만약 할인율이 있으면
								%> <%=animalDetail.getA_discount_rate()%>% OFF <%
 	}
 %></td>
							</tr>
							<tr class="detail_tr">
								<td class="detail_td">적립금</td>
								<td class="detail_td"><%=newformat_mileage%>원</td>
							</tr>
							<%
								if (animalDetail.getA_discount_rate() != 0) {//만약 할인율이 있으면
							%>
							<tr class="detail_tr">
								<td class="detail_td">할인판매가</td>
								<td class="detail_td"><%=newformat_price_sale%>원 (<%=animalDetail.getA_discount_rate()%>%
									할인율)</td>
							</tr>
							<%
								}
							%>
						</table>
						<!-- 배송방법 -->
						<div class="detail_select">
							<span class="detail_select_title">배송방법</span> <select
								class="detail_select_input" id="delivery_method"
								name="delivery_method" onchange="changeDeliMethod();">
								<option value="" selected disabled>-[필수]배송방법을 선택해 주세요 -
								</option>
								<option disabled>---------------</option>
								<option value="일반포장">일반포장</option>
								<option value="퀵서비스">퀵서비스(착불)</option>
								<option value="지하철">지하철택배(착불)</option>
								<option value="고속버스">고속버스택배 (+14,000원)</option>
								<option value="매장방문">매장방문수령</option>
							</select>
						</div>
						<!-- 옵션 선택시 상품 정보 및 구매정보 자동으로 올라가는 부분 -->
						<table class="selected_table">

							<colgroup>
								<col width="30%">
								<col width="40%">
								<col width="30%">
							</colgroup>
							<tr class="selected_tr selected_th">
								<td class="selected_td">상품명</td>
								<td class="selected_td">상품수</td>
								<td class="selected_td">가격</td>
							</tr>
							<!-- 옵션을 선택했을시 최종 상품 정보 나타내기 -->
							<tbody id="final_product_info_table"></tbody>

							<tr class="selected_tr">
								<td class="selected_td selected_td_last" colspan="3">TOTAL
									: <span id="final_total_price"></span>원 (<span
									id="final_total_amount"></span>개)
								</td>
							</tr>
						</table>
						<div class="btn_wrap">
							<div class="top_btn_wrap">
								<%
									if (animalDetail.getA_amount() == 0) {
								%>
								<span class="buy_btn"> 품절 </span>
								<button class="fav_btn" type="button">관심상품</button>
								<%
									} else {
								%>
								<button class="buy_btn" type="button"
									onclick="valueOrderChecked();">바로구매</button>
								<button class="buy_btn" type="button"
									onclick="valueBasketChecked();">장바구니</button>
								<button class="fav_btn" type="button">관심상품</button>
								<%
									}
								%>
							</div>
							<button class="kakao_btn" type="button" onclick="kakaoChat();">
								카카오톡 상담</button>
						</div>
					</div>
				</div>
			</form>
		</div>

		<br>
		<hr>


		<!-- 상품 관련 상품들 파트 ------------------------------------------------------------------------------------------ -->
		<div id="menu2" class="menu">
			<div>
				RECOMMEND ITEMS <br> 본 상품의 구매자 분들은 아래 상품들도 함께 구매하셨습니다.
			</div>
		</div>

		<br>
		<hr>

		<!-- 상품 상세 정보 파트 ------------------------------------------------------------------------------------------ -->
		<div id="menu1" class="menu">
			<!-- 소메뉴 -->
			<div class="move_wrap">
				<ul class="move_ul">
					<li class="move_list"><button class="move_btn"
							onclick="menuMove('0')">기본 정보</button></li>
					<li class="move_list"><button class="move_btn"
							onclick="menuMove('1')">디테일 정보</button></li>
					<li class="move_list"><button class="move_btn"
							onclick="menuMove('2')">추천 상품</button></li>
					<li class="move_list"><button class="move_btn"
							onclick="menuMove('3')">REVIEW</button></li>
					<li class="move_list"><button class="move_btn"
							onclick="menuMove('4')">Q & A</button></li>
				</ul>
			</div>

			<div class="info_detail">
				<%=animalDetail.getContent()%>
			</div>
		</div>

		<br>
		<hr>

		<!-- 상품 REVIEW 파트 -------------------------------------------------------------------------------------------->
		<div id="menu3" class="menu">
			<!-- 소메뉴 -->
			<div class="move_wrap">
				<ul class="move_ul">
					<li class="move_list"><button class="move_btn"
							onclick="menuMove('0')">기본 정보</button></li>
					<li class="move_list"><button class="move_btn"
							onclick="menuMove('1')">디테일 정보</button></li>
					<li class="move_list"><button class="move_btn"
							onclick="menuMove('2')">추천 상품</button></li>
					<li class="move_list"><button class="move_btn"
							onclick="menuMove('3')">REVIEW</button></li>
					<li class="move_list"><button class="move_btn"
							onclick="menuMove('4')">Q & A</button></li>
				</ul>
			</div>

			REVIEW <br> 상품의 사용후기를 적어주세요.

			<%
				BoardDAO bdao = new BoardDAO();
				List<BoardDTO> bList = bdao.getPList(1, animalDetail.getA_code());
			%>

			<table class="board_wrap">
				<colgroup>
					<col width="10%">
					<col width="40%">
					<col width="40%">
					<col width="10%">
				</colgroup>
				<tr class="board_tr">
					<th>글쓴이</th>
					<th>제목</th>
					<th>작성일자</th>
					<th>조회수</th>
				</tr>
				<%
					if (bList.size() > 0) {
						for (BoardDTO dto : bList) {
				%>
				<tr class="board_tr">
					<td><%=dto.getB_writer()%></td>
					<td><%=dto.getB_title()%></td>
					<td><%=dto.getB_reg_date()%></td>
					<td><%=dto.getB_view()%></td>
				</tr>
				<%
					}
					} else {
				%>
				<tr class="board_tr">
					<td colspan='4'>작성된 글이 없습니다.</td>
				</tr>
				<%
					}
				%>
			</table>
			<button type="button"
				onclick="location.href='./Insert.bo?C=1&CODE=<%=animalDetail.getA_code()%>'">
				리뷰작성</button>
			<button type="button">모두보기</button>
		</div>

		<br>
		<hr>

		<!-- 상품 Q&A 파트 ------------------------------------------------------------------------------------------ -->
		<div id="menu4" class="menu">
			<!-- 소메뉴 -->
			<div class="move_wrap">
				<ul class="move_ul">
					<li class="move_list">
						<button class="move_btn" onclick="menuMove('0')">기본 정보</button>
					</li>
					<li class="move_list">
						<button class="move_btn" onclick="menuMove('1')">디테일 정보</button>
					</li>
					<li class="move_list">
						<button class="move_btn" onclick="menuMove('2')">추천 상품</button>
					</li>
					<li class="move_list">
						<button class="move_btn" onclick="menuMove('3')">REVIEW</button>
					</li>
					<li class="move_list">
						<button class="move_btn" onclick="menuMove('4')">Q & A</button>
					</li>
				</ul>
			</div>

			Q & A <br> 상품에 대해 궁금한 점을 해결해 드립니다.

			<%
				bList = bdao.getPList(2, animalDetail.getA_code());
				bdao.closeDB();
			%>

			<table class="board_wrap">
				<colgroup>
					<col width="10%">
					<col width="40%">
					<col width="40%">
					<col width="10%">
				</colgroup>
				<tr class="board_tr">
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
				<%
					if (bList.size() > 0) {
						for (BoardDTO dto : bList) {
				%>
				<tr class="board_tr">
					<td><%=dto.getB_title()%></td>
					<td><%=dto.getB_writer()%></td>
					<td><%=dto.getB_reg_date()%></td>
					<td><%=dto.getB_view()%></td>
				</tr>

				<%
					}
					} else {
				%>
				<tr class="board_tr">
					<td colspan="4">작성된 글이 없습니다.</td>
				</tr>
				<%
					}
				%>
			</table>
			<button type="button"
				onclick="location.href='./Insert.bo?C=2&CODE=<%=animalDetail.getA_code()%>'">상품문의하기</button>
			<button type="button">모두보기</button>
		</div>

	</div>

	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp" /> </footer>

</body>
<script type="text/javascript">

	//사용자가 배송방법을 선택했을시------------------------------------------------------------------------------
	
	var total_price; //추가되는 tr의 총 판매가
	var final_total_price = 0; //최종 total 판매가 계산하기 위한 변수
	var final_total_amount = 0; //최종 total 수량 계산하기 위한 변수
	
	var count = 0; //사용자가 배송방법을 추가하거나 없앨때 늘어나고 줄어드는 변수
	
	var selectedValues = ""; //사용자가 선택한 배송방법들을 차례대로 담는 변수
	
	var selectedAmounts = ""; //사용자가 선택한 배송방법의 수량들을 차례대로 담는 변수
	
	var selectedArray = new Array(); //사용자가 선택한 배송방법들을 담기 위한 Array 

	function changeDeliMethod(){
		
		var delivery_method = document.getElementById('delivery_method').value;	//배송방법
		
		var a_morph = document.getElementById('a_morph').value;					//모프
		var a_price_origin = document.getElementById('a_price_origin').value;	//오리지날 판매가
		var a_discount_rate = document.getElementById('a_discount_rate').value;	//할인율
		var a_price_sale = document.getElementById('a_price_sale').value;		//할인된 판매가
		
		//만약 배송방법을 고속버스로 추가하면 판매가격에 +14000 추가한 값 저장하기
		if(delivery_method == '고속버스'){
			//할인율이 있으면
			if(a_discount_rate != 0){
				a_price_sale_option = parseInt(a_price_sale) + parseInt(14000);
			}
			//없으면
			else{
				a_price_origin_option = parseInt(a_price_origin) + parseInt(14000);
			}	
		}
		//만약 고속버스가 아니면 원판매가 그대로 a_price_sale_option에 저장
		else{
			//할인율이 있으면
			if(a_discount_rate != 0){
				a_price_sale_option = parseInt(a_price_sale);
			}
			//없으면
			else{
				a_price_origin_option = parseInt(a_price_origin);
			}
		}
		
		var a_mileage = document.getElementById('a_mileage').value;		//적립금
		
		var objRow;
		objRow = document.all["final_product_info_table"].insertRow();
		objRow.className = 'delivery_list';
		
		//사용자가 올바른 배송방법을 선택 하지 않았을시
		if(delivery_method == null){
			document.getElementById("final_product_info_table").style.display = "none";
		}
		//사용자가 올바른 배송방법을 선택했을시 새로운 cell 추가하기
		else {
			//모프 - 첫번째 td(cell) 항목
			var objCell_morph = objRow.insertCell();
			objCell_morph.className='selected_td';
			objCell_morph.innerHTML = "<span id='objCell_morph' class='a_morph'>" + a_morph + "</span> <br>" + "<span id='delivery_method_option'>[옵션:" + delivery_method + "]</span>";
			
			//상품수 - 두번째 td(cell) 항목
			var objCell_amount = objRow.insertCell();
			objCell_amount.className='selected_td';
			objCell_amount.innerHTML = "<input type='text' class='a_amount' id='a_amount_" + delivery_method + "' name='a_amount_" + delivery_method + "' value='1' maxlength='3' size='3' >" 
										+ "<input type='button' class='a_amount_btn' id='amountPlus' name='amountPlus' value='+' onclick='plus(" + "\"" + delivery_method + "\"" + ");'>" 
										+ "<input type='button' class='a_amount_btn' id='amountMinus' name='amountMinus' value='-' onclick='minus(" + "\"" + delivery_method + "\"" + ");'>"
										+ "<input type='button' class='a_amount_btn' id='deleteCell' name='deleteCell' value='x' onclick='delCell(this, " + "\"" + delivery_method + "\"" + ");'>";		
			
			//가격, 적립금 - 세번째 td(cell) 항목
			var objCell_price = objRow.insertCell();
			objCell_price.className='selected_td';
				//만약 적립금이 0이 아니면
				if(a_discount_rate != 0){
					objCell_price.innerHTML = "<span id='total_product_price_" + delivery_method + "' >" 
											+ a_price_sale_option.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원 </span> <br>" 
											+ "(적 " + "<span id='total_product_mileage_" + delivery_method + "'>" + a_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</span>" + ")"
											+ "<input type='hidden' id='total_product_price_" + delivery_method + "_input" + "' name='total_product_price_" + delivery_method + "_input' value=" + a_price_sale_option + ">";
				}
				//만약 적립금이 0이면
				else{
					objCell_price.innerHTML = "<span id='total_product_price_" + delivery_method + "'>" 
											+ a_price_origin_option.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원 </span> <br>" 
											+ "(적 " + "<span id='total_product_mileage_" + delivery_method + "'>" + a_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</span>" + ")"
											+ "<input type='hidden' id='total_product_price_" + delivery_method + "_input" + "' name='total_product_price_" + delivery_method + "_input' value=" + a_price_origin_option + ">";
				}
		}
		
		//select option 태그안에 사용자가 선택한 배송방법 비활성화 시키기
		$("select option[value*='"+ delivery_method +"']").attr('disabled',true);
		
		//final_total_price 태그 제어
		total_price = $('#total_product_price_' + delivery_method + '_input').val(); //하나의 tr(배송)의 총 판매가
		
		//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 저장하기, 만약 처음이면 0에 추가하기
		final_total_price += Number(total_price);
		//태그에 추가하기
		$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
		
		//final_total_amount 태그 제어
		total_amount = $('#a_amount_' + delivery_method).val(); //하나의 tr(배송)의 총 수량
		final_total_amount += Number(total_amount);
		//태그에 추가하기
		$('#final_total_amount').text(final_total_amount);
		
		//사용자가 select option 에서 selected 한 값  input hidden value에 차례대로 넣기
		 selectedValues += (delivery_method + ",");
		//추가된 values 변수를 태그에 담기
		$("#selectedValues").val(selectedValues);
		
		count += Number("1");
		
		//추가된 배송방법 selectedArray에 추가하기
		selectedArray.push(delivery_method);
		
		//----- 키보드로 주문수량 변경시 모든 옵션의 총 수량 제어 ---------------------------------------------------
		
		//사용자가 수량 input 태그에 마우스를 클릭했을시 입력되어있던 수량을 저장하기
 		$('#a_amount_' + delivery_method).on('focusin', function(){
			//console.log("저장된 value : " + $(this).val());
			
			//사용자가 키보드로 입력하기 전 수량
			$(this).data('val', $(this).val()); 
 		});
		
		//사용자가 수량 input 태그에 키보드로 새로운 수량을 입력했을시
		$('#a_amount_' + delivery_method).on('change', function(){

			//만약 배송방법을 고속버스로 추가하면 판매가격에 +14000 추가한 값 저장하기
			if(delivery_method == '고속버스'){
				//할인율이 있으면
				if(a_discount_rate != 0){
					a_price_sale_option = parseInt(a_price_sale) + parseInt(14000);
				}
				//없으면
				else{
					a_price_origin_option = parseInt(a_price_origin) + parseInt(14000);
				}	
			}
			//만약 고속버스가 아니면 원판매가 그대로 a_price_sale_option에 저장
			else{
				//할인율이 있으면
				if(a_discount_rate != 0){
					a_price_sale_option = parseInt(a_price_sale);
				}
				//없으면
				else{
					a_price_origin_option = parseInt(a_price_origin);
				}
			}
			
			final_total_amount = document.getElementById('final_total_amount').innerHTML; //총 수량 (span 태그 안에 있는 값) 가져오기
			final_total_amount = Number(final_total_amount); //문자열을 숫자로 형변환
			
			var previousAmount = $(this).data('val'); 	//사용자가 키보드로 입력하기 전 수량
		    var currentAmount = $(this).val();			//사용자가 키보드로 입력 한 수량

			//사용자가 키보드로 input에 0보다 작은수를 입력했을시
			if(currentAmount < 1) {
				alert("상품의 최소 구매량은 1개입니다.");
				currentAmount = parseInt("1");
				$("#a_amount_" + delivery_method).val(currentAmount);
			} else{
				//변경 전 수량이 변경 후 수량보다 클때
			   	if(previousAmount > currentAmount){
			   		//final_total_amount 태그 제어
					final_total_amount -= (previousAmount - currentAmount);

					//만약 할인율이 0이 아니면
			   		if(a_discount_rate != 0){
			   			
			   			//각 tr의 총 가격 span 태그에 값 넣기
			   			total_price = Number(a_price_sale_option * currentAmount); 
						document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
						
						//최종 마일리지 계산하기 
						final_mileage = a_mileage * currentAmount;
						//계산된 마일리지 span 태그에 넣기
						document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
						
						//final_total_price 태그 제어
			   			final_total_price -= (a_price_sale * (previousAmount - currentAmount));
			   		}
			   		//할인율이 0이면
			   		else{
			   			
			   			//각 tr의 총 가격 span 태그에 값 넣기
			   			total_price = Number(a_price_origin_option * currentAmount); 
						document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
						
						//최종 마일리지 계산하기 
						final_mileage = a_mileage * currentAmount;
						//계산된 마일리지 span 태그에 넣기
						document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			   			
			   			//final_total_price 태그 제어
			   			final_total_price -= (a_price_origin * (previousAmount - currentAmount));
			   		}
			   	} 
			   	//변경 전 수량이 변경 후 수량보다 작을때
			   	else if(previousAmount < currentAmount) {
			   		//final_total_amount 태그 제어
					final_total_amount += (currentAmount - previousAmount);
					
			   		//만약 할인율이 0이 아니면
			   		if(a_discount_rate != 0){
			   			
			   			//각 tr의 총 가격 span 태그에 값 넣기
			   			total_price = Number(a_price_sale_option * currentAmount); 
						document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
						
						//최종 마일리지 계산하기 
						final_mileage = a_mileage * currentAmount;
						//계산된 마일리지 span 태그에 넣기
						document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			   			
			   			//final_total_price 태그 제어
						final_total_price += (a_price_sale * (currentAmount - previousAmount)); 			
			   		}
			   		//할인율이 0이면
			   		else{
			   			
			   			//각 tr의 총 가격 span 태그에 값 넣기
			   			total_price = Number(a_price_origin_option * currentAmount); 
						document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
						
						//최종 마일리지 계산하기 
						final_mileage = a_mileage * currentAmount;
						//계산된 마일리지 span 태그에 넣기
						document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			   			
			   			//final_total_price 태그 제어
			   			final_total_price += (a_price_origin * (currentAmount - previousAmount));
			   		}
			   	}
			}
		    
			//태그에 추가하기
			$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			$('#final_total_amount').text(final_total_amount);
    
		});
	}

	//주문수량 변경시----------------------------------------------------------------------------------------
	
	var delivery_method = document.getElementById('delivery_method').value;	//배송방법
	
	var a_price_origin = document.getElementById('a_price_origin').value;	//오리지날 판매가
	var a_discount_rate = document.getElementById('a_discount_rate').value;	//할인율
	var a_price_sale = document.getElementById('a_price_sale').value;		//할인된 판매가
	var a_mileage = document.getElementById('a_mileage').value;				//적립금

	//사용자가 '+'를 눌렸을시
	function plus(delivery_method){
		
		var total_price = Number($('#total_product_price_' + delivery_method + '_input').val()); //하나의 tr(배송)의 총 판매가 String -> Int 형변환

		//delivery_method 인수로 들어온 값에 따라 new_a_amount 값 바꾸기
		var new_a_amount = document.getElementById('a_amount_' + delivery_method).value;	//사용자가 새로 수정하는 수량

		//사용자가 수량 999에서 +를 눌렸을시
		if(new_a_amount == 999) {
			alert("상품의 최대 구매량은 999개입니다.");
			new_a_amount = parseInt("999");
			$("#a_amount_" + delivery_method).val(new_a_amount);
		}else {
			new_a_amount++;
			$("#a_amount_" + delivery_method).val(new_a_amount);
			
			//final_total_amount 태그 제어
			final_total_amount += Number("1");
			$('#final_total_amount').text(final_total_amount);
			
			//만약 할인율(a_discount_rate)이 0이 아니면
			if(a_discount_rate != 0) {

				//계산된 값 span 태그에 넣기
				total_price += Number(a_price_sale);
				
				//각 tr의 총 가격 span 태그에 값 넣기
				document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				//input hidden 값에 수정된 총 가격 넣기
				$('#total_product_price_' + delivery_method + "_input").val(total_price);
				
				//최종 마일리지 계산하기 
				final_mileage = a_mileage * new_a_amount;
				//계산된 마일리지 span 태그에 넣기
				document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
				//final_total_price 태그 제어
				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 저장하기, 만약 처음이면 0에 추가하기
				final_total_price += Number(a_price_sale);
				//태그에 추가하기
				$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			}
			//할인율이 0이면
			else{
				
				//계산된 값 span 태그에 넣기
				total_price += Number(a_price_origin);
				
				//각 tr의 총 가격 span 태그에 값 넣기
				document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				//input hidden 값에 수정된 총 가격 넣기
				$('#total_product_price_' + delivery_method + "_input").val(total_price);	
				
				//최종 마일리지 계산하기 
				final_mileage = a_mileage * new_a_amount;
				//계산된 마일리지 span 태그에 넣기
				document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
				//final_total_price 태그 제어
				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 저장하기, 만약 처음이면 0에 추가하기
				final_total_price += Number(a_price_origin);
				//태그에 추가하기
				$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			}
		}
	}
	
	//사용자가 '-'를 눌렸을시
	function minus(delivery_method){
		
		var total_price = Number($('#total_product_price_' + delivery_method + "_input").val()); //하나의 tr(배송)의 총 판매가 String -> Int 형변환

		//delivery_method 인수로 들어온 값에 따라 new_a_amount 값 바꾸기
		var new_a_amount = document.getElementById('a_amount_' + delivery_method).value;	//사용자가 새로 수정하는 수량	
		
		//사용자가 수량 1에서 -를 눌렸을시
		if(new_a_amount == 1) {
			alert("상품의 최소 구매량은 1개입니다.");
			new_a_amount = parseInt("1");
			$("#a_amount_" + delivery_method).val(new_a_amount);
		}else {
			new_a_amount--;
			$("#a_amount_" + delivery_method).val(new_a_amount);
			
			//final_total_amount 태그 제어
			final_total_amount -= Number("1");
			$('#final_total_amount').text(final_total_amount);
			
			//만약 할인율(a_discount_rate)이 0이 아니면
			if(a_discount_rate != 0) {
				
				//계산된 값 span 태그에 넣기
				total_price -= Number(a_price_sale);
				
				//각 tr의 총 가격 span 태그에 값 넣기
				document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				//input hidden 값에 수정된 총 가격 넣기
				$('#total_product_price_' + delivery_method + "_input").val(total_price);
				
				//최종 마일리지 계산하기 
				final_mileage = a_mileage * new_a_amount;
				//계산된 마일리지 span 태그에 넣기
				document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
				//final_total_price 태그 제어
				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 빼고나서 저장하기
				final_total_price -= Number(a_price_sale);
				//태그에 추가하기
				$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			}
			//할인율이 0이면
			else{
				
				//계산된 값 span 태그에 넣기
				total_price -= Number(a_price_origin);
				
				//각 tr의 총 가격 span 태그에 값 넣기
				document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				//input hidden 값에 수정된 총 가격 넣기
				$('#total_product_price_' + delivery_method + "_input").val(total_price);
				
				//최종 마일리지 계산하기 
				final_mileage = a_mileage * new_a_amount;
				//계산된 마일리지 span 태그에 넣기
				document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
				//final_total_price 태그 제어
				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 빼고나서 저장하기
				final_total_price -= Number(a_price_origin);
				//태그에 추가하기
				$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			}
		}
	}
	
	//사용자가 상품정보를 제거했을시
	function delCell(obj, delivery_method){
		
		var total_price = Number($('#total_product_price_' + delivery_method + "_input").val()); //하나의 tr(배송)의 총 판매가 String -> Int 형변환
		
		//만약 할인율(a_discount_rate)이 0이 아니면
		if(a_discount_rate != 0) {
		
			//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 빼고나서 저장하기
			final_total_price -= Number(total_price);
			//태그에 추가하기
			$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			
			//delivery_method 인수로 들어온 값에 따라 new_a_amount 값 바꾸기
			var new_a_amount = document.getElementById('a_amount_' + delivery_method).value;	//사용자가 새로 수정하는 수량
			
			//final_total_amount 태그 제어
			final_total_amount -= Number(new_a_amount);
			$('#final_total_amount').text(final_total_amount);
			
			//현재 위치에서 부모태그의 부모태그(현재 span -> td -> tr) 없애기
			$(obj).parent().parent().remove();
			
			//select option 태그안에 사용자가 선택한 배송방법 활성화 시키기
			$("select option[value*='"+ delivery_method +"']").removeAttr('disabled');
		}
		//할인율이 0이면
		else {
			//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 빼고나서 저장하기
			final_total_price -= Number(total_price);
			//태그에 추가하기
			$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			
			//delivery_method 인수로 들어온 값에 따라 new_a_amount 값 바꾸기
			var new_a_amount = document.getElementById('a_amount_' + delivery_method).value;	//사용자가 새로 수정하는 수량
			
			//final_total_amount 태그 제어
			final_total_amount -= Number(new_a_amount);
			$('#final_total_amount').text(final_total_amount);
			
			//현재 위치에서 부모태그의 부모태그(현재 span -> td -> tr) 없애기
			$(obj).parent().parent().remove();
			
			//select option 태그안에 사용자가 선택한 배송방법 활성화 시키기
			$("select option[value*='"+ delivery_method +"']").removeAttr('disabled');			
		}
		
		count -= Number("1");
		
		//selectedArray에 삭제하고 싶은 배송방법을 삭제하기
		selectedArray.splice(selectedArray.indexOf(delivery_method),1);
	}

	
	//구매하기, 장바구니 버튼 눌렸을시 ------------------------------------------------------------------------------------

	//장바구니 버튼을 클릭했을시
	function valueBasketChecked() {
		//만약 배송방법을 선택하지 않았다면
		if(document.getElementById("delivery_method").value == ""){
			alert("배송옵션을 선턱해주세요");
			document.fr.delivery_method.focus();
			return false;
		}
		//배송방법을 선택했을시
		else {
					
			for(var i=0; i<count; i++){
				//selectedArray[i] -> 선택된 배송방법의 value들
				selectedAmounts += ($('#a_amount_' + selectedArray[i]).val() + ",")
			}
			
			//추가된 values 변수를 태그에 담기
			$("#selectedAmounts").val(selectedAmounts);
			
			document.fr.action="./BasketAdd.ba";
			document.fr.submit();
			
			var goBasket = confirm("장바구니에 담겼습니다. \n장바구니로 이동하시겠습니까?");
			if(goBasket){
				location.href="./BasketList.ba";
			}else if(!goBasket){
				window.location.reload(); //현재 페이지 새로고침
			}
			
		}
	}
	
	//구매하기 버튼을 클릭했을시
	function valueOrderChecked() {
		//만약 배송방법을 선택하지 않았다면
		if(document.getElementById("delivery_method").value == ""){
			alert("배송옵션을 선턱해주세요");
			document.fr.delivery_method.focus();
			return false;
		}
		//배송방법을 선택했을시
		else {
			var isBasket = confirm("구매하시겠습니까?");
			if(isBasket) {
				document.fr.action="";
				document.fr.submit();
			} else {
				return false;
			}
		}
	}
	
	//소메뉴 눌렸을시 ------------------------------------------------------------------------------------
	
	//소메뉴에서 클릭했을시 특정 div로 스크롤 이동시키는 함수 ex) 기본 정보 눌렸을시 기본정보div로 이동하기
	function menuMove(seq){
        var offset = $("#menu" + seq).offset();
        $('html, body').animate({scrollTop : offset.top}, 300);
    }
			
	// 카카오 채팅 상담 -----------------------------------------------------------------------------------
	function kakaoChat() {
		var popupX = (window.screen.width / 6) - (200 / 2); 
		var popupY = (window.screen.height / 4) - (300 / 2);  
		window.open('https://pf.kakao.com/_iLxlxexb','windows','width=600,height=670,left='+popupX+',top='+popupY+',scrollbars=yes');
	}

</script>
</html>