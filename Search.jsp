<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page import="java.util.*"%>
<%@ page import = "java.net.HttpURLConnection, java.net.URL, java.net.URLEncoder"%>
<%@ page import = "java.io.BufferedReader, java.io.IOException, java.io.*"%>
<%@ page import = "java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>
<%@ page import = "javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory, javax.xml.parsers.ParserConfigurationException"%>
<%@ page import = "org.w3c.dom.Document, org.w3c.dom.Element, org.w3c.dom.Node, org.w3c.dom.NodeList, org.xml.sax.SAXException, org.xml.sax.*"%>
<%@ include file="module/reserveModal.jsp" %>
<jsp:include page="module/reserveModal.jsp" flush="true" />



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>메디닥</title>
<!-- 외부 CSS 및 JS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./css/custom.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/7f5811a0ff.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ab2bc5c24540617e4235c668b239cd7e&libraries=services"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">


<script>
$(function() {
  $("#datepicker").datepicker({
    closeText: "닫기",
    currentText: "오늘",
    prevText: '이전 달',
    nextText: '다음 달',
    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
    dayNames: ['일','월','화','수','목','금','토'],
    minDate: 0,
    maxDate: "+1M"
  });
});

function clickBtn() {
  navigator.geolocation.getCurrentPosition(function(position) {
    var lat = position.coords.latitude;
    var lng = position.coords.longitude;
    document.forms['searchBar']['lat'].value = lat;
    document.forms['searchBar']['lng'].value = lng;
    document.getElementById('searchBar').submit();
  });
}

function transParam(dutyName, dgidIdName, hpid){
  var arr = dgidIdName.split(',');
  $("#IdHospital").val(hpid);
  $("#hospitalName").val(dutyName);
  $("#namehospital").val(dutyName);
  $("#exampleModalLabel").text(dutyName);
  $('#department').empty();
  for (var i = 0; i < arr.length; i++) {
    var option = $('<option>', {
      value: arr[i],
      text: arr[i]
    });
    $('#department').append(option);
  }
}
</script>
</head>
<%
String name = (String)session.getAttribute("memName");
List<Map> pubList = (ArrayList)request.getAttribute("pubList");
String id = (String)session.getAttribute("memId");
String memLogin = (String)session.getAttribute("memLogin");
%>
<body>
<jsp:include page="module/<%= ("ok".equals(memLogin)) ? "patientHeader.jsp" : ("hos".equals(memLogin) ? "hospitalHeader.jsp" : "header.jsp") %>" flush="false" />
<div class="container">
  <form class="row" action="PageControl.jsp" method="post" id="searchBar">
    <div class="col-md-3 py-3">
      <input type="radio" name="search" value="hosname" checked> 병원명
      <input type="radio" name="search" value="department"> 진료과
    </div>
    <div class="col-md-6 py-3">
      <input type="text" name="keyword" placeholder="병원명, 진료과 별로 검색해보세요 :)" class="form-control">
      <input type="hidden" name="lat" value="s">
      <input type="hidden" name="lng" value="s">
      <input type="hidden" name="hoslAction" value="search">
    </div>
    <div class="col-md-3 py-3">
      <button class="btn btn-primary" type="button" onclick="clickBtn()">검색</button>
    </div>
  </form>
</div>
<div class="container py-3">
  <div class="row">
    <div class="col-md-6" style="overflow-y: scroll; height: 500px;">
      <table class="table table-hover">
        <thead>
          <tr><th>#</th><th>병원명</th><th>전화번호</th><th>진료과</th><th>예약</th></tr>
        </thead>
        <tbody>
<%
int i = 1;
for (Map pub : pubList) {
  String hosName = (String) pub.get("dutyName");
  String tel = (String) pub.get("dutyTel1");
  String dept = (String) pub.get("dgidIdName");
  String lat = (String) pub.get("wgs84Lat");
  String lon = (String) pub.get("wgs84Lon");
  String hpid = (String) pub.get("hpid");
%>
<tr onclick="hospitalPos('<%=hosName%>', '<%=lat%>', '<%=lon%>')">
  <td><%=i++%></td>
  <td><%=hosName%></td>
  <td><%=tel%></td>
  <td><%=dept%></td>
  <td><button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="transParam('<%=hosName%>', '<%=dept%>', '<%=hpid%>')">예약</button></td>
</tr>
<% } %>
        </tbody>
      </table>
    </div>
    <div class="col-md-6">
      <div id="map" style="width:100%;height:500px;"></div>
    </div>
  </div>
</div>
<script>
function hospitalPos(name, lat, lng) {
  var position = new kakao.maps.LatLng(lat, lng);
  var marker = new kakao.maps.Marker({
    map: map,
    position: position,
    title: name
  });
  var infowindow = new kakao.maps.InfoWindow({
    content: '<div style="padding:5px;font-size:14px;">' + name + '</div>'
  });
  kakao.maps.event.addListener(marker, 'click', function() {
    infowindow.open(map, marker);
  });
  map.setCenter(position);
}

var mapContainer = document.getElementById('map');
var mapOption = {
  center: new kakao.maps.LatLng(37.5665, 126.9780),
  level: 5
};
var map = new kakao.maps.Map(mapContainer, mapOption);
</script>
<jsp:include page="module/footer.jsp" flush="false" />
</body>
</html>

