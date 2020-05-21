<%@page import="team2.member.db.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${pageContext.request.contextPath}/css/memberList.css" rel="stylesheet">
<title>회원 목록 페이지</title>
</head>
<body>

	<!-- Header -->
	<jsp:include page="/include/header.jsp" />

<%
		// 세션값 제어( 로그인,관리자 여부 )
		String id = (String) session.getAttribute("id");
	    
	    if(id == null || !id.equals("admin")){
	    	response.sendRedirect("MemberLogin.me");
	    }

		// 이전페이지에서 전달된 데이터를 처리 (회원목록리스트)
		// request 영역에 저장
		// request.setAttribute("memberList", memberList);
		List<MemberDTO> memberList 
		   = (List<MemberDTO>)request.getAttribute("memberList");

		// 표를 사용해서 데이터 출력
	%>
	
 <div class="board">
 
  <div class="top">
   <div class="boardname">
    <h2>
      	회원 목록 페이지
    </h2>
   </div>
   <div class="list-div">
	  <table class="list">
	   <colgroup>
	   	<col width="5%" />
	   	<col width="5%" />
	   	<col width="5%" />
	   	<col width="10%" />
	   	<col width="5%" />
	   	<col width="30%" />
	   	<col width="15%" />
	   	<col width="10%" />
	   	<col width="10%" />
	   </colgroup>
	   <thead>
	    <tr>
	      <th>아이디</th>
	      <th>비밀번호</th>
	      <th>이름</th>
	      <th>휴대전화</th>
	      <th>우편번호</th>
	      <th>주소</th>
	      <th>상세주소</th>
	      <th>이메일</th>
	      <th>가입일자</th>
	    </tr>
	   </thead>  
	    <%
	       for(int i=0;i<memberList.size();i++){
	    	      MemberDTO mdto = memberList.get(i);
	    	   %>
	    	   <tbody>
	    	    <tr>
			      <td><%=mdto.getId() %></td>
			      <td><%=mdto.getPass() %></td>
			      <td><%=mdto.getName() %></td>
			      <td><%=mdto.getPhone() %></td>
			      <td><%=mdto.getZipcode() %></td>
			      <td class="addr"><%=mdto.getAddr1() %></td>
			      <td><%=mdto.getAddr2() %></td>
			      <td><%=mdto.getEmail() %></td>
			      <td><%=mdto.getReg_date() %></td>
			    </tr>
			   </tbody> 
	    	   <%
	       }
	    %>
	  </table>
	  </div>
	  <hr>
	  <div class="bottom">
		<div class="button">

		<input type="button" value="관리자 페이지로 이동" onclick="location.href='./Main.ad'">
		</div>
	</div>
 </div>
 </div>
	<!-- Footer -->
	<jsp:include page="/include/footer.jsp" />
</body>
</html>