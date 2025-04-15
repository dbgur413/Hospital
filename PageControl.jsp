<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jsp.member.model.*, java.util.*" %>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@ page import = "java.net.HttpURLConnection, java.net.URL, java.net.URLEncoder"%>
<%@ page import = "java.io.BufferedReader, java.io.IOException, java.io.*"%>
<%@ page import = "java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>
<%@ page import = "javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory, javax.xml.parsers.ParserConfigurationException"%>
<%@ page import = "org.w3c.dom.Document, org.w3c.dom.Element, org.w3c.dom.Node, org.w3c.dom.NodeList, org.xml.sax.SAXException, org.xml.sax.*"%>
<%@ page import = "java.util.ResourceBundle" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="java.io.*, java.util.regex.Matcher, java.util.regex.Pattern"%>
<jsp:useBean id="pud" class="jsp.member.model.patientuserDAO"/>
<jsp:useBean id="addrmember" class="jsp.member.model.patientuserDTO" />
<jsp:setProperty name="addrmember" property="*" />
<jsp:useBean id="hud" class="jsp.member.model.hospitaluserDAO" />
<jsp:useBean id="addrhos" class="jsp.member.model.hospitaluserDTO" />
<jsp:setProperty name="addrhos" property="*" />
<jsp:useBean id="rd" class="jsp.member.model.reserveDAO" />
<jsp:useBean id="addrrd" class="jsp.member.model.reserveDTO" />
<jsp:setProperty name="addrrd" property="*" />
<jsp:useBean id="hosm" class="jsp.member.model.hosdepartmentDAO" />
<jsp:useBean id="addrhosm" class="jsp.member.model.hosdepartmentDTO" />
<jsp:setProperty name="addrhosm" property="*" />
<jsp:useBean id="hosl" class="jsp.member.model.hospitallistDAO" />
<jsp:useBean id="addrhosl" class="jsp.member.model.hospitallistDTO" />
<jsp:setProperty name="addrhosl" property="*" />
<jsp:setProperty property="idHospital" name="addrrd" value="<%=request.getParameter(\"IdHospital\")%>"/>
<jsp:setProperty property="idpatient" name="addrrd" value="<%=request.getParameter(\"Idpatient\")%>"/>
<jsp:setProperty property="namepatient" name="addrrd" value="<%=request.getParameter(\"namepatient\")%>"/>
<jsp:setProperty property="namehospital" name="addrrd" value="<%=request.getParameter(\"namehospital\")%>"/>
<%

//컨트롤러 요청 파라메터
String action = request.getParameter("action"); // 개인 회원 열람 컨트롤러
String hosAction = request.getParameter("hosAction"); // 기업 회원 열람 컨트롤러
String rdAction = request.getParameter("rdAction"); // 예약 열람 컨트롤러
String hoslAction = request.getParameter("hoslAction"); // 병원 기본 정보 열람 컨트롤러

//환자 로그인
 if ("login".equals(action)) {
	String id = null;
	String password = null;
	if (request.getParameter("id") != null) {
		id = request.getParameter("id");
	}
	if (request.getParameter("password") != null) {
		password = request.getParameter("password");
	}
	// null값이 있는지 확인
	if (id == null || password == null || id.equals("") || password.equals("")) {
		PrintWriter pw = response.getWriter();
		pw.println("<script>");
		pw.println("alert('입력이 올바르지 않습니다.')");
		pw.println("history.back();");
		pw.println("</script>");
		pw.close();
		return;
	}
	if (id.equals("admin") || password.equals("admin")) {
		session.setAttribute("memLogin", "admin");
		response.sendRedirect("index.jsp");
	}

	// 오류를 감지하기 위해 result 값에 담음
	int result = pud.login(id, password);
	if (result == 1) {
		session.setAttribute("memLogin", "ok");
		if (request.getParameter("idSave") == null) {
	session.removeAttribute("memSave");
		} else {
	session.setAttribute("memSave", "check");
		}
		session.setAttribute("memId", id);
		session.setAttribute("memPw", password);
		//헤더부분에 이름을 보내주기 위해 로그인할때 이름을 가져와 세션에 선언한다.
		String name = pud.getNameDB(id);
		session.setAttribute("memName", name);
		response.sendRedirect("Index.jsp");
	}

	else if (result == 0) {
		PrintWriter pw = response.getWriter();
		pw.println("<script>");
		pw.println("alert('비밀번호가 틀립니다.')");
		pw.println("history.back();");
		pw.println("</script>");
		pw.close();
		return;
	}

	else if (result == -1) {
		PrintWriter pw = response.getWriter();
		pw.println("<script>");
		pw.println("alert('존재하지 않는 아이디입니다.')");
		pw.println("history.back();");
		pw.println("</script>");
		pw.close();
		return;
	} else
		throw new Exception("DB 입력오류");
}

