<%@ page language ="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    //MemberIDCheckAction에서 저장한 데이터 가져오기
      String id = (String)request.getAttribute( "id");
      boolean check = (Boolean)(request.getAttribute( "check"));
      //request의 반환형은 Object 니깐.
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd" >
<html>
<head>
<meta http-equiv= "Content-Type" content ="text/html; charset=UTF-8">

<title> Insert title here</title>
  <script>
      //현재 창을 열게 해준 창의 joinform.MEMBER_ID에게 id값을 넘겨주고 현재창을 닫는 함수
     
      function windowclose(){
       //상식 나를 연창의 name 값에 접근 하는 방법.
       // open 메서드를 사용한 곳은 meber_join.jsp 파일에서 사용했다.
       //나를 연창의 joinform의 MEMBER_ID (name 속성중에 하나)의 value값을 변경시켜라//★★
         opener.document.joinform.id.value = "<%=id%>";
         
         //중복체크가 끝나면 true (중복체크 했다고)로 만들어준당
         opener.document.joinform.idcheck.value="true";        
         self.close();
        }
    </script>


</head>
<body>

    <!-- 아이디가 중복되었을 때의 화면 만들기 -->

   <%if (check){ %>
     <table width ="360" border = "0">
         <tr align = "center">
           <td height = "30">
             <font size ="2"><%=id %>는 사용 중입니다. </font >
           </td >
            </tr >
     
     </table >
     <!-- 아이디를 입력받아서 중복확인을 수행할 폼 작성 -->
     <form action = "./MemberIDCheckAction.me" method ="post" name= "checkform">
            <table width ="360" border="0">
                 <tr >
                      <td align = "center">
                            <font size ="2">아이디를 입력하세요</font>
                      <p>
                            <input type ="text" size="20" maxlength= "20" name ="id"/>
                            <input type ="submit" value= "중복확인" />
                      </p>
                      </td >
                 </tr >
            </table >
     </form >

     <!-- 중복된 아이디가 없을 떄의 화면 구성 -->
     <% }else{ %>
     <table width ="360" border="0">
            <td align = "center">
            <font size ="2">입력하신 <%= id %> 는 사용가능한 아이디 입니다.</font>
            <br /><br />
            <input type ="button" value="닫기" onclick = "windowclose()"/>  <!-- 눌렸을 때 windowclose () 실행 -->
   </table >
  <% } %>


</body>
</html>
