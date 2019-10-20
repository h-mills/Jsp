<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

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
	function fn_local() {
		form.action = "/stats/qr_stats_local";
		form.submit();
	}
	function excelDown() {
		
		form.action="/stats/qr_scanexcel";
		form.submit();
	}
	function printfn()
	{
		window.print();
	}
	function fn_search() {
		if($('#startDate').val() == "" || $('#endDate').val() == "") {
			alert("날짜를 지정하세요.");
			return false;
		}

		form.action = "/stats/qr_stats_scan";
		form.submit();
	};

<c:if test="${totalCnt > 0}">
	//월별
	var data = [
		['월별', '스캔수', {role : 'annotation'}],
		<c:forEach items="${monthData }" var="monthData" varStatus="m">
			[
				"${monthData.year}년 ${monthData.month}월", <c:out value="${monthData.count}"/>, "${monthData.count}"
			],
		</c:forEach>
	];
	var options = 
	{
		title: '월별 스캔횟수 (총 스캔수 : <c:out value="${totalCnt}"/>)',
		width: 900, 
		height: 300,
		vAxis: 
		{
			title: '스캔수'
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
	<c:forEach items="${monthData }" var="monthData" varStatus="d">
		<c:set var="data_d">data_d${d.index}</c:set>
		var <c:out value="${data_d}"/> = [['일별', '스캔수', {role : 'annotation'}],
		<c:forEach items="${dailyData }" var="dailyData" varStatus="a">
			<c:if test="${monthData.year == dailyData.year && monthData.month == dailyData.month}">
				[
					"${dailyData.month}/${dailyData.day}", <c:out value="${dailyData.count}"/>, "${dailyData.count}"
				],
			</c:if>
		</c:forEach>
		];

		<c:set var="options_d">options_d${d.index}</c:set>
		var <c:out value="${options_d}"/> = 
		{
		  	title: '일별 스캔횟수 - <c:out value="${monthData.year}"/>년 <c:out value="${monthData.month}"/>월',
		  	width: 900, 
		  	height: 300,
			vAxis: 
			{
				title: '스캔수'
			},
		}
		google.load('visualization', '1.0', {'packages':['corechart']});
		google.setOnLoadCallback(function() {
		<c:set var="chart_d">chart_d${d.index}</c:set>
		var <c:out value="${chart_d}"/> = new google.visualization.ColumnChart(document.querySelector('#dGraph${d.index}'));
		<c:out value="${chart_d}"/>.draw(google.visualization.arrayToDataTable(<c:out value="${data_d}"/>), <c:out value="${options_d}"/>);
		});
	</c:forEach>
	
	// 시간대별
	var data_h = [
		['시간대별', '스캔수', {role : 'annotation'}],
		<c:forEach items="${hourData }" var="hourData" varStatus="h">
			[
				"${hourData.hour} ~ ${hourData.hour + 1}", <c:out value="${hourData.count}"/>, "${hourData.count}"
			],
		</c:forEach>
	];
	var options_h = {
		title : '시간대별 스캔횟수',
		width : 900,
		height : 300,
		vAxis : {
			title : '스캔수'
		}
	}
	google.load('visualization', '1.0', {
		'packages' : [ 'corechart' ]
	});
	google.setOnLoadCallback(function() {
		var chart_h = new google.visualization.ColumnChart(document.querySelector('#hGraph'));
		chart_h.draw(google.visualization.arrayToDataTable(data_h), options_h);
	});

</c:if>
</script>

</head>
<body>
	<fmt:formatDate value="${now }" pattern="yyyy-MM-dd" var="today" />
	<form id="form" method="post">
		<input type="hidden" id="no" name="no" value="${param.no }">
		<input type="hidden" id="category" name="category" value="${param.category }">
		<div class="container subnav subnav-top" style="border-radius: 5px;">
			<div class="subnavcontainer">
				<div class="input-group pull-left" style="width: 450px;">
					<div class="input-group pull-left" style="width: 200px;">
						<input type="text" class="form-control input-sm" id="startDate" name="startDate" value="${param.startDate==null?'2017-06-05':param.startDate}" placeholder="yyyy-MM-dd">
					</div>
					<p class="pull-left margin-lr-10 font-w" style="padding-top: 4px;">~</p>
					<div class="input-group pull-left margin-r-10" style="width: 200px;">
						<input type="text" class="form-control input-sm" id="endDate" name="endDate" value="${param.endDate==null?today:param.endDate}" placeholder="yyyy-MM-dd">
					</div>
				</div>
				<div class="pull-left width-200" style="padding-top: 0px;">
					<div class="input-group input-group-sm" style="margin-left: 10px;">
						<span class="input-group-btn">
							<button class="btn btn-info wd50" type="button" onclick="fn_search();">검색</button>
						</span>
					</div>
				</div>
			</div>
		</div>
	</form>

	<div class="container margin-t-10 cntbox radiall" style="padding: 20px 20px 0 20px;">
		<div class="pull-left center-block" style="width: 100%;">
			<div class="btn-group center-block center-block text-center" style="width: 200px;">
				<button type="button" class="btn btn-primary navbar-btn wd100 active">스캔별</button>
				<button type="button" class="btn btn-default navbar-btn wd100" onclick="fn_local();">지역별</button>
			</div>
		</div>
		<div>
			<div class="pull-left">
				<p class="pull-left text-muted stats-date" style="width: 100%; margin-top: 20px;">
					<span class="label label-primary">기간</span>&nbsp;&nbsp;${param.startDate==null?'2017-06-05':param.startDate} ~ ${param.endDate==null?today:param.endDate}&nbsp;&nbsp; 
					<span class="label label-primary">iqr 번호</span>&nbsp;&nbsp;${param.no}&nbsp;&nbsp;
				</p>
			</div>
			<div class="navbar-btn btn-group-sm pull-right" style="display: ${(totalCnt > 0)?'block':'none'};">
				<button type="button" class="btn btn-success btn-sm" onclick="excelDown();">
					<img src="/image/png/1448007871_excel.png" alt="" width="14px" style=""> &nbsp;엑셀
				</button>
				<button type="button" class="btn btn-danger btn-sm margin-l-10" onclick="printfn();">
					<img src="/image/png/1448007858_pdf.png" alt="" width="14px" style=""> &nbsp;PDF
				</button>
			</div>
		</div>
		<div class="pull-left inbox">
			<c:choose>
				<c:when test="${totalCnt <= 0 || monthData == null }">
					<div style="text-align: center;">해당 QR의 통계자료가 없습니다.</div>
				</c:when>
				<c:otherwise>
					<h4>
						<img src="/image/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">월별 현황
					</h4>
					<div class="pull-left inbox" id="mGraph"></div>
					<h4>
						<img src="/image/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">일별 현황
					</h4>
					<div class="pull-left inbox" id="dGraph">
						<c:forEach items="${monthData }" var="data" varStatus="i">
							<div class="pull-left inbox" id="dGraph${i.index }"></div>
						</c:forEach>
					</div>
					<h4>
						<img src="/image/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">시간대별 현황
					</h4>
					<div class="pull-left inbox" id="hGraph"></div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</html>