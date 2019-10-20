<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="now" class="java.util.Date" />
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>

<html>
<head>
<link rel="stylesheet" href="/common/leaflet/leaflet.css" />
<script src="/common/leaflet/leaflet-src.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
<style type="text/css">
svg > g:last-child > g:last-child { pointer-events: none }
</style>
<script language="javascript">
$(document).ready(function() {
	fn_companylist();
});

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

	form.action = "/pc/statistics/stats_local";
	form.submit();
}

// 스캔별 페이지로 이동
function fn_scan() {
	form.action = "/pc/statistics/stats_scan";
	form.submit();
}

// PDF 다운로드
function fn_printfn() {
	window.print();
}

// 엑셀 다운로드
function excelDownload() {
	$("#st_companyName").val($("#st_company option:selected").text());
	$("#st_orderName").val($("#st_order option:selected").text());

	form.action="/pc/statistics/stats_excel_local";
	form.submit();
}

function fn_companylist() {
	var url = "/pc/statistics/companylist"
	$.ajax({
		type: 'post',
		url : url,
		data : {},
        async: true,
		success : function(data) {

			var JSONobj = JSON.parse(data);
			var companylist = JSONobj.companyList;
    		$("#st_company").find("option").remove();
    		$("#st_company").append("<option value='-1'>업체 선택</option>");
   			$("#st_company").append("<option value='0'>전체</option>");

       		for(var i=0; i<companylist.length; i++){
       			var cd = companylist[i].no;
       			var name = companylist[i].name;
   				$("#st_company").append("<option value="+cd+">"+name+"</option>");
    		}
       		if ("${st_order}" != "") {
           		$("#st_company option[value='"+"${st_company}"+"']").attr("selected", "selected");
       		}
       		fn_orderlist();
		}
	});
}

function fn_orderlist() {
	var company_no = $('#st_company').val();
	var url = "/pc/statistics/orderlist"
	$.ajax({
		type: 'post',
		url : url,
		data : {company_no:company_no},
        async: true,
		success : function(data) {

			var JSONobj = JSON.parse(data);
			var orderList = JSONobj.orderList;
			var result = JSONobj.result;

			$("#st_order").find("option").remove();
   			$("#st_order").append("<option value='-1'>발주차수 선택</option>");
			$("#st_order").append("<option value='0'>전체</option>");

			if (result == "1") {
	   			for(var i=0; i<orderList.length; i++){
	   				var no = orderList[i].no;
	   				var title = orderList[i].title;
					$("#st_order").append("<option value="+no+">"+title+"</option>");
	   			}
	   			if ("${st_order}" != "") {
	           		$("#st_order option[value='"+"${st_order}"+"']").attr("selected", "selected");
	       		}
			}
   			if(company_no == '-1' || result != '1'){
   				$("#st_order").find("option").remove();
   				$("#st_order").append("<option value='-1'>발주차수 선택</option>");
   			}
		}
	});
}

function fn_addrmore() {
	var page = $('#pageNum').val();
	page = (page == null ? 0 : parseInt(page) + 1);
	var st_category = "${st_category}";
	var st_company = "${st_company}";
	var st_order = "${st_order}";
	var startDate = "${startDate}";
	var endDate = "${endDate}";
	var url = "/pc/statistics/addrmore";

	$.ajax({
		type: 'post',
		url : url,
		data : {pageNum:page,st_category:st_category,st_company:st_company,st_order:st_order,startDate:startDate,endDate:endDate},
        async: true,
		success : function(data) {
			var JSONobj = JSON.parse(data);
			var addrList = JSONobj.addrList;
			var pagingValues = JSONobj.pagingValues;
			console.log(pagingValues);

			if (addrList != null) {
				var htmlcode = "";
				for (var i=0; i<addrList.length; i++) {
					var rn = parseInt(pagingValues.totalListCount) - (((parseInt(pagingValues.pageNum)+1)-1) * parseInt(pagingValues.listViewSize) + i);
					htmlcode += "<tr>";
					htmlcode += "<td>" + rn + "</td>";
					htmlcode += "<td>" + addrList[i].name + "</td>";
					htmlcode += "<td>" + addrList[i].nation + "</td>";
					htmlcode += "<td>" + addrList[i].city + "</td>";
					htmlcode += "<td>" + addrList[i].address + "</td>";
					htmlcode += "<td>";
					htmlcode += "<button type=\"button\" class=\"btn btn-primary btn-sm wd50\" onclick=\"fn_stats('" + addrList[i].category + "', '" + addrList[i].card_data_no + "', '" + addrList[i].order_no + "');\">통계</button>";
					htmlcode += "</td>";
					htmlcode += "</tr>";
				}
			}

			$("#pageNum").val(pagingValues.pageNum);
			$("#addrList").append(htmlcode);
			if (parseInt(pagingValues.pageNum) + 1 >= pagingValues.totalPageSize) {
				$("#pageNum").attr("disabled", "disabled");
			}
		}
	});
}

function fn_stats(category, carddata_master_no, order_no) {
	window.open("/pc/card/card_stats_scan?order_no="+order_no+"&category="+category+"&carddata_master_no="+carddata_master_no,"통계",
			"width=1000,height=700,scrollbars=yes,resizeable=yes,left=200,top=50");
}

if (<c:out value="${countMap.count}"/> > 0 && <c:out value="${st_company}"/> >= 0) {
	var data_r = [
		['회사별 도시 통계', '지역수', {role : 'annotation'}],
		<c:forEach items="${companyCityRank }" var="data" varStatus="i">
			[
				"${data.name}", <c:out value="${data.count}"/>, "${data.count}"
			],
		</c:forEach>
	];
	var options_r = 
	{
		title: '회사별 지역 통계',
		width: 900, 
		height: 300,
		vAxis: 
		{
			title: ''
		},
		hAxis:
		{
			fontSize: '8pt'
		}
	}
	google.load('visualization', '1.0', {'packages':['corechart']});
	google.setOnLoadCallback(function() {
	var chart_r = new google.visualization.ColumnChart(document.querySelector('#rGraph'));
	chart_r.draw(google.visualization.arrayToDataTable(data_r), options_r);
	});

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
			title: ''
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
}
</script>

