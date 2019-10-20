<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="now" class="java.util.Date" />
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>

<html>
<head>
<link rel="stylesheet" href="/common/bootstrap-select-1.12.4/css/bootstrap-select.min.css">
<script src="/common/bootstrap-select-1.12.4/js/bootstrap-select.min.js"></script>
<title>업체관리</title>

<style>
*{text-decoration:none;}
li {list-style:none; text-decoration:none; float:left;}
</style>

<script language="javascript">
//페이지
function pageMove(pageNum) {
	$("#pageNum").val(pageNum);
	form.action = "/pc/company/companylist";
	form.submit();
}

//검색
function fn_Search() {
	$("#pageNum").val(0);
	form.action = "/pc/company/companylist";
	form.submit();
}

//업체상세정보
function fn_companyDetail(no)
{
	window.open("/pc/company/companydetail?no="+no,"회원사정보", 
			"width=1000,height=350,scrollbars=no,resizeable=yes,left=450,top=150");
}

//주문정보페이지
function fn_OrderInfo(no){
	var startDate = $("#startDate").val();
	var endDate = $("#endDate").val();
	var keyword = $("#keyword").val();
	location.href="/pc/company/orderlist?no="+no+"&parentStartDate="+startDate+"&parentEndDate="+endDate+"&parentKeyword="+keyword;
}

//업종정보
function fn_industryInfo(company_no, company_name) {
	$("#industryModal #companyName").text("(" + company_name + ")");
	$("#industryModal").modal();
	
	$.ajax({
		type: 'post',
		url : "/pc/company/industryinfo",
		data : {no:company_no},
        async: true,
		success : function(data)
		{
			var JSONobj = JSON.parse(data);
			var industryInfo = JSONobj.industryInfo;
			var htmlCode = "";

			if (industryInfo != null) {
				if(industryInfo.length==0){
					htmlCode += "<tr>";
					htmlCode += "<td colspan='2'>검색된 리스트가 없습니다.</td>";
					htmlCode += "</tr>";
				}
				else{
					for (var i=0; i<industryInfo.length; i++) {
						htmlCode += "<tr>";
						htmlCode += "<td>" + industryInfo[i].cd + "</td><td>" + industryInfo[i].name + "</td>";
						htmlCode += "</tr>";
					}
				}
			}

			$("#industryInfo").html(htmlCode);
		}
	});
}
// 부서정보
function fn_orgchart(company_no){
	window.open("/pc/company/orginfo?company_no="+company_no,
			"부서정보", "width=1000,height=500,top=0,left=0 scrollbars=yes,resizeable=yes,left=250,top=150");
}
</script>

