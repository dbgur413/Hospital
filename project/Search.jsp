<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page import="java.util.*"%>
<%@ page import = "java.net.HttpURLConnection, java.net.URL, java.net.URLEncoder"%>
<%@ page import = "java.io.BufferedReader, java.io.IOException, java.io.*"%>
<%@ page import = "java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>
<%@ page import = "javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory, javax.xml.parsers.ParserConfigurationException"%>
<%@ page import = "org.w3c.dom.Document, org.w3c.dom.Element, org.w3c.dom.Node, org.w3c.dom.NodeList, org.xml.sax.SAXException, org.xml.sax.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>메디닥</title>
<!-- 스크립트 부분 -->
<script src="apikey.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">
<link rel="stylesheet" href="./css/custom.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://kit.fontawesome.com/7f5811a0ff.js"
	crossorigin="anonymous"></script>
<!--지도 -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ab2bc5c24540617e4235c668b239cd7e&libraries=services"></script>

<!-- Icon -->
<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
  <symbol id="facebook" viewBox="0 0 16 16">
    <path
		d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951z" />
  </symbol>
  <symbol id="instagram" viewBox="0 0 16 16">
      <path
		d="M8 0C5.829 0 5.556.01 4.703.048 3.85.088 3.269.222 2.76.42a3.917 3.917 0 0 0-1.417.923A3.927 3.927 0 0 0 .42 2.76C.222 3.268.087 3.85.048 4.7.01 5.555 0 5.827 0 8.001c0 2.172.01 2.444.048 3.297.04.852.174 1.433.372 1.942.205.526.478.972.923 1.417.444.445.89.719 1.416.923.51.198 1.09.333 1.942.372C5.555 15.99 5.827 16 8 16s2.444-.01 3.298-.048c.851-.04 1.434-.174 1.943-.372a3.916 3.916 0 0 0 1.416-.923c.445-.445.718-.891.923-1.417.197-.509.332-1.09.372-1.942C15.99 10.445 16 10.173 16 8s-.01-2.445-.048-3.299c-.04-.851-.175-1.433-.372-1.941a3.926 3.926 0 0 0-.923-1.417A3.911 3.911 0 0 0 13.24.42c-.51-.198-1.092-.333-1.943-.372C10.443.01 10.172 0 7.998 0h.003zm-.717 1.442h.718c2.136 0 2.389.007 3.232.046.78.035 1.204.166 1.486.275.373.145.64.319.92.599.28.28.453.546.598.92.11.281.24.705.275 1.485.039.843.047 1.096.047 3.231s-.008 2.389-.047 3.232c-.035.78-.166 1.203-.275 1.485a2.47 2.47 0 0 1-.599.919c-.28.28-.546.453-.92.598-.28.11-.704.24-1.485.276-.843.038-1.096.047-3.232.047s-2.39-.009-3.233-.047c-.78-.036-1.203-.166-1.485-.276a2.478 2.478 0 0 1-.92-.598 2.48 2.48 0 0 1-.6-.92c-.109-.281-.24-.705-.275-1.485-.038-.843-.046-1.096-.046-3.233 0-2.136.008-2.388.046-3.231.036-.78.166-1.204.276-1.486.145-.373.319-.64.599-.92.28-.28.546-.453.92-.598.282-.11.705-.24 1.485-.276.738-.034 1.024-.044 2.515-.045v.002zm4.988 1.328a.96.96 0 1 0 0 1.92.96.96 0 0 0 0-1.92zm-4.27 1.122a4.109 4.109 0 1 0 0 8.217 4.109 4.109 0 0 0 0-8.217zm0 1.441a2.667 2.667 0 1 1 0 5.334 2.667 2.667 0 0 1 0-5.334z" />
  </symbol>
  <symbol id="twitter" viewBox="0 0 16 16">
    <path
		d="M5.026 15c6.038 0 9.341-5.003 9.341-9.334 0-.14 0-.282-.006-.422A6.685 6.685 0 0 0 16 3.542a6.658 6.658 0 0 1-1.889.518 3.301 3.301 0 0 0 1.447-1.817 6.533 6.533 0 0 1-2.087.793A3.286 3.286 0 0 0 7.875 6.03a9.325 9.325 0 0 1-6.767-3.429 3.289 3.289 0 0 0 1.018 4.382A3.323 3.323 0 0 1 .64 6.575v.045a3.288 3.288 0 0 0 2.632 3.218 3.203 3.203 0 0 1-.865.115 3.23 3.23 0 0 1-.614-.057 3.283 3.283 0 0 0 3.067 2.277A6.588 6.588 0 0 1 .78 13.58a6.32 6.32 0 0 1-.78-.045A9.344 9.344 0 0 0 5.026 15z" />
  </symbol>
