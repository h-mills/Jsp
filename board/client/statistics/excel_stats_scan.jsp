<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="project.pc.model.statsModel"%>
<%@page import="project.pc.model.statsConfig"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLEncoder"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Calendar cal = new GregorianCalendar(Locale.KOREA);
	SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
	cal.setTime(new Date());
	String date = fm.format(cal.getTime());
	cal.add(Calendar.DAY_OF_YEAR, -1); // 하루를 더한다.
	String yesterday = fm.format(cal.getTime());
	cal.setTime(new Date());
	cal.add(Calendar.DAY_OF_YEAR, -7); // 하루를 더한다.
	String lastweek = fm.format(cal.getTime());
	cal.setTime(new Date());
	cal.add(Calendar.DAY_OF_YEAR, -30); // 하루를 더한다.
	String lastmonth = fm.format(cal.getTime());
	int count = 0;
	List<statsModel> deptRank = (List<statsModel>) session.getAttribute("deptRank");
	List<statsModel> statsModel_m = (List<statsModel>) session.getAttribute("monthData");
	List<statsModel> statsModel_d = (List<statsModel>) session.getAttribute("dailyData");
	List<statsModel> statsModel_h = (List<statsModel>) session.getAttribute("hourData");
	Map<String,Object> paramMap = (Map)request.getAttribute("paramMap");
	List<statsConfig> statsConfig = (List<statsConfig>) session.getAttribute("statsConfig");
	
	response.setHeader("Content-Disposition", "attachment;filename="+
	         URLEncoder.encode("기간별통계_"+paramMap.get("deptname")+"_"+paramMap.get("startDate")+"-"+paramMap.get("endDate")+".xls","utf-8"));
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
<% if(paramMap.get("deptname") != null) {%>
부서 : <b><%=paramMap.get("deptname")%></b><br/>
<%} else {%>
부서 : <b>전체</b><br/>
<%}%>
<h4><b>부서 통계 요약(조건 무관)</b></h4>
<b><%=date%> 기준 (총 스캔수 제외)</b>
<table>
	<tr>
		<td>
			<strong>총 스캔수</strong>
			<br> ~ <%=date%> (누적)
		</td>
		<td><%=statsConfig.get(0).getCount()%></td>
	</tr>
	<tr>
		<td>
			<strong>어제 스캔수</strong>
        	<br>비교일 <%=yesterday%> (1일)
        </td>
        <td>
			<span><%=statsConfig.get(1).getCount()%></span>
		</td>
	</tr>
	<tr>
		<td>
			<strong>지난 7일간 스캔수</strong>
            <br>비교일 <%=lastweek%> ~ <%=yesterday%> (7일)
        </td>
		<td>
			<span><%=statsConfig.get(2).getCount()%></span>
		</td>
	</tr>
	<tr>
		<td>
			<strong>지난 30일간 스캔수</strong>
            <br>비교일 <%=lastmonth%> ~ <%=yesterday%> (30일)
        </td>
		<td>
			<span><%=statsConfig.get(3).getCount()%></span>
		</td>
	</tr>
</table>
<br/>
<%if(paramMap.get("namesearch").equals("0")) {%>
<h4><b>부서별 스캔 현황</b></h4>
<table>
	<tr>
		<th>부서명</th><th>스캔수</th>
	</tr>
	<%for (int i = 0; i < deptRank.size(); i++) { %>
	<tr>
		<td><%=deptRank.get(i).getDept_name()%></td>
		<td><%=deptRank.get(i).getCount()%></td>
	</tr>
	<%} %>
</table>
<br>
<h4><b>월별 스캔수</b></h4>
<table>
	<tr>
		<th>날짜</th><th>스캔수</th>
	</tr>
	<%for (int i = statsModel_m.size() - 1; i >= 0; i--) { count += statsModel_m.get(i).getCount();%>
	<tr>
		<td><%=statsModel_m.get(i).getYear()%>년 <%=statsModel_m.get(i).getMonth()%>월</td>
		<td><%=statsModel_m.get(i).getCount()%></td>
	</tr>
	<%} %>
	<tr>
		<td>합계</td>
		<td><%=count %></td>
	</tr>
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
<%} else {%>
<h4><b>명함별 스캔 통계 현황</b></h4>
	<table>
		<tr>
			<th>이름</th>
			<th>스캔수</th>
		</tr>
		<c:forEach  items="${nameRankData }" var="nameRankData">
		<tr>
			<td>${nameRankData.name }</td>
			<td>${nameRankData.count }</td>
		</tr>
		</c:forEach>
	</table>
	<br/>
<%}%>
</body>
</html>