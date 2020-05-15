<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/css/hospital.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/basic.css" rel="stylesheet">
<title>Insert title here</title>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/kakao/kakao.js"></script>
<!-- 	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d008964a68ee4b1fba3fe111db8b5b6b"></script> -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d008964a68ee4b1fba3fe111db8b5b6b&libraries=services,clusterer,drawing"></script>
	<script type="text/javascript">
		//	SDK 초기화
		Kakao.init('437fde8f58dcf68d0d0bb1f6f7691c54');
		//	SDK 초기화 여부 판단
		console.log(Kakao.isInitialized());
	</script>
</head>
<body>

	<!-- Header -->
	<jsp:include page="/include/header.jsp" />
	
<div class="body">

	<div class="main">
	
		<div class="desc_wrap">
			<span class="title">동물병원 정보</span>
			<p class="desc">현재 위치 근처의 동물병원 검색 결과를 보여줍니다.</p>
		</div>
		<div class="content_wrap">
			<div class="map" id="map"></div>
			<div class="list">
				<ul id="spaceList">
				</ul>
				<ul id="pageList">
				</ul>
			</div>
		</div>
	</div>
		
</div>

	<!-- FOOTER -->
	<jsp:include page="/include/footer.jsp"/>

</body>
<script type="text/javascript">
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 4 // 지도의 확대 레벨 
	    }; 
	var sList = document.getElementById('spaceList');
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	var ps = new kakao.maps.services.Places();
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	var ps = new kakao.maps.services.Places();
	var pageList = document.getElementById('pageList');
	
	//	페이징 처리 함수
	var pageNum = <%=request.getParameter("page")%>;
	if(pageNum==null){
		pageNum = 1;
	}
	var pageSize = 6;
	
	var dataList = [];
	// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
	if (navigator.geolocation) {
	    
	    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
	    navigator.geolocation.getCurrentPosition(function(position) {
	        
	        var lat = position.coords.latitude, // 위도
            lon = position.coords.longitude; // 경도
	        
            console.log('수정위치 : '+lat + ', ' + lon);
            
	        var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
	            message = ''; // 인포윈도우에 표시될 내용입니다
	        
	        // 마커와 인포윈도우를 표시합니다
	        displayMarker(locPosition, message);
	        
	        ps.keywordSearch('동물병원', placesSearchCB,{
        		location: new kakao.maps.LatLng(lat, lon)}
        	);
	            
	      });
	    
	} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
	    
	    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
	        message = 'geolocation을 사용할수 없어요..'
	        
	    displayMarker(locPosition, message);
	}
	
	function outputList(){
		
		var startNum = (pageNum-1)*pageSize;
		var endNum = pageNum*pageSize>dataList.length?dataList.length:pageNum*pageSize;
		
		var StartPage = 0;
		var EndPage = dataList.length/pageSize;
		
		console.log(dataList);
		
		for(var i = startNum; i<endNum; i++){
			
			var textnode;
	        var node = document.createElement("li");	  									     		// Create a <li> node
	        node.className = 'h_list';
	        var div = document.createElement("div");
	        div.className = 'list_div';
	        
	        var span = document.createElement("span");
	        span.className = 'place_name';
	        textnode = document.createTextNode(dataList[i].place_name);
	        span.appendChild(textnode);
	        div.appendChild(span);
	        
	        span = document.createElement("span");
				span.className = 'phone';
	        textnode = document.createTextNode(dataList[i].phone);
	        span.appendChild(textnode);
	        div.appendChild(span);
	        
	        
	        span = document.createElement("span");
	        span.className = 'address_name';
	        textnode = document.createTextNode("구 주소 : "+dataList[i].address_name);
	        span.appendChild(textnode);
	        div.appendChild(span);
	        
	        span = document.createElement("span");
	        span.className = 'road_address_name';
	        textnode = document.createTextNode("도로명 주소 : "+dataList[i].road_address_name);
	        span.appendChild(textnode);
	        div.appendChild(span);
	        div.setAttribute('onclick', "location.href='" + dataList[i].place_url +"';");
	        
	        node.appendChild(div);
	                                    									// Append the text to <li>
	        sList.appendChild(node);     // Append <li> to <ul> with id="myList"
		}
		
		for(var i = StartPage; i<EndPage; i++){
			var textnode;
			var node = document.createElement("li");
			node.setAttribute('onclick', "location.href='./aHospital.bo?page="+(i+1)+"'");
			textnode = document.createTextNode(i+1);
			node.appendChild(textnode);
			pageList.appendChild(node);
		}
		
	}
	
	
	// 지도에 마커와 인포윈도우를 표시하는 함수입니다
	function displayMarker(locPosition, message) {
	
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({  
	        map: map, 
	        position: locPosition
	    }); 
	    
	    var iwContent = message, // 인포윈도우에 표시할 내용
	        iwRemoveable = true;
	
	    // 인포윈도우를 생성합니다
	    var infowindow = new kakao.maps.InfoWindow({
	        content : iwContent,
	        removable : iwRemoveable
	    });
	    
	    // 인포윈도우를 마커위에 표시합니다
	    
	    // 지도 중심좌표를 접속위치로 변경합니다
	    map.setCenter(locPosition);      
	}
	
	function placesSearchCB (data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        var bounds = new kakao.maps.LatLngBounds();

	        for (var i=0; i<data.length; i++) {
	            displayMarker(data[i]);
	            console.log(data[i]);

	            dataList.push(data[i]);

	            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
	        }       

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	        map.setBounds(bounds);
	        
	        outputList();
	    } 
	}
	
	function displayMarker(place) {
	    
	    // 마커를 생성하고 지도에 표시합니다
	    var marker = new kakao.maps.Marker({
	        map: map,
	        position: new kakao.maps.LatLng(place.y, place.x) 
	    });

	    // 마커에 클릭이벤트를 등록합니다
	    kakao.maps.event.addListener(marker, 'click', function() {
	        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
	        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
	        infowindow.open(map, marker);
	    });
	}
	
	
	
</script>
</html>