//환자 회원 가입
else if ("insert".equals(action)) {
	String id = null; //환자 아이디
	String password = null; // 환자 비밀번호
	String name = null; // 환자 이름
	int birthdate = 0; // 환자 생년월일
	String sex = null; // 환자 성별
	String address = null; // 환자 주소
	
	if (request.getParameter("id") != null) {
		id = request.getParameter("id");
	}
	if (request.getParameter("password") != null) {
		password = request.getParameter("password");
	}
	if (request.getParameter("name") != null) {
		name = request.getParameter("name");
	}
	if(request.getParameter("birthdate") != null){
		birthdate = Integer.parseInt(request.getParameter("birthdate"));
	}
	if (request.getParameter("sex") != null) {
		sex = request.getParameter("sex");
	}
	if (request.getParameter("address") != null) {
		address = request.getParameter("address");
	}
	
	// null값이 있는지 확인
	if (id == null || password == null || name == null || birthdate == 0 || sex == null || address == null || id.equals("")
	|| password.equals("") || password.equals("")) {
		PrintWriter pw = response.getWriter();
		pw.println("<script>");
		pw.println("alert('입력이 올바르지 않습니다.')");
		pw.println("history.back();");
		pw.println("</script>");
		pw.close();
		return;
	}

	// 오류를 감지하기 위해 result변수에 담음
	int result = pud.insertDB(addrmember);
	if (result > 0) {
		response.sendRedirect("Index.jsp");
	}

	else if (result == -1) {
		PrintWriter pw = response.getWriter();
		pw.println("<script>");
		pw.println("alert('회원가입에 실패했습니다.')");
		pw.println("history.back();");
		pw.println("</script>");
		pw.close();
		return;
	} else
		throw new Exception("DB 입력오류");
}

//환자 개인정보 관리 비밀번호 확인
else if ("confirm".equals(action)) {
	String password = null; // 확인할 비밀번호
	String memPass = null; // 환자 비밀번호
	String id = null; // 아이디 값 담을 변수 생성
	if (request.getParameter("password") == null) { //비밀번호에 아무 것도 입력하지 않았을 때
		PrintWriter pw = response.getWriter();
		pw.println("<script>");
		pw.println("alert('비밀번호를 입력해주세요.')");
		pw.println("history.back();");
		pw.println("</script>");
		pw.close();
		return;
	}
	password = request.getParameter("password");
	memPass = (String)session.getAttribute("memPw");
	
	if(password.equals(memPass)){
		id = (String)session.getAttribute("memId");
		patientuserDTO pudData = pud.getDBList(id);
		request.setAttribute("pudData", pudData);
		pageContext.forward("PrivacyManagement.jsp");
	}
	else{
		PrintWriter pw = response.getWriter();
		pw.println("<script>");
		pw.println("alert('비밀번호가 맞지 않습니다.')");
		pw.println("history.back();");
		pw.println("</script>");
		pw.close();
		return;
	}
}
//환자 비밀번호 변경
else if ("change".equals(action)) {
	String password = null;
	String id = null; // 아이디 값 담을 변수 생성
	String Privacy[] = new String[2]; // 업데이트할 정보를 담을 배열
	if (request.getParameter("password") == null) { //비밀번호에 아무 것도 입력하지 않았을 때
		PrintWriter pw = response.getWriter();
		pw.println("<script>");
		pw.println("alert('비밀번호를 입력해주세요.')");
		pw.println("history.back();");
		pw.println("</script>");
		pw.close();
		return;
	}
	id = (String)session.getAttribute("memId");
	password = request.getParameter("password");
	Privacy[0] = password;
	Privacy[1] = id;
	// 오류를 감지하기 위해 result변수에 담음
	int result = pud.updateDB(Privacy);
	if (result > 0) {
		session.setAttribute("memPw", password); // 바뀐 비밀번호를 다시 세션에 선언해준다.
		id = (String)session.getAttribute("memId");
		patientuserDTO datas = pud.getDBList(id);
		PrintWriter pw = response.getWriter();
		pw.println("<script>");
		pw.println("alert('수정완료 되었습니다.')");
		pw.println("location.href='PageControl.jsp?rdAction=search';"); // 마이페이지로 보내준다.
		pw.println("</script>");
		pw.close();
	}
	else if (result == -1) {
		PrintWriter pw = response.getWriter();
		pw.println("<script>");
		pw.println("alert('비밀번호 수정을 실패했습니다.')");
		pw.println("history.back();");
		pw.println("</script>");
		pw.close();
		return;
	} else
		throw new Exception("DB 입력오류");
		
}