</svg>

<!-- Modal -->
<script type='text/javascript' src='//code.jquery.com/jquery-1.8.3.js'></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" /> 
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> 
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
 <script>
 $(function() { $( "#datepicker" ).datepicker(); });
 </script>
<script>
$(document).ready(function(){ 
	$.datepicker.setDefaults({ 
		closeText: "닫기", 
		currentText: "오늘", 
		prevText: '이전 달', 
		nextText: '다음 달', 
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		dayNames: ['일', '월', '화', '수', '목', '금', '토'], 
		dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
		weekHeader: "주", 
		yearSuffix: '년',
		minDate:"0",
		maxDate:"+1M"
	}); 
}); 
</script>		
<!-- css -->
<style>
      #datepicker{
        width:800px;
        height:30px;
      }
</style>
<script>
function clickBtn(){
	navigator.geolocation.getCurrentPosition(
			function(position) {
			console.log("위도 : " + position.coords.latitude);
			console.log("경도 : " + position.coords.longitude);
			
			 var lat= position.coords.latitude;
             var lng= position.coords.longitude;
             
             var latInput = document.forms['searchBar']['lat'];
             var lngInput = document.forms['searchBar']['lng'];
             console.log(latInput.value);
             console.log(lngInput.value);
             
             
             latInput.setAttribute('value',lat);
             lngInput.setAttribute('value',lng);
             
             console.log(latInput.value);
             console.log(lngInput.value);
             
             document.getElementById('searchBar').submit();
			},
    );
}
</script>
</head>
<%
	String name = null; //로그인 정보에 따라 해당 계정의 이름 정보를 담는 변수
	name = (String)session.getAttribute("memName");
	List<Map> pubList = new ArrayList();
	pubList = (ArrayList)request.getAttribute("pubList");
	//api키 가져오기
	ResourceBundle resource = ResourceBundle.getBundle("apikey");
	String covidApiKey = resource.getString("covidApiKey");
