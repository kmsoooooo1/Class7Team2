<%@page import="team2.board.action.PageMaker"%>
<%@page import="team2.board.action.Criteria"%>
<%@page import="team2.board.db.PDAO"%>
<%@page import="team2.board.db.ProductDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="team2.board.action.cSet"%>
<%@page import="team2.goods.db.GoodsDAO"%>
<%@page import="java.util.List"%>
<%@page import="team2.animal.db.AnimalDAO"%>
<%@page import="team2.animal.db.AnimalDTO"%>
<%@page import="team2.goods.db.GoodsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/css/searchItem.css" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String c_str = request.getParameter("C");
	String page_str = request.getParameter("pageNum");
	int pagea = 0;
	if(page_str!=null){
		pagea = Integer.parseInt(page_str);
	}
	int c = 0;
	if(c_str != null){
		c = Integer.parseInt(c_str);
	}
	String product = request.getParameter("product");
	String cate = request.getParameter("cate");
	String kind = request.getParameter("kind");
	
	String keyword = request.getParameter("keyword");
	
	List<ProductDTO> list = new ArrayList<>();
	GoodsDAO gdao = new GoodsDAO();
	AnimalDAO adao = new AnimalDAO();
	if(product==null){
		if(keyword==null || keyword.equals("")){
			list = PDAO.getProduct(gdao.getGoodsList(), adao.getAnimalList("all", "", ""));
		}else{
			list = PDAO.getProduct(adao.searchKeyword(keyword),gdao.searchKeyword(keyword));
			 
		}
	}else if(product.equals("ANIMAL")){
		//	animal 검색
		if(cate==null){
			list = PDAO.getProduct(null, adao.getAnimalList("all", "", ""));
		}else if(cate!=null && kind==null){
			list = PDAO.getProduct(null, adao.getAnimalList(cate, "all", ""));
		}else if(cate!= null && kind!=null){
			list = PDAO.getProduct(null, adao.getAnimalList(cate, kind, "all"));
		}
	}else if(product.equals("GOODS")){
		//	goods 검색
		if(cate==null){
			list = PDAO.getProduct(gdao.GoodsList("all", "", ""),null);
		}else if(cate!=null && kind==null){
			list = PDAO.getProduct(gdao.GoodsList(cate, "all", ""), null);
		}else if(cate!=null && kind!=null){
			list = PDAO.getProduct(gdao.GoodsList(cate, kind, "all"), null);
		}
	}
	gdao.closeDB();
	adao.closeDB();
	
	System.out.println("product : " + product);
	System.out.println("cate : " + cate);
	System.out.println("kind : " + kind);
	System.out.println("keyword : " + keyword);
	
	String[] cList = {};
		
	cSet cset = new cSet();
	
%>
	<div id="container">
		
		<div class="page_title">
			<span>상품검색</span>
		</div>
		<div class="inner">
		<form name="fr" method="post">
			<div class="input_wrap_div">
				<div class="select_div">
					<select class="input_select" name="product" onchange="return pChange();">
						<option value="-">전체</option>
						<option value="ANIMAL" <%if(product!=null && product.equals("ANIMAL")){ %> selected="selected" <%} %>>동물</option>
						<option value="GOODS" <%if(product!=null && product.equals("GOODS")){ %> selected="selected" <%} %>>상품</option>
					</select>
				<%if(product!=null && !product.equals("-")){
					if(product.equals("ANIMAL")){
						cList = cset.ANIMAL;
					}else if(product.equals("GOODS")){
						cList = cset.GOODS;
					}
				}
				%>
					<select class="input_select" name="cate" onchange="return cChange();">
						<option value="-">전체</option>
					<%if(cList.length>0){
						for(String str:cList){ %>
						<option value="<%=str %>" <%if(cate!=null && cate.equals(str)){ %> selected="selected" <%} %>><%=str %></option>		
					<%	}
					  }%>
					</select>
				<%
				  if(product!=null && cate!=null){
				  	if(cate.equals("파충류")){
				  		cList = cset.ANIMAL_R;
				  	}else if(cate.equals("양서류")){
				  		cList = cset.ANIMAL_A;
				  	}else if(cate.equals("먹이")){
				  		cList = cset.GOODS_F;
				  	}else if(cate.equals("사육용품")){
				  		cList = cset.GOODS_B;
				  	}
				  }
				  %>
				  	<select class="input_select" name="kind" onchange="return kChange();">
				  		<option value="-">전체</option>
		  		<%if(cList.length>0){
		  			for(String str:cList){ %>
		  				<option value="<%=str %>" <%if(kind!=null && str.equals(kind)){ %> selected="selected" <%} %>><%=str %></option>
		  		<%	}
				  } %>
				  	</select>
			  	</div>
			  	<input hidden="hidden">
			  	<div class="keyword_div">
					<input  class="input_text" type="text" name="keyword" ><button class="input_btn" type="button" onclick="return getkeyword();">search</button>
				</div>
			</div>
		</form>
			<div class="search_list">
				<table class="list_table">
				<colgroup>
					<col width="10%">
					<col width="15%">
					<col width="30%">
					<col width="15%">
					<col width="15%">
					<col width="15%">
				</colgroup>
					<tr>
						<th>CODE</th>
						<th>IMAGE</th>
						<th>NAME</th>
						<th>CATEGORY</th>
						<th>SUB<br>CATEGORY</th>					
						<th>DETAIL</th>						
					</tr>
			<%if(list.size()>0){ 
				for(ProductDTO dto:list){
					%>
					<tr class="choice_tr" onclick="choice('<%=dto.getP_code()%>');">
						<td><%=dto.getP_code() %></td>
						<td><img src="./upload/multiupload/<%=dto.getImg_src() %>" alt="" width="100" height="100"></td>
						<td><%=dto.getName() %></td>
						<td><%=dto.getCategory() %></td>
						<td><%=dto.getSub_category() %></td>
						<td><%=dto.getSub_category_idx() %></td>
					</tr>
			<%}
			}else{ %>
					<tr>
						<td colspan="6">상품목록이 없습니다</td>
					</tr>
			<%} %>
				</table>
			</div>
		</div>
	</div>
	<jsp:include page="/include/footer.jsp"/>
</body>
<script type="text/javascript">
	var Product = document.fr.product;
	var Cate = document.fr.cate;
	var kind = document.fr.kind;
<%if(product==null){%>
	Cate.style.display = "none";
	kind.style.display = "none";
<%}%>
<%if(cate==null){%>
	kind.style.display = "none";
<%}%>
	
	function pChange(){
		if(Product.value=="-"){
			Product.value= "";
			Cate.value = "";
			kind.value = "";
		}else{
			Cate.value = "";
			kind.value = "";
		}
		document.fr.submit();
	}
	function cChange(){
		if(Cate.value=="-"){
			Cate.value = "";
			kind.value = "";
		}else{
			kind.value="";
		}
		document.fr.submit();
	}
	function kChange(){
		if(kind.value=="-"){
			kind.value="";
		}
		document.fr.submit();
	}
	
	function getkeyword(){
		Product.value= "";
		Cate.value = "";
		kind.value = "";
		
		document.fr.submit();
	}
	function choice(p_code){
		opener.location.href='${pageContext.request.contextPath}/Insert.bo?C=<%=c%>&CODE='+p_code;
		window.close();
	}
	
</script>

</html>