<%@page import="java.util.Map"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
	Map<String, Object> paramMap = (Map) request.getAttribute("paramMap");
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
	         URLEncoder.encode("기간별통계_"+paramMap.get("t_category")+"_"+paramMap.get("startDate")+"-"+paramMap.get("endDate")+".xls","utf-8"));
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
	<h4><b>월별 스캔수</b></h4>
	<table>
		<tr>
			<th>날짜</th><th>스캔수</th>
		</tr>
		<c:forEach  items="${monthData }" var="monthData">
		<tr>
			<td>${monthData.year}년 ${monthData.month}월</td>
			<td>${monthData.count}</td>
		</tr>
		</c:forEach>
		<tr>
			<td>합계</td>
			<td>${scanTotalCount}</td>
		</tr>
	</table>
	<br>
	<h4><b>일별 스캔수</b></h4>
	<table>
		<tr>
			<th>날짜</th><th>스캔수</th>
		</tr>
		<c:forEach items="${monthData }" var="monthData" varStatus="d">
			<c:forEach items="${dailyData }" var="dailyData" varStatus="a">
				<c:if test="${monthData.year == dailyData.year && monthData.month == dailyData.month}">
		<tr>
			<td align="left">${dailyData.year}년 ${dailyData.month}월 ${dailyData.day}일</td>
			<td>${dailyData.count}</td>
		</tr>
				</c:if>
			</c:forEach>
		<tr></tr>
		</c:forEach>
	</table>
	<br>
	<h4><b>시간대별 스캔수</b></h4>
	<table>
		<tr>
			<th>시간</th><th>스캔수</th>
		</tr>
		<c:forEach items="${hourData }" var="hourData" varStatus="h">
		<tr>
			<td>${hourData.hour}시 ~ ${hourData.hour + 1}시</td>
			<td>${hourData.count}</td>
		</tr>
		</c:forEach>
	</table>
</body>
</html>