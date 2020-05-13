<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/css/join.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
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
				else if(joinform.email.value == ""){
					alert("이메일을 입력해주세요.");
					joinform.email.focus();
					return false;
				}
				if ((joinform.pass.value == "") 
				|| (!/^(?=.*[a-z])(?=.*[0-9]).{8,25}$/.test($('#pass').val()))){
					alert("비밀번호가 조건에 맞지 않습니다.");
					joinform.pass.focus();
					return false;
				}
				else if (!/^(?=.*[a-z])(?=.*[0-9]).{8,25}$/.test($('#user_pass_confirm').val())){
					alert("비밀번호 확인란을 다시 입력해주세요.");
					joinform.user_pass_confirm.focus();
					return false;
				}
				else if(document.joinform.pass.value != document.joinform.user_pass_confirm.value){
					alert("비밀번호가 동일하지 않습니다.");
					joinform.user_pass_confirm.focus();
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

		//중복확인을 했는지 검사
		//그리고 중복확인을하고나서도 포커스를 눌려서 아이디를 수정한경우를 막기 위한 코드이기도함
						
		if(joinform.idcheck.value == "false"){
			alert("아이디 중복 검사를 하지 않으셨습니다.");
			return false;
		}	
		return true;
			
		
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
	<!-- Header -->
	<jsp:include page="/include/header.jsp" />
	
	<div class="contents">
		<div class="box">
		<!-- 회원가입 -->
		<form action="./MemberJoinAction.me" method="post" name="joinform" id="joinform"
			onsubmit="return !!(check() & send(this))">
		
		<!-- 중복체크를 하기위해서 히든을 이용해서 변수선언. 초기에 false선언
			  중복체크를하고나면 true로 변경. 단 다시 아이디 체크박스를 누르면 false로 변경!-->
			<input type="hidden" name="idcheck" value="false" />
	
		 	<h2 class="name">아이디</h2>
		 	<div>
			 <input type="text" class="id" name="id" size="20" maxlength=30 onfocus="func()"/>
			 <input type="button" class="btn" name="confirm_id" value="중복확인" onclick="openConfirmId(this.form)" /><br>
			</div>
			 <h2 class="name">비밀번호</h2>
			<p id="passp"><input type="password" id="pass" name="pass" class="inputTypeText" onkeyup="checkValidPW()"> (영문/숫자 조합, 8자리 이상) &nbsp; <span id="pwConstraintMsg"></span><p><br>
			
			<h2 class="name">비밀번호 확인</h2> 
			<input type="password" id="user_pass_confirm" name="user_pass_confirm" onkeyup="checkSamePW()" class="inputTypeText"> &nbsp; <span id="pwConfirmMsg"></span><br>
			
			<h2 class="name">이름</h2>
			<input type="text" id="name" name="name" size="20"><br>
			<h2 class="name">전화번호</h2>
			<!-- 눌렸을때 호출되는 gNumCheck()메서드 등록  -->
			<input type="text" id="phone" name="phone" onkeypress="gNumCheck()" size="24" />
			<h2 class="name">우편번호</h2>
			<input type="text" name="zipcode" id="zipcode" size="7" readonly>
				<input type="button" value="주소찾기" onclick="DaumPostcode()">
			<h2 class="name">주소</h2>
			<input type="text" name="addr1" id="addr1" size="40" readonly>
			<h2 class="name">상세주소</h2>
			<input type="text" name="addr2" id="addr2" size="40">
			<h2 class="name">이메일</h2>
			<input type="email" id="email" name="email"><br></br>
            <textarea cols="107" rows="14" readonly>Community 서비스약관 (2020. 1. 01 부터 유효)

제1조(목적 등)

 
① Community (www.j'sD&NBox.co.kr) 서비스 약관(이하 "본 약관"이라 합니다)은 이용자가 ㈜ www_pilot(이하 "Community"이라 합니다)에서 제공하는 인터넷 관련 서비스(이하 "서비스"라 합니다)를 이용함에 있 어 이용자와 "Community"의 권리·의무 및 책임사항을 규정함을 목적으로 합니다.
 
② 이용자가 되고자 하는 자가 "Community"이 정한 소정의 절차를 거쳐서 "등록하기" 단추를 누르면 본 약관에 동의하는 것 으로 간주합니다. 본 약관에 정하는 이외의 이용자와 "Community"의 권리, 의무 및 책임사항에 관해서는 전기통신사업법 기 타 대한민국의 관련 법령과 상관습에 의합니다. 
 

제2조(이용자의 정의)

 
① 이용자"란 "Community"에 접속하여 본 약관에 따라 "Community" 회원으로 가입하여 "Community"이 제공하는 서비스를 받는 자를 말합니다. 
 

제3조(회원 가입)

 
① 이용자가 되고자 하는 자는 "Community"이 정한 가입 양식에 따라 회원정보를 기입하고 "등록하기" 단추를 누르는 방법으로 회원 가입을 신청합니다. 
 
② "Community"은 제1항과 같이 회원으로 가입할 것을 신청한 자가 다음 각 호에 해당하지 않는 한 신청한 자를 회원으로 등록합니다. 
 
 1. 가입신청자가 본 약관 제6조 제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우. 다만 제6조 제3항에 의한 회원자 격 상실 후 3년이 경과한 자로서 "Community"의 회원재가입 승낙을 얻은 경우에는 예외로 합니다. 
2. 등록 내용에 허위, 기재누락, 오기가 있는 경우 
3. 기타 회원으로 등록하는 것이 "Community"의 기술상 현저히 지장이 있다고 판단되는 경우 
 
③ 회원가입계약의 성립시기는 "Community"의 승낙이 가입신청자에게 도달한 시점으로 합니다. 
 
④ 회원은 제1항의 회원정보 기재 내용에 변경이 발생한 경우, 즉시 변경사항을 정정하여 기재하여야 합니다. 
 

제4조(서비스의 제공 및 변경)

 
① "Community"은 이용자에게 아래와 같은 서비스를 제공합니다.
1. 한메일넷 서비스
2. 인터넷동호회 카페 이용서비스
3. 칼럼 서비스 
4. 메시지 전송, 메일 통보, 친구찾기, 1:1 채팅, 실시간 뉴스, 증권정보의 제공 등을 내용으로 하는 메신저 서비스
5. 이동통신(핸드폰/PCS)으로 문자메세지를 발송할 수 있는 SMS서비스를 비롯한 무선인터넷 서비스 
6. 사람찾기 서비스. 다만, 사람찾기 서비스를 통하여 자신의 이용자정보가 공개되기를 원하지 않는 이용자는 가입시 또는 가입후 이용자정보관리 화면에서 비공개로 설정할 수 있습니다.
7. 회원을 위한 섹션 및 컨텐트 서비스, 맞춤 서비스
8. 기타 "Community"이 자체 개발하거나 다른 회사와의 협력계약 등을 통해 회원들에게 제공할 일체의 서비스
 
② "Community"은 그 변경될 서비스의 내용 및 제공일자를 제7조 제2항에서 정한 방법으로 이용자에게 통지하고, 제1항에 정한 서비스를 변경하여 제공할 수 있습니다.
 
③ "Community"은 "한메일넷 서비스"의 원활한 수행을 저해하는 제3자와 이용자간 혹은 이용자간 스팸메일, 대량메일 등 의 전송행위를 방지하기 위하여 여러가지 기술적, 제도적 정책(예: 온라인 우표제, 스팸메일방지정책 등)을 시행할 수 있으며, 이 로 인하여 "이용자"는 "Community"이 제공하는 "한메일넷 서비스" 이용에 제한을 받을 수 있습니다.(2001년 12 월 18일자 변경) 
 

제5조(서비스의 중단)

 
① "Community"은 컴퓨터 등 정보통신설비의 보수점검·교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제 공을 일시적으로 중단할 수 있고, 새로운 서비스로의 교체 기타 "Community"이 적절하다고 판단하는 사유에 기하여 현재 제공 되는 서비스를 완전히 중단할 수 있습니다. 
 
② 제1항에 의한 서비스 중단의 경우에는 "Community"은 제7조 제2항에서 정한 방법으로 이용자에게 통지합니다. 다 만, "Community"이 통제할 수 없는 사유로 인한 서비스의 중단(시스템 관리자의 고의, 과실이 없는 디스크 장애, 시스 템 다운 등)으로 인하여 사전 통지가 불가능한 경우에는 그러하지 아니합니다. 
 

제6조(이용자 탈퇴 및 자격 상실 등)

 
① 이용자는 "Community"에 언제든지 자신의 회원 등록을 말소해 줄 것(이용자 탈퇴)을 요청할 수 있으며 "Community"은 위 요청을 받은 즉시 해당 이용자의 회원 등록 말소를 위한 절차를 밟습니다. 
 
② 이용자가 다음 각 호의 사유에 해당하는 경우, "Community"은 이용자의 회원자격을 적절한 방법으로 제한 및 정지, 상실시킬 수 있습니다. 
 
 1. 가입 신청 시에 허위 내용을 등록한 경우 
2. 다른 사람의 "서비스" 이용을 방해하거나 그 정보를 도용하는 등 전자거래질서를 위협하는 경우 
3. "서비스"를 이용하여 법령과 본 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우 
 
③ "Community"이 이용자의 회원자격을 상실시키기로 결정한 경우에는 회원등록을 말소합니다. 이 경우 이용자인 회원에게 회원 등록 말소 전에 이를 통지하고, 말소통지를 받은 날로부터 30일 이내에 소명할 기회를 부여합니다. (2005년 7월 18일자 변 경) 
 
④ "이용자"가 본 약관에 의해서 회원 가입 후 "서비스"를 이용하는 도중, 연속하여 3개월 동안 "서비스"를 이용하기 위 해 log-in한 기록이 없는 경우, "Community"은 이용자로 하여금 "한메일넷 서비스" 상에서 전자우편을 수령할 수 없도 록 제한을 가할 수 있습니다. (2001년 12월 18일자 변경)
 
⑤ "이용자"가 본 약관에 의해서 회원 가입 후 "서비스"를 이용하는 도중, 연속하여 1년 동안 "서비스"를 이용하기 위 해 log-in한 기록이 없는 경우, "Community"은 이용자의 회원자격을 상실시킬 수 있습니다.(2002년 6월28일자 변 경)  

제7조(이용자에 대한 통지)

 
① "Community"이 특정 이용자에 대한 통지를 하는 경우 "Community"이 부여한 메일주소로 할 수 있습니다. 
 
② "Community"이 불특정다수 이용자에 대한 통지를 하는 경우 칠(7)이상 "Community" 게시판에 게시함으로써 개별 통지에 갈음할 수 있습니다. 
 

제8조(이용자의 개인정보보호)

 
① "Community"은 맞춤서비스 제공을 목적으로, 이용자가 "Community"회원으로 가입하는 시점에서, 이름, 성별, 주소, 연락처, 생년월일을 필수적인 개인정보로 수집합니다. (2005년 7월 18일자 신설) 
 
② "Community"은 관련법령이 정하는 바에 따라서 이용자 등록정보를 포함한 이용자의 개인정보를 보호하기 위하여 노력합니 다. 이용자의 개인정보보호에 관해서는 관련법령 및 "Community"이 정하는 "개인정보보호정책"에 정한 바에 의합니다. 
 

제9조("Community"의 의무)

 
① "Community"은 법령과 본 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 본 약관이 정하는 바에 따라 지속적이고, 안정적으로 서비스를 제공하기 위해서 노력합니다. 
 
② "Community"은 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함)보호를 위한 보안 시스템을 구축합니다. 
 
③ "Community"은 이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다. 
 
④ "Community"은 이용자가 서비스를 이용함에 있어 "Community"의 고의 또는 중대한 과실로 인하여 입은 손해를 배상할 책임을 부담합니다. 
 

제10조(이용자의 ID 및 비밀번호에 대한 의무)

 
① "Community"이 관계법령, "개인정보보호정책"에 의해서 그 책임을 지는 경우를 제외하고, 자신의 ID와 비밀번호에 관한 관리책임은 각 이용자에게 있습니다. 
 
② 이용자는 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다. 
 
③ 이용자는 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 "Community"에 통보하고 "Community"의 안내가 있는 경우에는 그에 따라야 합니다. 
 

제11조(이용자의 의무)

 
① 이용자는 다음 각 호의 행위를 하여서는 안됩니다. 
 
1. 회원가입신청 또는 변경시 허위내용을 등록하는 행위 
2. "Community"에 게시된 정보를 변경하는 행위
3. "Community" 기타 제3자의 인격권 또는 지적재산권을 침해하거나 업무를 방해하는 행위 
4. 다른 회원의 ID를 도용하는 행위 
5. 정크메일(junk mail), 스팸메일(spam mail), 행운의 편지(chain letters), 피라미드 조직에 가입 할 것을 권유하는 메일, 외설 또는 폭력적인 메시지 ·화상·음성 등이 담긴 메일을 보내거나 기타 공서양속에 반하는 정보를 공개 또 는게시하는 행위. 
6. 관련 법령에 의하여 그 전송 또는 게시가 금지되는 정보(컴퓨터 프로그램 등)의 전송 또는 게시하는 행위
7. 다음의 직원이나 다음 서비스의 관리자를 가장하거나 사칭하여 또는 타인의 명의를 모용하여 글을 게시하거나 메일을 발송하는 행위
8. 컴퓨터 소프트웨어, 하드웨어, 전기통신 장비의 정상적인 가동을 방해, 파괴할 목적으로 고안된 소프트웨어 바이러스, 기타 다른 컴퓨터 코드, 파일, 프로그램을 포함하고 있는 자료를 게시하거나 전자우편으로 발송하는 행위
9. 스토킹(stalking) 등 다른 이용자를 괴롭히는 행위
10. 다른 이용자에 대한 개인정보를 그 동의 없이 수집,저장,공개하는 행위
11. 불특정 다수의 자를 대상으로 하여 광고 또는 선전을 게시하거나 스팸메일을 전송하는 등의 방법으로 "Community"의 서비스를 이용하여 영리목적의 활동을 하는 행위
12. "Community"이 제공하는 서비스에 정한 약관 기타 서비스 이용에 관한 규정을 위반하는 행위
 
② 제1항에 해당하는 행위를 한 이용자가 있을 경우 "Community"은 본 약관 제6조 제2, 3항에서 정한 바에 따라 이용자의 회원자격을 적절한 방법으로 제한 및 정지, 상실시킬 수 있습니다.
 
③ 이용자는 그 귀책사유로 인하여 "Community"이나 다른 이용자가 입은 손해를 배상할 책임이 있습니다.
 
④ 민법상 미성년자인 이용자가 유료 콘텐츠 이용을 위해 결제하고자 할 경우 미성년자인 이용자는 법정대리인의 사전 동의를 얻어야 합니다.(2004년 10월 11일자 신설)
 

제12조(공개게시물의 삭제)

 
① 이용자의 공개게시물의 내용이 다음 각 호에 해당하는 경우 "Community"은 이용자에게 사전 통지 없이 해당 공개게시물을 삭제할 수 있고, 해당 이용자의 회원 자격을 제한, 정지 또는 상실시킬 수 있습니다. 
 1. 다른 이용자 또는 제3자를 비방하거나 중상 모략으로 명예를 손상시키는 내용
2. 공서양속에 위반되는 내용의 정보, 문장, 도형 등을 유포하는 내용
3. 범죄행위와 관련이 있다고 판단되는 내용
4. 다른 이용자 또는 제3자의 저작권 등 기타 권리를 침해하는 내용
5. 기타 관계 법령에 위배된다고 판단되는 내용 
6. 종교적, 정치적 분쟁을 야기하는 내용으로서, 이러한 분쟁으로 인하여 Community의 업무가 방해되거나 방해되리라고 판단되는 경우 (2003년 1월 11일자 신설)  
② 이용자의 공개게시물로 인한 법률상 이익 침해를 근거로, 다른 이용자 또는 제3자가 이용자 또는 "Community"을 대상으 로 하여 민형사상의 법적 조치(예:고소, 가처분신청, 손해배상청구소송)를 취하는 동시에 법적 조치와 관련된 게시물의 삭제를 요청해 오는 경우, "Community"은 동 법적 조치의 결과(예: 검찰의 기소, 법원의 가처분결정, 손해배상판결)가 있을 때까지 관 련 게시물에 대한 접근을 잠정적으로 제한할 수 있습니다. (2003년 1월 11일자 신설) 
  

제13조(저작권의 귀속 및 이용제한)

 
① "Community"이 작성한 저작물에 대한 저작권 기타 지적재산권은 "Community"에 귀속합니다. 
 
② 이용자는 "Community"을 이용함으로써 얻은 정보를 "Community"의 사전승낙 없이 복제, 전송, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다. 
 

제14조(약관의 개정)

 
① "Community"은 약관의규제등에관한법률, 전자거래기본법, 전자서명법, 정보통신망이용촉진등에관한법률 등 관련법을 위배하지 않는 범위에서 본 약관을 개정할 수 있습니다. 
 
② 다만, 개정 내용이 "이용자"에게 불리할 경우에는 적용일자 삼십(30)일 이전부터 적용일자 전일까지 공지합니다. (2005년 7월 18일자 변경) 
 
③ "이용자"는 변경된 약관에 대해 거부할 권리가 있습니다. "이용자"는 변경된 약관이 공지된 후 십오(15)일 이내에 거부의사 를 표명할 수 있습니다. "이용자"가 거부하는 경우 "Community"은 당해 "이용자"와의 계약을 해지할 수 있습니다. 만 약 "이용자"가 변경된 약관이 공지된 후 십오(15)일 이내에 거부의사를 표시하지 않는 경우에는 동의하는 것으로 간주합니 다. (2001년 12월 18일자 변경) 
 

제15조(재판관할)

 
 "Community"과 이용자간에 발생한 서비스 이용에 관한 분쟁에 대하여는 대한민국 법을 적용하며, 본 분쟁으로 인한 소는 민사소송법상의 관할을 가지는 대한민국의 법원에 제기합니다. (2001년 12월 18일자 변경) 


부 칙

 
본 약관은 2005. 7. 18. 부터 적용하고, 2004. 10. 11.부터 적용되던 종전의 약관은 본 약관으로 대체합니다. 
            </textarea><br>
  	   <p id="agreep"><input type="checkbox" name="agree"/> 약관에 동의합니다</p>

		<input type="submit" value="회원가입" class="btn"/> 
		<input type="button" value="취소"  class="btn" onclick="javascript:history.back();"/>
	   </form>	
		</div>
		
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
        }).open();
    }
