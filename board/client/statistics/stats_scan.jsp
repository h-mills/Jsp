<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="project.pc.model.statsModel"%>
<%@page import="project.pc.model.statsConfig"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>

<!DOCTYPE html>
<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.addHeader("Cache-Control", "no-store");
	response.setDateHeader("Expries", 1L);
	int cnt = (Integer) session.getAttribute("count");
	int month_count = 0;
	String namesearch = request.getParameter("namesearch");
	if (namesearch == null)
		namesearch = "0";
	List<statsConfig> statsConfig = (List<statsConfig>) session.getAttribute("statsConfig");
	List<statsModel> monthData = null;
	List<statsModel> dailyData = null;
	List<statsModel> hourData = null;
	List<statsModel> nameData = null;
	List<statsModel> deptRank = null;
	if (namesearch.equals("0")) {
		monthData = (List<statsModel>) session.getAttribute("monthData");
		dailyData = (List<statsModel>) session.getAttribute("dailyData");
		hourData = (List<statsModel>) session.getAttribute("hourData");
		deptRank = (List<statsModel>) session.getAttribute("deptRank");
	} else if (namesearch.equals("1"))
		nameData = (List<statsModel>) session.getAttribute("nameData");

	Calendar cal = new GregorianCalendar(Locale.KOREA);
	SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
	cal.setTime(new Date());
	String date = fm.format(cal.getTime());
	cal.add(Calendar.DAY_OF_YEAR, -1); // 하루를 더한다.
	String yesterday = fm.format(cal.getTime());
	cal.setTime(new Date());
	cal.add(Calendar.DAY_OF_YEAR, -7); 
	String lastweek = fm.format(cal.getTime());
	cal.setTime(new Date());
	cal.add(Calendar.DAY_OF_YEAR, -30); 
	String lastmonth = fm.format(cal.getTime());
