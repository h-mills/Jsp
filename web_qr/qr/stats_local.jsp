<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<jsp:useBean id="now" class="java.util.Date" />
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>

<html>
<head>
<title>통계_지역별</title>
<style>
* {text-decoration: none;}
li {list-style: none;text-decoration: none;float: left;}
@media print {html, body {width: 210mm;min-height: 297mm;}}
</style>

<script type="text/javascript">
//스캔별 페이지로 이동
function fn_scan() {
	form.action = "/stats/qr_stats_scan";
	form.submit();
}

// PDF 다운로드
function fn_printfn() {
	window.print();
}

// 엑셀 다운로드
function excelDown() {
	form.action="/stats/qr_localexcel";
	form.submit();
}

function fn_search() {
	if($('#startDate').val() == "" || $('#endDate').val() == "") {
		alert("날짜를 지정하세요.");
		return false;
	}

	form.action = "/stats/qr_stats_local";
	form.submit();
}

<c:if test="${countMap.count > 0}">
	var data_n = [
		['국가별 스캔 통계', '스캔수', {role : 'annotation'}],
		<c:forEach items="${nationData }" var="data" varStatus="i">
			[
				"${data.nation}", <c:out value="${data.count}"/>, "${data.count}"
			],
		</c:forEach>
	];
	var options_n = 
	{
		title: '국가별 스캔 통계',
		width: 900, 
		height: 300,
		vAxis: 
		{
			title: '스캔수'
		},
		hAxis:
		{
			fontSize: '8pt'
		}
	}
	google.load('visualization', '1.0', {'packages':['corechart']});
	google.setOnLoadCallback(function() {
	var chart_n = new google.visualization.ColumnChart(document.querySelector('#nGraph'));
	chart_n.draw(google.visualization.arrayToDataTable(data_n), options_n);
	});

	<c:forEach items="${nationData }" var="nationData" varStatus="n">
		<c:set var="data_a">data_a${n.index}</c:set>
		var <c:out value="${data_a}"/> = [['국가별 상세', '스캔수', {role : 'annotation'}],
		<c:forEach items="${cityData }" var="cityData" varStatus="a">
			<c:if test="${cityData.nation == nationData.nation}">
				[
					"${cityData.city}", <c:out value="${cityData.count}"/>, "${cityData.city}"
				],
			</c:if>
		</c:forEach>
		];

		<c:set var="options_a">options_a${n.index}</c:set>
		var <c:out value="${options_a}"/> = 
		{
		  	title: "${nationData.nation }",
		  	width: 900, 
		  	height: 300
		}
		google.load('visualization', '1.0', {'packages':['corechart']});
		google.setOnLoadCallback(function() {
		<c:set var="chart_a">chart_a${n.index}</c:set>
		var <c:out value="${chart_a}"/> = new google.visualization.PieChart(document.querySelector('#cGraph${n.index}'));
		<c:out value="${chart_a}"/>.draw(google.visualization.arrayToDataTable(<c:out value="${data_a}"/>), <c:out value="${options_a}"/>);
		});
	</c:forEach>

</c:if>
</script>

</head>
<body>
	<fmt:formatDate value="${now }" pattern="yyyy-MM-dd" var="today" />
	<form id="form" method="post">
		<input type="hidden" name="no" id="no" value="${param.no }">
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
				<button type="button" class="btn btn-default navbar-btn wd100" onclick="fn_scan();">스캔별</button>
				<button type="button" class="btn btn-primary navbar-btn wd100 active">지역별</button>
			</div>
		</div>

		<div>
			<div>
				<div class="pull-left">
					<p class="pull-left text-muted stats-date" style="width: 100%; margin-top: 20px;">
						<span class="label label-primary">기간</span>&nbsp;&nbsp;${param.startDate==null?'2017-06-05':param.startDate} ~ ${param.endDate==null?today:param.endDate}&nbsp;&nbsp;
						<span class="label label-primary">iqr 번호</span>&nbsp;&nbsp;${param.no}&nbsp;&nbsp;
					</p>
				</div>
				<div class="navbar-btn btn-group-sm pull-right" style="display: ${(countMap.count > 0 && countMap != null)?'block':'none'};">
					<button type="button" class="btn btn-success btn-sm" onclick="excelDown();">
						<img src="/image/png/1448007871_excel.png" alt="" width="14px" style="">&nbsp;엑셀
					</button>
					<button type="button" class="btn btn-danger btn-sm margin-l-10" onclick="fn_printfn();">
						<img src="/image/png/1448007858_pdf.png" alt="" width="14px" style="">&nbsp;PDF
					</button>
				</div>
			</div>

			<div class="pull-left inbox">
				<c:choose>
					<c:when test="${countMap.count=='0'}">
						<div style="text-align: center;">해당 조건내의 통계자료가 없습니다.</div>
					</c:when>
					<c:otherwise>
						<h4><img src="/image/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">국가별 현황</h4>
						<div class="pull-left inbox" id="nGraph"></div>
						<h4><img src="/image/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">국가별 상세 현황</h4>
						<c:forEach items="${nationData }" var="data" varStatus="i">
							<div class="pull-left inbox" id="cGraph${i.index }"></div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

	</div>
</body>
</html>