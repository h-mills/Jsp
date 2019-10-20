<%@page import="java.util.Map"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
	Map<String, Object> paramMap = (Map) request.getAttribute("paramMap");

	response.setHeader("Content-Disposition", "attachment;filename="+
	         URLEncoder.encode("기간별통계_"+paramMap.get("st_categoryName")+"_"+paramMap.get("startDate")+"-"+paramMap.get("endDate")+".xls","utf-8"));
	response.setHeader("Content-Description", "JSP Generated Data");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body> 
	구분 : <b>${paramMap.st_categoryName}</b><br/>
	기간 : <b>${param.startDate} ~ ${param.endDate}</b><br/>
	<h4><b>최근 통계 요약(조건 무관)</b></h4>
	<b>${statsConfig[4].day2} 기준 (총 스캔수 제외)</b>
	<table>
		<tr>
			<td>
				<strong>총 스캔수</strong>
				<br> ~ ${statsConfig[0].day1} (누적)
			</td>
			<td>${statsConfig[0].count}</td>
		</tr>
		<tr>
			<td>
				<strong>어제 스캔수</strong>
	        	<br>비교일 ${statsConfig[4].day1} (1일)
	        </td>
	        <td>
				<span>${statsConfig[1].count}</span>
			</td>
		</tr>
		<tr>
			<td>
				<strong>지난 7일간 스캔수</strong>
	            <br>비교일 ${statsConfig[5].day1} ~ ${statsConfig[5].day2} (7일)
	        </td>
			<td>
				<span>${statsConfig[2].count}</span>
			</td>
		</tr>
		<tr>
			<td>
				<strong>지난 30일간 스캔수</strong>
	            <br>비교일 ${statsConfig[6].day1} ~ ${statsConfig[6].day2} (30일)
	        </td>
			<td>
				<span>${statsConfig[3].count}</span>
			</td>
		</tr>
	</table>
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