<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인 회원가입</title>
<!-- 스크립트 부분 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<link rel="stylesheet" href="./css/custom.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://kit.fontawesome.com/7f5811a0ff.js" crossorigin="anonymous"></script>
<!-- Icon -->
<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
  <symbol id="facebook" viewBox="0 0 16 16">
    <path d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951z"/>
  </symbol>
  <symbol id="instagram" viewBox="0 0 16 16">
      <path d="M8 0C5.829 0 5.556.01 4.703.048 3.85.088 3.269.222 2.76.42a3.917 3.917 0 0 0-1.417.923A3.927 3.927 0 0 0 .42 2.76C.222 3.268.087 3.85.048 4.7.01 5.555 0 5.827 0 8.001c0 2.172.01 2.444.048 3.297.04.852.174 1.433.372 1.942.205.526.478.972.923 1.417.444.445.89.719 1.416.923.51.198 1.09.333 1.942.372C5.555 15.99 5.827 16 8 16s2.444-.01 3.298-.048c.851-.04 1.434-.174 1.943-.372a3.916 3.916 0 0 0 1.416-.923c.445-.445.718-.891.923-1.417.197-.509.332-1.09.372-1.942C15.99 10.445 16 10.173 16 8s-.01-2.445-.048-3.299c-.04-.851-.175-1.433-.372-1.941a3.926 3.926 0 0 0-.923-1.417A3.911 3.911 0 0 0 13.24.42c-.51-.198-1.092-.333-1.943-.372C10.443.01 10.172 0 7.998 0h.003zm-.717 1.442h.718c2.136 0 2.389.007 3.232.046.78.035 1.204.166 1.486.275.373.145.64.319.92.599.28.28.453.546.598.92.11.281.24.705.275 1.485.039.843.047 1.096.047 3.231s-.008 2.389-.047 3.232c-.035.78-.166 1.203-.275 1.485a2.47 2.47 0 0 1-.599.919c-.28.28-.546.453-.92.598-.28.11-.704.24-1.485.276-.843.038-1.096.047-3.232.047s-2.39-.009-3.233-.047c-.78-.036-1.203-.166-1.485-.276a2.478 2.478 0 0 1-.92-.598 2.48 2.48 0 0 1-.6-.92c-.109-.281-.24-.705-.275-1.485-.038-.843-.046-1.096-.046-3.233 0-2.136.008-2.388.046-3.231.036-.78.166-1.204.276-1.486.145-.373.319-.64.599-.92.28-.28.546-.453.92-.598.282-.11.705-.24 1.485-.276.738-.034 1.024-.044 2.515-.045v.002zm4.988 1.328a.96.96 0 1 0 0 1.92.96.96 0 0 0 0-1.92zm-4.27 1.122a4.109 4.109 0 1 0 0 8.217 4.109 4.109 0 0 0 0-8.217zm0 1.441a2.667 2.667 0 1 1 0 5.334 2.667 2.667 0 0 1 0-5.334z"/>
  </symbol>
  <symbol id="twitter" viewBox="0 0 16 16">
    <path d="M5.026 15c6.038 0 9.341-5.003 9.341-9.334 0-.14 0-.282-.006-.422A6.685 6.685 0 0 0 16 3.542a6.658 6.658 0 0 1-1.889.518 3.301 3.301 0 0 0 1.447-1.817 6.533 6.533 0 0 1-2.087.793A3.286 3.286 0 0 0 7.875 6.03a9.325 9.325 0 0 1-6.767-3.429 3.289 3.289 0 0 0 1.018 4.382A3.323 3.323 0 0 1 .64 6.575v.045a3.288 3.288 0 0 0 2.632 3.218 3.203 3.203 0 0 1-.865.115 3.23 3.23 0 0 1-.614-.057 3.283 3.283 0 0 0 3.067 2.277A6.588 6.588 0 0 1 .78 13.58a6.32 6.32 0 0 1-.78-.045A9.344 9.344 0 0 0 5.026 15z"/>
  </symbol>
</svg>
<link rel="stylesheet" type="text/css" href="css/PatientSignUp.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type='text/javascript' src='//code.jquery.com/jquery-1.8.3.js'></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" /> 
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> 
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
<!-- 다음 api 스크립트 -->
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
    function patientSignUpView() {
    	var patientView = document.getElementById("patientSignUp");
    	patientView.style.display ='none';
	}
