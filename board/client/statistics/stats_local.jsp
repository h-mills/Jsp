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

<link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
<link href="/common/bootstrap-treeselect/css/jquery.bootstrap.treeselect.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-1.12.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<script src="/common/bootstrap-treeselect/js/jquery.bootstrap.treeselect.js"></script>
<title>통계_지역별</title>

<style>
* {text-decoration: none;}
li {list-style: none;text-decoration: none;float: left;}
@media print {html, body {width: 210mm;min-height: 297mm;}}
.controls {margin-top: 10px;border: 1px solid transparent;border-radius: 2px 0 0 2px;box-sizing: border-box;-moz-box-sizing: border-box;height: 32px;outline: none;box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);}
#pac-input {background-color: #fff;font-family: Roboto;font-size: 15px;font-weight: 300;margin-left: 12px;padding: 0 11px 0 13px;text-overflow: ellipsis;width: 300px;}
#pac-input:focus {border-color: #4d90fe;}
.pac-container {font-family: Roboto;}
html, body, #mapid{height: 100%;margin: 0;}
.deptSelectBtn{width: 100%;padding-top: 5px;padding-bottom: 5px;padding-left: 10px;padding-right: 10px;font-size: 12px;border-radius: 0;}
.bts_dropdown  .dropdown-menu {z-index: 2000;}
svg > g:last-child > g:last-child { pointer-events: none }
</style>
<script type="text/javascript">

</script>

<script language="javascript">
$(document).ready(function() {
	
	var value = "${namesearch}";
	if(value == 0){
		$("input:radio[name=statstype]:radio[value='0']").prop("checked",true);
		$("input:radio[name=statstype]:radio[value='1']").prop("checked",false);
	}
	else{
		$("input:radio[name=statstype]:radio[value='0']").prop("checked",false);
		$("input:radio[name=statstype]:radio[value='1']").prop("checked",true);
	}
	$('#namesearch').val(value);
});

function fn_search() {
	if($('#st_dept').val() < -1 ) {
		alert("부서를 선택하세요.");
		return false;
	} else if($('#startDate').val() == "" || $('#endDate').val() == "") {
		alert("날짜를 지정하세요.");
		return false;
	} else if($('#scan_cnt').val() < 0) {
		alert("0 이상의 숫자를 입력해 주세요.");
		return false;
	}
	form.action = "/pc/statistics/stats_local";
	form.submit();
}

// 스캔별 페이지로 이동
function fn_scan() {
	$('#namesearch').val(0);
	$('#st_more').val(1);
	$('#scan_cnt').val(0);
	$('#st_sort').val(1);
	document.getElementById('pageNum').value = 0;
	form.action = "/pc/statistics/stats_scan";
	form.submit();
}

// PDF 다운로드
function fn_printfn() {
	window.print();
}

// 엑셀 다운로드
function excelDownload() {
	var st_deptname = ""
		var nodes = $("[name='st_dept[]']");
		for (var i=0; i<nodes.length; i++) {
			if (nodes[i].checked == true) {
				if (st_deptname == "") {
					st_deptname = $(nodes[i]).closest("label").text();
				} else {
					st_deptname = st_deptname + "," + $(nodes[i]).closest("label").text();
				}
			}
		}
	$("#deptname").val(st_deptname);
	form.action="/pc/statistics/stats_excel_local";
	form.submit();
}

//도시별 페이지
function fn_namecard(){
	$('#namesearch').val(1);
	document.getElementById('pageNum2').value = 0;
	document.getElementById('nameopt').style.display = 'block';
}

// 요약 페이지
function fn_total(){
	$('#namesearch').val(0);
	$('#st_more').val(1);
	$('#scan_cnt').val(0);
	$('#st_sort').val(1);
	document.getElementById('pageNum2').value = 0;
	document.getElementById('nameopt').style.display = 'none';
}

