<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="team2.animal.db.AnimalDTO"%>
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
		//AnimalListAction 객체에서 저장된 정보를 저장 
		List<AnimalDTO> animalList = (List<AnimalDTO>) request.getAttribute("animalList");
	%>

	<!-- Header -->
	<header> <jsp:include page="/include/header.jsp" /> </header>
	
	<!-- Main Content -->
	
	<table border="1">
		<%    
	        int size = animalList.size();
		    int col = 4;
		    int row = (size / col) + (size%col>0? 1:0);
		    int num = 0;
		
			for (int a = 0; a < row; a++) {
		%>
		<tr>
			<%
				for (int i = 0; i <col; i++) {
					AnimalDTO adto = animalList.get(num);
					//###,###,###원 표기하기 위해서 format 바꾸기
					DecimalFormat formatter = new DecimalFormat("#,###,###,###");
					String newformat_price = formatter.format(adto.getA_price());
					
			%>
			
			<td colspan="2">
  			<a href='./AnimalDetail.an?a_code=<%=adto.getA_code()%>'> <img src="./upload/multiupload/<%=adto.getA_image().split(",")[0]%>" width="300" height="300"> </a> <br> 
		    <a href='./AnimalDetail.an?a_code=<%=adto.getA_code()%>'> <%=adto.getA_morph()%>/<%=adto.getA_sex()%>/<%=adto.getA_status()%> </a> <br>
		    <%=newformat_price%>원 <br>    
			</td>
			<%
			   num++;  
			   if(size <= num) break;
			 }			
			%>
		</tr>
		<%}%>
	
	</table>
	
	<!-- FOOTER -->
	<footer> <jsp:include page="/include/footer.jsp"/> </footer>
	
</body>
</html>