<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<link href="${pageContext.request.contextPath}/css/basic.css?ver=2" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
	<!-- side 퀵바 -->
 <div id="quick">
 		 <p>
           	<a href="./BasketList.ba" class="basket_quick">
           		<i class="fas fa-cart-plus"></i>
           		<span>장바구니</span>
           	</a>
           	<a href="./recentView.me" class="recent_quick">
           		<i class="fas fa-history"></i>
           		<span>최근 본 상품</span>
           	</a>
           	<a href="#" onclick="kakaoChat();" class="kakao_quick">
           		<i class="fas fa-comment-dots"></i>
           		<span>카톡 상담</span>
           	</a>
           	<a href="./OrderList.or" class="order_quick">
           		<i class="fas fa-shipping-fast"></i>
           		<span>주문 상품</span>
           	</a>
           	<a href="./WishList.wl" class="interest_quick">
           		<i class="fas fa-heart"></i>
           		<span>관심 상품</span>
           	</a>
           
           	<a href="#h-group" class="up_quick">
           		<i class="fas fa-angle-double-up"></i>
           		<span>맨위로</span>
           	</a>
           	<a href="#copyright" class="down_quick">
           		<i class="fas fa-angle-double-down"></i>
           		<span>맨아래로</span>
           	</a>
         </p>
      </div>
<!-- side 퀵바 -->
</body>
<script type="text/javascript">
//카카오 채팅 상담 -----------------------------------------------------------------------------------
function kakaoChat() {
	var popupX = (window.screen.width / 6) - (200 / 2); 
	var popupY = (window.screen.height / 4) - (300 / 2);  
	window.open('https://pf.kakao.com/_iLxlxexb','windows','width=600,height=670,left='+popupX+',top='+popupY+',scrollbars=yes');
}


window.onscroll = function() {myFunction()};

var header = document.getElementById("nav_menu");
var sticky = header.offsetTop;

function myFunction() {
  if (window.pageYOffset > sticky) {
    header.classList.add("sticky");
  } else {
    header.classList.remove("sticky");
  }
}
</script>
</html>