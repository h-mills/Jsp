<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="now" class="java.util.Date" />
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주문관리_수정</title>
<link href="/common/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/common/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/common/css/pop.css" rel="stylesheet">
<style>
* {text-decoration: none;}
</style>
</head>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
function golist(){
	var pageNum = $("#pageNum").val();
	var startDate = $("#startDate").val();
	var endDate = $("#endDate").val();
	var keyword = $("#keyword").val();
	var searchType = $('#searchType').val();
	var optNum = $('#optNum').val();
	opener.location.href = "/pc/order/main?searchType="+searchType+"&optNum="
	+optNum+"&startDate="+startDate+
	"&endDate="+endDate+"&keyword="+keyword+"&pageNum="+pageNum;
	window.close();
}
function fn_mod(no){
	frm.action="/pc/order/mod?no="+no;
	frm.submit();
}
function fn_cancel(no){
	if (confirm('주문을 취소 하시겠습니까?') != true)
		return;
	frm.action="/pc/order/cancel?no="+no;
	frm.submit();
}
function fn_reply(orderno){
	if (confirm('등록하시겠습니까?') != true)
		return;
	var reply = $('#reply').val();
	if(reply.length <= 0){
		alert("댓글을 입력해주세요");
		return;
	}
	if(reply.length >= 100){
		alert("100자 이내로 입력해주세요");
		return;
	}
	frm.action="/pc/order/reply?orderno="+orderno;
	frm.submit();
}
function fn_close() {
	window.close();
}
function fn_xlsdown(){
	frm.action="/pc/order/download";
	frm.submit();
}
function fn_dsfiledown(dsfilepath) {
	frm.action="/pc/order/dsfiledown?path="+dsfilepath.trim();
	frm.submit();
}
</script>
<body>
	<form name="frm" method="post">
		<input type="hidden" id="order_no" name="order_no" value="${orderModel.no }">
		<input type="hidden" id="pageNum" name="pageNum" value="${pageNum }">
		<input type="hidden" id="searchType" name="searchType" value="${searchType }">
		<input type="hidden" id="startDate" name="startDate" value="${startDate }">
		<input type="hidden" id="endDate" name="endDate" value="${endDate }">
		<input type="hidden" id="optNum" name="optNum" value="${optNum }">
		<input type="hidden" id="keyword" name="keyword" value="${keyword }">
		<div class="container-fluid cntbox radiall width:100%;">
			<div class="inbox">
				<div class="clearfix margin-b-10 margin-t-10">
					<div class="pull-left" style="position: relative; top: -2px;">
						<div class="input-group input-group-m">
							<h4 class="pull-left">
								<strong>주문관리</strong>
							</h4>
						</div>
					</div>
				</div>
			</div>
			<div class="clearfix margin-t-10">
				<div class="clearfix">
					<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 105px;">${orderModel.orderth }차 발주</span>
						<input type="text" class="form-control" value="${orderModel.title }" disabled>
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 105px;">업체이름</span>
						<input type="text" class="form-control" value="${orderModel.name }" disabled>
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 105px;">주문자</span>
						<input type="text" class="form-control" value="${orderModel.id }" disabled>
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 105px;">연락처</span>
						<input type="text" class="form-control" value="${orderModel.tel }" disabled>
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 105px;">메일주소</span>
						<input type="text" class="form-control" value="${orderModel.email }" disabled>
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 105px;">배송주소</span>
						<input type="text" class="form-control" value="${orderModel.address }" disabled>
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 105px;">배송희망날짜</span>
						<input type="text" class="form-control" value="${orderModel.recvdate }" disabled>
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 105px;">진행상태</span>
						<c:if test="${orderModel.status==0 }">
							<input type="text" class="form-control" value="주문" disabled>
						</c:if>
						<c:if test="${orderModel.status==1 }">
							<input type="text" class="form-control" value="접수" disabled>
						</c:if>
						<c:if test="${orderModel.status==2 }">
							<input type="text" class="form-control" value="제작중" disabled>
						</c:if>
						<c:if test="${orderModel.status==3 }">
							<input type="text" class="form-control" value="배송중" disabled>
						</c:if>
						<c:if test="${orderModel.status==4 }">
							<input type="text" class="form-control" value="완료" disabled>
						</c:if>
						<c:if test="${orderModel.status==5 }">
							<input type="text" class="form-control" value="취소" disabled>
						</c:if>
					</div>
					<div class="input-group input-group pull-left margin-t-10">
						<span class="input-group-addon" id="basic-addon1" style="width: 105px; border: 1px solid #ccc; border-radius: 2px;">언어 </span>
						<c:set var="levelList" value="${fn:split(orderModel, ',') }"></c:set>
						<label class="checkbox-inline" style="margin-left: 10px;"> <input type="checkbox" ${levelList[3] !="false"?"checked":""} disabled>한국어</label> 
						<label class="checkbox-inline" style="margin-left: 10px;"> <input type="checkbox" ${levelList[2] !="false"?"checked":""} disabled>영어</label> 
						<label class="checkbox-inline" style="margin-left: 10px;"> <input type="checkbox" ${levelList[1] !="false"?"checked":""} disabled>중국어</label> 
						<label class="checkbox-inline" style="margin-left: 10px;"> <input type="checkbox" ${levelList[0] !="false"?"checked":""} disabled>일어</label>
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 105px; border: 1px solid #ccc; border-radius: 2px;">디자인 템플릿</span>
						<c:set value="${fn:length(orderModel.dsfile) }" var="dslen"></c:set>
						<c:choose>
							<c:when test="${orderModel.dsfile == '-' || orderModel.dsfile == null || orderModel.dsfile == ''}">
								<span class="form-control input-sm filenameclass"> 등록된 디자인 템플릿이 없습니다. </span>
							</c:when>
							<c:otherwise>
								<span style="cursor: pointer" onclick="fn_dsfiledown('${orderModel.dsfile}');">
									<a href="#" class="form-control input-sm filenameclass">${fn:substring(orderModel.dsfile,23,dslen) }</a>
								</span>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
						<button type="button" class="btn" id="exceldownload" name="exceldownload" style="width: 35%; border: 1px solid #ccc; border-radius: 2px;" onclick="fn_xlsdown();">명함엑셀 일괄 다운로드</button>
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 105px; border: 1px solid #ccc; border-radius: 2px;">히든태그 타입</span>
						<span class="form-control input-sm filenameclass"> ${orderModel.category==0?'일반':'' } ${orderModel.category==1?'와이드':'' } ${orderModel.category==2?'마이크로':'' } ${orderModel.category==3?'마이크로와이드':'' } </span>
					</div>
					<div class="input-group input-group pull-left" style="width: 100%; margin-bottom: 20px; margin-top: 20px;">
						<p>
							<strong>내용</strong>
						</p>
						<textarea class="form-control" rows="3" disabled>${orderModel.content }</textarea>
					</div>
					<div class="input-group input-group pull-left" style="width: 100%; margin-bottom: 20px; margin-top: 20px;">
						<button type="button" class="btn btn-default btn-m wd100 pull-left" onclick="fn_mod(${orderModel.no})" ${orderModel.status==5?"disabled":""}>수정</button>
						<button type="button" class="btn btn-default btn-m wd100" style="margin-left: 35%;" onclick="fn_cancel(${orderModel.no})" ${orderModel.status!=0?"disabled":""}>주문취소</button>
						<button type="button" class="btn btn-default btn-m wd100 pull-right" value="닫기" id="list" onclick="window.close();">닫기</button>
					</div>
				</div>
				<div class="clearfix">
					<div class="input-group input-group pull-left" style="width: 100%; margin-bottom: 20px; margin-top: 20px;">
						<table class="table table-hover text-center table-striped" style="margin-top: 30px;">
							<tr style="height: 30px;">
								<td style="width: 10%;">관리자</td>
								<td style="width: 65%">
									<input type="text" id="reply" name="reply" style="width: 95%;" placeholder="100자 이내로 입력하세요." />
								</td>
								<td style="width: 10%;">
									<button type="button" class="btn btn-primary btn-m wd100 pull-right" onclick="fn_reply(${orderModel.no});">등록</button>
								<td style="width: 10%;"></td>
							</tr>
						</table>
						<c:if test="${replyList.size() != 0 }">
							<table class="table table-hover text-center table-striped" style="margin-top: 30px;">
								<tr>
									<td class="text-center client-n" style="width: 110px;">작성자</td>
									<td class="text-center client-num">내용</td>
									<td class="text-center client-num" style="width: 310px;">등록일</td>
									<td class="text-center client-num" style="width: 110px;">조회일</td>
								</tr>
								<tbody>
									<c:forEach items="${replyList }" var="reply">
										<tr>
											<td class="text-center client-n" style="width: 110px;">${reply.isuser==1?"관리자":"고객" }</td>
											<td class="text-center client-num">${reply.content }</td>
											<td class="text-center client-num" style="width: 310px;">
												<fmt:formatDate value="${reply.regdate }" pattern="yyyy-MM-dd" />
											</td>
											<td class="text-center client-num" style="width: 110px;">
												<fmt:formatDate value="${reply.ansdate }" pattern="yyyy-MM-dd" />
											</td>
										</tr>
									</c:forEach>
							</table>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>