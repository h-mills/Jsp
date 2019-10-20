<%@page import="java.util.Map"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
	Map<String,Object> paramMap = (Map) session.getAttribute("paramMap");
	Map<String,Object> orderData = (Map) session.getAttribute("orderData");

	response.setHeader("Content-Disposition", "attachment;filename="+
	         URLEncoder.encode("지역별통계_"+orderData.get("company_name")+"_"+orderData.get("order_title")+"_"+paramMap.get("startDate")+"-"+paramMap.get("endDate")+".xls","UTF-8"));
	response.setHeader("Content-Description", "JSP Generated Data");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	기간 : <b>${paramMap.startDate} ~ ${paramMap.endDate}</b><br/>
	업체명 : <b>${orderData.company_name== null?"전체":orderData.company_name}</b><br/>
	발주차수 : <b>${orderData.order_title== null?"전체":orderData.order_title}</b><br/>
	<h4><b>국가별 현황</b></h4>
	<table>
		<tr>
			<th>국가</th>
			<th>스캔수</th>
		</tr>
		<c:forEach items="${nationData }" var="nationData">
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
	<h4><b>상세 현황</b></h4>
	<table>
		<tr>
			<th>번호</th>
			<th>국가</th>
			<th>지역</th>
			<th>상세주소</th>
			<th>검출일자</th>
		</tr>
		<c:forEach  items="${excelAddressData }" var="excelAddressData" varStatus="i">
		<tr>
			<td>${i.count}</td>
			<td>${excelAddressData.nation}</td>
			<td>${excelAddressData.city}</td>
			<td>${excelAddressData.address}</td>
			<td>${excelAddressData.date}</td>
		</tr>
		</c:forEach>
	</table>
	<br/>
</body>
</html>