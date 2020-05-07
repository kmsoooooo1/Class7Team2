<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
		<table>
			<tr>
				<td align="right"><h2>관심상품</h2></td>
				<td align="left"><img src=""></td>
			</tr>
			<tr>
				<td colspan="2">관심있는 상품을 담아보세요.</td>
			</tr>
		</table>
		<br><br>
		<table>
			<tr align="center">
			<td>
				<a href="./MemberPage.me">마이페이지</a> | 
				<a href="#">주문내역</a> | 
				<a href="./MemberInfo.me">회원정보</a> | 
				<a href="#">관심상품</a> | 
				<a href="#">적립금</a> | 
				<a href="#">쿠폰</a> | 
				<a href="./BoardList.bo?category=1">게시물</a> | 
				<a href="#">배송주소록</a> | 
			</td>
			</tr>
		</table>
		<table width="100%" cellpadding="10" cellspacing="0">
			<tr>
				<td colspan="9">
					<hr color="#D8D8D8" width="100%">
				</td>
			</tr>
			<tr>
				<th><input type="checkbox" name="chk" value="chk"></th>
				<th>이미지</th>
				<th width="30%">상품정보</th>
				<th>판매가</th>
				<th>적립금</th>
				<th>배송구분</th>
				<th>배송비</th>
				<th>합계</th>
				<th>선택</th>
			</tr>
			<tr>
				<td colspan="9">
					<hr color="#D8D8D8" width="100%">
				</td>
			</tr>
			<c:if test="${list==null || list.size()==0}">
			<tr>
				<td align="center" colspan="9">관심 상품이 없습니다.</td>
			</tr>
			</c:if>
			<c:forEach var="dto" items="${list}">
			<tr>
				<td><input type="checkbox" name="chk" value="chk"></td>
				<td>image</td>
				<td>content</td>
				<td>price</td>
				<td>point</td>
				<td>deliv</td>
				<td>deliprice</td>
				<td>total</td>
				<td>select</td>
			</tr>
			</c:forEach>
			<tr>
				<td colspan="9">
					<hr color="#D8D8D8" width="100%">
				</td>
			</tr>
		</table>
		<br><br>
		<table width="100%">
			<tr>
				<td align="left">선택상품 삭제하기 | 선택상품 장바구니 담기</td>
				<td align="right">전체상품 주문 | 관심상품 비우기</td>
			</tr>
		</table>
	</div>
</body>
</html>