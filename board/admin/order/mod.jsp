<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
*{text-decoration:none;}
</style>
</head>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
function fn_modOk(no){
	if (confirm('수정하시겠습니까?') != true)
		return;
	var status = $('#status option:selected').val();
	frm.action="/pc/order/modOk?no="+no+"&status="+status;
	frm.submit();
	alert("수정되었습니다.");
}
function openmap() {
	window.open("/pc/order/jusopop","pop","width=600, height=420, left=500px; top=200px;");
}
function jusoCallBack(roadFullAddr){
	// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
	document.getElementById('addrbtn').value="기존주소로 변경";
	document.getElementById('address').value=roadFullAddr;
	$('#addrbtn').attr('onclick','addr_standard()');
}
function addr_standard(){
	document.getElementById('address').value='${orderModel.address}';
	$('#addrbtn').val("주소 검색");
	$('#addrbtn').attr('onclick','openmap()');
}
</script>
<body>
	<form name="frm" method="post">
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
						<input type="text" name="tel" id="tel" class="form-control" value="${orderModel.tel }">
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 105px;">메일주소</span>
						<input type="text" name="email" id="email" class="form-control" value="${orderModel.email }">
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 105px;">배송주소</span>
						<input type="text" style="width: 746px;" name="address" id="address" class="form-control" value="${orderModel.address }">
						<input type="button" class="btn btn-standard" id="addrbtn" name="addrbtn" style="width: 105px;" value="주소 검색" onclick="openmap();">
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 105px;">배송희망날짜</span>
						<input type="text" id="endDate" class="form-control" name="startDate" value="${orderModel.recvdate}" placeholder="yyyy-MM-dd">
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 105px;">진행상태</span>
						<select id="status" name="status" class="form-control">
							<c:if test="${orderModel.status == 0 }">
								<option value="0" selected="selected">주문</option>
								<option value="1">접수</option>
								<option value="2">제작중</option>
								<option value="3">배송중</option>
								<option value="4">완료</option>
							</c:if>
							<c:if test="${orderModel.status == 1 }">
								<option value="0">주문</option>
								<option value="1" selected="selected">접수</option>
								<option value="2">제작중</option>
								<option value="3">배송중</option>
								<option value="4">완료</option>
							</c:if>
							<c:if test="${orderModel.status == 2 }">
								<option value="0">주문</option>
								<option value="1">접수</option>
								<option value="2" selected="selected">제작중</option>
								<option value="3">배송중</option>
								<option value="4">완료</option>
							</c:if>
							<c:if test="${orderModel.status == 3 }">
								<option value="0">주문</option>
								<option value="1">접수</option>
								<option value="2">제작중</option>
								<option value="3" selected="selected">배송중</option>
								<option value="4">완료</option>
							</c:if>
							<c:if test="${orderModel.status == 4 }">
								<option value="0">주문</option>
								<option value="1">접수</option>
								<option value="2">제작중</option>
								<option value="3">배송중</option>
								<option value="4" selected="selected">완료</option>
							</c:if>
						</select>
					</div>
					<div class="input-group input-group pull-left margin-t-10">
						<span class="input-group-addon" id="basic-addon1" style="width: 105px; border: 1px solid #ccc; border-radius: 2px;">언어 </span>
						<c:set var="levelList" value="${fn:split(orderModel, ',') }"></c:set>
						<label class="checkbox-inline" style="margin-left: 10px;"> <input type="checkbox" ${levelList[3] !="false"?"checked":""} disabled>한국어</label> 
						<label class="checkbox-inline" style="margin-left: 10px;"> <input type="checkbox"${levelList[2] !="false"?"checked":""} disabled >영어</label> 
						<label class="checkbox-inline" style="margin-left: 10px;"> <input type="checkbox" ${levelList[1] !="false"?"checked":""} disabled >중국어</label> 
						<label class="checkbox-inline" style="margin-left: 10px;"> <input type="checkbox" ${levelList[0] !="false"?"checked":""} disabled >일어</label>
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
						<button type="button" class="btn" id="exceldownload" name="exceldownload" style="width: 20%; border: 1px solid #ccc; border-radius: 2px;" disabled="disabled">첨부파일 일괄 다운로드</button>
					</div>
					<div class="input-group input-group pull-left" style="width: 100%; margin-bottom: 20px; margin-top: 20px;">
						<p>
							<strong>내용</strong>
						</p>
						<textarea class="form-control" rows="3" disabled>${orderModel.content }</textarea>
					</div>
					<div class="input-group input-group pull-left" style="width: 100%; margin-bottom: 20px; margin-top: 20px;">
						<button type="button" class="btn btn-default btn-m wd100 pull-left" onclick="fn_modOk(${orderModel.no})">수정완료</button>
						<button type="button" class="btn btn-default btn-m wd100 pull-right" onclick="javascript:history.back()">수정취소</button>
					</div>
				</div>
				<div class="clearfix">
					<div class="input-group input-group pull-left" style="width: 100%; margin-bottom: 20px; margin-top: 20px;">
						<table class="table table-hover text-center table-striped" style="margin-top: 30px;">
							<tr style="height: 30px;">
								<td style="width: 10%;">관리자</td>
								<td style="width: 65%">
									<input type="text" disabled id="reply" name="reply" style="width: 95%;" placeholder="100자 이내로 입력하세요." />
								</td>
								<td style="width: 10%;">
									<button type="button" class="btn btn-primary btn-m wd100 pull-right" onclick="fn_reply(${orderModel.no});" disabled>등록</button>
								<td style="width: 10%;"></td>
							</tr>
						</table>
						<c:if test="${replyList.size() != 0 }">
							<table class="table table-hover text-center table-striped" style="margin-top: 30px;">
								<thead>
									<tr>
										<th class="text-center client-n" style="width: 110px;">작성자</th>
										<th class="text-center client-num">내용</th>
										<th class="text-center client-num" style="width: 310px;">등록일</th>
										<th class="text-center client-num" style="width: 110px;">조회일</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${replyList }" var="reply">
										<tr>
											<th class="text-center client-n" style="width: 110px;">${reply.isuser==1?"관리자":"고객" }</th>
											<th class="text-center client-num">${reply.content }</th>
											<th class="text-center client-num" style="width: 310px;">
												<fmt:formatDate value="${reply.regdate }" pattern="yyyy-MM-dd" />
											</th>
											<th class="text-center client-num" style="width: 110px;">
												<fmt:formatDate value="${reply.ansdate }" pattern="yyyy-MM-dd" />
											</th>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>