// 지역별 상세현황 더보기
function fn_viewMore(){
	var xmlhttp;
	var pageNum = document.getElementById('pageNum2').value;
	var company_no = document.getElementById('company_no').value;
	var st_dept = new Array();
	var nodes = $("[name='st_dept[]']");
	for (var i=0; i<nodes.length; i++) {
		if (nodes[i].checked == true) {
			st_dept.push(nodes[i].value);
		}
	}
	var startDate = document.getElementById('startDate').value;
	var endDate = document.getElementById('endDate').value;
	if (window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	} else {// code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.open("GET", "/pc/statistics/stats_more?pageNum2="+pageNum+"&st_dept="+st_dept+"&startDate="+startDate+"&endDate="+endDate+"&company_no="+company_no, true);
	xmlhttp.send();
 
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var JSONobj = JSON.parse(xmlhttp.responseText);
			var result = JSONobj.list;
			var pagingValues = JSONobj.pagingValues;
			var addbtn = document.getElementById('btndiv');
			var divid = document.getElementById("firstpane");
			var htmlcode = "";
			if(result.length < 15)
				addbtn.style = "display: none";
			for (var i = 0; i < result.length; i++) {
				var rn = parseInt(pagingValues.totalListCount) - (((parseInt(pagingValues.pageNum)+1)-1) * parseInt(pagingValues.listViewSize) + i);
				htmlcode += "<tr>";
				htmlcode += "<td width=\"5%\">"+rn+"</td>";
				htmlcode += "<td width=\"7%\">"+result[i].getName+"</td>";
				htmlcode += "<td width=\"8%\">"+result[i].getCity+"</td>";
				htmlcode += "<td width=\"15%\">"+result[i].getNation+"</td>";
				htmlcode += "<td width=\"55%\">"+result[i].getAddress+"</td>";
				htmlcode += "<td><button type=\"button\" class=\"btn btn-primary btn-sm wd50\" onclick=\"fn_stats('"+result[i].getName+"','"+result[i].getCategory+"', '"+result[i].getCard_data_no+"', '"+result[i].getOrder_no+"');\">통계</button></td>";
				htmlcode += "</tr>"
			}
			pageNum = parseInt(pageNum) + 1;
			divid.innerHTML += htmlcode;
			document.getElementById('pageNum2').value = pageNum;
		}
	};
}
// 명함별 도시 스캔순위 더보기
function fn_viewMore2(){
	var xmlhttp;
	var pageNum = document.getElementById('pageNum2').value;
	var company_no = document.getElementById('company_no').value;
	var st_dept = new Array();
	var nodes = $("[name='st_dept[]']");
	for (var i=0; i<nodes.length; i++) {
		if (nodes[i].checked == true) {
			st_dept.push(nodes[i].value);
		}
	}
	var startDate = document.getElementById('startDate').value;
	var endDate = document.getElementById('endDate').value;
	var st_more = $("#st_more option:selected").val();
	var scan_cnt = document.getElementById('scan_cnt').value;
	var st_sort = $("#st_sort option:selected").val();
	if (window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	} else {// code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.open("GET", "/pc/statistics/stats_local_more?pageNum2="+pageNum+"&st_dept="
			+st_dept+"&startDate="+startDate+"&endDate="+endDate+
			"&company_no="+company_no+"&st_more="+st_more+"&scan_cnt="+scan_cnt
			+"&st_sort="+st_sort, true);
	xmlhttp.send();
 
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var JSONobj = JSON.parse(xmlhttp.responseText);
			var result = JSONobj.list;
			var addbtn = document.getElementById('btndiv2');
			var divid = document.getElementById("firstpane2");
			var htmlcode = "";
			if(result.length < 15)
				addbtn.style = "display: none";
			for (var i = 0; i < result.length; i++) {
				htmlcode += "<tr>";
				htmlcode += "<td width=\"5%\">"+result[i].getRownum+"</td>";
				htmlcode += "<td width=\"5%\">"+result[i].getOrderth+"</td>";
				htmlcode += "<td width=\"10%\">"+result[i].getName+"</td>";
				htmlcode += "<td width=\"8%\">"+result[i].getDept_name+"</td>";
				htmlcode += "<td width=\"7%\">"+result[i].getCitycount+"</td>";
				htmlcode += "<td><button type=\"button\" class=\"btn btn-primary btn-sm wd50\" onclick=\"fn_stats('"+result[i].getName+"','"+result[i].getCategory+"', '"+result[i].getCard_data_no+"', '"+result[i].getOrder_no+"');\">통계</button></td>";
				htmlcode += "</tr>"
			}
			pageNum = parseInt(pageNum) + 1;
			divid.innerHTML += htmlcode;
			document.getElementById('pageNum2').value = pageNum;
		}
	};
}
function fn_stats(name, category, carddata_master_no, order_no) {
	window.open("/pc/card/card_stats_local?order_no="+order_no+"&name="+encodeURI(encodeURIComponent(name))+"&category="+category+"&carddata_master_no="+carddata_master_no,"통계",
			"width=1000,height=700,scrollbars=yes,resizeable=yes,left=200,top=50");
}

