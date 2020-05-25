<%@page import="java.util.List"%>
<%@page import="team2.member.db.MemberPointDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/css/searchItem.css" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
	<%
		String id = (String) session.getAttribute("id");
	
		List<MemberPointDTO> pointList = (List<MemberPointDTO>)request.getAttribute("pointList");
	%>
	
	<div id="container">
		<div class="page_title">
			<span> Mileage (적립금) </span>
		</div>
	
			<div class="inner" style="margin: 20px;">
			<div class="search_list">
				<table class="list_table" style="width:100%">
					<colgroup>
						<col width="10%">
						<col width="15%">
						<col width="20%">
						<col width="20%">
						<col width="auto">
					</colgroup>
					<tr>
						<td>번호</td>
						<td>아이디</td>
						<td>포인트</td>
						<td>획득경로</td>
						<td>날짜</td>
					</tr>
					<%
					int num = 1;
					for(int i=0; i<pointList.size(); i++){
						MemberPointDTO mpdto = pointList.get(i);
					%>
					<tr>
						<td><%=num %></td>
						<td><%=id %></td>
						<td><%=mpdto.getPoint() %></td>
						<td><%=mpdto.getPoint_description() %></td>
						<td><%=mpdto.getDate() %></td>
					</tr>
					<%
					num++;
					}
					%>
				</table>
			</div>
		</div>
	</div>
	
	<jsp:include page="/include/footer.jsp"/>
	
</body>
</html>