</head>
<body>
	<fmt:formatDate value="${now }" pattern="yyyy-MM-dd" var="today" />

	<div class="container cntbox radiall" style="padding: 20px 20px 0 20px; margin-top: 20px;">
		<div class="pull-left center-block" style="width: 100%;">
			<div class="btn-group center-block center-block text-center" style="width: 200px;">
				<button type="button" class="btn btn-default navbar-btn wd100" onclick="fn_scan();">스캔별</button>
				<button type="button" class="btn btn-primary navbar-btn wd100 active">지역별</button>
			</div>
		</div>

		<div class="panel panel-default pull-left inbox stats-s-t stats-l-t">
			<div class="panel-heading">
				<strong>최근 통계 현황 요약(조건 무관)</strong>
			</div>
			<div class="panel-body">
				<table class="table">
					<tr>
						<td><span>${countMap.nationcount}</span></td>
						<td><span>${nationRank[0].count==null?0:nationRank[0].count }</span>&nbsp;<span class="label label-danger">${nationRank[0].nation==null?"-":nationRank[0].nation }</span></td>
						<td><span>${nationRank[1].count==null?0:nationRank[1].count }</span>&nbsp;<span class="label label-success">${nationRank[1].nation==null?"-":nationRank[1].nation }</span></td>
						<td><span>${nationRank[2].count==null?0:nationRank[2].count }</span>&nbsp;<span class="label label-warning">${nationRank[2].nation==null?"-":nationRank[2].nation }</span></td>
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
	</div>

	<form id="form" method="post">
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
					<select class="form-control input-sm" name="st_company" id="st_company" onchange="fn_orderlist('clear');">
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
			<div>
				<div class="pull-left">
					<p class="pull-left text-muted stats-date" style="width: 100%; margin-top: 20px;">
						<span class="label label-primary">기간</span>&nbsp;&nbsp;${startDate } ~ ${endDate }&nbsp;&nbsp;
						<span class="label label-primary">총 지역 개수</span>&nbsp;&nbsp;${st_company<0 || st_company==null ? "0" : fn:length(cityData) }&nbsp;&nbsp;
					</p>
				</div>
				<div class="navbar-btn btn-group-sm pull-right" style="display: ${(countMap.count > 0 && st_company >= 0)?'block':'none'};">
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
					<c:when test="${st_company<0 || st_company==null }">
						<div style="text-align: center;">해당 조건내의 통계자료가 없습니다.</div>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${countMap.count=='0'}">
								<div style="text-align: center;">해당 조건내의 통계자료가 없습니다.</div>
							</c:when>
							<c:otherwise>
								<h4><img src="/image/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">상세 지도</h4>
								<div style="padding: 10px 50px 30px 50px; height: 500px;"><div class="pull-left inbox" id="map" style="width: 100%; height: 100%;"></div></div>
								<script>
									var tiles = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
										maxZoom: 18,
										attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
									}),
									latlng = L.latLng(37.566535, 126.97796919999996);

									var map = L.map('map', {
										center: latlng, 
										zoom: 5, 
										minZoom: 2,
										layers: [tiles]
									});
	
									var markers = L.markerClusterGroup();
									var markerList = [];
	
									function populate() {
										<c:forEach items="${mapData}" var="data">
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
								<h4><img src="/image/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">회사별 지역 순위 (상위10개)</h4>
								<div class="pull-left inbox" id="rGraph"></div>
								<h4><img src="/image/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">국가별 현황</h4>
								<div class="pull-left inbox" id="nGraph"></div>
								<h4><img src="/image/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">국가별 상세 현황</h4>
								<c:forEach items="${nationData }" var="data" varStatus="i">
									<div class="pull-left inbox" id="cGraph${i.index }"></div>
								</c:forEach>
								<h4><img src="/image/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">상세 현황</h4>
								<div class="pull-left inbox">
									<table class="table text-center table-striped" id="addrList">
										<thead>
											<tr>
												<th class="text-center client-num" style="width: 5%">번호</th>
												<th class="text-center client-num" style="width: 8%">이름</th>
												<th class="text-center client-num" style="width: 13%">국가</th>
												<th class="text-center client-num" style="width: 14%">지역</th>
												<th class="text-center client-num" style="width: 55%">상세주소</th>
												<th class="text-center client-num" style="width: 5%">통계</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${addressData }" var="aData" varStatus="status">
											<tr>
												<td>${pagingValues.totalListCount - (((pagingValues.pageNum+1)-1) * pagingValues.listViewSize + status.index)}</td>
												<td>${aData.name}</td>
												<td>${aData.nation}</td>
												<td>${aData.city}</td>
												<td>${aData.address}</td>
												<td>
													<button type="button" class="btn btn-primary btn-sm wd50" onclick="fn_stats('${aData.category}', '${aData.card_data_no}', '${aData.order_no }');">통계</button>
												</td>
											</tr>
										</c:forEach>
										</tbody>
										<tfoot>
											<tr>
												<td colspan="6">
													<button type="button" class="btn btn-primary wd100" id="pageNum" value="${pagingValues.pageNum}" ${(pagingValues.totalListCount > 0) && (pagingValues.totalPageSize > 1) ? "" : "disabled"} onclick="fn_addrmore();">더 보기</button>
												</td>
											</tr>
										</tfoot>
									</table>
								</div>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</body>
</html>