</script>
<jsp:include page="module/header.jsp" flush="false"/>
</head>
<body>
	<section class="bg-light" style="height: 1000px;">
        <div class="container py-4">
        	<div class="row" style="padding-bottom: 20px;">
                <a class="navbar-brand text-left col-md-3 patientSignUp" href="PatientSignUp.jsp">	
                    <span class="text-dark h4" style="font-size:15px;">개인 회원가입</span>
                </a>
                <a class="navbar-brand text-left col-md-3 hospitalSignUp" href="OrganSignUp.jsp">	
                    <span class="text-dark h4" style="font-size:15px;">병원 회원가입</span>
                </a>
            </div>
            <div class="row">
                <a class="navbar-brand h1 text-left col-md-3">	
                    <span class="text-dark h4">개인</span> <span class="text-primary h4">회원가입</span>
                </a>
            </div>
            <form id="patientSignUp" method="get" action="PageControl.jsp" onsubmit="onSubmit()">
                <div class="form-group">
                     <label for="userId" class="form-label mt-4">아이디</label>
                    <input type="text" class="form-control" name="id" id="userId" aria-describedby="emailHelp" placeholder="아이디를 입력해주세요.">
                    <div class="valid-feedback">
          	 			사용가능한 아이디 입니다.
    				</div>
    				<div class="invalid-feedback">
            			5글자 이상 10글자 이하로 작성해 주세요.
    				</div>
                </div>
                <div class="form-group">
                    <label class="form-label mt-4" for="userPass">비밀번호</label>
                    <input type="password" class="form-control" id="userPass" name="password">
                    <div class="valid-feedback">
          	 			사용가능한 비밀번호 입니다.
    				</div>
    				<div class="invalid-feedback">
            			영문, 숫자, 특수문자 반드시 포함 8자 이상 15자 이하로 작성해주세요.
    				</div>
                </div>

                <div class="form-group">
                    <label class="form-label mt-4" for="userRePass">비밀번호 재확인</label> 
                    <input type="password" class="form-control" id="userRePass">
                    <div class="valid-feedback">
          	 			비밀번호가 일치합니다.
    				</div>
    				<div class="invalid-feedback">
            			비밀번호가 일치하지 않습니다.
    				</div>
                </div>
                <div class="form-group">
                       <label for="name" class="form-label mt-4">이름</label>
                    <input type="text" class="form-control" id="name" name="name" aria-describedby="emailHelp" required>
                    <div class="valid-feedback">
          	 			
    				</div>
    				<div class="invalid-feedback">
            			이름을 작성해주세요.
    				</div>
                </div>
				<div class ="bir_wrap">
                    <label class="form-label mt-4">생년월일</label>
                    <div class="bir_yy">
                        <span class="ps_box">
                            <input type="text" class="form-control" id="yy" name="yy" placeholder="년(4자)" maxlength="4">
                        </span>
                    </div>
                    <div class="bir_mm">
                        <span class="ps_box focus">
                            <select class="form-select" id="mm" id="exampleSelect1" name="mm">
                                <option>월</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                                <option value="6">6</option>
                                <option value="7">7</option>
                                <option value="8">8</option>
                                <option value="9">9</option>
                                <option value="10">10</option>
                                <option value="11">11</option>
                                <option value="12">12</option>
                             </select>
                        </span>
                    </div>
                    <div class="bir_dd">
                        <span class="ps_box">
                            <input type ="text" class="form-control" id ="dd" name="dd" placeholder="일" maxlength="2">
                        </span>
                    </div>
                </div>
				<div class="form-group" style="margin-bottom: 20px;">
                  <label for="exampleSelect1" class="form-label mt-4">성별</label><br>
                  <select class="form-select" id="exampleSelect1" name="sex"><br>
                    <option>남자</option>
                    <option>여자</option>
                  </select>
                </div>
                
                <div class="form-group">
             		<label for="inputAddress" class="form-label">주소</label><br>
 					<div class="row" style="height: 42px; --bs-gutter-x: 0.5rem;">
               		 	<div class="col-md-4">
                    		<input type="text" class="form-control" id="sample6_postcode" name="wn" placeholder="우편번호">
                		</div>
                		<div class="col-md-4">
                    		<input type="button" class="form-control" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
                		</div>
            		</div>
            		<div class="row" style="height: 42px; --bs-gutter-x: 0.5rem;">
                		<div class="col-md-6">
                    		<input type="text" class="form-control" id="sample6_address" name="ad" placeholder="주소">
                		</div>
               		 	<div class="col-md-6">
                    		<input type="text" class="form-control" id="sample6_detailAddress" name="sa" placeholder="상세주소">
                		</div>
            		</div>
            		<input type="text" class="form-control" id="sample6_extraAddress" name="ch" placeholder="참고항목"><br>
            	</div>
            	<div class="d-grid gap-2">
                    <button class="w-100 btn btn-lg btn-primary" type="submit">가입하기</button>
                </div>
                <input type=hidden name="action" value="insert">
                <input type=hidden id = "address" name="address" value="">
                <input type=hidden id = "birthdate" name="birthdate" value="">
            </form>
        </div>
    </section>
