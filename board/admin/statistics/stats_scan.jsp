<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="project.pc.model.statsModel"%>
<%@page import="project.pc.model.statsConfig"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.addHeader("Cache-Control", "no-store");
	response.setDateHeader("Expries", 1L);
	int cnt = (Integer) session.getAttribute("count");
	int month_count = 0;
	List<statsConfig> statsConfig = (List<statsConfig>) session.getAttribute("statsConfig");
	List<statsModel> monthData = (List<statsModel>) session.getAttribute("monthData");
	List<statsModel> dailyData = (List<statsModel>) session.getAttribute("dailyData");
	List<statsModel> hourData = (List<statsModel>) session.getAttribute("hourData");
%>
<jsp:useBean id="now" class="java.util.Date" />
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<html>
<head>
<title>통계_스캔별</title>
<style>
* {text-decoration: none;}
li {list-style: none;text-decoration: none;float: left;}
@media print {html, body {width: 210mm;min-height: 297mm;}}
</style>

<script type="text/javascript" charset="UTF-8">
	$(document).ready(function() {
		fn_companylist();
	});
	function fn_local() {
		form.action = "/pc/statistics/stats_local";
		form.submit();
	}
	function excelDownload() {
		$("#st_companyName").val($("#st_company option:selected").text());
		$("#st_orderName").val($("#st_order option:selected").text());
		
		form.action="/pc/statistics/excel";
		form.submit();
	}
	function fn_companylist() {
		var url = "/pc/statistics/companylist"
		$.ajax({
			type : 'post',
			url : url,
			data : {},
			async : true,
			success : function(data) {

				var JSONobj = JSON.parse(data);
				var companylist = JSONobj.companyList;
				$("#st_company").find("option").remove();
				$("#st_company").append("<option value='-1'>업체 선택</option>");
				$("#st_company").append("<option value='0'>전체</option>");

				for (var i = 0; i < companylist.length; i++) {
					var cd = companylist[i].no;
					var name = companylist[i].name;
					$("#st_company").append("<option value="+cd+">" + name + "</option>");
				}
				if ("${st_company}" != "") {
					$("#st_company option[value='" + "${st_company}" + "']").attr("selected", "selected");
				}
				fn_orderlist();
			}
		});
	}
	function printfn()
	{
		window.print();
	};
	function fn_search() {
		if($('#startDate').val() == "" || $('#endDate').val() == "") {
			alert("날짜를 지정하세요.");
			return false;
		} else if($('#st_company').val() == -1) {
			alert("업체명을 선택하세요.");
			return false;
		} else if($('#st_order').val() == -1) {
			alert("발주차수를 선택하세요.");
			return false;
		}

		$("#st_companyName").val($("#st_company option:selected").text());
		$("#st_orderName").val($("#st_order option:selected").text());

		form.action = "/pc/statistics/stats_scan";
		form.submit();
	}
	function fn_orderlist() {
		var company_no = $('#st_company').val();
		var url = "/pc/statistics/orderlist"
		$.ajax(
		{
			type : 'post',
			url : url,
			data : {company_no : company_no},
			async : true,
			success : function(data) {

				var JSONobj = JSON.parse(data);
				var orderList = JSONobj.orderList;
				var result = JSONobj.result;

				$("#st_order").find("option").remove();
				$("#st_order").append("<option value='-1'>발주차수 선택</option>");
				$("#st_order").append("<option value='0'>전체</option>");

				if (result == "1") {
					for (var i = 0; i < orderList.length; i++) {
						var no = orderList[i].no;
						var title = orderList[i].title;
						$("#st_order").append("<option value="+no+">" + title + "</option>");
					}
					if ("${st_order}" != "") {
						$("#st_order option[value='" + "${st_order}" + "']").attr("selected", "selected");
					}
				}
				if (company_no == '-1' || result != '1') {
					$("#st_order").find("option").remove();
					$("#st_order").append("<option value='-1'>발주차수 선택</option>");
				}
			}
		});
	}
 
<c:if test="${st_company >= 0 && st_company != null && count > 0}">
var data_R = [
		['회사명', '스캔수', {role : 'annotation'}],
		<c:forEach items="${rankData}" var="rankData">
		['${rankData.company_name}',<c:out value="${rankData.count}"/>,'${rankData.count}'],
		</c:forEach>
	];

	var options_R = 
	{
		title: '기간 내 스캔횟수',
		width: 900, 
		height: 300,
		vAxis: 
		{
			title: ''
		},
		hAxis:
		{
		}
	}
	google.load('visualization', '1.0', {'packages':['corechart']});
	google.setOnLoadCallback(function() {
		var chart = new google.visualization.ColumnChart(document.querySelector('#cGraph'));
		chart.draw(google.visualization.arrayToDataTable(data_R), options_R);
	});

