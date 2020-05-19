<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/css/basic.css" rel="stylesheet">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<title>Insert title here</title>
</head>
<body>
   <aside id="quick" class="fixed">
         <nav>
            <ul>
               <li>
               	<a href="./BasketList.ba">
               		<i class="fas fa-cart-plus"><span>&nbsp&nbsp장바구니</span></i>
               	</a>
               </li>
               <li>
               	<a href="./recentView.me">
               		<i class="fas fa-history"><span>&nbsp&nbsp최근본상품</span></i>
               	</a>
               </li>
               <li>
               	<a href="#" onclick="kakaoChat();" class="kakao_btn">
               		<i class="fas fa-comment-dots"><span>&nbsp&nbsp카톡 상담</span></i>
               	</a>
               </li>
               <li>
               	<a href="#">
               		<i class="fas fa-shipping-fast"><span>&nbsp&nbsp배송 조회</span></i>
               	</a>
               </li>
               <li>
               	<a href="#">
               		<i class="fas fa-heart"><span>&nbsp&nbsp관심상품</span></i>
               	</a>
               </li>
               <li>
               	<a href="#">
               		<i class="fas fa-search"><span>&nbsp&nbsp검색</span></i>
               	</a>
               </li>
            </ul>
         </nav>
      </aside>
</body>
<script type="text/javascript">
//카카오 채팅 상담 -----------------------------------------------------------------------------------
function kakaoChat() {
	var popupX = (window.screen.width / 6) - (200 / 2); 
	var popupY = (window.screen.height / 4) - (300 / 2);  
	window.open('https://pf.kakao.com/_iLxlxexb','windows','width=600,height=670,left='+popupX+',top='+popupY+',scrollbars=yes');
}
</script>

</html>