%>
<body>
<% 
  			String memLogin = null; // 로그인 여부에 따라 탑메뉴 보여주는 로직
  			memLogin = (String)session.getAttribute("memLogin");
  			String id = (String)session.getAttribute("memId");
  			if(memLogin == "ok"){ // 환자회원 헤더
  				%>
  				 <jsp:include page="module/patientHeader.jsp" flush="false" />
  				<%
  			}
  			else if(memLogin == "hos"){ // 병원회원 헤더
  				%>
 				 <jsp:include page="module/hospitalHeader.jsp" flush="false" />
 				<%
  			} else{ // 로그인 안했을때 헤더
  				%>
				 <jsp:include page="module/header.jsp" flush="false" />
				<%
  			}
  			if(memLogin == null) //로그인을 하지 않으면 병원검색을 하지 못함
  	        {
  				PrintWriter pw = response.getWriter();
  				pw.println("<script>");
  				pw.println("alert('로그인을 해주세요.')");
  				pw.println("location.href='PatientLogin.jsp;'");
  				pw.println("</script>");
  				pw.close();
  				return;
  	        }
 %>
	<div class="container">
 		<div>
			<form class="row" action="PageControl.jsp" method="post" id="searchBar">
				<div class="btn-group py-3 col-md-3" role="group"
				aria-label="Basic outlined example">
					<input type="radio" class="btn-check" name="search" value="hosname" id="btnradio1" autocomplete="off" checked>
  					<label class="btn btn-outline-primary" for="btnradio1">병원명</label>
  					<input type="radio" class="btn-check" name="search" value="department" id="btnradio2" autocomplete="off">
  					<label class="btn btn-outline-primary" for="btnradio2">진료과</label>
				</div>
				<div class="search col-md-6 py-3">
					<div class="Mainsearch">
						<input type="text" placeholder="병원명, 진료과 별로 검색해보세요 :)"
							class="Mainsearch searchBar" name="keyword">
						<button class="Mainsearch icon" onclick="clickBtn()">
							<i class="fa fa-search"></i>
						</button>
						<input type="hidden" name="lat" value="s">
						<input type="hidden" name="lng" value="s">
						<input type="hidden" name="hoslAction" value="search">
					</div>
				</div>
			</form>
		</div>
	</div>

	<div class="container py-3">
		<div class="row">
			<div class="col-md-6"
				style="white-space: nowrap; overflow: scroll; height: 500px;">
				<table class="table table-hover" style="width: 100%;">
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">병원명</th>
							<th scope="col">전화번호</th>
							<th scope="col">진료과</th>
							<th scope="col">진료여부</th>
							<th scope="col">예약</th>
						</tr>
					</thead>
					<tbody
						style="text-overflow: ellipsis; overflow: hidden; width: 150px; white-space: nowrap;">
						<%
						int i = 1; // 테이블의 번호를 세주는 변수
						for(Map pub : pubList){ %>
						<tr onclick="hospitalPos('<%=pub.get("dutyName")%>','<%=pub.get("dgidIdName")%>','<%=pub.get("dutyAddr")%>','<%=pub.get("wgs84Lat")%>','<%=pub.get("wgs84Lon")%>','<%=pub.get("postCdn")%>')">
							<th scope="row"><%= i %></th>
							<td><%= pub.get("dutyName") %></td>
							<td><%= pub.get("dutyTel1") %></td>
							<td style="text-overflow: ellipsis; overflow: hidden; max-width: 150px; white-space: nowrap;"><%= pub.get("dgidIdName") %></td>
							<td><span class="badge bg-success">가능</span></td>
							<td><button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="transParam('<%=pub.get("dutyName")%>','<%=pub.get("dgidIdName")%>', '<%= pub.get("hpid") %>')">예약</button></td>
						</tr>
							<% i++; %>
						<%} %>	
					</tbody>

				</table>
			</div>
			<div class="col-md-6">
				<div id="map" style="width: 100%; height: 500px;"></div>
				<script>
  var mapContainer = document.getElementById('map');
  var mapOption = {
    center: new kakao.maps.LatLng(37.5665, 126.9780),
    level: 5
  };

  var map = new kakao.maps.Map(mapContainer, mapOption);

  function hospitalPos(hosName, department, addr, lat, lng, postCdn) {
    var markerPosition = new kakao.maps.LatLng(lat, lng);

    var marker = new kakao.maps.Marker({
      position: markerPosition,
      map: map,
      title: hosName
    });

    var iwContent = `<div style="padding:10px;"><strong>${hosName}</strong><br>${addr}<br>${department}</div>`;
    var infowindow = new kakao.maps.InfoWindow({
      content: iwContent
    });

    kakao.maps.event.addListener(marker, 'click', function () {
      infowindow.open(map, marker);
    });

    map.setCenter(markerPosition);
  }
</script>


			</div>
		</div>
	</div>
