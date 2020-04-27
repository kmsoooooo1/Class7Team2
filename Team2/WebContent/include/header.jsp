	
	<div>
		<%
			request.setCharacterEncoding("utf-8");
		
			//로그인 되었는지	
			String id = (String) session.getAttribute("id");
			if(id == null){	
		%>
			<a href=""> 관리자 페이지 임시 </a>
			<a href=""> 회원가입 </a>
			<a href=""> 로그인 </a>
		<% }else if(id.equals("admin")) { %>
			<a href=""> 관리자 페이지 </a>
			<a href=""> 로그아웃 </a>
		<% }else{ %>
			<a href=""> 로그아웃 </a>
		<% } %> 
	</div>