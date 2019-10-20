<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="now" class="java.util.Date" />
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>

<html>
<head>
<title>통계_스캔별</title>

<style>
* {text-decoration: none;}
li {list-style: none;text-decoration: none;float: left;}
</style>

<script language="javascript">
function fn_search() {
	if($('#startDate').val() == "" || $('#endDate').val() == "") {
		alert("날짜를 지정하세요.");
		return false;
	}

	form.action = "/pc/card/card_stats_scan";
	form.submit();
}

// 지역별 페이지로 이동
function fn_local() {

	form.action = "/pc/card/card_stats_local";
	form.submit();
}

// PDF 다운로드
function fn_printfn() {
	window.print();
}

// 엑셀 다운로드
function excelDownload() {
	form.action="/pc/card/excel_card_stats_scan";
	form.submit();
}

if ("${count}" > 0) {
	//월별
	var data = [
		['월별', '스캔수', {role : 'annotation'}],
		<c:forEach items="${monthData }" var="data" >
			[ 
				"${data.year}년 ${data.month}월", <c:out value="${data.count}"/>, "${data.count}"
			],
		</c:forEach>
	];
	var options = 
	{
		title: '월별 스캔횟수 (총 스캔수 : ${count})',
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
	
	//일별
	<c:forEach items="${monthData }" var="monthData" varStatus="m">
		<c:set var="data_d">data_d${m.index}</c:set>
		var <c:out value="${data_d}"/> = [['일별', '스캔수', {role : 'annotation'}],
		<c:forEach items="${dailyData }" var="dailyData" varStatus="d">
			<c:if test="${dailyData.year == monthData.year && dailyData.month == monthData.month}">
				[
					"${dailyData.month}/${dailyData.day}", <c:out value="${dailyData.count}"/>, "${dailyData.count}"
				],
			</c:if>
		</c:forEach>
		];
	
		<c:set var="options_d">options_d${m.index}</c:set>
		var <c:out value="${options_d}"/> = 
		{
		  	title: "일별 스캔횟수 - ${monthData.year}년 ${monthData.month}월",
		  	width: 900, 
		    height: 300,
		    vAxis: 
		    {
		    	title: ''
		    }
		}
		google.load('visualization', '1.0', {'packages':['corechart']});
		google.setOnLoadCallback(function() {
		<c:set var="chart_d">chart_d${m.index}</c:set>
		var <c:out value="${chart_d}"/> = new google.visualization.ColumnChart(document.querySelector('#dGraph${m.index}'));
		<c:out value="${chart_d}"/>.draw(google.visualization.arrayToDataTable(<c:out value="${data_d}"/>), <c:out value="${options_d}"/>);
		});
	</c:forEach>

	//시간대별
	var data_h = [
		['시간대별', '스캔수', {role : 'annotation'}],
		<c:forEach items="${hourData }" var="hourData" >
			[ 
				"${hourData.hour}~${hourData.hour+1}", <c:out value="${hourData.count}"/>, "${hourData.count}"
			],
		</c:forEach>
	];

	var options_h = 
	{
		title : '시간대별 스캔횟수',
		width : 900,
		height : 300,
		vAxis : {
			title : ''
		}
	}
	google.load('visualization', '1.0', {'packages':['corechart']});
	google.setOnLoadCallback(function() {
		var chart_h = new google.visualization.ColumnChart(document.querySelector('#hGraph'));
		chart_h.draw(google.visualization.arrayToDataTable(data_h), options_h);
	}); 
}
</script>

</head>
<body>
	<fmt:formatDate value="${now }" pattern="yyyy-MM-dd" var="today" />
	<form id="form" method="post">
		<input type="hidden" name="category" id="category" value="${paramMap.category }">
		<input type="hidden" name="carddata_master_no" id="carddata_master_no" value="${paramMap.carddata_master_no }">
		<input type="hidden" name="order_no" id="order_no" value="${paramMap.order_no }">
		<div class="container subnav" style="border-radius: 5px;">
			<div class="input-group pull-left width-120" style="width: 180px; margin-left: 10px;">
				<input type="text" class="form-control input-sm" id="startDate" name="startDate" value="${paramMap.startDate==null?'2017-02-16':paramMap.startDate}" maxlength="10" placeholder="yyyy-MM-dd"> 
			</div>
			<p class="pull-left margin-lr-10 font-w" style="padding-top: 4px;">~</p>
			<div class="input-group pull-left width-120 margin-r-10" style="width: 180px;">
				<input type="text" class="form-control input-sm" id="endDate" name="endDate" value="${paramMap.endDate==null?today:paramMap.endDate}" maxlength="10" placeholder="yyyy-MM-dd"> 
			</div>
			<div class="pull-left width-100">
				<button class="btn btn-info wd50 btn-sm " type="button" onclick="fn_search();">검색</button>
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
			<div>
				<div class="pull-left">
					<p class="pull-left text-muted stats-date" style="width: 100%; margin-top: 20px;">
						<span class="label label-primary">기간</span>&nbsp;&nbsp;${paramMap.startDate==null?'2017-02-16':paramMap.startDate} ~ ${paramMap.endDate==null?today:paramMap.endDate}&nbsp;&nbsp;
						<span class="label label-primary">총 스캔 횟수</span>&nbsp;&nbsp;${count }&nbsp;&nbsp;
					</p>
				</div>
				<div class="navbar-btn btn-group-sm pull-right">
					<button type="button" class="btn btn-success btn-sm" onclick="excelDownload();">
						<img src="/image/png/1448007871_excel.png" alt="" width="14px" style="">&nbsp;엑셀
					</button>
					<button type="button" class="btn btn-danger btn-sm margin-l-10" onclick="fn_printfn();">
						<img src="/image/png/1448007858_pdf.png" alt="" width="14px" style="">&nbsp;PDF
					</button>
				</div>
			</div>

			<div class="pull-left inbox">
				<c:choose>
					<c:when test="${count == '0'}">
						<div style="text-align: center;">해당 조건내의 통계자료가 없습니다.</div>
					</c:when>
					<c:otherwise>
						<h4><img src="/image/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">월별 현황</h4>
						<div class="pull-left inbox" id="mGraph"></div>
						<h4><img src="/image/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">일별 현황</h4>
						<c:forEach items="${monthData }" varStatus="i">
							<div class="pull-left inbox" id="dGraph${i.index }"></div>
						</c:forEach>
						<h4><img src="/image/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">시간대별 현황</h4>
						<div class="pull-left inbox" id="hGraph"></div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

	</div>
</body>
</html>