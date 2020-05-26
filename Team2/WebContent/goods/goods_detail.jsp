<%@page import="team2.board.db.BoardDTO"%>
<%@page import="team2.board.db.BoardDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="team2.goods.db.GoodsDTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/product_detail.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<title>Insert title here</title>
</head>
<body>

	<%
		String id = (String) session.getAttribute("id");
		if (id == null) {
			id = "";
		}

		// GoodsDetailAction 객체에서 저장된 정보를 저장
		List<GoodsDTO> detailList = (List<GoodsDTO>) request.getAttribute("detailList");

		int g_amount = (int) request.getAttribute("g_amount");

		//###,###,###원 표기하기 위해서 format 바꾸기
		DecimalFormat formatter = new DecimalFormat("#,###,###,###");
		String newformat_price_origin = formatter.format(detailList.get(0).getG_price_origin());
		String newformat_mileage = formatter.format(detailList.get(0).getG_mileage());
		String newformat_price_sale = formatter.format(detailList.get(0).getG_price_sale());

		// 할인율 유무에 따라 최근 본 상품 페이지에 가격표시
		String price = "";
		// 할인율이 있으면
		if (detailList.get(0).getG_discount_rate()!= 0) {
			price = "<span style='text-decoration: line-through; color: gray; font-size: 14px;'>"+newformat_price_origin+"원</span>"
					+ "<span style='color: black; font-size: 14px;'>"+newformat_price_sale+"원</span>"
					+ "<span style='color: red; font-size: 14px;'>"+detailList.get(0).getG_discount_rate()+"%</span>";
			
			// 할인율이 없으면
		} else {
			price = "<span style='color: black; font-size: 14px;'>"+newformat_price_origin+"원</span>"
					+ "<span style='color: red; font-size: 14px;'>"+detailList.get(0).getG_discount_rate()+"%</span>";
		}
		
		int price1 = 0;
		// 할인율이 있으면
		if (detailList.get(0).getG_discount_rate() != 0) {
			price1 = detailList.get(0).getG_price_sale();
			// 할인율이 없으면
		} else {
			price1 = detailList.get(0).getG_price_origin();
		}
		
		Cookie cook = new Cookie("item" + detailList.get(0).getG_code(),
				URLEncoder.encode(
						"<li><input type='checkbox' class='chkBox' id='chkBox' name='chkBox' style='display: none;'>" 
						+"<div class='div_info1'>"
						+"<a href='./GoodsDetail.go?g_code="+detailList.get(0).getG_code()+"'><img src='./upload/multiupload/"+detailList.get(0).getG_thumbnail()+"' width='100' height='100'></a>"
						+"</div>"
						+"<div class='div_info div_wish'>"
						+"<a href='./GoodsDetail.go?g_code="+detailList.get(0).getG_code()+"' class='name'>"+detailList.get(0).getG_name()+"</a> <br>"
						+"<div class='price'>"
						+price
						+"</div>"
						+"</div></li>"
						,
						"UTF-8"));
		cook.setMaxAge(60 * 60); // 한시간 유지
		response.addCookie(cook);
		
		Cookie cook1 = new Cookie("cookie" + detailList.get(0).getG_code(),
				URLEncoder.encode(
						"<tr> <td> <a href='./GoodsDetail.go?g_code=" + detailList.get(0).getG_code()
								+ "'> <img src='./upload/multiupload/" + detailList.get(0).getG_thumbnail()
								+ "' width='150' height='150'></a> </td>" + "<td>" + detailList.get(0).getG_name()
								+ "</td>" + "<td>" + price1 + "원</td>"
								+ "<td>"+detailList.get(0).getG_mileage()+"</td>"
								+ "<td><a 'recent_a' href='./GoodsDetail.go?g_code="+detailList.get(0).getG_code()+"'>상품 보러가기</a></td> </tr>",
						"UTF-8"));
		cook1.setMaxAge(60 * 60); // 한시간 유지
		response.addCookie(cook1);
		
	%>

	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>

	<!-- Main Content -->

	<div class="container">
		<input type="hidden" id="id" name="id" value="<%=id%>">
		<!-- 상품 기본 정보 파트 -->
		<div id="menu0" class="menu">
			<form action="" method="post" name="fr">

				<!-- hidden 값들(코드, 오리지날 판매가, 할인된 판매가, 할인율  -->
				<input type="hidden" id="product_code" name="product_code" value="<%=detailList.get(0).getG_code()%>"> 
				<input type="hidden" id="g_price_origin" name="g_price_origin" value="<%=detailList.get(0).getG_price_origin()%>"> 
				<input type="hidden" id="g_price_sale" name="g_price_sale" value="<%=detailList.get(0).getG_price_sale()%>"> 
				<input type="hidden" id="g_discount_rate" name="g_discount_rate" value="<%=detailList.get(0).getG_discount_rate()%>"> 
				<input type="hidden" id="g_mileage" name="g_mileage" value="<%=detailList.get(0).getG_mileage()%>"> 
				<input type="hidden" id="g_name" name="g_name" value="<%=detailList.get(0).getG_name()%>"> 
				<input type="hidden" id="g_delivery" name="g_delivery" value="<%=detailList.get(0).getG_delivery()%>"> 
				<input type="hidden" id="g_option" name="g_option" value="<%=detailList.get(0).getG_option()%>">
				<input type="hidden" name="num" value="<%=detailList.get(0).getNum()%>">
					


				<!-- 사용자가 추가한 배송방법들의 value들을 모두 저장하는 input hidden -->
				<input type="hidden" id="selectedValues" name="selectedValues"
					value="">
				<!-- 사용자가 추가한 배송방법들의 수량들을 저장하는 input hidden -->
				<input type="hidden" id="selectedAmounts" name="selectedAmounts"
					value="">
				<!-- 사용자가 추가한 옵션들을 모두 저장하는 input hidden -->
				<input type="hidden" id="selectedOptions" name="selectedOptions"
					value="">

				<div class="info_table">
					<div class="info_img">
						<img
							src="./upload/multiupload/<%=detailList.get(0).getG_thumbnail()%>"
							width="500" height="500">
					</div>

					<div class="info_desc">
						<!-- 상품명 -->
						<%
							if (g_amount == 0) {
						%>
						<span> SOLD OUT </span>
						<h4>
							<%=detailList.get(0).getG_name()%>
						</h4>
						<%
							} else {
						%>
						<h4>
							<%=detailList.get(0).getG_name()%>
						</h4>
						<%
							}
						%>



						<!-- 판매가, 적립금, 할인판매가 -->
						<table class="detail_table">
							<tr class="detail_tr">
								<td class="detail_td">판매가</td>
								<td class="detail_td"><%=newformat_price_origin%>원 <%
									if (detailList.get(0).getG_discount_rate() != 0) { //할인율 있으면
								%>
									<%=detailList.get(0).getG_discount_rate()%>% OFF <%
										}
									%></td>
							</tr>

							<tr class="detail_tr">
								<td class="detail_td">적립금</td>
								<td class="detail_td"><%=newformat_mileage%>원</td>
							</tr>

							<%
								if (detailList.get(0).getG_discount_rate() != 0) { //할인율 있으면
							%>
							<tr class="detail_tr">
								<td class="detail_td">할인판매가</td>
								<td class="detail_td"><%=newformat_price_sale%>원 (<%=detailList.get(0).getG_discount_rate()%>%
									할인율)</td>
							</tr>
							<%
								}
							%>
						</table>




						<!-- 배송(일반포장, 선택배송) 구분 -->

						<%
							if (detailList.get(0).getG_delivery().equals("일반포장") && detailList.get(0).getG_option().equals("")) {
						%>
						<!-- 일반포장이고 옵션이 없는 경우 -------------------------------------------->
						<table class="selected_table">

							<colgroup>
								<col width="30%">
								<col width="40%">
								<col width="30%">
							</colgroup>

							<!-- 옵션 선택시 상품 정보 및 구매정보 자동으로 올라가는 부분 -->
							<tr class="selected_tr selected_th">
								<td class="selected_td">상품명</td>
								<td class="selected_td">상품수</td>
								<td class="selected_td">가격</td>
							</tr>
							<!-- 옵션이 default이 아니면 최종 상품 정보 나타내기 -->
							<!-- <tbody id="final_product_info_table"></tbody> -->
							<%
								for (int i = 0; i < detailList.size(); i++) {
										GoodsDTO goodsDetail = (GoodsDTO) detailList.get(i);
							%>
							<tr class="delivery_list">
								<input type="hidden" id="delivery_method" name="delivery_method"
									value="<%=goodsDetail.getG_delivery()%>">

								<td class="selected_td"><%=goodsDetail.getG_name()%></td>
								<!-- 상품 수량 -->
								<td class="selected_td">
									<input type="text" id="g_amount_<%=goodsDetail.getG_delivery()%>"
									name="g_amount_<%=goodsDetail.getG_delivery()%>" value=1
									maxlength="3" size="3" >
									<input type="button" class='g_amount_btn' id="amountPlus" name="amountPlus" value="+"
									onclick='plus("<%=goodsDetail.getG_delivery()%>");'> 
									<input type="button" class='g_amount_btn' id="amountMinus" name="amountMinus" value="-"
									onclick='minus("<%=goodsDetail.getG_delivery()%>");'>
								</td>
								<!-- 상품 판매가(할인율 있을때와 없을때와 -->
								<%
									if (goodsDetail.getG_discount_rate() != 0) {
								%>
								<td class="selected_td"><span
									id="total_product_price_<%=goodsDetail.getG_delivery()%>"><%=formatter.format(goodsDetail.getG_price_sale())%>원</span>
									<br> (적 <span
									id="total_product_mileage_<%=goodsDetail.getG_delivery()%>"><%=formatter.format(goodsDetail.getG_mileage())%>원</span>)
								</td>
								<input type="hidden"
									id="total_product_price_<%=goodsDetail.getG_delivery()%>_input"
									value="<%=goodsDetail.getG_price_sale()%>">

								<%
									} else { // 할인율 없을 때
								%>
								<td class="selected_td"><span
									id="total_product_price_<%=goodsDetail.getG_delivery()%>"><%=formatter.format(goodsDetail.getG_price_origin())%>원</span>
									<br> (적 <span
									id="total_product_mileage_<%=goodsDetail.getG_delivery()%>"><%=formatter.format(goodsDetail.getG_mileage())%>원</span>)
								</td>
								<input type="hidden"
									id="total_product_price_<%=goodsDetail.getG_delivery()%>_input"
									value="<%=goodsDetail.getG_price_origin()%>">

								<%
									}
								%>
							</tr>

							<%
								if (goodsDetail.getG_discount_rate() != 0) {
							%>
							<tr class="selected_tr">
								<td class="selected_td selected_td_last" colspan="3">TOTAL
									: <span id="final_total_price_normal"><%=formatter.format(goodsDetail.getG_price_sale())%></span>원
									(<span id="final_total_amount_normal">1</span>개)
								</td>
							</tr>
							<%
								} else {
							%>
							<tr class="selected_tr">
								<td class="selected_td selected_td_last" colspan="3">TOTAL
									: <span id="final_total_price_normal"><%=formatter.format(goodsDetail.getG_price_origin())%></span>원
									(<span id="final_total_amount_normal">1</span>개)
								</td>
							</tr>
							<%
								}
							%>

							<%
								} // for문 닫기
							%>
						</table>


						<%
							} else if (!detailList.get(0).getG_option().equals("")) {
						%>
						<!-- 일반포장이고 옵션이 있는 경우 --------------------------------------------->
						<!-- 옵션을 셀렉트박스로 가져오기 -->
						<div class="detail_select" id="detail_select_option">
							<span class="detail_select_title">옵션선택 </span>
							<!-- 상품 옵션값들 나타내기 -->
							<select id="option_method" name="option_method"
								onchange="changeOptionMethod();">
								<option value="" selected disabled>-[필수] 선택하시오-</option>
								<option disabled>------------------------------</option>
								<c:forEach var="detailList" items="${detailList}">
									<c:if test="${detailList.g_amount eq 0}">
										<option value="${detailList.g_option}" disabled>
											${detailList.g_option}
											<c:if test="${detailList.g_option_price ne 0}">
					        			    (+ ${detailList.g_option_price} 원)
					        			</c:if> [품절]
										</option>
									</c:if>

									<c:if test="${detailList.g_amount ne 0}">
										<option value="${detailList.g_option}">
											${detailList.g_option}
											<c:if test="${detailList.g_option_price ne 0}">
						        			    (+ ${detailList.g_option_price} 원)
						        			</c:if>
										</option>
									</c:if>
								</c:forEach>
							</select>
						</div>
						<%
							for (int i = 0; i < detailList.size(); i++) {
									GoodsDTO gdto = detailList.get(i);
						%>
						<input type="hidden" id="option_price_<%=gdto.getG_option()%>"
							name="option_price_<%=gdto.getG_option()%>"
							value="<%=gdto.getG_option_price()%>">
						<%
							} //추가가격 히든값으로 가져가기
						%>

						<!-- 옵션 선택 시, 주문현황 나오게 하기 -->
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
							<tbody id="final_product_info_table_option"></tbody>

							<tr class="selected_tr">
								<td class="selected_td selected_td_last" colspan="3">TOTAL
									: <span id="final_total_price"></span>원 (<span
									id="final_total_amount"></span>개)
								</td>
							</tr>
						</table>
						<%
							} else {
						%>
						<!-- 선택 배송일 때, -->
						<div class="detail_select" id="detail_select_delivery">
							<span class="detail_select_title">배송방법 </span> <select
								class="detail_select_input" id="delivery_method"
								name="delivery_method" onchange="changeDeliMethod();">
								<option value="" selected disabled>-[필수]배송방법을 선택해 주세요 -</option>
								<option disabled>---------------</option>
								<option value="일반포장">일반포장</option>
								<option value="퀵서비스">퀵서비스(착불)</option>
								<option value="지하철">지하철택배(착불)</option>
								<option value="고속버스">고속버스택배 (+14,000원)</option>
								<option value="매장방문">매장방문수령</option>
							</select>
						</div>

						<table class="selected_table">
							<colgroup>
								<col width="30%">
								<col width="40%">
								<col width="30%">
							</colgroup>

							<!-- 옵션 선택시 상품 정보 및 구매정보 자동으로 올라가는 부분 -->
							<tr class="selected_tr selected_th">
								<td class="selected_td">상품명</td>
								<td class="selected_td">상품수</td>
								<td class="selected_td">가격</td>
							</tr>
							<!-- 옵션이 default이 아니면 최종 상품 정보 나타내기 -->
							<tbody id="final_product_info_table"></tbody>

							<tr class="selected_tr">
								<td class="selected_td selected_td_last" colspan="3">TOTAL
									: <span id="final_total_price"></span>원 (<span
									id="final_total_amount"></span>개)
								</td>
							</tr>
						</table>
						<%
							} // 배송, 옵션에 따른 주문 테이블 제어 끝
						%>

						<div class="btn_wrap">
							<div class="top_btn_wrap">
								<%
									if (g_amount == 0) {
								%>
								<span class="buy_btn"> 품절 </span>
								<button class="fav_btn" type="button" onclick="wishlistChecked();">관심상품</button>
								<%
									} else {
								%>
								<button class="buy_btn" type="button"
									onclick="valueOrderChecked();">바로구매</button>
								<button class="buy_btn" type="button"
									onclick="valueBasketChecked();">장바구니</button>
								<button class="fav_btn" type="button" onclick="wishlistChecked();">관심상품</button>

								<%
									}
								%>
							</div>

							<button class="kakao_btn" type="button" onclick="kakaoChat();">카카오톡
								상담</button>

						</div>
					</div>
				</div>
			</form>
		</div>

		<br>
		<hr>



		<!-- 상품 관련 상품들 파트 ---------------------------------------------------------------------->
		<div id="menu2" class="menu">
			<div>
				RECOMMEND ITEMS <br> 본 상품의 구매자 분들은 아래 상품들도 함께 구매하셨습니다.
			</div>
		</div>

		<br>
		<hr>

		<!-- 상품 상세 정보 파트 ----------------------------------------------------------------------------->
		<div id="menu1" class="menu">
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

			<div class="info_detail">
				<%=detailList.get(0).getContent()%>
			</div>
		</div>

		<br>
		<hr>

		<!-- 상품 REVIEW 파트 -------------------------------------------------------------------------------------------->
		<div id="menu3" class="menu">
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

			REVIEW <br> 상품의 사용후기를 적어주세요.

			<%
				BoardDAO bdao = new BoardDAO();
				List<BoardDTO> bList = bdao.getPList(1, detailList.get(0).getG_code());
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
				onclick="location.href='./Insert.bo?C=1&CODE=<%=detailList.get(0).getG_code()%>'">
				리뷰작성</button>
			<button type="button">모두보기</button>
		</div>

		<br>
		<hr>

		<!-- 상품 Q&A 파트 ------------------------------------------------------------>
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
				bList = bdao.getPList(2, detailList.get(0).getG_code());
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
				onclick="location.href='./Insert.bo?C=2&CODE=<%=detailList.get(0).getG_code()%>'">상품문의하기</button>
			<button type="button">모두보기</button>
		</div>

	</div>


	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp" /> </footer>

</body>

<script type="text/javascript">

	var total_price; //추가되는 tr의 총 판매가
	var final_total_price = 0; // 선택배송이고, 최종 total 판매가 계산하기 위한 변수
	
	// 일반포장이고, 최종 total 판매가 계산하기 위한 변수
	if(<%=detailList.get(0).getG_discount_rate() != 0%>){
		var final_total_price_normal = <%=detailList.get(0).getG_price_sale()%>;   
	}else{
		var final_total_price_normal = <%=detailList.get(0).getG_price_origin()%>;
	}
	 
	var final_total_amount = 0; //최종 total 수량 계산하기 위한 변수 (선택배송)
	
	var final_total_amount_normal = 1; //최종 total 수량 계산하기 위한 변수 (일반포장)
	
	var count = 0; //사용자가 배송방법을 추가하거나 없앨때 늘어나고 줄어드는 변수
	
	var selectedValues = ""; //사용자가 선택한 배송방법들을 차례대로 담는 변수
	
	var selectedAmounts = ""; //사용자가 선택한 배송방법의 수량들을 차례대로 담는 변수
	
	var selectedArray = new Array(); //사용자가 선택한 배송방법들을 담기 위한 Array 
	
	var selectedOptions = "";
	
	//사용자가 배송방법을 선택했을시(일반포장+선택배송)-------------------------------------------
	
	function changeDeliMethod(){
		var delivery_method = document.getElementById('delivery_method').value;	//배송방법
		
		var g_name = document.getElementById('g_name').value;					//상품명
		var g_price_origin = document.getElementById('g_price_origin').value;	//오리지날 판매가
		var g_discount_rate = document.getElementById('g_discount_rate').value;	//할인율
		var g_price_sale = document.getElementById('g_price_sale').value;		//할인된 판매가
		
		//만약 배송방법을 고속버스로 추가하면 판매가격에 +14000 추가한 값 저장하기
		if(delivery_method == '고속버스'){
			//할인율이 있으면
			if(g_discount_rate != 0){
				g_price_sale_option = parseInt(g_price_sale) + parseInt(14000);
			}
			//없으면
			else{
				g_price_origin_option = parseInt(g_price_origin) + parseInt(14000);
			}	
		}
		//만약 고속버스가 아니면 원판매가 그대로 g_price_sale_option에 저장
		else{
			//할인율이 있으면
			if(g_discount_rate != 0){
				g_price_sale_option = parseInt(g_price_sale);
			}
			//없으면
			else{
				g_price_origin_option = parseInt(g_price_origin);
			}
		}
		
		var g_mileage = document.getElementById('g_mileage').value;		//적립금
		
		var objRow;
		objRow = document.all["final_product_info_table"].insertRow();
		objRow.className = 'delivery_list';

		//사용자가 올바른 배송방법을 선택 하지 않았을시
		if(delivery_method == null){
			document.getElementById("final_product_info_table").style.display = "none";
		}
		//사용자가 올바른 배송방법을 선택했을시 새로운 cell 추가하기
		else {
			//상품명 - 첫번째 td(cell) 항목
			var objCell_name = objRow.insertCell();
			objCell_name.className='selected_td';
			objCell_name.innerHTML = "<span id='objCell_name' class='g_name'>" + g_name + "</span> <br>" + "<span id='delivery_method_option'>[옵션:" + delivery_method + "]</span>";
			
			//상품수 - 두번째 td(cell) 항목
			var objCell_amount = objRow.insertCell();
			objCell_amount.className='selected_td';
			objCell_amount.innerHTML = "<input type='text' class='g_amount' id='g_amount_" + delivery_method + "' name='g_amount_" + delivery_method + "' value='1' maxlength='3' size='3'>" 
										+ " <input type='button' class='g_amount_btn' id='amountPlus' name='amountPlus' value='+' onclick='plus(" + "\"" + delivery_method + "\"" + ");'> " 
										+ " <input type='button' class='g_amount_btn' id='amountMinus' name='amountMinus' value='-' onclick='minus(" + "\"" + delivery_method + "\"" + ");'> "
										+ " <input type='button' class='g_amount_btn' id='deleteCell' name='deleteCell' value='x' onclick='delCell(this, " + "\"" + delivery_method + "\"" + ");'> ";		
			
			//가격, 적립금 - 세번째 td(cell) 항목
			var objCell_price = objRow.insertCell();
			objCell_price.className='selected_td';
				//만약 적립금이 0이 아니면
				if(g_discount_rate != 0){
					objCell_price.innerHTML = "<span id='total_product_price_" + delivery_method + "' >" 
											+ g_price_sale_option.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원 </span> <br>" 
											+ "(적 " + "<span id='total_product_mileage_" + delivery_method + "'>" + g_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</span>" + ")"
											+ "<input type='hidden' id='total_product_price_" + delivery_method + "_input" + "' name='total_product_price_" + delivery_method + "_input' value=" + g_price_sale_option + ">";
				}
				//만약 적립금이 0이면
				else{
					objCell_price.innerHTML = "<span id='total_product_price_" + delivery_method + "'>" 
											+ g_price_origin_option.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원 </span> <br>" 
											+ "(적 " + "<span id='total_product_mileage_" + delivery_method + "'>" + g_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</span>" + ")"
											+ "<input type='hidden' id='total_product_price_" + delivery_method + "_input" + "' name='total_product_price_" + delivery_method + "_input' value=" + g_price_origin_option + ">";
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
		total_amount = $('#g_amount_' + delivery_method).val(); //하나의 tr(배송)의 총 수량
		final_total_amount += Number(total_amount);
		//태그에 추가하기
		$('#final_total_amount').text(final_total_amount);
		
		//사용자가 select option 에서 selected 한 값  input hidden value에 차례대로 넣기
		selectedValues += (delivery_method + ",");
		//추가된 values 변수를 태그에 담기
		$("#selectedValues").val(selectedValues);
		
		//사용자가 select option 에서 selected 한 값 selectedValues input hidden value에 차례대로 넣기
		selectedOptions += (" , ");
		//추가된 values 변수를 태그에 담기
		$("#selectedOptions").val(selectedOptions);
		
		count += Number("1");
		
		//추가된 배송방법 selectedArray에 추가하기
		selectedArray.push(delivery_method);
		
		//----- 키보드로 주문수량 변경시 모든 옵션의 총 수량 제어 ---------------------------------------------------
		
		//사용자가 수량 input 태그에 마우스를 클릭했을시 입력되어있던 수량을 저장하기
 		$('#g_amount_' + delivery_method).on('focusin', function(){
			//console.log("저장된 value : " + $(this).val());
			
			//사용자가 키보드로 입력하기 전 수량
			$(this).data('val', $(this).val()); 
 		});
		
		//사용자가 수량 input 태그에 키보드로 새로운 수량을 입력했을시
		$('#g_amount_' + delivery_method).on('change', function(){
			
			var previousAmount = $(this).data('val'); 	//사용자가 키보드로 입력하기 전 수량
		    var currentAmount = $(this).val();			//사용자가 키보드로 입력 한 수량

			//사용자가 키보드로 input에 0보다 작은수를 입력했을시
			if(currentAmount < 1) {
				alert("상품의 최소 구매량은 1개입니다.");
				currentAmount = parseInt("1");
				$("#g_amount_" + delivery_method).val(currentAmount);
			} else{
				//변경 전 수량이 변경 후 수량보다 클때
			   	if(previousAmount > currentAmount){
			   		//final_total_amount 태그 제어
					final_total_amount -= (previousAmount - currentAmount);

					//만약 할인율이 0이 아니면
			   		if(g_discount_rate != 0){
			   			//각 tr의 총 가격 span 태그에 값 넣기
			   			//만약 배송방법을 고속버스로 추가하면 판매가격에 +14000 추가한 값 저장하기
			   			if(delivery_method == '고속버스'){
							total_price = Number(g_price_sale * currentAmount) + Number(14000); 
						}else {
							total_price = Number(g_price_sale * currentAmount); 
						}
						document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
						//input hidden 값에 수정된 총 가격 넣기
						$('#total_product_price_' + delivery_method + "_input").val(total_price);
						
						//최종 마일리지 계산하기 
						final_mileage = g_mileage * currentAmount;
						//계산된 마일리지 span 태그에 넣기
						document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
						
			   			//final_total_price 태그 제어
						//만약 html 페이지에 g_amount_고속버스 라는 id를 가진 요소가 있으면 총 금액에 14000원 추가해서 final 태그에 넣기 
			   			if(document.getElementById('g_amount_고속버스')){
			   				final_total_price = (g_price_sale * final_total_amount) + Number(14000);
			   			}else {
			   				final_total_price = (g_price_sale * final_total_amount); 	
			   			}
			   		}
			   		//할인율이 0이면
			   		else{
			   			//각 tr의 총 가격 span 태그에 값 넣기
			   			//만약 배송방법을 고속버스로 추가하면 판매가격에 +14000 추가한 값 저장하기
						if(delivery_method == '고속버스'){
							total_price = Number(g_price_origin * currentAmount) + Number(14000); 
						}else {
							total_price = Number(g_price_origin * currentAmount); 
						} 
						document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
						//input hidden 값에 수정된 총 가격 넣기
						$('#total_product_price_' + delivery_method + "_input").val(total_price);
						
						
						//최종 마일리지 계산하기 
						final_mileage = g_mileage * currentAmount;
						//계산된 마일리지 span 태그에 넣기
						document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			   			
			   			//final_total_price 태그 제어
						//만약 html 페이지에 g_amount_고속버스 라는 id를 가진 요소가 있으면 총 금액에 14000원 추가해서 final 태그에 넣기 
			   			if(document.getElementById('g_amount_고속버스')){
			   				final_total_price = (g_price_origin * final_total_amount) + Number(14000);
			   			}else {
			   				final_total_price = (g_price_origin * final_total_amount); 	
			   			}
			   		}
			   	} 
			   	//변경 전 수량이 변경 후 수량보다 작을때
			   	else if(previousAmount < currentAmount) {
			   		//final_total_amount 태그 제어
					final_total_amount += (currentAmount - previousAmount);
					
			   		//만약 할인율이 0이 아니면
			   		if(g_discount_rate != 0){
			   			//각 tr의 총 가격 span 태그에 값 넣기
			   			//만약 배송방법을 고속버스로 추가하면 판매가격에 +14000 추가한 값 저장하기
						if(delivery_method == '고속버스'){
							total_price = Number(g_price_sale * currentAmount) + Number(14000); 
						}else {
							total_price = Number(g_price_sale * currentAmount); 
						}
			   			document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			   			//input hidden 값에 수정된 총 가격 넣기
						$('#total_product_price_' + delivery_method + "_input").val(total_price);
						
			   			
						//최종 마일리지 계산하기 
						final_mileage = g_mileage * currentAmount;
						//계산된 마일리지 span 태그에 넣기
						document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			   			
						//final_total_price 태그 제어
						//만약 html 페이지에 a_amount_고속버스 라는 id를 가진 요소가 있으면 총 금액에 14000원 추가해서 final 태그에 넣기 
			   			if(document.getElementById('g_amount_고속버스')){
			   				final_total_price = (g_price_sale * final_total_amount) + Number(14000);
			   			}else {
			   				final_total_price = (g_price_sale * final_total_amount); 	
			   			}			
			   		}
			   		//할인율이 0이면
			   		else{
			   			//각 tr의 총 가격 span 태그에 값 넣기
			   			//만약 배송방법을 고속버스로 추가하면 판매가격에 +14000 추가한 값 저장하기
						if(delivery_method == '고속버스'){
							total_price = Number(g_price_origin * currentAmount) + Number(14000); 
						}else {
							total_price = Number(g_price_origin * currentAmount); 
						}
						document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
						//input hidden 값에 수정된 총 가격 넣기
						$('#total_product_price_' + delivery_method + "_input").val(total_price);
						
						//최종 마일리지 계산하기 
						final_mileage = g_mileage * currentAmount;
						//계산된 마일리지 span 태그에 넣기
						document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			   			
			   			//final_total_price 태그 제어
						//만약 html 페이지에 a_amount_고속버스 라는 id를 가진 요소가 있으면 총 금액에 14000원 추가해서 final 태그에 넣기 
			   			if(document.getElementById('g_amount_고속버스')){
			   				final_total_price = (g_price_sale * final_total_amount) + Number(14000);
			   			}else {
			   				final_total_price = (g_price_sale * final_total_amount); 	
			   			}
			   		}
			   	}
			}
			
			//태그에 추가하기
			$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			$('#final_total_amount').text(final_total_amount);
    
		});
	} // changeDeliMethod()

	
	
	// 사용자가 옵션을 선택했을 시-----------------------------------------------------------------
	function changeOptionMethod(){
		var option_method = document.getElementById('option_method').value; 					// 선택한 옵션
		
		var g_name = document.getElementById('g_name').value;								 	// 상품명
		var g_price_origin = document.getElementById('g_price_origin').value;					//오리지날 판매가
		var g_discount_rate = document.getElementById('g_discount_rate').value;					//할인율
		var g_price_sale = document.getElementById('g_price_sale').value;						//할인된 판매가
 		var g_option_price = document.getElementById('option_price_' + option_method).value;	//옵션별 판매가

 		// 만약 추가가격이 있는 옵션을 선택하는 경우 추가가격 저장하기
 		if(g_option_price != 0){
 			// 할인율 있으면
 			if(g_discount_rate != 0){
 				g_price_sale = parseInt(g_price_sale) + parseInt(g_option_price);
 			}
 			// 할인율 없으면
 			else{
 				g_price_origin = parseInt(g_price_origin) + parseInt(g_option_price);
 			}
 		}
 		// 추가가격이 없는 옵션을 선택하는 경우
 		else{
 			// 할인율 있으면
 			if(g_discount_rate != 0){
 				g_price_sale = parseInt(g_price_sale);
 			}else{
 				g_price_origin = parseInt(g_price_origin);
 			}
 		}
 		
		var g_mileage = document.getElementById('g_mileage').value;				//적립금
		
		var objRow;
		objRow = document.all["final_product_info_table_option"].insertRow();
		
		//사용자가 올바른 옵션을 선택 하지 않았을시
		if(option_method == null){
			document.getElementById("final_product_info_table_option").style.display = "none";
		}
		//사용자가 올바른 옵션을 선택했을시 새로운 cell 추가하기
		else {
			//상품명 - 첫번째 td(cell) 항목
			var objCell_name = objRow.insertCell();
			objCell_name.innerHTML = "<span id='objCell_name'>" + g_name + "</span> <br>" + "<span id='option_method_option'>[옵션:" + option_method + "]</span>";
			
			//상품수 - 두번째 td(cell) 항목
			var objCell_amount = objRow.insertCell();
			objCell_amount.innerHTML = "<input type='text' id='g_amount_" + option_method + "' name='g_amount_" + option_method + "' value='1' maxlength='3' size='3'>" 
										+ " <input type='button' id='amountPlus' name='amountPlus' value='+' onclick='plusOption(" + "\"" + option_method + "\"" + ");'> " 
										+ " <input type='button' id='amountMinus' name='amountMinus' value='-' onclick='minusOption(" + "\"" + option_method + "\"" + ");'> "
										+ " <input type='button' id='deleteCell' name='deleteCell' value='x' onclick='delOptionCell(this, " + "\"" + option_method + "\"" + ");'> ";		
			
			//가격, 적립금 - 세번째 td(cell) 항목
			var objCell_price = objRow.insertCell();
			//만약 적립금이 0이 아니면
			if(g_discount_rate != 0){
				objCell_price.innerHTML = "<span id='total_product_price_" + option_method + "' >" 
										+ g_price_sale.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원 </span> <br>" 
										+ "(적 " + "<span id='total_product_mileage_" + option_method + "'>" + g_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</span>" + ")"
										+ "<input type='hidden' id='total_product_price_" + option_method + "_input" + "' name='total_product_price_" + option_method + "_input' value=" + g_price_sale + ">";
			}
			//만약 적립금이 0이면
			else{
				objCell_price.innerHTML = "<span id='total_product_price_" + option_method + "'>" 
										+  g_price_origin.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원 </span> <br>" 
										+ "(적 " + "<span id='total_product_mileage_" + option_method + "'>" + g_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</span>" + ")"
										+ "<input type='hidden' id='total_product_price_" + option_method + "_input" + "' name='total_product_price_" + option_method + "_input' value=" + g_price_origin + ">";
			}
		}
		
		//select option 태그안에 사용자가 선택한 배송방법 비활성화 시키기
		$("select option[value*='"+ option_method +"']").attr('disabled',true);
		
		//final_total_price 태그 제어
		total_price = document.getElementById('total_product_price_' + option_method + '_input').value; //하나의 tr(옵션)의 총 판매가
		//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 저장하기, 만약 처음이면 0에 추가하기
		final_total_price += Number(total_price);
		//태그에 추가하기
		$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
		
		//final_total_amount 태그 제어
		total_amount = document.getElementById('g_amount_' + option_method).value; //하나의 tr(배송)의 총 수량
		final_total_amount += Number(total_amount);
		//태그에 추가하기
		$('#final_total_amount').text(final_total_amount);
		
		selectedValues += "일반포장, ";
		$('#selectedValues').val(selectedValues);
		
		//사용자가 select option 에서 selected 한 값 selectedValues input hidden value에 차례대로 넣기
		selectedOptions += (option_method + ", ");
		//추가된 values 변수를 태그에 담기
		$("#selectedOptions").val(selectedOptions);
		
		count += Number("1");
		
		//추가된 옵션방법 selectedArray에 추가하기
		selectedArray.push(option_method);
		
		//----- 키보드로 주문수량 변경시 모든 옵션의 총 수량 제어 ---------------------------------------------------
		//사용자가 수량 input 태그에 마우스를 클릭했을시 입력되어있던 수량을 저장하기
		$(document.getElementById('g_amount_' + option_method)).on('focusin', function(){
			//console.log("저장된 value : " + $(this).val());
			
			//사용자가 키보드로 입력하기 전 수량
			$(this).data('val', $(this).val()); 
 		}); 
		
		//사용자가 수량 input 태그에 키보드로 새로운 수량을 입력했을시
		$(document.getElementById('g_amount_' + option_method)).on('change', function(){
			final_total_amount = document.getElementById('final_total_amount').innerHTML; //총 수량 (span 태그 안에 있는 값) 가져오기
			final_total_amount = Number(final_total_amount); //문자열을 숫자로 형변환
			
			var previousAmount = $(this).data('val'); 	//사용자가 키보드로 입력하기 전 수량
		    var currentAmount = $(this).val();			//사용자가 키보드로 입력 한 수량
		    
		  //사용자가 키보드로 input에 0보다 작은수를 입력했을시
		    if(currentAmount < 1){
		    	 alert("상품의 최소 구매량은 1개입니다.");
				 currentAmount = parseInt("1");
				 $("#g_amount_" + option_method).val(currentAmount);
		    }else{
		    	//변경 전 수량이 변경 후 수량보다 클때
		    	if(previousAmount > currentAmount){
		    		//final_total_amount 태그 제어
					final_total_amount -= (previousAmount - currentAmount);
		    		
					//만약 할인율이 0이 아니면
					if(g_discount_rate != 0){
						//각 tr의 총 가격 span 태그에 값 넣기
			   			total_price = Number(g_price_sale * currentAmount); 
						document.getElementById("total_product_price_" + option_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
						
						//최종 마일리지 계산하기 
						final_mileage = g_mileage * currentAmount;
						//계산된 마일리지 span 태그에 넣기
						document.getElementById("total_product_mileage_" + option_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
						
						//final_total_price 태그 제어
			   			final_total_price -= (g_price_sale * (previousAmount - currentAmount));
						
					}
					//할인율이 0이면
					else{
						//각 tr의 총 가격 span 태그에 값 넣기
			   			total_price = Number(g_price_origin * currentAmount); 
						document.getElementById("total_product_price_" + option_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
						
						//최종 마일리지 계산하기 
						final_mileage = g_mileage * currentAmount;
						//계산된 마일리지 span 태그에 넣기
						document.getElementById("total_product_mileage_" + option_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			   			
						//final_total_price 태그 제어
			   			final_total_price -= (g_price_origin * (previousAmount - currentAmount));
						
					}
		    	}
		    	//변경 전 수량이 변경 후 수량보다 작을때
		    	else if(previousAmount < currentAmount){
		    		//final_total_amount 태그 제어
					final_total_amount += (currentAmount - previousAmount);
		    		
					//만약 할인율이 0이 아니면
					if(g_discount_rate != 0){

			   			//각 tr의 총 가격 span 태그에 값 넣기
			   			total_price = Number(g_price_sale * currentAmount); 
						document.getElementById("total_product_price_" + option_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
						
						//최종 마일리지 계산하기 
						final_mileage = g_mileage * currentAmount;
						//계산된 마일리지 span 태그에 넣기
						document.getElementById("total_product_mileage_" + option_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			   			
						//final_total_price 태그 제어
			   			final_total_price += (g_price_sale * (currentAmount - previousAmount));

					}
					//할인율이 0이면
					else{

			   			//각 tr의 총 가격 span 태그에 값 넣기
			   			total_price = Number(g_price_origin * currentAmount); 
						document.getElementById("total_product_price_" + option_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
						
						//최종 마일리지 계산하기 
						final_mileage = g_mileage * currentAmount;
						//계산된 마일리지 span 태그에 넣기
						document.getElementById("total_product_mileage_" +option_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			   			
						//final_total_price 태그 제어
			   			final_total_price += (g_price_origin * (currentAmount - previousAmount));

					}
		    	}
		    }
		    //input hidden 값에 수정된 총 가격 넣기
			$('#total_product_price_' + option_method + "_input").val(total_price);
		    
		    //태그에 추가하기
			$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			//document.getElementById("final_total_price") = final_total_price;
		    $('#final_total_amount').text(final_total_amount);
		    //document.getElementById('final_total_amount') = final_total_amount;
		});
		
	} // changeOptionMethod()
	
	
	

	//주문수량 변경 시-----------------------------------------------------------------------------
// 	var delivery_method = document.getElementById('delivery_method').value;	//배송방법
// 	var option_method = document.getElementById('option_method').value;     //옵션선택
// 	var g_price_origin = document.getElementById('g_price_origin').value;	//오리지날 판매가
// 	var g_discount_rate = document.getElementById('g_discount_rate').value;	//할인율
// 	var g_price_sale = document.getElementById('g_price_sale').value;		//할인된 판매가
// 	var g_mileage = document.getElementById('g_mileage').value;				//적립금


	//주문수량 키보드로 변경시 tr한줄의 총 금액과 마일리지 및 모든 옵션의 총 금액 제어 ----------------------------------------------------------
	//일반포장일 때
// 	function amountChange(delivery_method){
		
	
		//사용자가 수량 input 태그에 마우스를 클릭했을시 입력되어있던 수량을 저장하기
 		$('#g_amount_일반포장').on('focusin', function(){
			//console.log("저장된 value : " + $(this).val());
			
			//사용자가 키보드로 입력하기 전 수량
			$(this).data('val', $(this).val()); 
 		});
		
 		//사용자가 수량 input 태그에 키보드로 새로운 수량을 입력했을시
 		$('#g_amount_일반포장').on('change', function(){
 			
 			var delivery_method = document.getElementById('delivery_method').value;
 			
 			var g_price_origin = document.getElementById('g_price_origin').value;	//오리지날 판매가
 			var g_discount_rate = document.getElementById('g_discount_rate').value;	//할인율
 			var g_price_sale = document.getElementById('g_price_sale').value;		//할인된 판매가
 			var g_mileage = document.getElementById('g_mileage').value;				//적립금
 		
 			var total_price = Number(document.getElementById('total_product_price_' + delivery_method + '_input').value); //하나의 tr(배송)의 총 판매가 String -> Int 형변환
 			
 			var previousAmount = $(this).data('val'); 	//사용자가 키보드로 입력하기 전 수량
		    var currentAmount = $(this).val();			//사용자가 키보드로 입력 한 수량
		    
		    //사용자가 키보드로 input에 0보다 작은수를 입력했을시
			if(currentAmount < 1) {
				alert("상품의 최소 구매량은 1개입니다.");
				currentAmount = parseInt("1");
				$("#g_amount_" + delivery_method).val(currentAmount);
			}else{
				
				//변경 전 수량이 변경 후 수량보다 클때
			   	if(previousAmount > currentAmount){
			   		//final_total_amount 태그 제어
					final_total_amount_normal -= (previousAmount - currentAmount);
			   		
					//만약 할인율이 0이 아니면
			   		if(g_discount_rate != 0){
			   			//각 tr의 총 가격 span 태그에 값 넣기
			   			total_price = Number(g_price_sale * currentAmount); 
			   			
			   			document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			   			//input hidden 값에 수정된 총 가격 넣기
						$('#total_product_price_' + delivery_method + "_input").val(total_price);
			   			
						//최종 마일리지 계산하기 
						final_mileage = g_mileage * currentAmount;
						//계산된 마일리지 span 태그에 넣기
						document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
						
						//final_total_price 태그 제어
						final_total_price_normal = (g_price_sale * final_total_amount_normal); 
			   		}
					// 할인율이 0이면
					else{
						//각 tr의 총 가격 span 태그에 값 넣기
						total_price = Number(g_price_origin * currentAmount);
						
						document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
						//input hidden 값에 수정된 총 가격 넣기
						$('#total_product_price_' + delivery_method + "_input").val(total_price);
						
						//최종 마일리지 계산하기 
						final_mileage = g_mileage * currentAmount;
						//계산된 마일리지 span 태그에 넣기
						document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			   			
						//final_total_price 태그 제어
						final_total_price_normal = (g_price_origin * final_total_amount_normal); 	
					}
			   	}
				//변경 전 수량이 변경 후 수량보다 작을 때
				else if(previousAmount < currentAmount){
					//final_total_amount 태그 제어
					final_total_amount_normal += (currentAmount - previousAmount);
					
					//만약 할인율이 0이 아니면
			   		if(g_discount_rate != 0){
			   			total_price = Number(g_price_sale * currentAmount); 
			   			
			   			document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			   			//input hidden 값에 수정된 총 가격 넣기
						$('#total_product_price_' + delivery_method + "_input").val(total_price);
			   			
						//최종 마일리지 계산하기 
						final_mileage = g_mileage * currentAmount;
						//계산된 마일리지 span 태그에 넣기
						document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			   			
						//final_total_price 태그 제어
						final_total_price_normal = (g_price_sale * final_total_amount_normal); 	
			   		}
					//할인율 0이면
					else{
						total_price = Number(g_price_origin * currentAmount); 
						
						document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
						//input hidden 값에 수정된 총 가격 넣기
						$('#total_product_price_' + delivery_method + "_input").val(total_price);
						
						//최종 마일리지 계산하기 
						final_mileage = g_mileage * currentAmount;
						//계산된 마일리지 span 태그에 넣기
						document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
			   			
						//final_total_price 태그 제어
						final_total_price_normal = (g_price_sale * final_total_amount_normal); 
					}
					
					
				}
				
				
			}
		    
			//태그에 추가하기
			$('#final_total_price_normal').text(final_total_price_normal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			$('#final_total_amount_normal').text(final_total_amount_normal);
 			
 			
 		});
 		
 		
 		
		
		//delivery_method 인수로 들어온 값에 따라 new_g_amount 값 바꾸기
// 		var new_g_amount = document.getElementById('g_amount_' + delivery_method).value;	//사용자가 새로 수정하는 수량
	
// 		//final_total_amount 태그 제어
// 		total_amount = $('#g_amount_' + delivery_method).val(); //하나의 tr(배송)의 총 수량
// 		final_total_amount_normal = Number(total_amount);
// 		//태그에 추가하기
// 		$('#final_total_amount_normal').text(final_total_amount_normal);
		
	
		
// 			//만약 할인율(a_discount_rate)이 0이 아니면
// 			if(g_discount_rate != 0){
			
// 				total_price = Number(g_price_sale * new_g_amount);
				
// 				//각 tr의 총 가격 span 태그에 값 넣기
// 				document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
// 				//input hidden 값에 수정된 총 가격 넣기
// 				$('#total_product_price_' + delivery_method + "_input").val(total_price);
				
// 				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 저장하기, 만약 처음이면 0에 추가하기
// 				final_total_price_normal = Number(total_price);
// 				//태그에 추가하기
// 				$('#final_total_price_normal').text(final_total_price_normal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
				
				
// 				//최종 마일리지 계산하기 
// 				final_mileage = g_mileage * new_g_amount;
// 				//계산된 마일리지 span 태그에 넣기
// 				document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
// 			}
// 			//할인율이 0이면
// 			else{
	
// 				total_price = Number(g_price_origin * new_g_amount);
				
// 				//각 tr의 총 가격 span 태그에 값 넣기
// 				document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
// 				//input hidden 값에 수정된 총 가격 넣기
// 				$('#total_product_price_' + delivery_method + "_input").val(total_price);	
				
// 				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 저장하기, 만약 처음이면 0에 추가하기
// 				final_total_price_normal = Number(total_price);
// 				//태그에 추가하기
// 				$('#final_total_price_normal').text(final_total_price_normal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
		
				
// 				//최종 마일리지 계산하기 
// 				final_mileage = g_mileage * new_g_amount;
// 				//계산된 마일리지 span 태그에 넣기
// 				document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
// 			}
		
// 	} //amountChange()
	
	
	//사용자가 '+'를 눌렸을시---------------------------------------------------------------------------
	// 선택배송,일반배송 제어
	function plus(delivery_method){
		
		var g_price_origin = document.getElementById('g_price_origin').value;	//오리지날 판매가
		var g_discount_rate = document.getElementById('g_discount_rate').value;	//할인율
		var g_price_sale = document.getElementById('g_price_sale').value;		//할인된 판매가
		var g_mileage = document.getElementById('g_mileage').value;				//적립금
		
		var total_price = Number($('#total_product_price_' + delivery_method + "_input").val()); //하나의 tr(배송)의 총 판매가 String -> Int 형변환
		
		//delivery_method 인수로 들어온 값에 따라 new_g_amount 값 바꾸기
		var new_g_amount = document.getElementById('g_amount_' + delivery_method).value;	//사용자가 새로 수정하는 수량
		
		
		//사용자가 수량 999에서 +를 눌렸을시
		if(new_g_amount == 999) {
			alert("상품의 최대 구매량은 999개입니다.");
			new_g_amount = parseInt("999");
			$("#g_amount_" + delivery_method).val(new_g_amount);
		}else {
			
			new_g_amount++;
			$("#g_amount_" + delivery_method).val(new_g_amount);
			
			//final_total_amount 태그 제어
			// 선택배송일 때
			final_total_amount += Number("1");
			$('#final_total_amount').text(final_total_amount);
			// 일반배송일 때
			final_total_amount_normal += Number("1");
			$('#final_total_amount_normal').text(final_total_amount_normal);
			
			//만약 할인율(g_discount_rate)이 0이 아니면
			if(g_discount_rate != 0) {
				
				//계산된 값 span 태그에 넣기
				total_price += Number(g_price_sale);
				
				//각 tr의 총 가격 span 태그에 값 넣기
				document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				//input hidden 값에 수정된 총 가격 넣기
				$('#total_product_price_' + delivery_method + "_input").val(total_price);
				
				//최종 마일리지 계산하기 
				final_mileage = g_mileage * new_g_amount;
				
				//계산된 마일리지 span 태그에 넣기
				document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
				//final_total_price 태그 제어
				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 저장하기, 만약 처음이면 0에 추가하기
				//선택배송일 때
				final_total_price += Number(g_price_sale);
				//일반배송일 때
				final_total_price_normal += Number(g_price_sale);
				
				//태그에 추가하기
				//선택배송일때
				$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
				//일반배송일때
				$('#final_total_price_normal').text(final_total_price_normal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
				
			}
			//할인율이 0이면
			else{
				
				//계산된 값 span 태그에 넣기
				total_price += Number(g_price_origin);
				
				//각 tr의 총 가격 span 태그에 값 넣기
				document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				//input hidden 값에 수정된 총 가격 넣기
				$('#total_product_price_' + delivery_method + "_input").val(total_price);	
				
				//최종 마일리지 계산하기 
				final_mileage = g_mileage * new_g_amount;
				//계산된 마일리지 span 태그에 넣기
				document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
				
				//final_total_price 태그 제어
				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 저장하기, 만약 처음이면 0에 추가하기
				//선택배송일 때
				final_total_price += Number(g_price_origin);
				//일반배송일 때
				final_total_price_normal += Number(g_price_origin);
				
				//태그에 추가하기
				//선택배송일 때
				$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
				//일반배송일 때
				$('#final_total_price_normal').text(final_total_price_normal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			}

		}
	}
	
	//사용자가 '+'를 눌렸을시---------------------------------------------------------------------------
	//옵션 제어
	function plusOption(option_method){
		
		var g_price_origin = document.getElementById('g_price_origin').value;	//오리지날 판매가
		var g_discount_rate = document.getElementById('g_discount_rate').value;	//할인율
		var g_price_sale = document.getElementById('g_price_sale').value;		//할인된 판매가
		var g_mileage = document.getElementById('g_mileage').value;				//적립금
		var g_option_price = document.getElementById('option_price_' + option_method).value;	//옵션별 추가가격
		
		var total_price = Number(document.getElementById('total_product_price_' + option_method + '_input').value);
		
		// option_method 인수로 들어온 값에 따라 new_g_amount 값 바꾸기
		var new_g_amount = document.getElementById('g_amount_' +  option_method).value;	//사용자가 새로 수정하는 수량
		
		//사용자가 수량 999에서 +를 눌렸을시
		if(new_g_amount == 999) {
			alert("상품의 최대 구매량은 999개입니다.");
			new_g_amount = parseInt("999");
			$("#g_amount_" + option_method).val(new_g_amount);
		}else{
			
			new_g_amount++;
			document.getElementById('g_amount_' + option_method).value = new_g_amount;
		
			//final_total_amount 태그 제어 
			final_total_amount += Number("1");
			$('#final_total_amount').text(final_total_amount);
			
			//만약 할인율(g_discount_rate)이 0이 아니면
			if(g_discount_rate != 0){
		
				//계산된 값 span 태그에 넣기
				total_price += (Number(g_price_sale) + Number(g_option_price));
				
				//각 tr의 총 가격 span 태그에 값 넣기
				document.getElementById("total_product_price_" + option_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				//input hidden 값에 수정된 총 가격 넣기
				document.getElementById('total_product_price_' + option_method + '_input').value = total_price;
				
				//최종 마일리지 계산하기 
				final_mileage = g_mileage * new_g_amount;
				
				//계산된 마일리지 span 태그에 넣기
				document.getElementById("total_product_mileage_" + option_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
				//final_total_price 태그 제어
				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 저장하기, 만약 처음이면 0에 추가하기
				final_total_price += (Number(g_price_sale) + Number(g_option_price));
				//태그에 추가하기
				//document.getElementById('final_total_price').value = final_total_price;
				$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
				
			}else{
				
				//계산된 값 span 태그에 넣기
				total_price += (Number(g_price_origin) + Number(g_option_price));
				
				//각 tr의 총 가격 span 태그에 값 넣기
				document.getElementById("total_product_price_" + option_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				//input hidden 값에 수정된 총 가격 넣기
				document.getElementById("total_product_price_" + option_method + "_input").value = total_price;
				
				//최종 마일리지 계산하기 
				final_mileage = g_mileage * new_g_amount;
				//계산된 마일리지 span 태그에 넣기
				document.getElementById("total_product_mileage_" + option_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
				//final_total_price 태그 제어
				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 저장하기, 만약 처음이면 0에 추가하기
				final_total_price += (Number(g_price_origin) + Number(g_option_price));
				
				//태그에 추가하기
				$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
				
			}
			
			
		}
		
	}
	
	

	//사용자가 '-'를 눌렸을시------------------------------------------------------------------------------
	//선택배송,일반배송 제어
	function minus(delivery_method){
		
		var g_price_origin = document.getElementById('g_price_origin').value;	//오리지날 판매가
		var g_discount_rate = document.getElementById('g_discount_rate').value;	//할인율
		var g_price_sale = document.getElementById('g_price_sale').value;		//할인된 판매가
		var g_mileage = document.getElementById('g_mileage').value;				//적립금
		
		
		var total_price = Number($('#total_product_price_' + delivery_method + "_input").val()); //하나의 tr(배송)의 총 판매가 String -> Int 형변환
		
		//delivery_method 인수로 들어온 값에 따라 new_g_amount 값 바꾸기
		var new_g_amount = document.getElementById('g_amount_' + delivery_method).value;	//사용자가 새로 수정하는 수량
		
		//사용자가 수량 1에서 -를 눌렸을시
		if(new_g_amount == 1) {
			alert("상품의 최소 구매량은 1개입니다.");
			new_g_amount = parseInt("1");
			$("#g_amount_" + delivery_method).val(new_g_amount);
		}else {
			new_g_amount--;
			$("#g_amount_" + delivery_method).val(new_g_amount);
			
			//final_total_amount 태그 제어
			//선택배송일 때
			final_total_amount -= Number("1");
			$('#final_total_amount').text(final_total_amount);
			//일반배송일 때
			final_total_amount_normal -= Number("1");
			$('#final_total_amount_normal').text(final_total_amount_normal);
			
			//만약 할인율(g_discount_rate)이 0이 아니면
			if(g_discount_rate != 0) {
				
				//계산된 값 span 태그에 넣기
				total_price -= Number(g_price_sale);
				
				//각 tr의 총 가격 span 태그에 값 넣기
				document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				//input hidden 값에 수정된 총 가격 넣기
				$('#total_product_price_' + delivery_method + "_input").val(total_price);
				
				//최종 마일리지 계산하기 
				final_mileage = g_mileage * new_g_amount;
				//계산된 마일리지 span 태그에 넣기
				document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
				
				//final_total_price 태그 제어
				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 빼고나서 저장하기
				//선택배송일 때
				final_total_price -= Number(g_price_sale);
				//일반배송
				final_total_price_normal -= Number(g_price_sale);
				
				//태그에 추가하기
				//선택배송
				$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
				//일반배송
				$('#final_total_price_normal').text(final_total_price_normal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			}
			//할인율이 0이면
			else{
				//계산된 값 span 태그에 넣기
				total_price -= Number(g_price_origin);
				
				//각 tr의 총 가격 span 태그에 값 넣기
				document.getElementById("total_product_price_" + delivery_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				//input hidden 값에 수정된 총 가격 넣기
				$('#total_product_price_' + delivery_method + "_input").val(total_price);
				
				//최종 마일리지 계산하기 
				final_mileage = g_mileage * new_g_amount;
				//계산된 마일리지 span 태그에 넣기
				document.getElementById("total_product_mileage_" + delivery_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
				//final_total_price 태그 제어
				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 빼고나서 저장하기
				//선택배송
				final_total_price -= Number(g_price_origin);
				//일반배송
				final_total_price_normal -= Number(g_price_origin);
				
				//태그에 추가하기
				//선택배송
				$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
				//일반배송
				$('#final_total_price_normal').text(final_total_price_normal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			}
		}
	}	
	

	//사용자가 '-'를 눌렸을시------------------------------------------------------------------------------
	//옵션 제어
	function minusOption(option_method){
		
		var g_price_origin = document.getElementById('g_price_origin').value;	//오리지날 판매가
		var g_discount_rate = document.getElementById('g_discount_rate').value;	//할인율
		var g_price_sale = document.getElementById('g_price_sale').value;		//할인된 판매가
		var g_mileage = document.getElementById('g_mileage').value;				//적립금
		var g_option_price = document.getElementById('option_price_' + option_method).value;	//옵션별 추가가격

		var total_price = Number(document.getElementById('total_product_price_' + option_method + '_input').value); //하나의 tr의 총 판매가 String -> Int 형변환

		// option_method 인수로 들어온 값에 따라 new_g_amount 값 바꾸기
		var new_g_amount = document.getElementById('g_amount_' +  option_method).value;	//사용자가 새로 수정하는 수량
		
		//사용자가 수량 999에서 +를 눌렸을시
		if(new_g_amount == 1) {
			alert("상품의 최소 구매량은 1개입니다.");
			new_g_amount = parseInt("1");
			$("#g_amount_" + option_method).val(new_g_amount);
		}else{
			
			new_g_amount--;
			document.getElementById('g_amount_' + option_method).value = new_g_amount;
			//$("#g_amount_" + option_method).val(new_g_amount);
			
			//final_total_amount 태그 제어 
			final_total_amount -= Number("1");
			$('#final_total_amount').text(final_total_amount);
			
			//만약 할인율(g_discount_rate)이 0이 아니면
			if(g_discount_rate != 0){
				
				//계산된 값 span 태그에 넣기
				total_price -= (Number(g_price_sale) + Number(g_option_price));
				
				//각 tr의 총 가격 span 태그에 값 넣기
				document.getElementById("total_product_price_" + option_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				//input hidden 값에 수정된 총 가격 넣기
				document.getElementById('total_product_price_' + option_method + '_input').value = total_price;
				//$('#total_product_price_' + option_method + "_input").val(total_price);
				
				//최종 마일리지 계산하기 
				final_mileage = g_mileage * new_g_amount;
				//계산된 마일리지 span 태그에 넣기
				document.getElementById("total_product_mileage_" + option_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
				//final_total_price 태그 제어
				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 빼고나서 저장하기
				final_total_price -= (Number(g_price_sale) + Number(g_option_price));
				
				//태그에 추가하기
				$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
				
			}else{
				
				//계산된 값 span 태그에 넣기
				total_price -= (Number(g_price_origin) + Number(g_option_price));
				
				//각 tr의 총 가격 span 태그에 값 넣기
				document.getElementById("total_product_price_" + option_method).innerHTML = total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				//input hidden 값에 수정된 총 가격 넣기
				document.getElementById("total_product_price_" + option_method + "_input").value = total_price;
				
				//최종 마일리지 계산하기 
				final_mileage = g_mileage * new_g_amount;
				//계산된 마일리지 span 태그에 넣기
				document.getElementById("total_product_mileage_" + option_method).innerHTML = final_mileage.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
				
				//final_total_price 태그 제어
				//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 저장하기, 만약 처음이면 0에 추가하기
				final_total_price -= (Number(g_price_origin) + Number(g_option_price));
				
				//태그에 추가하기
				$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
				
			}
		}
	}
	
	
	
	// 사용자가 상품정보 제거했을 시----------------------------------------------
	// 배송 선택시
	function delCell(obj, delivery_method){
		
		var g_price_origin = document.getElementById('g_price_origin').value;	//오리지날 판매가
		var g_discount_rate = document.getElementById('g_discount_rate').value;	//할인율
		var g_price_sale = document.getElementById('g_price_sale').value;		//할인된 판매가
		var g_mileage = document.getElementById('g_mileage').value;				//적립금
		
		
		var total_price = Number($('#total_product_price_' + delivery_method + "_input").val()); //하나의 tr(배송)의 총 판매가 String -> Int 형변환
		
		//만약 할인율(g_discount_rate)이 0이 아니면
		if(g_discount_rate != 0){
			//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 빼고나서 저장하기
			final_total_price -= Number(total_price);
			//태그에 추가하기
			$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			
			//delivery_method 인수로 들어온 값에 따라 new_g_amount 값 바꾸기
			var new_g_amount = document.getElementById('g_amount_' + delivery_method).value;	//사용자가 새로 수정하는 수량
			
			//final_total_amount 태그 제어
			final_total_amount -= Number(new_g_amount);
			$('#final_total_amount').text(final_total_amount);
			
			//현재 위치에서 부모태그의 부모태그(현재 span -> td -> tr) 없애기
			$(obj).parent().parent().remove();
			
			//select option 태그안에 사용자가 선택한 배송방법 활성화 시키기
			$("select option[value*='"+ delivery_method +"']").removeAttr('disabled');
		}
		//할인율이 0이면
		else{
			//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 빼고나서 저장하기
			final_total_price -= Number(total_price);
			//태그에 추가하기
			$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			
			//delivery_method 인수로 들어온 값에 따라 new_g_amount 값 바꾸기
			var new_g_amount = document.getElementById('g_amount_' + delivery_method).value;	//사용자가 새로 수정하는 수량
			
			//final_total_amount 태그 제어
			final_total_amount -= Number(new_g_amount);
			$('#final_total_amount').text(final_total_amount);
			
			//현재 위치에서 부모태그의 부모태그(현재 span -> td -> tr) 없애기
			$(obj).parent().parent().remove();
			
			//select option 태그안에 사용자가 선택한 배송방법 활성화 시키기
			$("select option[value*='"+ delivery_method +"']").removeAttr('disabled');
		}
		
		count -= Number("1");
		
		//selectedArray에 삭제하고 싶은 배송방법을 삭제하기
		selectedArray.splice(selectedArray.indexOf(delivery_method),1);
		
	}// delCell
	
	// 사용자가 상품정보 제거했을 시----------------------------------------------
	// 옵션 선택시
	function delOptionCell(obj, option_method){

		var g_price_origin = document.getElementById('g_price_origin').value;	//오리지날 판매가
		var g_discount_rate = document.getElementById('g_discount_rate').value;	//할인율
		var g_price_sale = document.getElementById('g_price_sale').value;		//할인된 판매가
		var g_mileage = document.getElementById('g_mileage').value;				//적립금
		
		var total_price = Number(document.getElementById('total_product_price_' + option_method + '_input').value); //하나의 tr(옵션)의 총 판매가 String -> Int 형변환
		
		//만약 할인율(g_discount_rate)이 0이 아니면
		if(g_discount_rate != 0){
			//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 빼고나서 저장하기
			final_total_price -= Number(total_price);
			//태그에 추가하기
			$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			
			//option_method 인수로 들어온 값에 따라 new_g_amount 값 바꾸기
			var new_g_amount = document.getElementById('g_amount_' + option_method).value;	//사용자가 새로 수정하는 수량
			
			//final_total_amount 태그 제어
			final_total_amount -= Number(new_g_amount);
			$('#final_total_amount').text(final_total_amount);
			
			//현재 위치에서 부모태그의 부모태그(현재 span -> td -> tr) 없애기
			$(obj).parent().parent().remove();
			
			//select option 태그안에 사용자가 선택한 배송방법 활성화 시키기
			$("select option[value*='"+ option_method +"']").removeAttr('disabled');
		}
		//할인율이 0이면
		else{
			//새롭게 추가되는 total_price를 전에 추가되었던 final_total_price에 빼고나서 저장하기
			final_total_price -= Number(total_price);
			//태그에 추가하기
			$('#final_total_price').text(final_total_price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			
			//delivery_method 인수로 들어온 값에 따라 new_g_amount 값 바꾸기
			var new_g_amount = document.getElementById('g_amount_' + option_method).value;	//사용자가 새로 수정하는 수량
			
			//final_total_amount 태그 제어
			final_total_amount -= Number(new_g_amount);
			$('#final_total_amount').text(final_total_amount);
			
			//현재 위치에서 부모태그의 부모태그(현재 span -> td -> tr) 없애기
			$(obj).parent().parent().remove();
			
			//select option 태그안에 사용자가 선택한 배송방법 활성화 시키기
			$("select option[value*='"+ option_method +"']").removeAttr('disabled');
		}
		
		count -= Number("1");
		
		//selectedArray에 삭제하고 싶은 옵션을 삭제하기
		selectedArray.splice(selectedArray.indexOf(option_method),1);
	
	} //delOptionCell 종료 
	
	
	//구매하기, 장바구니 버튼 눌렸을시 ------------------------------------------
	
	//장바구니 버튼을 클릭했을시
	function valueBasketChecked() {
		
		// 배송선택 테이블이 존재할 때
		if(document.getElementById("detail_select_delivery")){
			
			if(document.getElementById("delivery_method").value == ""){
				alert("필수옵션을 선택해주세요");
				document.fr.delivery_method.focus();
				return false;	
			}else{
				for(var i=0; i<count; i++){
					//selectedArray[i] -> 선택된 배송방법의 value들
					selectedAmounts += ($('#g_amount_' + selectedArray[i]).val() + ", ")
				} 
				
				//추가된 values 변수를 태그에 담기
				$("#selectedAmounts").val(selectedAmounts);
				
				document.fr.action="./BasketAdd.ba";
				document.fr.submit();
				
			}	
		}
		// 옵션선택 테이블이 존재할 때
		if(document.getElementById("detail_select_option")){
			if(document.getElementById("option_method").value == ""){
				alert("필수옵션을 선택해주세요");
				document.fr.option_method.focus();
				return false;
			}else{
				for(var i=0; i<count; i++){
					//selectedArray[i] -> 선택된 배송방법의 value들
					selectedAmounts += (document.getElementById('g_amount_' + selectedArray[i]).value + ", ");
				}
				
				//추가된 values 변수를 태그에 담기
				//$("#selectedAmounts").val(selectedAmounts);
				document.getElementById('selectedAmounts').value = selectedAmounts;
				
				document.fr.action="./BasketAdd.ba";
				document.fr.submit();

			}	
		}
		
		//일반포장일 때
		if(document.getElementById("detail_select_delivery") == null){
			if(document.getElementById("delivery_method").value == "일반포장"){
				count = 1;
				
				selectedValues = "일반포장,";
				$('#selectedValues').val(selectedValues);
				
				//selectedArray[i] -> 선택된 배송방법의 value들
				selectedAmounts += ($('#g_amount_일반포장').val() + ", ")
				
				//추가된 values 변수를 태그에 담기
				$("#selectedAmounts").val(selectedAmounts);
				
				document.fr.action="./BasketAdd.ba";
				document.fr.submit();

			}
		}

	}
	
	//구매하기 버튼을 클릭했을시
	function valueOrderChecked() {
// 		//만약 배송방법을 선택하지 않았다면
// 		if(document.getElementById("delivery_method").value == ""){
// 			alert("배송옵션을 선택해주세요");
// 			document.fr.delivery_method.focus();
// 			return false;
// 		}
// 		//배송방법을 선택했을시
// 		else {
// 			var isBasket = confirm("구매하시겠습니까?");
// 			if(isBasket) {
// 				document.fr.action="";
// 				document.fr.sbmit();
// 			} else {
// 				return false;
// 			}
// 		}
		// 배송선택 테이블이 존재할 때
		if(document.getElementById("detail_select_delivery")){
			
			if(document.getElementById("delivery_method").value == ""){
				alert("필수옵션을 선택해주세요");
				document.fr.delivery_method.focus();
				return false;	
			}else{
				for(var i=0; i<count; i++){
					//selectedArray[i] -> 선택된 배송방법의 value들
					selectedAmounts += ($('#g_amount_' + selectedArray[i]).val() + ", ")
				} 
				
				//추가된 values 변수를 태그에 담기
				$("#selectedAmounts").val(selectedAmounts);
				
				document.fr.action="./BasketAdd2.ba";
				document.fr.submit();
				
			}	
		}
		// 옵션선택 테이블이 존재할 때
		if(document.getElementById("detail_select_option")){
			if(document.getElementById("option_method").value == ""){
				alert("필수옵션을 선택해주세요");
				document.fr.option_method.focus();
				return false;
			}else{
				for(var i=0; i<count; i++){
					//selectedArray[i] -> 선택된 배송방법의 value들
					selectedAmounts += (document.getElementById('g_amount_' + selectedArray[i]).value + ", ");
				}
				
				//추가된 values 변수를 태그에 담기
				//$("#selectedAmounts").val(selectedAmounts);
				document.getElementById('selectedAmounts').value = selectedAmounts;
				
				document.fr.action="./BasketAdd2.ba";
				document.fr.submit();

			}	
		}
		
		//일반포장일 때
		if(document.getElementById("detail_select_delivery") == null){
			if(document.getElementById("delivery_method").value == "일반포장"){
				count = 1;
				
				selectedValues = "일반포장,";
				$('#selectedValues').val(selectedValues);
				
				//selectedArray[i] -> 선택된 배송방법의 value들
				selectedAmounts += ($('#g_amount_일반포장').val() + ", ")
				
				//추가된 values 변수를 태그에 담기
				$("#selectedAmounts").val(selectedAmounts);
				
				document.fr.action="./BasketAdd2.ba";
				document.fr.submit();

			}
		}
	}
	
	//관심상품 버튼을 클릭했을 시
	function wishlistChecked(){
		// 로그인된 상태면
		if(document.getElementById('id').value){
			var product_code = document.getElementById('product_code').value;
			//관심상품 db에 먼저 접근하여 해당 상품코드 값 저장하기
			$.ajax({
				type:'get',
				url:'./WishListAdd.wl',
				data:'product_code='+$('#product_code').val(),
				dataType:'html',
				success: function(data){
					if(data == 1){
						var goWishlist = confirm("관심상품에 등록되었습니다. \n관심상품으로 이동하시겠습니까?")
						if(goWishlist){
							location.href="./WishList.wl";
						}else{
							window.location.reload(); //현재 페이지 새로고침
						}
					}else if(data == -1){
						alert("이미 관심상품에 등록된 상품입니다.");
					}
				},error: function(request,status,error){
					alert("code=" + request.status + " message=" + request.responseText +" error=" + error);
				}
			});
	
		}else{
			alert("로그인을 먼저 해주세요.");
		}
	}
	
	
	//소메뉴 눌렸을시 --------------------------------------------------------------
	
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