// 병원 로그인
 if ("login".equals(hosAction)) {
	String id = null;
	String password = null;
	if (request.getParameter("id") != null) {
		id = request.getParameter("id");
	}
	if (request.getParameter("password") != null) {
		password = request.getParameter("password");
	}
	// null값이 있는지 확인
	if (id == null || password == null || id.equals("") || password.equals("")) {
		PrintWriter pw = response.getWriter();
		pw.println("<script>");
		pw.println("alert('입력이 올바르지 않습니다.')");
		pw.println("history.back();");
		pw.println("</script>");
		pw.close();
		return;
	}
	if (id.equals("admin") || password.equals("admin")) {
		session.setAttribute("memLogin", "admin");
		response.sendRedirect("Index.jsp");
	}

	// 오류를 감지하기 위해 result 값에 담음
	int result = hud.login(id, password);
	if (result == 1) {
		session.setAttribute("memLogin", "hos");
		if (request.getParameter("hosIdSave") == null) {
	session.removeAttribute("hosMemSave");
		} else {
	session.setAttribute("hosMemSave", "check");
		}
		session.setAttribute("hosMemId", id);
		session.setAttribute("hosMemPw", password);
		
		ArrayList<reserveDTO> datas = rd.getDBList(hud.getHosIdDB(id));
		request.setAttribute("datas", datas);
		//헤더부분에 이름을 보내주기 위해 로그인할때 이름을 가져와 세션에 선언한다.
		String name = hud.getNameDB(id);
		session.setAttribute("memName", name);
		pageContext.forward("HospitalReserve.jsp");
	}

	else if (result == 0) {
		PrintWriter pw = response.getWriter();
		pw.println("<script>");
		pw.println("alert('비밀번호가 틀립니다.')");
		pw.println("history.back();");
		pw.println("</script>");
		pw.close();
		return;
	}

	else if (result == -1) {
		PrintWriter pw = response.getWriter();
		pw.println("<script>");
		pw.println("alert('존재하지 않는 아이디입니다.')");
		pw.println("history.back();");
		pw.println("</script>");
		pw.close();
		return;
	} else
		throw new Exception("DB 입력오류");
}

//병원 회원 가입
else if ("insert".equals(hosAction)) {
	String id = null;; //병원 아이디
	String password = null;;// 병원 비밀번호
	String hospitalName = null;;// 병원명
	String hospitalNumber = null;;// 병원 대표 전화
	String hospitalId = null;; // 병원 기관 ID
	String hospitalAddress = null;; // 병원 주소
	
	if (request.getParameter("id") != null) {
		id = request.getParameter("id");
	}
	if (request.getParameter("password") != null) {
		password = request.getParameter("password");
	}
	if (request.getParameter("hospitalName") != null) {
		hospitalName = request.getParameter("hospitalName");
	}
	if(request.getParameter("hospitalNumber") != null){
		hospitalNumber = request.getParameter("hospitalNumber");
	}
	if (request.getParameter("hospitalId") != null) {
		hospitalId = request.getParameter("hospitalId");
	}
	if (request.getParameter("hospitalAddress") != null) {
		hospitalAddress = request.getParameter("hospitalAddress");
	}
	
	// null값이 있는지 확인
	if (id == null || password == null || hospitalName == null || hospitalNumber == null || hospitalId == null || hospitalAddress == null || id.equals("")
	|| password.equals("") || password.equals("")) {
		PrintWriter pw = response.getWriter();
		pw.println("<script>");
		pw.println("alert('입력이 올바르지 않습니다.')");
		pw.println("history.back();");
		pw.println("</script>");
		pw.close();
		return;
	}

	// 오류를 감지하기 위해 result변수에 담음
	int result = hud.insertDB(addrhos);
	if (result > 0) {
		response.sendRedirect("Index.jsp");
	}

	else if (result == -1) {
		PrintWriter pw = response.getWriter();
		pw.println("<script>");
		pw.println("alert('회원가입에 실패했습니다.')");
		pw.println("history.back();");
		pw.println("</script>");
		pw.close();
		return;
	} else
		throw new Exception("DB 입력오류");
}

//병원 예약 조회
else if("search".equals(hosAction)){
	String id = null;
	id = (String)session.getAttribute("hosMemId");
	ArrayList<reserveDTO> datas = rd.getDBList(hud.getHosIdDB(id));
	request.setAttribute("datas", datas);
	pageContext.forward("HospitalReserve.jsp");
}