</head>
<body>
	<fmt:formatDate value="${now }" pattern="yyyy-MM-dd" var="today" />
	<form id="form" method="post">
		<input type="hidden" id="pageNum" name="pageNum" value="0">
		<div class="container subnav" style="margin-top:20px; border-radius: 5px;">
			<div class="subnavcontainer">
				<div class="font-w pull-left" style="margin: 0 auto;">
					<div class="pull-left margin-r-10" style="width: 200px;">
						<select class="form-control selectpicker" name="st_industry" id="st_industry" multiple title="업종 선택" data-selected-text-format="count > 2" data-size="15" data-live-search="true" data-live-search-placeholder="검색" data-actions-box="true">
							<c:forEach var="list" items="${industryList }">
								<c:choose>
									<c:when test="${list.level == '1' }">
										<optgroup label="${list.name }">
									</c:when>
									<c:when test="${list.level == '2' }">
										<option value="${list.cd }" disabled>${list.name }</option>
									</c:when>
									<c:otherwise>
										<option value="${list.cd }" title="${list.name }" ${list.select=="1"?"selected":""}>&nbsp;&nbsp;&nbsp;${list.name }</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="input-group pull-left margin-r-10" style="width: 400px;">
					<div class="input-group pull-left" style="width: 180px;">
						<input type="text" class="form-control input-sm" id="startDate" name="startDate" value="${startDate==null?'2017-02-16':startDate}" maxlength="10" placeholder="yyyy-MM-dd">
					</div>
					<p class="pull-left margin-lr-10 font-w" style="padding-top: 4px;">~</p>
					<div class="input-group pull-left width-120 margin-r-10" style="width: 180px;">
						<input type="text" class="form-control input-sm" id="endDate" name="endDate" value="${endDate==null?today:endDate}" maxlength="10" placeholder="yyyy-MM-dd">
					</div>
				</div>
				<div class="pull-left width-200" style="padding-top: 0px;">
					<div class="input-group input-group-sm">
						<input type="text" class="form-control" style="width: 200px;" id="keyword" name="keyword" value="${keyword}" maxlength="32" placeholder="회사명"> 
						<span class="input-group-btn">
							<button class="btn btn-info wd100" type="button" onclick="fn_Search();">검색</button>
						</span>
					</div>
				</div>
			</div>
		</div>
	</form>

	<div class="container margin-t-10 cntbox radiall" style="padding: 20px 20px 0 20px;">
		<div class="inbox">
			<div class="clearfix margin-b-10">
				<div class="pull-left" style="position: relative; top: -2px;">
					<div class="input-group input-group-sm">
						<h4 class="pull-left" style="display: block; margin: 20px 0 20px 0;">
							<strong>업체관리</strong>
						</h4>
					</div>
				</div>
			</div>
		</div>
		<table class="table table-hover text-center table-striped ">
			<thead>
				<tr>
					<th class="text-center client-n" style="width: 50px;">번호</th>
					<th class="text-center client-num" style="width: 250px;">회사명</th>
					<th class="text-center client-num" style="width: 70px;">명함개수</th>
					<th class="text-center client-num" style="width: 80px;">등록날짜</th>
					<th class="text-center client-num" style="width: 90px;">주문리스트</th>
					<th class="text-center client-num" style="width: 90px;">서비스업종</th>
					<th class="text-center client-num" style="width: 90px;">부서정보</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="list" items="${companyList }" varStatus="status">
					<tr>
						<td>${list.rownum }</td>
						<td onClick="fn_companyDetail('${list.no }');">${list.name }</td>
						<td onClick="fn_companyDetail('${list.no }');">${list.cardcount }</td>
						<td onClick="fn_companyDetail('${list.no }');">
							<fmt:formatDate value="${list.date }" pattern="yyyy-MM-dd" />
						</td>
						<td><button type="button" class="btn btn-primary btn-sm wd100" onclick="fn_OrderInfo('${list.no }');">주문정보</button></td>
						<td><button type="button" class="btn btn-primary btn-sm wd100" onclick="fn_industryInfo('${list.no }', '${list.name }');">업종정보</button></td>
						<td><button type="button" class="btn btn-primary btn-sm wd100" onclick="fn_orgchart('${list.no}');">부서정보</button></td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="7" class="text-center">
						<ul class="pagination">
							<%@ include file="/WEB-INF/jsp/include/paging.jsp" %>
						</ul>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="industryModal" role="dialog">
		<div class="modal-dialog">

			<div class="modal-content">
				<div class="modal-body">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<div class="inbox">
						<div class="clearfix margin-b-10">
							<div class="pull-left" style="position: relative; top: -2px;">
								<div class="input-group input-group-sm">
									<h4 class="pull-left" style="display: block; margin: 20px 0 20px 0;">
										<strong>업종정보</strong><small id="companyName"></small>
									</h4>
								</div>
							</div>
						</div>
					</div>
					<table class="table table-hover text-center table-striped ">
						<thead>
							<tr>
								<th class="text-center client-n" style="width: 50px;">코드</th>
								<th class="text-center client-num" style="width: 300px;">업종명</th>
							</tr>
						</thead>
						<tbody id="industryInfo">
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger btn-m wd100" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>