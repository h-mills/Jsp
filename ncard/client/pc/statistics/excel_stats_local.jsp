<%@page import="java.util.Map"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
	Map<String,Object> paramMap = (Map) request.getAttribute("paramMap");

	response.setHeader("Content-Disposition", "attachment;filename="+
	         URLEncoder.encode("지역별통계_"+paramMap.get("deptname")+"_"+paramMap.get("startDate")+"-"+paramMap.get("endDate")+".xls","UTF-8"));
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
	부서 : <b>${paramMap.deptname== null?"전체":paramMap.deptname}</b><br/>
	<h4><b>부서 통계 요약</b></h4>
	<table>
		<tr>
			<td><strong>총 인식 국가수</strong></td>
			<td><strong>상위 1순위 국가</strong></td>
			<td><strong>상위 2순위 국가</strong></td>
			<td><strong>상위 3순위 국가</strong></td>
		</tr>
		<tr>
			<td><span>${countMap.nationcount }</span></td>
			<td><span>${nationRack[0].count==null?0:nationRack[0].count }</span>&nbsp;<span>(${nationRack[0].nation==null?"-":nationRack[0].nation })</span></td>
			<td><span>${nationRack[1].count==null?0:nationRack[1].count }</span>&nbsp;<span>(${nationRack[1].nation==null?"-":nationRack[1].nation })</span></td>
			<td><span>${nationRack[2].count==null?0:nationRack[2].count }</span>&nbsp;<span>(${nationRack[2].nation==null?"-":nationRack[2].nation })</span></td>
		</tr>
	</table>
	<br/>
	<c:if test="${namesearch == 0}">
	<h4><b>부서별 지역 현황</b></h4>
	<table>
		<tr>
			<th>부서</th><th>국가수</th>
		</tr>
		<c:forEach  items="${deptRank }" var="deptRank">
		<tr>
			<td>${deptRank.dept_name }</td>
			<td>${deptRank.count }</td>
		</tr>
		</c:forEach>
	</table>
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
	<h4><b>상세 현황</b></h4>
	<table>
		<tr>
			<th>국가</th>
			<th>지역</th>
			<th>이름</th>
			<th>상세주소</th>
			<th>스캔일자</th>
		</tr>
		<c:forEach  items="${addressData }" var="addressData">
		<tr>
			<td>${addressData.nation }</td>
			<td>${addressData.city }</td>
			<td>${addressData.name}</td>
			<td>${addressData.address }</td>
			<td>${addressData.date }</td>
		</tr>
		</c:forEach>
	</table>
	</c:if>
	<c:if test="${namesearch == 1}">
	<h4><b>명함별 지역 통계 현황</b></h4>
	<table>
		<tr>
			<th>이름</th><th>지역수</th>
		</tr>
		<c:forEach  items="${nameData }" var="nameData">
		<tr>
			<td>${nameData.name }</td>
			<td>${nameData.citycount }</td>
		</tr>
		</c:forEach>
	</table>
	<br/>
	</c:if>
	<br/>
</body>
</html>