</script> 
<!-- ----- DAUM 우편번호 API 종료----- -->

</div>	
<!-- FOOTER -->
<jsp:include page="/include/footer.jsp"/>
	

</body>

<!-- 비밀번호 유효성 검사 -->
<script type="text/javascript">

var passCheck;
var passDoubleCheck;

//비밀번호 유효성검사 함수
function checkValidPW() {
	//비밀번호 조건에 부합하지 않으면
	if(!/^(?=.*[a-z])(?=.*[0-9]).{8,25}$/.test($('#pass').val())){            
        $('#pwConstraintMsg').text('사용 할 수 없는 비밀번호 입니다.').css({'color':'red', 'font-size':12});
        $('#pass').val($('#pass').val()).focus();
        passCheck = false;
    } 
	//비밀번호 조건에 부합한다면
	else if(/^(?=.*[a-z])(?=.*[0-9]).{8,25}$/.test($('#pass').val())) {
    	$('#pwConstraintMsg').text('사용가능한 비밀번호 입니다.').css({'color':'green', 'font-size':12});
    	passCheck = true;
    }
}

//비밀번호와 비밀번호확인란이 같은지 검사하는 함수
function checkSamePW() {
	//비밀번호와 비밀번호확인란이 같지 않으면
	if(document.joinform.pass.value != document.joinform.user_pass_confirm.value ){
		$('#pwConfirmMsg').text(' 비밀번호가 다릅니다.').css({'color':'red', 'font-size':12});
		$('#user_pass_confirm').val($('#user_pass_confirm').val()).focus();
		passDoubleCheck = false;
    }
	//비밀번호와 비밀번호확인란이 같으면
	else {
    	$('#pwConfirmMsg').text('비밀번호가 일치합니다.').css({'color':'green', 'font-size':12});	
    	passDoubleCheck = true;
    }
}

// 약관 동의 체크 안됬을 시
function send(f){
   if(f.agree.checked==true){
      return true;
   }else{
      alert("약관에 동의한 후 회원가입이 가능합니다");
      return false;
   }
}
</script>

</html>