//예약 등록
if ("insert".equals(rdAction)) {
	String IdHospital = null; //병원 아이디
	String Idpatient = null;// 환자 아이디
	String department = null;// 예약구분
	String reserveDiv = null;// 진료과
	String registrationBackNumber = null; // 주민번호 뒷자리
	String symptom = null; // 증상
	String reserveDate = null; //예약날짜
	String namepatient = null; //환자이름
	String namehospital = null; //환자이름
	
	if (request.getParameter("IdHospital") != null) {
		IdHospital = request.getParameter("IdHospital");
	}
	if (request.getParameter("Idpatient") != null) {
		Idpatient = request.getParameter("Idpatient");
	}
	if (request.getParameter("department") != null) {
		department = request.getParameter("department");
	}
	if(request.getParameter("reserveDiv") != null){
		reserveDiv = request.getParameter("reserveDiv");
	}
	if (request.getParameter("registrationBackNumber") != null) {
		registrationBackNumber = request.getParameter("registrationBackNumber");
	}
	if (request.getParameter("symptom") != null) {
		symptom = request.getParameter("symptom");
	}
	if (request.getParameter("reserveDate") != null) {
		reserveDate = request.getParameter("reserveDate");
	}
	if (request.getParameter("namepatient") != null) {
		namepatient = request.getParameter("namepatient");
	}
	if (request.getParameter("namehospital") != null) {
		namehospital = request.getParameter("namehospital");
	}
	
	// null값이 있는지 확인
	if (IdHospital == null || Idpatient == null || department == null || reserveDiv == null || registrationBackNumber == null || symptom == null || reserveDate == null || namepatient == null || namehospital == null)
	{
		PrintWriter pw = response.getWriter();
		pw.println("<script>");
		pw.println("alert('입력이 올바르지 않습니다.')");
		pw.println("history.back();");
		pw.println("</script>");
		pw.close();
		return;
	}
	// 오류를 감지하기 위해 result변수에 담음
	int result = rd.insertDB(addrrd);
	if (result > 0) {
		response.sendRedirect("Index.jsp");
	}

	else if (result == -1) {
		PrintWriter pw = response.getWriter();
		pw.println("<script>");
		pw.println("alert('예약에 실패했습니다.')");
		pw.println("history.back();");
		pw.println("</script>");
		pw.close();
		return;
	} else
		throw new Exception("DB 입력오류");
}
//예약 삭제
else if ("delete".equals(rdAction)){
	String hosUserId = (String)session.getAttribute("hosMemId");
	String hosId = null;
	String patId = null;
	String[] id = new String[2];
	
	hosId = hud.getHosIdDB(hosUserId);
	
	if (request.getParameter("Idpatient") != null) {
		patId = request.getParameter("Idpatient");
	}
	
	// null값이 있는지 확인
	if (hosId == null || patId == null)
	{
		PrintWriter pw = response.getWriter();
		pw.println("<script>");
		pw.println("alert('ID값을 가져오는데 실패했습니다.')");
		pw.println("history.back();");
		pw.println("</script>");
		pw.close();
		return;
	}
	
	//DAO에 보내기 위해 문자 배열에 ID 값을 넣어준다.
	id[0] = hosId;
	id[1] = patId;
	
	System.out.println(id[0]);
	System.out.println(id[1]);
	
	if (rd.deleteDB(id)) {
		response.sendRedirect("PageControl.jsp?hosAction=search");
	} else
		throw new Exception("DB 삭제 오류");
}

//환자 마이페이지 예약 조회
else if("search".equals(rdAction)){
	String id = null;
	id = (String)session.getAttribute("memId");
	ArrayList<reserveDTO> datas = rd.getMemDBList(id);
	request.setAttribute("datas", datas);
	pageContext.forward("MyPage.jsp");
}

