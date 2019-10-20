<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="now" class="java.util.Date" />
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>

<html>
<head>
<title>업체관리_주문정보</title>

<style>
*{text-decoration:none;}
li {list-style:none; text-decoration:none; float:left;}
</style>

<script language="javascript">
//페이지
function pageMove(pageNum) {
	$("#pageNum").val(pageNum);
	form.action = "/pc/company/orderlist";
	form.submit();
}

//검색
function fn_Search() {
	pageMove(0);
}

//업체정보페이지
function fn_pageBack(){
	var startDate = $("#parentStartDate").val();
	var endDate = $("#parentEndDate").val();
	var keyword = $("#parentKeyword").val();
	location.href="/pc/company/companylist?startDate="+startDate+"&endDate="+endDate+"&keyword="+keyword;
}

//업체상세정보
function fn_orderDetail(no)
{
	window.open("/pc/company/orderdetail?no="+no,"주문상세정보", 
			"width=1000,height=350,scrollbars=no,resizeable=yes,left=450,top=150");
}
</script>

</head>
<body>
	<fmt:formatDate value="${now }" pattern="yyyy-MM-dd" var="today" />
	<form id="form" method="post">
		<input type="hidden" id="pageNum" name="pageNum" size="10" value="${pagingValues.pageNum }">
		<input type="hidden" id="parentStartDate" name="parentStartDate" value="${parentStartDate}">
		<input type="hidden" id="parentEndDate" name="parentEndDate" value="${parentEndDate}">
		<input type="hidden" id="parentKeyword" name="parentKeyword" value="${parentKeyword}">
		<input type="hidden" id="no" name="no" value="${companyInfo.no }">
		<div class="container subnav" style="margin-top:20px; border-radius: 5px;">
			<div class="subnavcontainer">
				<div class="input-group pull-left" style="width: 400px;">
					<div class="input-group pull-left" style="width: 180px;">
						<input type="text" class="form-control input-sm" id="startDate" name="startDate" value="${startDate==null?'2017-02-16':startDate}" maxlength="10" placeholder="yyyy-MM-dd">
					</div>
					<p class="pull-left margin-lr-10 font-w" style="padding-top: 4px;">~</p>
					<div class="input-group pull-left margin-r-10" style="width: 180px;">
						<input type="text" class="form-control input-sm" id="endDate" name="endDate" value="${endDate==null?today:endDate}" maxlength="10" placeholder="yyyy-MM-dd">
					</div>
				</div>
				<div class="pull-left width-100" style="margin-left: -10px;">
					<button class="btn btn-info btn-sm wd50" type="button" onclick="fn_Search();">검색</button>
				</div>
			</div>
		</div>
	</form>

	<div class="container margin-t-10 cntbox radiall" style="padding: 20px 20px 0 20px;">
		<div class="inbox">
			<div class="clearfix">
				<div class="pull-left" style="position: relative;">
					<div class="input-group input-group-m">
						<p class="pull-left" style="display: block; margin: 20px 0 20px 0; width: 100px;"><strong>${companyInfo.name }</strong>&nbsp;&nbsp;</p>
						<p class="pull-left" style="display: block; margin: 20px 0 20px 0; width: 100px;">회원 수: ${companyInfo.usercount }&nbsp;&nbsp;</p>
						<p class="pull-left" style="display: block; margin: 20px 0 20px 0; width: 100px;">주문 수: ${companyInfo.ordercount }&nbsp;&nbsp;</p>
						<p class="pull-left" style="display: block; margin: 20px 0 20px 0; width: 100px;">명함개수: ${companyInfo.cardcount }&nbsp;&nbsp;</p>
					</div>
				</div>
			</div>
		</div>
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
					<th class="text-center client-num" style="width: 310px;">제목</th>
					<th class="text-center client-num" style="width: 70px;">발주차수</th>
					<th class="text-center client-num" style="width: 110px;">주문자</th>
					<th class="text-center client-num" style="width: 110px;">타입</th>
					<th class="text-center client-num" style="width: 110px;">진행상태</th>
					<th class="text-center client-num" style="width: 110px;">주문날짜</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="list" items="${orderList }">
					<tr>
						<td>${list.rownum }</td>
						<td onClick="fn_orderDetail('${list.no }');">${list.title }</td>
						<td onClick="fn_orderDetail('${list.no }');">${list.orderth }</td>
						<td onClick="fn_orderDetail('${list.no }');">${list.name }</td>
						<td onClick="fn_orderDetail('${list.no }');">${list.category_name }</td>
						<td onClick="fn_orderDetail('${list.no }');">
							<c:if test="${list.status==0 }">주문</c:if>
							<c:if test="${list.status==1 }">접수</c:if>
							<c:if test="${list.status==2 }">제작</c:if>
							<c:if test="${list.status==3 }">배송</c:if>
							<c:if test="${list.status==4 }">완료</c:if>
							<c:if test="${list.status==5 }">취소</c:if>
						</td>
						<td onClick="fn_orderDetail('${list.no }');">
							<fmt:formatDate value="${list.orderdate }" pattern="yyyy-MM-dd" />
						</td>
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
		<div class="input-group" style="width: 100%; margin-bottom: 20px;">
			<button type="button" class="btn btn-primary btn-m wd100 pull-right" onclick="fn_pageBack();">뒤로</button>
		</div>
	</div>
</body>
</html>