<%@page import="team2.member.db.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
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
	  <table border="1">
	    <tr>
	      <td>아이디</td>
	      <td>비밀번호</td>
	      <td>이름</td>
	      <td>휴대전화</td>
	      <td>우편번호</td>
	      <td>주소</td>
	      <td>상세주소</td>
	      <td>이메일</td>
	      <td>가입일자</td>
	    </tr> 
	    
	    <%
	       for(int i=0;i<memberList.size();i++){
	    	      MemberDTO mdto = memberList.get(i);
	    	   %>
	    	    <tr>
			      <td><%=mdto.getId() %></td>
			      <td><%=mdto.getPass() %></td>
			      <td><%=mdto.getName() %></td>
			      <td><%=mdto.getPhone() %></td>
			      <td><%=mdto.getZipcode() %></td>
			      <td><%=mdto.getAddr1() %></td>
			      <td><%=mdto.getAddr2() %></td>
			      <td><%=mdto.getEmail() %></td>
			      <td><%=mdto.getReg_date() %></td>
			    </tr>
	    	   <%
	       }
	    %>
	  </table>
	  
	  <h2><a href="./MemberPage.me"> 마이페이지 이동 </a></h2>

</body>
</html>