%>
<jsp:useBean id="now" class="java.util.Date" />
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<html>
<head>
<link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
<link href="/common/bootstrap-treeselect/css/jquery.bootstrap.treeselect.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-1.12.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<script src="/common/bootstrap-treeselect/js/jquery.bootstrap.treeselect.js"></script>
<title>통계_스캔별</title>
<style>
* {text-decoration: none;}
li {list-style: none;text-decoration: none;float: left;}
@media print {
	html, body {
		width: 210mm;
		min-height: 297mm;
	}
}
.deptSelectBtn{width: 100%;padding-top: 5px;padding-bottom: 5px;padding-left: 10px;padding-right: 10px;font-size: 12px;border-radius: 0;}
</style>
<script type="text/javascript" charset="UTF-8">
	$(document).ready(function() {
		if("${st_dept}" == null || "${st_dept}" == '-2'){
			$('#st_dept').val("-2");
		}else{
			$('#st_dept').val("${st_dept}");
		}
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
	function fn_local() {
		$('#namesearch').val(0);
		$('#st_more').val(1);
		$('#scan_cnt').val(0);
		$('#st_sort').val(1);
		document.getElementById('pageNum').value = 0;
		form.action = "/pc/statistics/stats_local";
		form.submit();
	}
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
		form.action="/pc/statistics/excel";
		form.submit();
	}
	function printfn()
	{
		window.print();
	};
	function fn_search() {
		document.getElementById('pageNum').value = 0;
		
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
		form.action = "/pc/statistics/stats_scan";
		form.submit();
	}
 // 부서별
<c:if test="${fn:length(rankData) > 0}">
var data_R = [
		['부서명', '스캔수', {role : 'annotation'}],
		<c:forEach items="${rankData}" var="rankData">
		['${rankData.dept_name}',<c:out value="${rankData.count}"/>,'${rankData.count}'],
		</c:forEach>
	];

	var options_R = 
	{
		title: '기간 내 스캔횟수',
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
</c:if>
//부서별 - 검색조건 영향
<c:if test="${fn:length(deptRank) > 0 && namesearch == 0 && count > 0 && st_dept >= -1}">
var data_dept = [
		['부서명', '스캔수', {role : 'annotation'}],
		<c:forEach items="${deptRank}" var="deptRank">
		['${deptRank.dept_name}',<c:out value="${deptRank.count}"/>,'${deptRank.count}'],
		</c:forEach>
	];

	var options_dept = 
	{
		title: '기간 내 스캔횟수',
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
</c:if>

//월별
<c:if test="${st_dept !=null && st_dept >= -1 && namesearch != 1 && count > 0}">
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

// 명함별 페이지
function fn_namecard(){
	$('#namesearch').val(1);
	document.getElementById('pageNum').value=0;
	document.getElementById('nameopt').style.display='block';
}
// 요약 페이지
function fn_total(){
	$('#namesearch').val(0);
	$('#st_more').val(1);
	$('#scan_cnt').val(0);
	$('#st_sort').val(1);
	document.getElementById('nameopt').style.display='none';
}
// 더 보기
function fn_viewMore(){
	var xmlhttp;
	var pageNum = document.getElementById('pageNum').value;
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
	xmlhttp.open("GET", "/pc/statistics/stats_scan_more?pageNum="+pageNum+"&st_dept="
			+st_dept+"&startDate="+startDate+"&endDate="+endDate+
			"&company_no="+company_no+"&st_more="+st_more+"&scan_cnt="+scan_cnt
			+"&st_sort="+st_sort, true);
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
			for (var i = 0; i < result.length; i++) {
				htmlcode += "<tr>";
				htmlcode += "<td width=\"5%\">"+result[i].getRownum+"</td>";
				htmlcode += "<td width=\"5%\">"+result[i].getOrderth+"</td>";
				htmlcode += "<td width=\"10%\">"+result[i].getName+"</td>";
				htmlcode += "<td width=\"8%\">"+result[i].getDept_name+"</td>";
				htmlcode += "<td width=\"7%\">"+result[i].getCount+"</td>";
				htmlcode += "<td><button type=\"button\" class=\"btn btn-primary btn-sm wd50\" onclick=\"fn_stats('"+result[i].getName+"','"+result[i].getCategory+"', '"+result[i].getCard_data_no+"', '"+result[i].getOrder_no+"');\">통계</button></td>";
				htmlcode += "</tr>"
			}
			pageNum = parseInt(pageNum) + 1;
			divid.innerHTML += htmlcode;
			document.getElementById('pageNum').value = pageNum;
		}
	};
}
function fn_stats(name, category, carddata_master_no, order_no) {
	window.open("/pc/card/card_stats_scan?order_no="+order_no+"&name="+encodeURI(encodeURIComponent(name))+"&category="+category+"&carddata_master_no="+carddata_master_no,"통계",
			"width=1000,height=700,scrollbars=yes,resizeable=yes,left=200,top=50");
}
</script>

</head>
<body>
	<fmt:formatDate value="${now }" pattern="yyyy-MM-dd" var="today" />
	<form id="form" method="post" action="/pc/statistics/stats_scan">
		<input type="hidden" name="today" id="today" value="${today }">
		<input type="hidden" name="namesearch" id="namesearch" value="0">
		<input type="hidden" id="company_no" name="company_no" value="${sessionScope.COMPANY_NO }"> 
		<input type="hidden" name="deptname" id="deptname" value=""> 
		<input type="hidden" id="pageNum" name="pageNum" size="10" value="1"> 
		<input type="hidden" id="pagingURL" name="pagingURL" size="100" value="0">
		<div class="container margin-t-10 cntbox radiall" style="padding: 20px 20px 0 20px; margin-top: 20px;">
				<div class="btn-group center-block center-block text-center" style="width: 200px;">
					<button type="button" class="btn btn-primary navbar-btn wd100 active">스캔별</button>
					<button type="button" class="btn btn-default navbar-btn wd100" onclick="fn_local();">지역별</button>
				</div>
			<c:if test="${statsConfig!=null }">
		<div class="panel panel-default pull-left inbox stats-s-t" style="">
			<div class="panel-heading">
				<strong>업체 통계 현황(조건 무관)</strong>&nbsp;&nbsp; <small
					class="text-muted"><%=date%>일 스캔수 (${todayCount })</small>
			</div>
			<div class="panel-body" >
				<table class="table">
					<tr>
						<td><span><%=statsConfig.get(0).getCount()%></span></td>
						<td><span><%=statsConfig.get(1).getCount()%></span></td>
						<td><span><%=statsConfig.get(2).getCount()%></span></td>
						<td><span><%=statsConfig.get(3).getCount()%></span></td>
					</tr>
					<tr>
						<td><strong>총 스캔수</strong> <br>~<%=date%>(누적)</td>
						<td><strong>어제 스캔수</strong> <br><%=yesterday%>(1일)</td>
						<td><strong>지난 7일간 스캔수</strong> <br><%=lastweek%>~<%=yesterday%>(7일)
						</td>
						<td><strong>지난 30일간 스캔수</strong> <br><%=lastmonth%>~<%=yesterday%>(30일)
						</td>
					</tr>
				</table>
			</div>
		</div>
		<c:if test="${fn:length(rankData) > 0 }">
			<div class="pull-left inbox">
				<h4>
					<img src="/img/png/glyphicons-42-charts.png" width="18px" alt=""
						style="margin-bottom: 6px; margin-right: 8px;">부서별 스캔순위
				</h4>
				<div class="pull-left inbox" id="cGraph"></div>
			</div>
		</c:if>
	</c:if>
		</div>
		<div class="container subnav" style="border-radius: 5px; margin-top: 20px;">
			<div class="subnavcontainer">
				<div class="font-w pull-left">
					<div class="pull-left margin-r-10" style="width: 150px;">
						<select class="form-control input-sm" multiple="multiple" id="st_dept" name="st_dept">
							<c:forEach items="${deptList }" var="dept">
								<c:set var="parent" value="data-parent=${dept.parent_cd}"></c:set>
					            <option value="${dept.dept_no}" ${dept.level == 0 ? "" : parent} ${dept.isselect == "1" || st_dept == -2 ? "selected":""}>${dept.name }</option>
				            </c:forEach>
				        </select>
						<script type="text/javascript">
							$(document).ready(function() {
								$('#st_dept').treeselect();
								if("${st_dept}" == "-2")
									$(".bts_dropdown").addClass("dropup");
							});
							
							function fn_checkAll() {
								var nodes = $(".bts_dropdown").find(":checkbox");
								for (var i=0; i<nodes.length; i++) {
									if ($(nodes[i]).is(":checked") == false) {
										$(nodes[i]).prop('checked', true);
									}
								}
								$(".deptSelectBtn").children('span').text('전체선택');
							}

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
					<div class="input-group pull-left width-120" style="width: 100px;">
						<input type="text" class="form-control input-sm" id="startDate"
							name="startDate"
							value="${startDate==null?'2017-02-16':startDate}">
					</div>
					<p class="pull-left margin-lr-10 font-w" style="padding-top: 4px;">~</p>
					<div class="input-group pull-left width-120 margin-r-10"
						style="width: 100px;">
						<input type="text" class="form-control input-sm" id="endDate"
							name="endDate" value="${endDate==null?today:endDate}">
					</div>
					<div class="pull-left" style="display: ${namesearch==0?'none':'block'};" id="nameopt">
						<div class="input-group pull-left width-120 margin-r-10" style="width: 100px;">
							<input type="text" id="scan_cnt" name="scan_cnt"	value="${param.scan_cnt==null?0:param.scan_cnt}" autofocus="autofocus" class="form-control input-sm" style="width: 100px;">
						</div>
						<div class="pull-left margin-r-10" style="width: 100px;">
							<select name="st_more" id="st_more" class="form-control input-sm"
								style="width: 100px;">
								<option value="1"
									${param.st_more==null || param.st_more==1?'selected':''}>이상</option>
								<option value="2" ${param.st_more==2?'selected':'' }>이하</option>
							</select>
						</div>
						<div class="pull-left margin-r-10" style="width: 100px;">
							<select name="st_sort" id="st_sort" class="form-control input-sm"
								style="width: 100px;">
								<option value="1"
									${param.st_sort==null || param.st_sort==1?'selected':''}>내림차순</option>
								<option value="2" ${param.st_sort==2?'selected':''}>오름차순</option>
							</select>
						</div>
					</div>
				</div>
				<div class="pull-left width-100">
					<button class="btn btn-info wd50 btn-sm " type="button"
						onclick="fn_search()">검색</button>
				</div>
				<div class="pull-left" style="vertical-align: middle; color: white;">
					<input type="radio" id="statstype" name="statstype" value="0" style="margin-left: 10px; margin-right: 2px;" onclick="fn_total();">요약 
					<input type="radio" id="statstype" name="statstype" value="1" style="margin-left: 10px; margin-right: 2px;" onclick="fn_namecard();">명함별
				</div>
			</div>
		</div>
	</form>
	<div class="container margin-t-10 cntbox radiall" style="padding: 20px 20px 0 20px; display: ${(count >= 0 && st_dept >= -1 )?'block':'none'};">
	<div style="width: 100%; text-align: left;">
		<div class="navbar-btn btn-group-sm pull-right"
			style="width: 100%;">
			<div class="pull-left" style="">
			<p class="pull-left text-muted stats-date"
				style=" margin-top: 20px;">
				<span class="label label-primary">기간</span>&nbsp;&nbsp;${startDate==null?'2017-02-16':startDate}
				~ ${endDate==null?today:endDate}&nbsp;&nbsp; <span
					class="label label-primary">${namesearch==1?'총명함개수':'총스캔횟수' }</span>&nbsp;&nbsp;${count }&nbsp;&nbsp;
			</p>
			</div>
			<div style="text-align: right; display: ${count > 0 ?'block':'none'};">
			<button type="button" class="btn btn-success btn-sm"
				onclick="excelDownload();">
				<img src="/img/png/1448007871_excel.png" alt="" width="14px"
					style="">&nbsp;&nbsp;엑셀
			</button>
			<button type="button" class="btn btn-danger btn-sm"
				onclick="printfn();">
				<img src="/img/png/1448007858_pdf.png" alt="" width="14px"
					style="">&nbsp;&nbsp;PDF
			</button>
			</div>
		</div>
	</div>
	<div class="pull-left inbox">
		<c:choose>
			<c:when
				test="${namesearch == 1 && nameData.size() > 0 && st_dept >= -1}">
				<h4>
					<img src="/img/png/glyphicons-42-charts.png" width="18px" alt=""
						style="margin-bottom: 6px; margin-right: 8px;">명함별 스캔순위
				</h4>
				<div class="pull-left inbox">
					<table class="table text-center table-striped">
						<thead>
							<tr>
								<th width="5%;" class="text-center client-num">순위</th>
								<th width="5%;" class="text-center client-num">차수</th>
								<th width="10%;" class="text-center client-num">이름</th>
								<th width="8%;" class="text-center client-num">부서</th>
								<th width="7%;" class="text-center client-num">스캔수</th>
								<th width="10%;" class="text-center client-num">통계</th>
							</tr>
						</thead>
						<tbody id="firstpane">
							<c:forEach items="${nameData }" var="nameData">
								<tr>
									<td>${nameData.rownum }</td>
									<td>${nameData.orderth }</td>
									<td>${nameData.name}</td>
									<td>${nameData.dept_name }</td>
									<td>${nameData.count }</td>
									<td>
										<button type="button" class="btn btn-primary btn-sm wd50"
											onclick="fn_stats('${nameData.name }','${nameData.category}', '${nameData.card_data_no}', '${nameData.order_no }');">통계</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div id="btndiv" class="button"
					style="width: 100%; text-align: center; margin-bottom: 3%; display: ${nameData.size() >= 15 && count > 15?'block':'none'};">
					<button type="button" class="btn btn-primary wd100 "
						onclick="fn_viewMore();">더 보기</button>
				</div>
			</c:when>
			<c:when test="${count == 0 && namesearch == 1}">
				<div style="text-align: center;">해당 조건내의 통계자료가 없습니다.</div>
			</c:when>
			<c:when test="${st_dept == null || st_dept < -1}">
			</c:when>
			<c:when test="${namesearch ==0 }">
				<%
					if (cnt == 0) {
				%>
				<div style="text-align: center;">해당 조건내의 통계자료가 없습니다.</div>
				<%
					} else {
				%>
				<c:if test="${fn:length(deptRank) > 0 }">
					<div class="pull-left inbox">
						<h4>
						<img src="/img/png/glyphicons-42-charts.png" width="18px" alt=""
						style="margin-bottom: 6px; margin-right: 8px;">부서별 스캔 현황
						</h4>
						<div class="pull-left inbox" id="deptGraph"></div>
					</div>
				</c:if>
				<h4>
					<img src="/img/png/glyphicons-42-charts.png" width="18px" alt=""
						style="margin-bottom: 6px; margin-right: 8px;">월별 현황
				</h4>
				<div class="pull-left inbox" id="mGraph"></div>
				<h4>
					<img src="/img/png/glyphicons-42-charts.png" width="18px" alt=""
						style="margin-bottom: 6px; margin-right: 8px;">일별 현황
				</h4>
				<div class="pull-left inbox" id="dGraph">
					<%
						if (monthData != null) {
										for (int m = 0; m < monthData.size(); m++) {
					%>
					<div class="pull-left inbox" id="dGraph<%=m%>"></div>
					<%
						}
									}
					%>
				</div>
				<h4>
					<img src="/img/png/glyphicons-42-charts.png" width="18px" alt=""
						style="margin-bottom: 6px; margin-right: 8px;">시간대별 현황
				</h4>
				<div class="pull-left inbox" id="hGraph"></div>
				<%
					}
				%>
			</c:when>
		</c:choose>
	</div>
	</div>
</html>