if ("search".equals(hoslAction)) {
	long start = System.currentTimeMillis();
	List<Map> pubList = new ArrayList();
	try{
		request.setCharacterEncoding("UTF-8");
		String search = request.getParameter("search"); //검색 분류(병원명, 진료과)
		String keyword = request.getParameter("keyword");// 검색어
		String lat = request.getParameter("lat");//위도
		String lng = request.getParameter("lng");//경도
		System.out.println(lat + " , " + lng); //경도 위도 출력
		String location = getLocation(lat, lng);
		// XML 문서 파싱
		 String xml = location;// String으로 만든 xml 파일을 가져옴
		 InputSource is = new InputSource(new StringReader(xml));
		 DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		 DocumentBuilder documentBuilder = factory.newDocumentBuilder();
		 Document document = documentBuilder.parse(is);
		 document.getDocumentElement().normalize();
		 System.out.println("파일출력");
		// 읽어들인 파일 불러오기
         NodeList nodes = document.getElementsByTagName("item");
         for (int k = 0; k < nodes.getLength(); k++) {
             Node node = nodes.item(k);
             if (node.getNodeType() == Node.ELEMENT_NODE) {
                 Element element = (Element) node;
                 if(!(Float.parseFloat(getValue("distance", element)) < 1.0)){
                	 continue;
                 } // 현재 위치에서 1키로 이내에 있는 병원만 검색
                 
                 String DgidIdName =null;
                 
             	 
                 if(search.equals("hosname")){ // 검색 분류에 따라 다르게 검색
                	 if(!(getValue("dutyName", element).contains(keyword))){
                    	 continue;
                     } // 병원명으로 검색
                	 else{
                		 hosdepartmentDTO hosmdata = hosm.getDBList(getValue("hpid", element));
                		 DgidIdName = hosmdata.getDgidIdName();
                	 }
                 }else if(search.equals("department")){
                	 hosdepartmentDTO hosmdata = hosm.getDBList(getValue("hpid", element));
                	 DgidIdName = hosmdata.getDgidIdName();
                	 if(!(DgidIdName).contains(keyword)){
                    	 continue;
                     } // 진료과로 검색
                 }
                 
                 hospitallistDTO hosldata = hosl.getDBList(getValue("hpid", element));
                 String[] basicList = {DgidIdName, hosldata.getPostCdn1(), hosldata.getPostCdn2(), hosldata.getDutyAddr(), hosldata.getWgs84Lon(), hosldata.getWgs84Lat()};
                 Map<String, String> pub = new HashMap();
             	 pub.put("dutyName", getValue("dutyName", element));
             	 pub.put("dutyTel1", getValue("dutyTel1", element));
             	 pub.put("dgidIdName", basicList[0]);
             	 pub.put("postCdn", basicList[1] + basicList[2]);
             	 pub.put("hpid", getValue("hpid", element));
             	 pub.put("dutyAddr", basicList[3]);
             	 pub.put("wgs84Lon", basicList[4]);
             	 pub.put("wgs84Lat", basicList[5]);
             	pubList.add(pub);
             }
         }
         for(Map pub : pubList){
        	 System.out.println(pub.get("dutyName"));
        	 System.out.println(pub.get("hpid"));
        	 System.out.println(pub.get("dutyTel1"));
        	 System.out.println(pub.get("dgidIdName"));
         }
         request.setAttribute("pubList", pubList);
         long end = System.currentTimeMillis();
         pageContext.forward("Search.jsp");
         System.out.println("수행시간: " + (end - start) / 1000 + " s");
	}
	catch(Exception e){
		e.printStackTrace();
	}
	
}

%>
<%!
private static String getValue(String tag, Element element) {
    NodeList nodes = element.getElementsByTagName(tag).item(0).getChildNodes();
    Node node = (Node) nodes.item(0);
    return node.getNodeValue();
}

private static String getLocation(String lat, String lng) {
	String location = "";
	//api키 가져오기
	ResourceBundle resource = ResourceBundle.getBundle("apikey");
	String dataApiKey = resource.getString("dataApiKey");
	try{
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552657/HsptlAsembySearchService/getHsptlMdcncLcinfoInqire"); /*URL*/
		 urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + dataApiKey); /*Service Key*/
		 urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
		 urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("1000", "UTF-8")); /*한 페이지 결과 수*/
		 urlBuilder.append("&" + URLEncoder.encode("WGS84_LON","UTF-8") + "=" + URLEncoder.encode(lng, "UTF-8")); /*병원경도*/
		 urlBuilder.append("&" + URLEncoder.encode("WGS84_LAT","UTF-8") + "=" + URLEncoder.encode(lat, "UTF-8")); /*병원위도*/
		 URL url = new URL(urlBuilder.toString());
		 HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		 conn.setRequestMethod("GET");
		 conn.setRequestProperty("Content-type", "application/json");
		 System.out.println("Response code: " + conn.getResponseCode());
		 BufferedReader rd;
		 if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
		     rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		 } else {
		     rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		 }
		 StringBuilder sb = new StringBuilder();
		 String line;
		 while ((line = rd.readLine()) != null) {
		     sb.append(line);
		 }
		 rd.close();
		 conn.disconnect();	
		 location = sb.toString();
		 
	}catch(Exception e){
		e.printStackTrace();
	}
	return location;
}

%>
