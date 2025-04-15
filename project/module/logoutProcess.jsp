<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.removeAttribute("memLogin");
	out.println("<script>alert('로그아웃 되었습니다.');</script>");
	out.println("<script>location.href='../Index.jsp'</script>");
%>