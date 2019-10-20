<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="now" class="java.util.Date" />
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<html>
<head>
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

function fn_addrmore() {
	var page = $('#pageNum').val();
	page = (page == null ? 0 : parseInt(page) + 1);
	var category = "${paramMap.category}";
	var carddata_master_no = "${paramMap.carddata_master_no}";
	var startDate = "${paramMap.startDate}";
	var endDate = "${paramMap.endDate}";
	var url = "/pc/card/addrmore";

	$.ajax({
		type: 'post',
		url : url,
		data : {pageNum:page,category:category,carddata_master_no:carddata_master_no,startDate:startDate,endDate:endDate},
        async: true,
		success : function(data) {
			var JSONobj = JSON.parse(data);
			var addrList = JSONobj.addrList;
			var pagingValues = JSONobj.pagingValues;

			if (addrList != null) {
				var htmlcode = "";
				for (var i=0; i<addrList.length; i++) {
					htmlcode += "<tr>";
					htmlcode += "<td>" + addrList[i].rownum + "</td>";
					htmlcode += "<td>" + addrList[i].nation + "</td>";
					htmlcode += "<td>" + addrList[i].city + "</td>";
					htmlcode += "<td>" + addrList[i].address + "</td>";
					htmlcode += "<td>" + addrList[i].date + "</td>";
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

if ("${countMap.count}" > 0) {
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
		var <c:out value="${chart_a}"/> = new google.visualization.PieChart(document.querySelector('#aGraph${n.index}'));
		<c:out value="${chart_a}"/>.draw(google.visualization.arrayToDataTable(<c:out value="${data_a}"/>), <c:out value="${options_a}"/>);
		});
	</c:forEach>
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
				<button type="button" class="btn btn-default navbar-btn wd100" onclick="fn_scan();">스캔별</button>
				<button type="button" class="btn btn-primary navbar-btn wd100 active">지역별</button>
			</div>
		</div>

		<div>
			<div>
				<div class="pull-left">
					<p class="pull-left text-muted stats-date" style="width: 100%; margin-top: 20px;">
						<span class="label label-primary">기간</span>&nbsp;&nbsp;${paramMap.startDate } ~ ${paramMap.endDate }&nbsp;&nbsp;
						<span class="label label-primary">총 지역 개수</span>&nbsp;&nbsp;${fn:length(cityData) }&nbsp;&nbsp;
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
					<c:when test="${countMap.count == '0'}">
						<div style="text-align: center;">해당 조건내의 통계자료가 없습니다.</div>
					</c:when>
					<c:otherwise>
						<h4><img src="/image/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">국가별 현황</h4>
						<div class="pull-left inbox" id="nGraph"></div>
						<h4><img src="/image/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">국가별 상세 현황</h4>
						<c:forEach items="${nationData }" varStatus="i">
							<div class="pull-left inbox" id="aGraph${i.index }"></div>
						</c:forEach>
						<h4><img src="/image/png/glyphicons-42-charts.png" width="18px" alt="" style="margin-bottom: 6px; margin-right: 8px;">상세 현황</h4>
						<div class="pull-left inbox">
							<table class="table text-center table-striped" id="addrList">
								<thead>
									<tr>
										<th class="text-center client-num" style="width: 5%">번호</th>
										<th class="text-center client-num" style="width: 15%">국가</th>
										<th class="text-center client-num" style="width: 15%">지역</th>
										<th class="text-center client-num" style="width: 55%">상세주소</th>
										<th class="text-center client-num" style="width: 10%">검출일자</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach items="${addressData }" var="aData">
									<tr>
										<td>${aData.rownum}</td>
										<td>${aData.nation}</td>
										<td>${aData.city}</td>
										<td>${aData.address}</td>
										<td>${aData.date}</td>
									</tr>
								</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="5">
											<button type="button" class="btn btn-primary wd100" id="pageNum" value="${pagingValues.pageNum}" ${(pagingValues.totalListCount > 0) && (pagingValues.totalPageSize > 1) ? "" : "disabled"} onclick="fn_addrmore();">더 보기</button>
										</td>
									</tr>
								</tfoot>
							</table>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

	</div>
</body>
</html>