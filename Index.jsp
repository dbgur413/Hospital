<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>메디닥</title>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
  <link rel="stylesheet" href="./css/custom.css">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://kit.fontawesome.com/7f5811a0ff.js" crossorigin="anonymous"></script>
  <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ab2bc5c24540617e4235c668b239cd7e&libraries=services"></script>

  <script>
  function clickBtn() {
    navigator.geolocation.getCurrentPosition(function(position) {
      document.forms['searchBar']['lat'].value = position.coords.latitude;
      document.forms['searchBar']['lng'].value = position.coords.longitude;
      document.getElementById('searchBar').submit();
    });
  }
  </script>
</head>

<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="Index.jsp" style="margin-right: 40px">
      <img src="img/logo.png" alt="로고" width="100" height="80">
    </a>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item"><a class="nav-link" href="Introduction.jsp"><h5><strong>서비스 소개</strong></h5></a></li>
        <li class="nav-item"><a class="nav-link" href="Guide.jsp"><h5><strong>이용안내</strong></h5></a></li>
        <li class="nav-item"><a class="nav-link" href="Index.jsp"><h5><strong>예약</strong></h5></a></li>
      </ul>
      <ul class="navbar-nav ml-auto mb-2 mb-lg-0">
        <li class="nav-item"><a class="nav-link" href="PatientLogin.jsp"><h5><strong>로그인</strong></h5></a></li>
        <li class="nav-item" style="margin-right: 80px"><a class="nav-link" href="PatientSignUp.jsp"><h5><strong>회원가입</strong></h5></a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="box1" style="background-color: rgb(52,152,219);"></div>

<div class="container">
  <form class="row" action="PageControl.jsp" method="post" id="searchBar">
    <div class="btn-group py-3 col-md-3" role="group">
      <input type="radio" class="btn-check" name="search" value="hosname" id="btnradio1" autocomplete="off" checked>
      <label class="btn btn-outline-primary" for="btnradio1">병원명</label>
      <input type="radio" class="btn-check" name="search" value="department" id="btnradio2" autocomplete="off">
      <label class="btn btn-outline-primary" for="btnradio2">진료과</label>
    </div>
    <div class="search col-md-6 py-3">
      <div class="Mainsearch">
        <input type="text" placeholder="병원명, 진료과 별로 검색해보세요 :)" class="Mainsearch searchBar" name="keyword">
        <button class="Mainsearch icon" onclick="clickBtn()"><i class="fa fa-search"></i></button>
        <input type="hidden" name="lat" value="s">
        <input type="hidden" name="lng" value="s">
        <input type="hidden" name="hoslAction" value="search">
      </div>
    </div>
  </form>
</div>

<div class="container py-3">
  <div class="row">
    <!-- 병원 리스트 테이블 -->
    <div class="col-md-6" style="white-space: nowrap; overflow: scroll; height: 500px;">
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
        <tbody id="hospitalTableBody" style="text-overflow: ellipsis; overflow: hidden; width: 150px; white-space: nowrap;">
          <!-- JS에서 채워짐 -->
        </tbody>
      </table>
    </div>

    <!-- 지도 -->
    <div class="col-md-6">
      <div id="map" style="width: 100%; height: 500px;"></div>
    </div>
  </div>
</div>

<script>
window.onload = function () {
  var mapContainer = document.getElementById('map');
  var mapOption = {
    center: new kakao.maps.LatLng(37.5665, 126.9780),
    level: 5
  };
  var map = new kakao.maps.Map(mapContainer, mapOption);

  const xhr = new XMLHttpRequest();
  const url = 'http://apis.data.go.kr/B551182/hospInfoServicev2/getHospBasisList?serviceKey=&pageNo=1&numOfRows=20';

  xhr.open("GET", url);
  xhr.onreadystatechange = function () {
    if (xhr.readyState === 4 && xhr.status === 200) {
      const xml = xhr.responseXML;
      const items = xml.getElementsByTagName('item');
      const table = document.getElementById('hospitalTableBody');

      for (let i = 0; i < items.length; i++) {
        const item = items[i];
        const name = item.getElementsByTagName('yadmNm')[0]?.textContent;
        const tel = item.getElementsByTagName('telno')[0]?.textContent || '-';
        const dept = item.getElementsByTagName('clCdNm')[0]?.textContent || '-';
        const lat = item.getElementsByTagName('YPos')[0]?.textContent;
        const lng = item.getElementsByTagName('XPos')[0]?.textContent;

        if (lat && lng) {
          // 지도 마커
          const marker = new kakao.maps.Marker({
            map: map,
            position: new kakao.maps.LatLng(lat, lng),
            title: name
          });

          const infowindow = new kakao.maps.InfoWindow({
            content: `<div style="padding:5px;font-size:14px;"><strong>${name}</strong></div>`
          });

          kakao.maps.event.addListener(marker, 'click', function () {
            infowindow.open(map, marker);
          });

          // 테이블 추가
          const row = document.createElement('tr');
          row.innerHTML = `
            <th scope="row">${i + 1}</th>
            <td>${name}</td>
            <td>${tel}</td>
            <td>${dept}</td>
            <td><span class="badge bg-success">가능</span></td>
            <td><button class="btn btn-primary btn-sm">예약</button></td>
          `;
          table.appendChild(row);
        }
      }
    }
  };
  xhr.send();
}
</script>

<!-- Footer -->
<footer class="container py-3 my-4 border-top">
  <div class="d-flex justify-content-between align-items-center">
    <span class="text-muted">&copy; 2022 Company, Inc</span>
    <div>
      <a class="text-muted me-3" href="#"><i class="fa fa-twitter"></i></a>
      <a class="text-muted me-3" href="#"><i class="fa fa-instagram"></i></a>
      <a class="text-muted" href="#"><i class="fa fa-facebook"></i></a>
    </div>
  </div>
</footer>
</body>
</html>