//	월별
<%if (monthData != null) {%>

	var data = [
		['월별', '스캔수', {role : 'annotation'}],
		<%for (int i = monthData.size() - 1; i >= 0; i--) {
					month_count += monthData.get(i).getCount();%>
		[
		'<%=monthData.get(i).getYear()%>년 <%=monthData.get(i).getMonth()%>월', 
		<%=monthData.get(i).getCount()%>,
		'<%=monthData.get(i).getCount()%>'
		],
		<%}%>
	];
	var options = 
	{
		title: '월별 스캔횟수 (총 스캔수 : <%=month_count%>)',
		width: 900, 
		height: 300,
		vAxis: 
		{
			title: ''
		},
		hAxis:
		{
		}
	}
	google.load('visualization', '1.0', {'packages':['corechart']});
	google.setOnLoadCallback(function() {
		var chart = new google.visualization.ColumnChart(document.querySelector('#mGraph'));
		chart.draw(google.visualization.arrayToDataTable(data), options);
	});

// 	일별
	<%for (int m = monthData.size() - 1; m >= 0; m--) {%>
	var data_d<%=m%> = 
		[
			['일별', '스캔수', {role : 'annotation'}],
	<%for (int d = dailyData.size() - 1; d >= 0; d--) {
						if (monthData.get(m).getYear().equals(dailyData.get(d).getYear())
								&& monthData.get(m).getMonth().equals(dailyData.get(d).getMonth())) {%>
	    [
	    	'<%=dailyData.get(d).getMonth()%>/<%=dailyData.get(d).getDay()%>', 
	      	<%=dailyData.get(d).getCount()%>, 
	      	'<%=dailyData.get(d).getCount()%>'
	    ],
	<%} // if
					} // for d%>
	];
	var options_d<%=m%> = 
	{
		title: '일별 스캔횟수 - <%=monthData.get(m).getYear()%>년 <%=monthData.get(m).getMonth()%>월',
	    width: 900, 
	    height: 300,
	    vAxis: 
	    {
	    	title: ''
	    }
	}
	google.load('visualization', '1.0', {'packages':['corechart']});
	google.setOnLoadCallback(function() {
		var chart_d<%=m%> = new google.visualization.ColumnChart(document.querySelector('#dGraph<%=m%>'));
		chart_d<%=m%>.draw(google.visualization.arrayToDataTable(data_d<%=m%>), options_d<%=m%>);
	});	
	<%} // for m%>	

//	 	시간대별
	var data_h = [
		['시간대별', '스캔수', {role : 'annotation'}],
		<%for (int i = hourData.size() - 1; i >= 0; i--) {
					int hour = Integer.parseInt(hourData.get(i).getHour());%>
		[
		'<%=hour%>~<%=hour + 1%>', 
		<%=hourData.get(i).getCount()%>, 
		'<%=hourData.get(i).getCount()%>'
		],
<%}%>
	];
	var options_h = {
		title : '시간대별 스캔횟수',
		width : 900,
		height : 300,
		vAxis : {
			title : ''
		}
	}
	google.load('visualization', '1.0', {
		'packages' : [ 'corechart' ]
	});
	google.setOnLoadCallback(function() {
		var chart_h = new google.visualization.ColumnChart(document
				.querySelector('#hGraph'));
		chart_h.draw(google.visualization.arrayToDataTable(data_h), options_h);
	});
<%}%>
</c:if>
</script>