</body>
<jsp:include page="module/footer.jsp" flush="false"/>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
      	<input type="hidden" id="hospitalName" name="hName" value="병원이름">
        <h5 class="modal-title" id="exampleModalLabel">병원이름</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="PageControl.jsp" method="get">
      <input type=hidden id = "IdHospital" name = "IdHospital" value ="id 가져오기 실패" >	
	  <input type=hidden id = "Idpatient" name = "Idpatient" value = "<%= id %>" >
      <div class="modal-body">
     	  <div class="container">
        <h5>예약날짜</h5>
        <div class="input-group date">
           <input type="text" id="datepicker" name= "reserveDate"> 
        </div>
       	<div class="col-md-4_1" style="width: 100%;float:center;">
		<div>
			<table class="table table-striped">	
				<colgroup> 
					<col width="200"> 
					<col> 
				</colgroup> 
				<thead>
					<tr>
						<th scope="col"></th>
						<th scope="col"></th>
					</tr>
				</thead>
				<tbody style="border: solid 1px #f0f0f0;border-radius: 5px;">
					<tr>
					<td class="booking_table_list">진료과<span>*</span>
						<select name="department" id="department" class="treatment_sel_box" style="width: 90%">
							<option value="">진료과목 선택</option>
							<option value="002">ex)치과</option>
																															
						</select>
					</td>
					<td class="booking_table_list">예약구분<span>*</span>
						<select name="reserveDiv" id="reserveDiv" class="treatment_sel_box" style="width: 90%;">
							<option value="">예약 선택</option>
								<option value="진료">진료</option>
								<option value="검진">검진</option>	
						</select>
					</td>
					</tr>
					<tr>
						<td class="booking_table_list">진료 받으실 분 <span>*</span></td>
						<td>
							<select name="department1" id = "department1" class="treatment_sel_box" style="width: 90%;">
								<option value="본인">본인</option>
																	
							</select>
						</td>
					</tr>
					
					<tr>
						<td class="booking_table_list">주민번호 뒷자리<span>*</span></td>
						<td>
							생년월일:
							<select name="birth_1" id="birth_1">
							<option value="">년도</option>
														<option value="2025">2025</option>
														<option value="2024">2024</option>	
														<option value="2023">2023</option>
														<option value="2022">2022</option>
														<option value="2021">2021</option>
														<option value="2020">2020</option>
														<option value="2019">2019</option>
														<option value="2018">2018</option>
														<option value="2017">2017</option>
														<option value="2016">2016</option>
														<option value="2015">2015</option>
														<option value="2014">2014</option>
														<option value="2013">2013</option>
														<option value="2012">2012</option>
														<option value="2011">2011</option>
														<option value="2010">2010</option>
														<option value="2009">2009</option>
														<option value="2008">2008</option>
														<option value="2007">2007</option>
														<option value="2006">2006</option>
														<option value="2005">2005</option>
														<option value="2004">2004</option>
														<option value="2003">2003</option>
														<option value="2002">2002</option>
														<option value="2001">2001</option>
														<option value="2000">2000</option>
														<option value="1999">1999</option>
														<option value="1998">1998</option>
														<option value="1997">1997</option>
														<option value="1996">1996</option>
														<option value="1995">1995</option>
														<option value="1994">1994</option>
														<option value="1993">1993</option>
														<option value="1992">1992</option>
														<option value="1991">1991</option>
														<option value="1990">1990</option>
														<option value="1989">1989</option>
														<option value="1988">1988</option>
														<option value="1987">1987</option>
														<option value="1986">1986</option>
														<option value="1985">1985</option>
														<option value="1984">1984</option>
														<option value="1983">1983</option>
														<option value="1982">1982</option>
														<option value="1981">1981</option>
														<option value="1980">1980</option>
														<option value="1979">1979</option>
														<option value="1978">1978</option>
														<option value="1977">1977</option>
														<option value="1976">1976</option>
														<option value="1975">1975</option>
														<option value="1974">1974</option>
														<option value="1973">1973</option>
														<option value="1972">1972</option>
														<option value="1971">1971</option>
														<option value="1970">1970</option>
														<option value="1969">1969</option>
														<option value="1968">1968</option>
														<option value="1967">1967</option>
														<option value="1966">1966</option>
														<option value="1965">1965</option>
														<option value="1964">1964</option>
														<option value="1963">1963</option>
														<option value="1962">1962</option>
														<option value="1961">1961</option>
														<option value="1960">1960</option>
														<option value="1959">1959</option>
														<option value="1958">1958</option>
														<option value="1957">1957</option>
														<option value="1956">1956</option>
														<option value="1955">1955</option>
														<option value="1954">1954</option>
														<option value="1953">1953</option>
														<option value="1952">1952</option>
														<option value="1951">1951</option>
														<option value="1950">1950</option>
														<option value="1949">1949</option>
														<option value="1948">1948</option>
														<option value="1947">1947</option>
														<option value="1946">1946</option>
														<option value="1945">1945</option>
														<option value="1944">1944</option>
														<option value="1943">1943</option>
														<option value="1942">1942</option>
														<option value="1941">1941</option>
														<option value="1940">1940</option>
														<option value="1939">1939</option>
														<option value="1938">1938</option>
														<option value="1937">1937</option>
														<option value="1936">1936</option>
														<option value="1935">1935</option>
														<option value="1934">1934</option>
														<option value="1933">1933</option>
														<option value="1932">1932</option>
														<option value="1931">1931</option>
														</select>
							<select name="birth_2" id="birth_2">
							<option value="">월</option>
													    <option value="01">1</option>
														<option value="02">2</option>
														<option value="03">3</option>
														<option value="04">4</option>
														<option value="05">5</option>
														<option value="06">6</option>
														<option value="07">7</option>
														<option value="08">8</option>
														<option value="09">9</option>
														<option value="10">10</option>
														<option value="11">11</option>
														<option value="12">12</option>
														</select>
							<select name="birth_3" id="birth_3">
							<option value="">일</option>
														<option value="01">1</option>
														<option value="02">2</option>
														<option value="03">3</option>
														<option value="04">4</option>
														<option value="05">5</option>
														<option value="06">6</option>
														<option value="07">7</option>
														<option value="08">8</option>
														<option value="09">9</option>
														<option value="10">10</option>
														<option value="11">11</option>
														<option value="12">12</option>
														<option value="13">13</option>
														<option value="14">14</option>
														<option value="15">15</option>
														<option value="16">16</option>
														<option value="17">17</option>
														<option value="18">18</option>
														<option value="19">19</option>
														<option value="20">20</option>
														<option value="21">21</option>
														<option value="22">22</option>
														<option value="23">23</option>
														<option value="24">24</option>
														<option value="25">25</option>
														<option value="26">26</option>
														<option value="27">27</option>
														<option value="28">28</option>
														<option value="29">29</option>
														<option value="30">30</option>
														<option value="31">31</option>
														</select>
							<br/>
							-주민번호 뒷자리:<input type="password" id="registrationBackNumber" name="registrationBackNumber" value="" size="7" maxlength="7"/>				
						</td>
					</tr>
					
					<tr>
						<td class="booking_table_list">증상<span>*</span></td>
						<td>
							<textarea type="text" name="symptom" id = "symptom" class="treatment_txt_box" style="width: 90%; height: 125px;   resize: none;  outline: 0;"></textarea>
						</td>
					</tr>
				</tbody>
			</table>
			<input type=hidden name="namepatient" value="<%= name %>">
			<input type="hidden" id="namehospital" name="namehospital" value="병원이름">
			<input type=hidden name="rdAction" value="insert">
		</div>
	</div> 
    </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="submit" class="btn btn-primary">예약하기</button>
      </div>
    </div>
    </form>
  </div>
</div>
<script>
function transParam(dutyName, dgidIdName, hpid){ // 병원정보를 모달창으로 넘겨주는 함수
	var arr = dgidIdName.split(',');
	$("#IdHospital").val(hpid);
	$("#hospitalName").val(dutyName);
	$("#namehospital").val(dutyName);
	$("#exampleModalLabel").text(dutyName);
	$('#department').empty();
	for(var count = 0; count < arr.length; count++){                
        var option = $("<option value=" + arr[count] + ">"+arr[count]+"</option>");
        $('#department').append(option);
    }
}

</script>
</html>