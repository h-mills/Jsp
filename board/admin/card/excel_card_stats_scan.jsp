<%@page import="java.util.Map"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="project.common.util.WebUtil"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<%
	Map<String,Object> paramMap = (Map) session.getAttribute("paramMap");
	Map<String,Object> orderData = (Map) session.getAttribute("orderData");
	String startDate = "";
	String endDate = "";
	String today = WebUtil.getDate();
	if(paramMap.get("startDate") == null){
		startDate = "2017-02-16";
	}
	if(paramMap.get("endDate") == null){
		endDate = today;
	}
	response.setHeader("Content-Disposition", "attachment;filename="+
	         URLEncoder.encode("기간별통계_"+orderData.get("company_name")+"_"+orderData.get("order_title")+"_"+startDate+"-"+endDate+".xls","utf-8"));
	response.setHeader("Content-Description", "JSP Generated Data");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<fmt:formatDate value="${now }" pattern="yyyy-MM-dd" var="today" />
기간 : <b>${paramMap.startDate==null?'2016-02-16':paramMap.startDate } ~ ${paramMap.endDate==null?today:paramMap.endDate }</b><br>
	업체명 : <b>${orderData.company_name== null?"전체":orderData.company_name}</b><br>
	발주차수 : <b>${orderData.order_title== null?"전체":orderData.order_title}</b><br>

	<h4><b>월별 스캔수</b></h4>
	<table>
		<tr>
			<th>날짜</th>
			<th>스캔수</th>
		</tr>
		<c:forEach items="${monthData }" var="monthData">
		<tr>
			<td>${monthData.year }년 ${monthData.month }월</td>
			<td>${monthData.count }</td>
		</tr>
		</c:forEach>
		<tr>
			<td>합계</td>
			<td>${count }</td>
		</tr>
	</table>
	<br>
	<h4>
		<b>일별 스캔수</b>
	</h4>
	<table>
		<tr>
			<th>날짜</th>
			<th>스캔수</th>
		</tr>
		<c:forEach items="${monthData }" var="monthData">
			 <c:forEach items="${dailyData }" var="dailyData">
			 	<c:if test="${monthData.year == dailyData.year && monthData.month == dailyData.month}">
			 		<tr>
			 			<td align="left">${dailyData.year }년 ${dailyData.month }월 ${dailyData.day }일</td>
			 			<td>${dailyData.count }</td>
			 		</tr>
			 	</c:if>
			 </c:forEach>
			 <tr></tr>
		</c:forEach>
	</table>
	<br>
	<h4>
		<b>시간대별 스캔수</b>
	</h4>
	<table>
		<tr>
			<th>시간</th>
			<th>스캔수</th>
		</tr>
		<c:forEach items="${hourData }" var="hourData">
		<tr>
			<td>${hourData.hour }시 ~ ${hourData.hour + 1 }</td>
			<td>${hourData.count }</td>
		</tr>
		</c:forEach>
	</table>
</body>
</html>