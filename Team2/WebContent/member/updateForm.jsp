<%@page import="team2.member.db.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 가입 </title>
<script>
	//submit을 눌렀을 때 호출되는 함수
	//유효성 검사를 위한 함수
	function check() {  //전송될때 불러지는 함수.
	
	// ID 가져오는건 window.onload 안에서만 가져올 수 있으므로 forms는 안쓰는걸로 한다. ★★★★
	var id1 = joinform.id.value;
	var mobile = joinform.phone.value;
	//var forms = document.getElementById("joinform");				
		if ((joinform.name.value == "")
				|| (joinform.name.value.length <= 1)) {
					alert("이름을 제대로 입력해 주세요.");
					joinform.name.focus();
					return false;
				}
				if (id1.length == 0) {
					alert("아이디를 입력하세요.");
					joinform.id.focus();
					return false;
				}
				if (mobile.length == 0) {
					alert("휴대폰 번호를 입력하세요.");
					joinform.phone.focus();
					return false;
				}

		//이름을 한글 2자이상 입력받기
		//정규식 객체 생성
		//정규식(javascript, java, c#, php에서 모두 활용) 객체 생성
		var regExp = /([가-힣]){2,}/g;  //가부터 힣까지 2글자 이상.
		
			if(!regExp.test(joinform.name.value)){
				alert("이름은 한글 2자 이상입니다.");
				return false;
			}


	function openConfirmId(joinform) {
		var id1 = joinform.id.value;
		var url = "./MemberIDCheckAction.me?id="
				+ joinform.id.value;

		if (id1.length == 0) {
			alert("아이디를 입력하세요.");
			joinform.id.focus();
			return false;
		}
		
		
		//상식 정규식은 항상 슬러시 / 로 시작한다.

		open(
				url,
				"confirm",
				"toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=400,height=200");
		
	}

	//숫자 키만 입력받도록 하기 위해서 숫자 인지 아닌 지를 판별해서
	//숫자가 아니면 이벤트가 발생하지 않은 것으로 해주는 함수
	function gNumCheck() {
		
	//크롬에서는 event로 iE에서는 window.event로 event 객체를 생성		
	var e = event || window.event;
			
	//누른 키값 가져오기
	//크롬에서는 keyCode로 IE에서는 which로 받아온다.
	//true(익스플로러)  false(크롬)
	var key = ('which' in e)?  e.which:e.keyCode;
		         	
		if (key < 48 || key> 57) {  //숫자외의 키가 들어온다면
		//IE에서 기본적으로 제공되는 이벤트 제거
		if(e.preventDefault)
		e.preventDefault();
	     //그이외 브라우저에서 기본적으로 제공되는 이벤트 제거
		else
		e.returnValue=false;
		}
	
	}
		
	function func(){
		//id에 (아이디입력창에) 포커스가 가면 수행되는 함수.
		joinform.idcheck.value="false";
		
	}
</script>
</head>
<body>
	<%
		String id = (String)session.getAttribute("id");
	
		if(id == null){
			response.sendRedirect("./MemberLogin.me");
		}
		
		MemberDTO mdto = (MemberDTO)request.getAttribute("mdto");
	
	%>
	
	<!-- Header -->
	<jsp:include page="/include/header.jsp" />

	<h2>회원 정보 수정 페이지</h2>
	
	<fieldset>
		<legend>회 원 정 보 수 정 </legend>
		<!-- 회원가입 -->
		<form action="./MemberUpdateAction.me" method="post" name="joinform"
			onsubmit="return check()">
		
		<!-- 중복체크를 하기위해서 히든을 이용해서 변수선언. 초기에 false선언
			  중복체크를하고나면 true로 변경. 단 다시 아이디 체크박스를 누르면 false로 변경!-->
			<input type="hidden" name="idcheck" value="false" />
			
		<table border="1">
		<tr>
		 	<td>아이디</td>
			<td>
			 <input type="text" name="id" size="20" maxlength=30 value="<%=mdto.getId() %>" readonly onfocus="func()"/>
			</td>
		</tr>
		<tr>
			<td>비밀번호</td> <td><input type="password" name="pass" required></td>
		</tr>
		<tr>
			<td>이름</td> <td><input type="text" name="name" value="<%=mdto.getName() %>" size="20"></td>
		</tr>
		<tr>
			<td>전화번호</td> 
			<!-- 눌렸을때 호출되는 gNumCheck()메서드 등록  -->
			<td><input type="text" name="phone" value="<%=mdto.getPhone() %>" onkeypress="gNumCheck()" size="24" />
			</td>
		</tr>
		<tr>
			<td>우편번호</td>
			<td><input type="text" name="zipcode" id="zipcode" size="7" value="<%=mdto.getZipcode() %>" readonly>
				<input type="button" value="주소찾기" onclick="DaumPostcode()">
			</td>
		</tr>
		<tr>
			<td>주소</td> <td><input type="text" value="<%=mdto.getAddr1() %>" name="addr1" id="addr1" size="40" readonly></td>
		</tr>
		<tr>
			<td>상세주소</td> <td><input type="text" value="<%=mdto.getAddr2() %>" name="addr2" id="addr2" size="40"></td>
		</tr>
		<tr>
			<td>이메일</td> <td><input type="email" value="<%=mdto.getEmail() %>" name="email"></td>
		</tr>
		</table>
		<input type="submit" value="회원정보 수정">
		<input type="reset" value="취소">
		
		<!-- ----- DAUM 우편번호 API 시작 ----- -->
<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 110px;position:relative">
  <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');
    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }
    function DaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수
                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1').value = fullAddr;
                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';
                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
                
                $('#addr2').focus();
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);
        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    } 
</script> 
<!-- ----- DAUM 우편번호 API 종료----- -->
		</form>	
	</fieldset>
	
	<!-- FOOTER -->
	<jsp:include page="/include/footer.jsp"/>
	
</body>
</html>