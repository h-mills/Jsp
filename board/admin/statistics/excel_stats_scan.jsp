<%@page import="project.pc.model.statsModel"%>
<%@page import="project.pc.model.statsConfig"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int count = 0;
	List<statsModel> statsModel_m = (List<statsModel>) session.getAttribute("monthData");
	List<statsModel> statsModel_d = (List<statsModel>) session.getAttribute("dailyData");
	List<statsModel> statsModel_h = (List<statsModel>) session.getAttribute("hourData");
	List<statsModel> statsModel_r = (List<statsModel>) session.getAttribute("rankData");
	Map<String,Object> paramMap = (Map)request.getAttribute("paramMap");
	List<statsConfig> statsConfig = (List<statsConfig>) session.getAttribute("statsConfig");
	
	response.setHeader("Content-Disposition", "attachment;filename="+
	         URLEncoder.encode("기간별통계_"+paramMap.get("st_companyName")+"_"+paramMap.get("st_orderName")+"_"+paramMap.get("startDate")+"-"+paramMap.get("endDate")+".xls","utf-8"));
	response.setHeader("Content-Description", "JSP Generated Data");
	
	//response.setContentType("application/vnd-ms.excel");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
기간 : <b><%=paramMap.get("startDate")%> ~ <%=paramMap.get("endDate")%></b><br/>
<% if(paramMap.get("st_companyName") != null) {%>
업체명 : <b><%=paramMap.get("st_companyName")%></b><br/>
<%} else {%>
업체명 : <b>전체</b><br/>
<%}%>
<% if(paramMap.get("st_orderName") != null) {%>
발주차수 : <b><%=paramMap.get("st_orderName")%></b>
<%} else {%>
발주차수 : <b>전체</b><br/>
<%}%>
<h4><b>최근 통계 요약(조건 무관)</b></h4>
<b><%=statsConfig.get(4).getDay2()%> 기준 (총 스캔수 제외)</b>
<table>
	<tr>
		<td>
			<strong>총 스캔수</strong>
			<br> ~ <%=statsConfig.get(0).getDay1()%> (누적)
		</td>
		<td><%=statsConfig.get(0).getCount()%></td>
	</tr>
	<tr>
		<td>
			<strong>어제 스캔수</strong>
        	<br>비교일 <%=statsConfig.get(4).getDay1()%> (1일)
        </td>
        <td>
			<span><%=statsConfig.get(1).getCount()%></span>
		</td>
	</tr>
	<tr>
		<td>
			<strong>지난 7일간 스캔수</strong>
            <br>비교일 <%=statsConfig.get(5).getDay1()%> ~ <%=statsConfig.get(5).getDay2()%> (7일)
        </td>
		<td>
			<span><%=statsConfig.get(2).getCount()%></span>
		</td>
	</tr>
	<tr>
		<td>
			<strong>지난 30일간 스캔수</strong>
            <br>비교일 <%=statsConfig.get(6).getDay1()%> ~ <%=statsConfig.get(6).getDay2()%> (30일)
        </td>
		<td>
			<span><%=statsConfig.get(3).getCount()%></span>
		</td>
	</tr>
</table>
<br/>
<h4><b>회사별 스캔 순위</b></h4>
<table>
	<tr>
		<th>회사명</th><th>스캔수</th>
	</tr>
	<%for (int i = 0; i < statsModel_r.size(); i++) { count += statsModel_r.get(i).getCount();%>
	<tr>
		<td><%=statsModel_r.get(i).getCompany_name()%></td>
		<td><%=statsModel_r.get(i).getCount()%></td>
	</tr>
	<%} %>
	<tr>
		<td>합계</td>
		<td><%=count %></td>
	</tr>
</table>
<br>
<h4><b>월별 스캔수</b></h4>
<table>
	<tr>
		<th>날짜</th><th>스캔수</th>
	</tr>
	<%for (int i = statsModel_m.size() - 1; i >= 0; i--) {%>
	<tr>
		<td><%=statsModel_m.get(i).getYear()%>년 <%=statsModel_m.get(i).getMonth()%>월</td>
		<td><%=statsModel_m.get(i).getCount()%></td>
	</tr>
	<%} %>
</table>
<br>
<h4><b>일별 스캔수</b></h4>
<table>
	<tr>
		<th>날짜</th><th>스캔수</th>
	</tr>
	<%
	for(int m = statsModel_m.size() - 1; m >= 0; m--) {
		for (int d = statsModel_d.size() - 1; d >= 0; d--) {
			if(statsModel_m.get(m).getYear().equals(statsModel_d.get(d).getYear()) && statsModel_m.get(m).getMonth().equals(statsModel_d.get(d).getMonth())) {	
	%>
	<tr>
		<td align="left"><%=statsModel_m.get(m).getYear()%>년 <%=statsModel_d.get(d).getMonth()%>월 <%=statsModel_d.get(d).getDay()%>일</td>
		<td><%=statsModel_d.get(d).getCount()%></td>
	</tr>
	<%
			}
		}
	%>
	<tr></tr>
	<%
	}
	%>
</table>
<br>
<h4><b>시간대별 스캔수</b></h4>
<table>
	<tr>
		<th>시간</th><th>스캔수</th>
	</tr>
	<%for (int h = statsModel_h.size() - 1; h >= 0; h--) {
		int hour = Integer.parseInt(statsModel_h.get(h).getHour());%>
	<tr>
		<td><%=hour%>시 ~ <%=hour+1%>시</td>
		<td><%=statsModel_h.get(h).getCount()%></td>
	</tr>
	<%} %>
</table>
</body>
</html>