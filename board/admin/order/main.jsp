<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<jsp:useBean id="now" class="java.util.Date" />
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주문관리</title>
<style>
* {text-decoration: none;}
li {list-style: none;text-decoration: none;float: left;}
</style>
</head>
<script type="text/javascript"> 
function optfn(i) {
	fn_Search(i);
}
function pageMove(pageNum) {
	document.getElementById('pageNum').value = pageNum;
	var optNum = $('#status').val();
	optfrm.action = "/pc/order/main?optNum="+optNum;
	optfrm.submit();
}
function fn_Search(i) {
	var pageNum = $("#pageNum").val();
	var searchType = $('#searchType').val();
	optfrm.action = "/pc/order/main?optNum="+i+"&pageNum="+pageNum+"&searchType="+searchType;
	optfrm.submit();
}
function fn_detail(no){
	var pageNum = $("#pageNum").val();
	var startDate = $("#startDate").val();
	var endDate = $("#endDate").val();
	var keyword = $("#keyword").val();
	var searchType = $('#searchType').val();
	var optNum = $('#status').val();
	window.open("/pc/order/detail?no="+no+"&searchType="+searchType+"&optNum="
			+optNum+"&startDate="+startDate+
			"&endDate="+endDate+"&keyword="+keyword+"&pageNum="+pageNum,
			"주문상세보기",
	"width=1000,height=700,scrollbars=yes,resizeable=yes,left=250,top=50");
}
</script>
<body>
	<fmt:formatDate value="${now }" pattern="yyyy-MM-dd" var="today" />
	<form method="post" id="optfrm">
		<input type="hidden" id="pageNum" name="pageNum" size="10" value="0">
		<input type="hidden" id="pagingURL" name="pagingURL" size="100" value="0"> 
		<input type="hidden" id="status" name="status" value="${status }">
		<div class="container subnav subnav-top" style="margin-top:20px;">
			<div class="subnavcontainer">
				<div class="font-w pull-left" style="margin: 0 auto;">
					<div class="pull-left margin-r-10" style="width: 150px;">
						<select class="form-control input-sm" id="searchType" name="searchType">
							<option value="1" ${searchType==1?"selected":""}>주문일로 조회</option>
							<option value="2" ${searchType==2?"selected":""}>납품일로 조회</option>
						</select>
					</div>
				</div>
				<div class="input-group pull-left" style="width: 340px;">
					<div class="input-group pull-left" style="width: 150px;">
						<input type="text" class="form-control input-sm" id="startDate" name="startDate" value="${startDate==null?'2017-02-16':startDate}" placeholder="yyyy-MM-dd">
					</div>
					<p class="pull-left margin-lr-10 font-w" style="padding-top: 4px;">~</p>
					<div class="input-group pull-left margin-r-10" style="width: 150px;">
						<input type="text" class="form-control input-sm" id="endDate" name="endDate" value="${endDate==null?today:endDate}" placeholder="yyyy-MM-dd">
					</div>
				</div>
				<div class="pull-left width-200" style="padding-top: 0px;">
					<div class="input-group input-group-sm" style="margin-left: 10px;">
						<input type="text" class="form-control" style="width: 200px;" id="keyword" name="keyword" value="${keyword}" placeholder="회사명"> 
						<span class="input-group-btn">
							<button class="btn btn-info wd50" type="button" onclick="fn_Search(${status});">검색</button>
						</span>
					</div>
				</div>
			</div>
		</div>

		<div class="container subnav subnav-bottom">
			<div class="subnavcontainer">
				<div class="font-w pull-left" style="margin: 0 auto;">
					<div class="pull-left">
						<label class="radio-inline"> 
							<input type="radio" onclick="optfn(6)" name="inlineRadioOptions" id="inlineRadio1" ${status!=6?"":"checked"}>모두
						</label>
						<c:forEach items="${option }" var="option" varStatus="i">
							<label class="radio-inline"> 
								<input type="radio" onclick="optfn(${i.index})" name="${i }" ${status==i.index?"checked":""}>${option }
							</label>
						</c:forEach>
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
							<strong>주문관리</strong>
						</h4>
					</div>
				</div>
			</div>
		</div>
		<table class="table table-hover text-center table-striped ">
			<thead>
				<tr>
					<th class="text-center client-num" style="width: 50px;">번호</th>
					<th class="text-center client-num" style="width: 80px;">타입</th>
					<th class="text-center client-num" style="width: 100px;">회원ID</th>
					<th class="text-center client-num" style="width: 200px;">회사명</th>
					<th class="text-center client-num" style="width: 250px;">제목</th>
					<th class="text-center client-num" style="width: 50px;">차수</th>
					<th class="text-center client-num" style="width: 100px;">주문날짜</th>
					<th class="text-center client-num" style="width: 80px;">진행상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list }" var="list" varStatus="i">
					<tr>
						<td align="center" onclick="fn_detail(${list.no})">${list.rownum }</td>
						<td align="center" onclick="fn_detail(${list.no})">${list.category_name }</td>
						<td align="center" onclick="fn_detail(${list.no})">${list.id }</td>
						<td align="center" onclick="fn_detail(${list.no})">
							<c:if test="${list.isclientnew == 1 }">
								<img src="/image/png/new_icon.png" style="width: 25px; margin-right: 10px;" alt="">
							</c:if>${list.name }
						</td>
						<td align="center" onclick="fn_detail(${list.no})">${list.title }</td>
						<td align="center" onclick="fn_detail(${list.no})">${list.orderth }</td>
						<td align="center" onclick="fn_detail(${list.no})">
							<fmt:formatDate value="${list.orderdate }" pattern="yyyy-MM-dd" />
						</td>
						<c:if test="${list.status==0 }">
							<td align="center" onclick="fn_detail(${list.no})">주문</td>
						</c:if>
						<c:if test="${list.status==1 }">
							<td align="center" onclick="fn_detail(${list.no})">접수</td>
						</c:if>
						<c:if test="${list.status==2 }">
							<td align="center" onclick="fn_detail(${list.no})">제작중</td>
						</c:if>
						<c:if test="${list.status==3 }">
							<td align="center" onclick="fn_detail(${list.no})">배송중</td>
						</c:if>
						<c:if test="${list.status==4 }">
							<td align="center" onclick="fn_detail(${list.no})">완료</td>
						</c:if>
						<c:if test="${list.status==5 }">
							<td align="center" onclick="fn_detail(${list.no})">취소</td>
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="9" class="text-center">
						<ul class="pagination">
							<%@ include file="/WEB-INF/jsp/include/paging.jsp"%>
						</ul>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
</body>
</html>