if (<c:out value="${count}"/> > 0 && <c:out value="${st_dept}"/> >= -1 && <c:out value="${namesearch}"/> == 0) {
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
		var <c:out value="${data_a}"/> = [['국가별 상세', '스캔수', {role : 'annotation'}],
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

//부서별
if (<c:out value="${fn:length(deptRank)}"/> > 0) {
	var data_R = [
		['부서명', '지역수', {role : 'annotation'}],
		<c:forEach items="${deptRank}" var="deptRank">
		['${deptRank.dept_name}',<c:out value="${deptRank.count}"/>,'${deptRank.count}'],
		</c:forEach>
	];
	
	var options_R = 
	{
		title: '기간 내 스캔한 지역수',
		width: 900, 
		height: 200,
		vAxis: 
		{
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
}

//부서별 - 검색조건 영향
if (<c:out value="${fn:length(localRank)}"/> > 0 && <c:out value="${st_dept}"/> >= -1 && <c:out value="${namesearch}"/> == 0) {
	var data_dept = [
		['부서명', '지역수', {role : 'annotation'}],
		<c:forEach items="${localRank}" var="localRank">
		['${localRank.dept_name}',<c:out value="${localRank.count}"/>,'${localRank.count}'],
		</c:forEach>
	];
	
	var options_dept = 
	{
		title: '기간 내 스캔한 지역수',
		width: 900, 
		height: 300,
		vAxis: 
		{
		},
		hAxis:
		{
		}
	}
	google.load('visualization', '1.0', {'packages':['corechart']});
	google.setOnLoadCallback(function() {
		var chart = new google.visualization.ColumnChart(document.querySelector('#deptGraph'));
		chart.draw(google.visualization.arrayToDataTable(data_dept), options_dept);
	});
}
</script>
</head>
<body>
	<fmt:formatDate value="${now }" pattern="yyyy-MM-dd" var="today" />
	<form id="form" method="post" action="/pc/statistics/stats_local">
		<input type="hidden" name="today" id="today" value="${today }">
		<input type="hidden" id="pageNum2" value="1">
		<input type="hidden" id="pageNum" name="pageNum" value="0">
		<input type="hidden" id="company_no" value="${sessionScope.COMPANY_NO }">
		<input type="hidden" name="namesearch" id="namesearch" value="0">
		<input type="hidden" name="deptname" id="deptname" value="">
		<div class="container margin-t-10 cntbox radiall" style="padding: 20px 20px 0 20px; margin-top: 20px;">
			<div class="btn-group center-block center-block text-center" style="width: 200px;">
				<button type="button" class="btn btn-default navbar-btn wd100 " onclick="fn_scan();">스캔별</button>
				<button type="button" class="btn btn-primary navbar-btn wd100 active">지역별</button>
			</div>
			<div class="panel panel-default pull-left inbox stats-s-t stats-l-t">
				<div class="panel-heading">
					<strong>업체 통계 요약(조건 무관)</strong>
				</div>
				<div class="panel-body">
					<table class="table">
						<tr>
							<td>
								<span>${countMap.nationcount }</span>
							</td>
							<td>
								<span>${nationRack[0].count==null?0:nationRack[0].count }</span>
								&nbsp;
								<span class="label label-danger">${nationRack[0].nation==null?"-":nationRack[0].nation }</span>
							</td>
							<td>
								<span>${nationRack[1].count==null?0:nationRack[1].count }</span>
								&nbsp;
								<span class="label label-success">${nationRack[1].nation==null?"-":nationRack[1].nation }</span>
							</td>
							<td>
								<span>${nationRack[2].count==null?0:nationRack[2].count }</span>
								&nbsp;
								<span class="label label-warning">${nationRack[2].nation==null?"-":nationRack[2].nation }</span>
							</td>
						</tr>
						<tr>
							<td>
								<strong>총 인식 국가수</strong>
							</td>
							<td>
								<strong>상위 1순위 국가</strong>
							</td>
							<td>
								<strong>상위 2순위 국가</strong>
							</td>
							<td>
								<strong>상위 3순위 국가</strong>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<c:if test="${fn:length(deptRank) > 0 }">
				<div class="pull-left inbox">
					<h4>
						<img src="/img/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">
						부서별 지역 순위
					</h4>
					<div class="pull-left inbox" id="cGraph"></div>
				</div>
			</c:if>
		</div>
		<div class="container subnav" style="margin-top: 20px; border-radius: 5px;">
			<div class="subnavcontainer">
				<div class="font-w pull-left">
					<div class="pull-left margin-r-10" style="width: 150px;">
						<select class="form-control input-sm" multiple="multiple" id="st_dept" name="st_dept">
							<c:forEach items="${deptList }" var="dept">
								<c:set var="parent" value="data-parent=${dept.parent_cd}"></c:set>
					            <option value="${dept.dept_no}" ${dept.level == 0 ? "" : parent} ${dept.isselect=="1"?"selected":""}>${dept.name }</option>
				            </c:forEach>
				        </select>
						<script type="text/javascript">
							$(document).ready(function() {
								$('#st_dept').treeselect();
							});
							
							function fn_checkClick(obj) {
								var childrensNode = $(obj).closest("li").find(":checkbox");

								for (var i=1; i<childrensNode.length; i++) {
									if ($(obj).is(":checked") == true) {
										$(childrensNode[i]).prop('checked', true);
									} else {
										$(childrensNode[i]).prop('checked', false);
									}
								}

								var pNode = $(obj).closest("ul").siblings(".parentNode");
								while (true) {
									if (pNode.length > 0) {
										$(pNode).children(":checkbox").prop('checked', false);
										pNode = $(pNode).closest("ul").siblings(".parentNode");
									} else {
										return;
									}
								}
							}
						</script>
					</div>
				</div>
				<div class="input-group pull-left width-120" style="width: 100px;">
					<input type="text" class="form-control input-sm" id="startDate" name="startDate" value="${startDate==null?'2017-02-16':startDate}">
				</div>
				<p class="pull-left margin-lr-10 font-w" style="padding-top: 4px;">~</p>
				<div class="input-group pull-left width-120 margin-r-10" style="width: 100px;">
					<input type="text" class="form-control input-sm" id="endDate" name="endDate" value="${endDate==null?today:endDate}">
				</div>
			</div>
			<div class="pull-left" style="display: ${namesearch==0?'none':'block'};" id="nameopt">
				<div class="input-group pull-left width-120 margin-r-10" style="width: 100px;">
					<input type="text" id="scan_cnt" name="scan_cnt" value="${param.scan_cnt==null?0:param.scan_cnt}" autofocus="autofocus" class="form-control input-sm" style="width: 100px;">
				</div>
				<div class="pull-left margin-r-10" style="width: 100px;">
					<select name="st_more" id="st_more" class="form-control input-sm" style="width: 100px;">
						<option value="1" ${param.st_more==null || param.st_more==1?'selected':''}>이상</option>
						<option value="2" ${param.st_more==2?'selected':'' }>이하</option>
					</select>
				</div>
				<div class="pull-left margin-r-10" style="width: 100px;">
					<select name="st_sort" id="st_sort" class="form-control input-sm" style="width: 100px;">
						<option value="1" ${param.st_sort==null || param.st_sort==1?'selected':''}>내림차순</option>
						<option value="2" ${param.st_sort==2?'selected':''}>오름차순</option>
					</select>
				</div>
			</div>
			<div class="pull-left width-100">
				<button class="btn btn-info wd50 btn-sm " type="button" onclick="fn_search()">검색</button>
			</div>
			<div class="pull-left" style="vertical-align: middle; color: white;">
				<input type="radio" id="statstype" name="statstype" value="0" style="margin-left: 10px; margin-right: 2px" onclick="fn_total();">요약
				<input type="radio" id="statstype" name="statstype" value="1" style="margin-left: 10px; margin-right: 2px" onclick="fn_namecard();">명함별
			</div>
		</div>
	</form>
	<div class="container margin-t-10 cntbox radiall" style="padding: 20px 20px 0 20px; display: ${(count >= 0 && st_dept >= -1 )?'block':'none'};">
		<div class="navbar-btn btn-group-sm pull-right" style="width: 100%;">
			<div class="pull-left">
				<p class="pull-left text-muted stats-date" style="width: 100%; margin-top: 20px;">
					<span class="label label-primary">기간</span>&nbsp;&nbsp;${startDate==null?'2017-02-16':startDate}~ ${endDate==null?today:endDate}&nbsp;&nbsp; 
					<span class="label label-primary">${namesearch==1?'총명함개수':'총지역개수' }</span>&nbsp;&nbsp;${namesearch==1?count:fn:length(cityData) }&nbsp;&nbsp;
				</p>
			</div>
			<div style="text-align: right; display: ${count > 0 ?'block':'none'};">
				<button type="button" class="btn btn-success btn-sm" onclick="excelDownload();">
					<img src="/img/png/1448007871_excel.png" alt="" width="14px" style="">&nbsp;&nbsp;엑셀
				</button>
				<button type="button" class="btn btn-danger btn-sm margin-l-10" onclick="fn_printfn();">
					<img src="/img/png/1448007858_pdf.png" alt="" width="14px" style="">&nbsp;&nbsp;PDF
				</button>
			</div>
		</div>
		<div class="pull-left inbox">
			<c:choose>
				<c:when test="${namesearch == 1 && nameData.size() > 0 && st_dept >= -1}">
					<h4>
						<img src="/img/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">명함별 지역 스캔순위
					</h4>
					<div class="pull-left inbox">
						<table class="table text-center table-striped">
							<thead>
								<tr>
									<th width="5%;" class="text-center client-num">순위</th>
									<th width="5%;" class="text-center client-num">차수</th>
									<th width="10%;" class="text-center client-num">이름</th>
									<th width="8%;" class="text-center client-num">부서</th>
									<th width="7%;" class="text-center client-num">지역수</th>
									<th width="10%;" class="text-center client-num">통계</th>
								</tr>
							</thead>
							<tbody id="firstpane2">
								<c:forEach items="${nameData }" var="nameData">
									<tr>
										<td>${nameData.rownum }</td>
										<td>${nameData.orderth }</td>
										<td>${nameData.name}</td>
										<td>${nameData.dept_name }</td>
										<td>${nameData.citycount }</td>
										<td>
											<button type="button" class="btn btn-primary btn-sm wd50" onclick="fn_stats('${nameData.name }','${nameData.category}', '${nameData.card_data_no}', '${nameData.order_no }');">통계</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div id="btndiv2" class="button" style="width: 100%; text-align: center; margin-bottom: 3%; display: ${nameData.size() >= 15 && count > 15?'block':'none'};">
						<button type="button" class="btn btn-primary wd100 " onclick="fn_viewMore2();">더 보기</button>
					</div>
				</c:when>
				<c:when test="${count <= 0 && namesearch == 1 }">
					<div style="text-align: center;">해당 조건내의 통계자료가 없습니다.</div>
				</c:when>
				<c:when test="${namesearch == 0 && st_dept >= -1}">
					<c:choose>
						<c:when test="${count=='0'}">
							<div style="text-align: center;">해당 조건내의 통계자료가 없습니다.</div>
						</c:when>
						<c:when test="${namesearch == 0 }">
							<h4>
								<img src="/img/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">지도
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
							<h4>
								<img src="/img/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">부서별 지역 현황
							</h4>
							<div class="pull-left inbox" id="deptGraph"></div>
							<h4>
								<img src="/img/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">국가별 현황
							</h4>
							<div class="pull-left inbox" id="nGraph"></div>
							<h4>
								<img src="/img/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">국가별 상세 현황
							</h4>
							<c:forEach items="${nationData }" var="data" varStatus="i">
								<div class="pull-left inbox" id="cGraph${i.index }"></div>
							</c:forEach>
							<h4>
								<img src="/img/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">상세 현황
							</h4>
							<div class="pull-left inbox">
								<table class="table text-center table-striped">
									<thead>
										<tr>
											<th width="5%;" class="text-center client-num">번호</th>
											<th width="7%;" class="text-center client-num">이름</th>
											<th width="8%;" class="text-center client-num">지역</th>
											<th width="15%;" class="text-center client-num">국가</th>
											<th width="55%;" class="text-center client-num">상세주소</th>
											<th width="10%;" class="text-center client-num">통계</th>
										</tr>
									</thead>
									<tbody id="firstpane">
										<c:forEach items="${addressData }" var="aData" varStatus="status">
											<tr>
												<td>${pagingValues.totalListCount - (((pagingValues.pageNum+1)-1) * pagingValues.listViewSize + status.index)}</td>
												<td>${aData.name }</td>
												<td>${aData.city}</td>
												<td>${aData.nation}</td>
												<td>${aData.address}</td>
												<td>
													<button type="button" class="btn btn-primary btn-sm wd50" onclick="fn_stats('${aData.name }','${aData.category}', '${aData.card_data_no}', '${aData.order_no }');">통계</button>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<div id="btndiv" class="button" style="width: 100%; text-align: center; margin-bottom: 3%;display: ${addressData.size() >= 15 && count > 15?'block':'none'};">
								<button type="button" class="btn btn-primary wd100 " onclick="fn_viewMore();">더 보기</button>
							</div>
						</c:when>
					</c:choose>
				</c:when>
			</c:choose>
		</div>
	</div>
</body>
</html>