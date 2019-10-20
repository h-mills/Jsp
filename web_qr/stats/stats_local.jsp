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
#mapid{height: 100%;margin: 0;}
</style>
<link rel="stylesheet" href="/common/leaflet/leaflet.css" />
<script src="/common/leaflet/leaflet-src.js"></script>
<link rel="stylesheet" href="/common/leaflet/screen.css" />
<link rel="stylesheet" href="/common/leaflet/MarkerCluster.css" />
<link rel="stylesheet" href="/common/leaflet/MarkerCluster.Default.css" />
<script src="/common/leaflet/DistanceGrid.js"></script>
<script src="/common/leaflet/MarkerCluster.js"></script>
<script src="/common/leaflet/MarkerCluster.QuickHull.js"></script>
<script src="/common/leaflet/MarkerClusterGroup.js"></script>
<script src="/common/leaflet/MarkerClusterGroup.Refresh.js"></script>
<script src="/common/leaflet/MarkerCluster.Spiderfier.js"></script>
<script src="/common/leaflet/MarkerOpacity.js"></script>
<script type="text/javascript">
//스캔별 페이지로 이동
function fn_scan() {
	form.action = "/stats/stats_scan";
	form.submit();
}

// PDF 다운로드
function fn_printfn() {
	window.print();
}

// 엑셀 다운로드
function excelDown() {
	$("#st_categoryName").val($("#st_category option:selected").text());

	form.action="/stats/localexcel";
	form.submit();
}

function fn_search() {
	if($('#st_category').val() < 0 || $('#st_category').val() > 7) {
		alert("카테고리를 선택하세요.");
		return false;
	} else if($('#startDate').val() == "" || $('#endDate').val() == "") {
		alert("날짜를 지정하세요.");
		return false;
	}

	form.action = "/stats/stats_local";
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
		<input type="hidden" name="st_categoryName" id="st_categoryName" value="">
		<div class="container subnav subnav-top" style="border-radius: 5px;">
			<div class="subnavcontainer">
				<div class="font-w pull-left" style="margin: 0 auto;">
					<div class="pull-left margin-r-10" style="width: 150px;">
						<select class="form-control input-sm" name="st_category" id="st_category">
							<option value="0" ${param.st_category==null||param.st_category=="0"?"selected":""}>전체</option>
							<option value="1" ${param.st_category=="1"?"selected":""}>URL</option>
							<option value="2" ${param.st_category=="2"?"selected":""}>이메일</option>
							<option value="3" ${param.st_category=="3"?"selected":""}>GPS</option>
							<option value="4" ${param.st_category=="4"?"selected":""}>전화번호</option>
							<option value="5" ${param.st_category=="5"?"selected":""}>FAX</option>
							<option value="6" ${param.st_category=="6"?"selected":""}>명함</option>
							<option value="7" ${param.st_category=="7"?"selected":""}>메시지</option>
						</select>
					</div>
				</div>
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
						<input type="text" class="form-control" style="width: 200px;" id="keyword" name="keyword" value="${param.keyword}" placeholder="제목"> 
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
						<span class="label label-primary">총스캔 횟수</span>&nbsp;&nbsp;${countMap==null?'0':countMap.count}&nbsp;&nbsp;
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

			<div class="panel panel-default pull-left inbox stats-s-t stats-l-t">
				<div class="panel-heading">
					<strong>설정 기간 통계 요약</strong>
				</div>
				<div class="panel-body">
					<table class="table">
						<tr>
							<td><span>${countMap.nationcount }</span></td>
							<td><span>${nationRack[0].count==null?0:nationRack[0].count }</span>&nbsp;<span class="label label-danger">${nationRack[0].nation==null?"-":nationRack[0].nation }</span></td>
							<td><span>${nationRack[1].count==null?0:nationRack[1].count }</span>&nbsp;<span class="label label-success">${nationRack[1].nation==null?"-":nationRack[1].nation }</span></td>
							<td><span>${nationRack[2].count==null?0:nationRack[2].count }</span>&nbsp;<span class="label label-warning">${nationRack[2].nation==null?"-":nationRack[2].nation }</span></td>
						</tr>
						<tr>
							<td><strong>총 인식 국가수</strong></td>
							<td><strong>상위 1순위 국가</strong></td>
							<td><strong>상위 2순위 국가</strong></td>
							<td><strong>상위 3순위 국가</strong></td>
						</tr>
					</table>
				</div>
			</div>

			<div class="pull-left inbox">
				<c:choose>
					<c:when test="${countMap.count=='0'}">
						<div style="text-align: center;">해당 조건내의 통계자료가 없습니다.</div>
					</c:when>
					<c:otherwise>
						<h4>
								<img src="/image/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">통계 지도
							</h4>
							<div style="padding: 20px 50px 20px 50px; height: 500px;">
								<div class="pull-left inbox" id="map" style="width: 100%; height: 100%;"></div>
							</div>
							<script>
									var tiles = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
										maxZoom: 18,
										attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
									}),
									latlng = L.latLng(37.566535, 126.97796919999996);

									var map = L.map('map', {
										center: latlng, 
										zoom: 2, 
										minZoom: 2,
										layers: [tiles]
									});
	
									var markers = L.markerClusterGroup();
									var markerList = [];
									function populate() {
										<c:forEach items="${gpsList}" var="data">
											var title = "${data.address}";
											var marker = L.marker(L.latLng(<c:out value="${data.lat}"/>, <c:out value="${data.lng}"/>), { title: title });
											marker.bindPopup(title);
											markers.addLayer(marker);
											markerList.push(marker);
										</c:forEach>
									}
									populate();
	
									map.addLayer(markers);
								</script>
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