<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="now" class="java.util.Date" />
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<html>
<head>
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
<title>통계_지역별</title>

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
	$('#pageNum').val(0);
	form.action = "/pc/card/card_stats_local";
	form.submit();
}

// 스캔별 페이지로 이동
function fn_scan() {

	form.action = "/pc/card/card_stats_scan";
	form.submit();
}

// PDF 다운로드
function fn_printfn() {
	window.print();
}

// 엑셀 다운로드
function excelDownload() {
	form.action="/pc/card/excel_card_stats_local";
	form.submit();
}

<c:if test="${countMap.count > 0 }">
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
		<c:forEach items="${addressData }" var="addressData" varStatus="a">
			<c:if test="${addressData.nation == nationData.nation}">
				[
					"${addressData.city}", <c:out value="${addressData.count}"/>, "${addressData.city}"
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
		var <c:out value="${chart_a}"/> = new google.visualization.PieChart(document.querySelector('#aGraph${n.index}'));
		<c:out value="${chart_a}"/>.draw(google.visualization.arrayToDataTable(<c:out value="${data_a}"/>), <c:out value="${options_a}"/>);
		});
	</c:forEach>

</c:if>

//지역별 상세현황 더보기
function fn_viewMore(){
	var xmlhttp;
	var pageNum = document.getElementById('pageNum').value;
	var startDate = document.getElementById('startDate').value;
	var endDate = document.getElementById('endDate').value;
	var category = document.getElementById('category').value;
	var order_no = document.getElementById('order_no').value;
	var carddata_master_no = document.getElementById('carddata_master_no').value;
	if (window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	} else {// code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.open("GET", "/pc/card/card_stats_local_more?pageNum="+pageNum+"&startDate="+startDate
			+"&endDate="+endDate+"&category="+category+"&order_no="+order_no
			+"&carddata_master_no="+carddata_master_no, true);
	xmlhttp.send();
 
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var JSONobj = JSON.parse(xmlhttp.responseText);
			var result = JSONobj.list;
			var addbtn = document.getElementById('btndiv');
			var divid = document.getElementById("firstpane");
			var htmlcode = "";
			if(result.length < 15)
				addbtn.style = "display: none";
			console.log(result);
			for (var i = 0; i < result.length; i++) {
				htmlcode += "<tr>";
				htmlcode += "<td width=\"5%\">"+result[i].getRownum+"</td>";
				htmlcode += "<td width=\"15%\">"+result[i].getNation+"</td>";
				htmlcode += "<td width=\"8%\">"+result[i].getCity+"</td>";
				htmlcode += "<td width=\"55%\">"+result[i].getAddress+"</td>";
				htmlcode += "<td width=\"7%\">"+result[i].getDate+"</td>";
				htmlcode += "</tr>"
			}
			pageNum = parseInt(pageNum) + 1;
			divid.innerHTML += htmlcode;
			document.getElementById('pageNum').value = pageNum;
		}
	};
}
</script>

</head>
<body>
	<fmt:formatDate value="${now }" pattern="yyyy-MM-dd" var="today" />
	<form id="form" method="post">
		<input type="hidden" name="pageNum" id="pageNum" value="1">
		<input type="hidden" name="category" id="category" value="${paramMap.category }">
		<input type="hidden" name="name" id="name" value="${paramMap.name }">
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
				<button type="button" class="btn btn-default navbar-btn wd100" onclick="fn_scan();">스캔별</button>
				<button type="button" class="btn btn-primary navbar-btn wd100 active">지역별</button>
			</div>
		</div>

		<div>
			<div>
				<div class="pull-left">
					<p class="pull-left text-muted stats-date" style="width: 100%; margin-top: 20px;">
						<span class="label label-primary">기간</span>&nbsp;&nbsp;${paramMap.startDate==null?'2017-02-16':paramMap.startDate} ~ ${paramMap.endDate==null?today:paramMap.endDate}&nbsp;&nbsp;
						<span class="label label-primary">총지역 개수</span>&nbsp;&nbsp;${fn:length(addressData) }&nbsp;&nbsp;
						<span class="label label-primary">이름</span>&nbsp;&nbsp;${paramMap.name }&nbsp;&nbsp;
					</p>
				</div>
				<div class="navbar-btn btn-group-sm pull-right">
					<button type="button" class="btn btn-success btn-sm" onclick="excelDownload();">
						<img src="/img/png/1448007871_excel.png" alt="" width="14px" style="">&nbsp;엑셀
					</button>
					<button type="button" class="btn btn-danger btn-sm margin-l-10" onclick="fn_printfn();">
						<img src="/img/png/1448007858_pdf.png" alt="" width="14px" style="">&nbsp;PDF
					</button>
				</div>
			</div>

			<div class="pull-left inbox">
				<c:choose>
					<c:when test="${countMap.count == '0'}">
						<div style="text-align: center;">해당 조건내의 통계자료가 없습니다.</div>
					</c:when>
					<c:otherwise>
						<h4><img src="/img/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">지도</h4>
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
						<h4><img src="/img/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">국가별 현황</h4>
						<div class="pull-left inbox" id="nGraph"></div>
						<h4><img src="/img/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">국가별 상세 현황</h4>
						<c:forEach items="${nationData }" varStatus="i">
							<div class="pull-left inbox" id="aGraph${i.index }"></div>
						</c:forEach>
						<h4>
								<img src="/img/png/glyphicons-42-charts.png" width="18px"
									alt="" style="margin-bottom: 6px; margin-right: 8px;">상세 현황
							</h4>
						<div class="pull-left inbox">
								<table class="table text-center table-striped">
									<thead>
										<tr>
											<th width="5%;" class="text-center client-num">번호</th>
											<th width="15%;" class="text-center client-num">국가</th>
											<th width="8%;" class="text-center client-num">지역</th>
											<th width="52%;" class="text-center client-num">상세주소</th>
											<th width="10%;" class="text-center client-num">검출일자</th>
										</tr>
									</thead>
									<tbody id="firstpane">
										<c:forEach items="${cityData }" var="cityData">
											<tr>
												<td>${cityData.rownum }</td>
												<td>${cityData.nation}</td>
												<td>${cityData.city}</td>
												<td>${cityData.address }</td>
												<td>${cityData.date}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<div id="btndiv" class="button"
								style="width: 100%; text-align: center; margin-bottom: 3%;display: ${cityData.size() >= 15 && countMap.count > 15?'block':'none'};">
								<button type="button" class="btn btn-primary wd100 "
									onclick="fn_viewMore();">더 보기</button>
							</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

	</div>
</body>
</html>