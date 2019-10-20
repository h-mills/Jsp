<%@page import="java.util.Map"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
	Map<String,Object> paramMap = (Map) request.getAttribute("paramMap");
	String t_category = "";
	if(paramMap.get("category").toString().equals("1")) t_category = "url";
	else if(paramMap.get("category").toString().equals("2")) t_category = "email";
	else if(paramMap.get("category").toString().equals("3")) t_category = "gps";
	else if(paramMap.get("category").toString().equals("4")) t_category = "전화번호";
	else if(paramMap.get("category").toString().equals("5")) t_category = "sms";
	else if(paramMap.get("category").toString().equals("6")) t_category = "명함";
	else if(paramMap.get("category").toString().equals("7")) t_category = "메시지";

	paramMap.put("t_category", t_category);
	
	response.setHeader("Content-Disposition", "attachment;filename="+
			URLEncoder.encode("지역별통계_"+paramMap.get("t_category")+"_"+paramMap.get("startDate")+"-"+paramMap.get("endDate")+".xls","utf-8"));
	response.setHeader("Content-Description", "JSP Generated Data");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	구분 : <b>${paramMap.t_category}</b><br/>
	기간 : <b>${param.startDate} ~ ${param.endDate}</b><br/>
	<br/>
	<h4><b>국가별 현황</b></h4>
	<table>
		<tr>
			<th>국가</th><th>스캔수</th>
		</tr>
		<c:forEach  items="${nationData }" var="nationData">
		<tr>
			<td>${nationData.nation }</td>
			<td>${nationData.count }</td>
		</tr>
		</c:forEach>
	</table>
	<br/>
	<h4><b>국가별 상세 현황</b></h4>
	<c:forEach  items="${nationData }" var="nationData">
	<b>${nationData.nation }</b>
	<table>
		<tr>
			<th>지역</th>
			<th>스캔수</th>
		</tr>
		<c:forEach  items="${cityData }" var="cityData">
		<c:if test="${cityData.nation == nationData.nation }">
		<tr>
			<td>${cityData.city }</td>
			<td>${cityData.count }</td>
		</tr>
		</c:if>
		</c:forEach>
	</table>
	<br/>
	</c:forEach>
</body>
</html>