</head>
<body>
	<fmt:formatDate value="${now }" pattern="yyyy-MM-dd" var="today" />

	<div class="container cntbox radiall" style="padding: 20px 20px 0 20px; margin-top: 20px;">
		<div class="pull-left center-block" style="width: 100%;">
			<div class="btn-group center-block center-block text-center" style="width: 200px;">
				<button type="button" class="btn btn-primary navbar-btn wd100 active">스캔별</button>
				<button type="button" class="btn btn-default navbar-btn wd100" onclick="fn_local();">지역별</button>
			</div>
		</div>
		<c:if test="${statsConfig!=null }">
			<div class="panel panel-default pull-left inbox stats-s-t">
				<div class="panel-heading">
					<strong>최근 통계 현황 요약(조건 무관)</strong>&nbsp;&nbsp; 
					<small class="text-muted"><%=statsConfig.get(4).getDay2()%>일 스캔수 (${todayCount })</small>
				</div>
				<div class="panel-body">
					<table class="table">
						<tr>
							<td><span><%=statsConfig.get(0).getCount()%></span></td>
							<td><span><%=statsConfig.get(1).getCount()%></span></td>
							<td><span><%=statsConfig.get(2).getCount()%></span></td>
							<td><span><%=statsConfig.get(3).getCount()%></span></td>
						</tr>
						<tr>
							<td><strong>총 스캔수</strong><br>~<%=statsConfig.get(0).getDay1()%>(누적)</td>
							<td><strong>어제 스캔수</strong><br><%=statsConfig.get(4).getDay1()%>(1일)</td>
							<td><strong>지난 7일간 스캔수</strong><br><%=statsConfig.get(5).getDay1()%>~<%=statsConfig.get(5).getDay2()%>(7일)</td>
							<td><strong>지난 30일간 스캔수</strong><br><%=statsConfig.get(6).getDay1()%>~<%=statsConfig.get(6).getDay2()%>(30일)</td>
						</tr>
					</table>
				</div>
			</div>
		</c:if>
	</div>

	<form id="form" method="post" action="/pc/statistics/stats_scan">
		<input type="hidden" name="today" id="today" value="${today }">
		<input type="hidden" name="st_companyName" id="st_companyName" value=""> 
		<input type="hidden" name="st_orderName" id="st_orderName" value="">
		<div class="container subnav" style="margin-top:10px; border-radius: 5px;">
			<div class="subnavcontainer">
				<div class="input-group pull-left width-120" style="width: 120px;">
					<input type="text" class="form-control input-sm" id="startDate" name="startDate" value="${startDate==null?'2017-02-16':startDate}">
				</div>
				<p class="pull-left margin-lr-10 font-w" style="padding-top: 4px;">~</p>
				<div class="input-group pull-left width-120 margin-r-10" style="width: 120px;">
					<input type="text" class="form-control input-sm" id="endDate" name="endDate" value="${endDate==null?today:endDate}">
				</div>
			</div>
			<div class="font-w pull-left">
				<div class="pull-left margin-r-10" style="width: 200px;">
					<select class="form-control input-sm" name="st_company" id="st_company" onchange="fn_orderlist();">
						<option value="-1">업체 선택</option>
					</select>
				</div>
			</div>
			<div class="font-w pull-left">
				<div class="pull-left" style="width: 180px;">
					<select class="form-control input-sm" name="st_order" id="st_order">
						<option value="-1">발주차수 선택</option>
					</select>
				</div>
			</div>
			<div class="pull-left width-100">
				<button class="btn btn-info wd50 btn-sm " type="button" onclick="fn_search()">검색</button>
			</div>
		</div>
	</form>

	<div class="container margin-t-10 cntbox radiall" style="padding: 20px 20px 0 20px;">
		<div>
			<div class="pull-left">
				<p class="pull-left text-muted stats-date" style="width: 100%; margin-top: 20px;">
					<span class="label label-primary">기간</span>&nbsp;&nbsp;${startDate==null?'2017-02-16':startDate} ~ ${endDate==null?today:endDate}&nbsp;&nbsp; 
					<span class="label label-primary">총 스캔 횟수</span>&nbsp;&nbsp;${st_company<0 || st_company==null ? "0" : count }&nbsp;&nbsp;
				</p>
			</div>
			<div class="navbar-btn btn-group-sm pull-right" style="display: ${(count > 0 && st_company >= 0)?'block':'none'};">
				<button type="button" class="btn btn-success btn-sm" onclick="excelDownload();">
					<img src="/image/png/1448007871_excel.png" alt="" width="14px" style=""> &nbsp;엑셀
				</button>
				<button type="button" class="btn btn-danger btn-sm margin-l-10" onclick="printfn();">
					<img src="/image/png/1448007858_pdf.png" alt="" width="14px" style=""> &nbsp;PDF
				</button>
			</div>
		</div>
		<div class="pull-left inbox">
			<c:choose>
				<c:when test="${st_company<0 || st_company==null }">
					<div style="text-align: center;">해당 조건내의 통계자료가 없습니다.</div>
				</c:when>
				<c:otherwise>
					<%if (cnt == 0) {%>
					<div style="text-align: center;">해당 조건내의 통계자료가 없습니다.</div>
					<%} else {%>
					<h4>
						<img src="/image/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">회사별 스캔 순위 (상위10개)
					</h4>
					<div class="pull-left inbox" id="cGraph"></div>
					<h4>
						<img src="/image/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">월별 현황
					</h4>
					<div class="pull-left inbox" id="mGraph"></div>
					<h4>
						<img src="/image/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">일별 현황
					</h4>
					<div class="pull-left inbox" id="dGraph">
						<%if (monthData != null) {
							for (int m = 0; m < monthData.size(); m++) {%>
						<div class="pull-left inbox" id="dGraph<%=m%>"></div>
						<%}}%>
					</div>
					<h4>
						<img src="/image/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">시간대별 현황
					</h4>
					<div class="pull-left inbox" id="hGraph"></div>
					<%}%>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</html>