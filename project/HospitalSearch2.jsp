<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.net.HttpURLConnection, java.net.URL, java.net.URLEncoder"%>
<%@ page import = "java.io.BufferedReader, java.io.IOException, java.io.*"%>
<%@ page import = "java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map" %>
<%@ page import = "javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory, javax.xml.parsers.ParserConfigurationException"%>
<%@ page import = "org.w3c.dom.Document, org.w3c.dom.Element, org.w3c.dom.Node, org.w3c.dom.NodeList, org.xml.sax.SAXException, org.xml.sax.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	List<Map> pubList = new ArrayList();
	try{
		String location = getLocation();
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
                 } // 현재 위치에서 3키로 이내에 있는 병원만 검색
                 if(!(getValue("dutyName", element).contains("365"))){
                	 continue;
                 } // 키워드에 따른 병원만 검색
                 
                 Map<String, String> pub = new HashMap();
             	 pub.put("dutyName", getValue("dutyName", element));
             	 pub.put("dutyTel1", getValue("dutyTel1", element));
             	 pub.put("dgidIdName", getHosInfo(getValue("hpid", element), 1));
             	 pub.put("hpid", getValue("hpid", element));
             	 
             	 System.out.println("item distance: " + getValue("distance", element));
                 System.out.println("item dutyName: " + getValue("dutyName", element));
                 System.out.println("item dutyTel1: " + getValue("dutyTel1", element));
                 System.out.println("item dgidIdName: " + getHosInfo(getValue("hpid", element), 1));
                 System.out.println("item hpid: " + getValue("hpid", element));
                 
                 pubList.add(pub);
             }
         }
         for(Map pub : pubList){
        	 System.out.println(pub.get("dutyName"));
        	 System.out.println(pub.get("dutyTel1"));
        	 System.out.println(pub.get("dgidIdName"));
         }
	}
	catch(Exception e){
		e.printStackTrace();
	}
%>
<%! 
private static String getValue(String tag, Element element) {
    NodeList nodes = element.getElementsByTagName(tag).item(0).getChildNodes();
    Node node = (Node) nodes.item(0);
    return node.getNodeValue();
}
%>
<%!//병‧의원 위치정보 조회 함수
private static String getLocation() {
	String location = "";
	try{
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552657/HsptlAsembySearchService/getHsptlMdcncLcinfoInqire"); /*URL*/
		 urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=x54Q8qIcHnEvwPqRil6XXkjUp2H9AzWuMgC8onIYs1CyUpBTOfUo7fYH540P3kHb0dUUgt%2FQEAo%2B1BfEWmKTsw%3D%3D"); /*Service Key*/
		 urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
		 urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("1000", "UTF-8")); /*한 페이지 결과 수*/
		 urlBuilder.append("&" + URLEncoder.encode("WGS84_LON","UTF-8") + "=" + URLEncoder.encode("126.8002458", "UTF-8")); /*병원경도*/
		 urlBuilder.append("&" + URLEncoder.encode("WGS84_LAT","UTF-8") + "=" + URLEncoder.encode("37.5270684", "UTF-8")); /*병원위도*/
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

<%!//병‧의원별 기본정보 조회 함수(1이 들어오면 진료과 출력, 2가 들어오면 우편번호 출력)
private static String getHosInfo(String HospitalId, int flag) {
	String Info = "";
	String postCdn1 = "";
	String postCdn2 = "";
	try{
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552657/HsptlAsembySearchService/getHsptlBassInfoInqire"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=x54Q8qIcHnEvwPqRil6XXkjUp2H9AzWuMgC8onIYs1CyUpBTOfUo7fYH540P3kHb0dUUgt%2FQEAo%2B1BfEWmKTsw%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("HPID","UTF-8") + "=" + URLEncoder.encode(HospitalId, "UTF-8")); /*기관ID*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지 번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("80", "UTF-8")); /*목록 건수*/
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
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
        
    	 // XML 문서 파싱
     	String xml = sb.toString();// String으로 만든 xml 파일을 가져옴
     	InputSource is = new InputSource(new StringReader(xml));
     	DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
     	DocumentBuilder documentBuilder = factory.newDocumentBuilder();
     	Document document = documentBuilder.parse(is);
     	document.getDocumentElement().normalize();
    	// 읽어들인 파일 불러오기
     	NodeList nodes = document.getElementsByTagName("item");
     	Node node = nodes.item(0);
        if (node.getNodeType() == Node.ELEMENT_NODE) {
            Element element = (Element) node;
            Info = getValue("dgidIdName", element).toString();
            postCdn1 = getValue("postCdn1", element).toString();
            postCdn2 = getValue("postCdn2", element).toString();
        }
	}catch(Exception e){
		e.printStackTrace();
	}
	if(flag == 1){
		return Info; //진료과를 String으로 캐스팅해서 반환한다.
	}else{
		String postCdn = postCdn1 + postCdn1;
		return postCdn;
	}
}

%>
</body>
</html>