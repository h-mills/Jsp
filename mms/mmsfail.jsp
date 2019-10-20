<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html class="mainhtml" style="background-image: url('./img/mmsfail.jpg'); margin: 0;">
<link rel="stylesheet" type="text/css" href="./css/fitz.css?ver=1.1">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<title>finish</title>
</head>
<body style="width:100%; height: 100%; margin: 0;">
<div style="position:absolute; width:75%; height:50%; overflow:hidden; background-color:white; margin-top:25%; margin-left:15%; ">
	<h1>MMS 전송실패!</h1>
	<h3>에러코드 : <%=request.getParameter("error_code") %></h3>
	<h3>원인 : <%=URLDecoder.decode(request.getParameter("error_reason"),"UTF-8")%></h3>
	<h5>재시도 후에도 같은 문제 발생 시</h5>
	<h5><a href="tel:02-554-6401">02-554-6401</a> 로 문의 주시기 바랍니다.</h5>
</div>
</html>