</body>
<script>
//유효성 여부를 저장할 변수를 만들고 초기값 false 부여
let isIdValid=false;
let isPwReValid=false;
let isPwValid=false;
let isNameValid=false;
// id 가 userId 인 input 요소에 input 이벤트가 일어났을때 실행할 함수 등록 
document.querySelector("#userId").addEventListener("input", function(){
   //1. 입력한 value 값을 읽어온다.
   let inputId=this.value;
   //2. 유효성(5글자이상 10글자 이하)을 검증한다.
   isIdValid = inputId.length >= 5 && inputId.length <= 10;
   //3. 유효하다면 input 요소에 is-valid 클래스 추가, 아니라면 is-invalid 클래스 추가
   if(isIdValid){
      this.classList.remove("is-invalid");
      this.classList.add("is-valid");
   }else{
      this.classList.remove("is-valid");
      this.classList.add("is-invalid");
   }
});

document.querySelector("#userPass").addEventListener("input", function(){
	   //1. 입력한 value 값을 읽어온다.
	   let inputPw=this.value;
	   //2. 유효성(8글자이상 15글자 이하)을 검증한다.
	   isPwValid = /^(?=.*?[A-Za-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,15}$/.test(inputPw)
	   //3. 유효하다면 input 요소에 is-valid 클래스 추가, 아니라면 is-invalid 클래스 추가
	   if(isPwValid){
	      this.classList.remove("is-invalid");
	      this.classList.add("is-valid");
	   }else{
	      this.classList.remove("is-valid");
	      this.classList.add("is-invalid");
	   }
	});

document.querySelector("#userRePass").addEventListener("input", function(){
	   //1. 입력한 value 값을 읽어온다.
	   let inputRePw=this.value;
	   let inputPw=document.querySelector("#userPass").value;
	   //2. 유효성(비밀번호 재확인)을 검증한다.
	   isPwReValid = inputRePw == inputPw;
	   //3. 유효하다면 input 요소에 is-valid 클래스 추가, 아니라면 is-invalid 클래스 추가
	   if(isPwReValid){
	      this.classList.remove("is-invalid");
	      this.classList.add("is-valid");
	   }else{
	      this.classList.remove("is-valid");
	      this.classList.add("is-invalid");
	   }
	});

document.querySelector("#name").addEventListener("input", function(){
	   //1. 입력한 value 값을 읽어온다.
	   let inputName=this.value;
	   //2. 유효성(비밀번호 재확인)을 검증한다.
	   isNameValid = !(inputName == "");
	   //3. 유효하다면 input 요소에 is-valid 클래스 추가, 아니라면 is-invalid 클래스 추가
	   if(isNameValid){
	      this.classList.remove("is-invalid");
	      this.classList.add("is-valid");
	   }else{
	      this.classList.remove("is-valid");
	      this.classList.add("is-invalid");
	   }
	});
	
//폼에 submit 이벤트가 일어 났을때 실행할 함수 등록
document.querySelector("#patientSignUp").addEventListener("submit", function(e){
   //만일 폼이 유효하지 않는다면 전송을 막아주기
   if(!isIdValid || !isPwValid || !isPwValid || !isNameValid){
      //이벤트 객체의 함수를 이용해서 폼 전송 막아주기 
      e.preventDefault();
   }
});
function onSubmit() {
	var birthdate1 = $('#yy').val();
	var birthdate2 = $('#mm').val();
	var birthdate3 = $('#dd').val();
	var birthdate4 = birthdate1 + birthdate2 + birthdate3;
	$('#birthdate').val(birthdate4);
	
	var address1 = $('input[name=wn]').val();
	var address2 = $('input[name=ad]').val();
	var address3 = $('input[name=sa]').val();
	var address4 = $('input[name=ch]').val();
	var address5 = address1 + ' ' + address2 +  ' ' + address3 +address4;
	$('#address').val(address5);
}
</script>
<jsp:include page="module/footer.jsp" flush="false"/>	
</html>