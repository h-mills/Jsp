<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="/WEB-INF/jsp/include/include.jsp"%>

<html>
<head>
<title>업체관리_주문상세정보</title>

<style>
* {
	text-decoration: none;
}
</style>

</head>
<body style="overflow: hidden;">
	<div class="container-fluid cntbox radiall width:100%;">
		<div class="inbox">
			<div class="clearfix margin-b-10 margin-t-10">
				<div class="pull-left" style="position: relative; top: -2px;">
					<div class="input-group input-group-m">
						<h4 class="pull-left">
							<strong>상세</strong>
						</h4>
					</div>
				</div>
			</div>
		</div>
		<div class="clearfix margin-t-10" style="margin-bottom: 30px;">
			<div class="clearfix">
				<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 110px;">회사명</span> 
					<input type="text" class="form-control" name="company_name" id="company_name" value="${order.company_name}" readonly>
				</div>
				<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 110px;">발주차수</span> 
					<input type="text" class="form-control" name="orderth" id="orderth" value="${order.orderth}" readonly>
				</div>
				<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 110px;">제목</span> 
					<input type="text" class="form-control" name="title" id="title" value="${order.title}" readonly>
				</div>
				<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 110px;">주문자</span> 
					<input type="text" class="form-control" name="user_name" id="user_name" value="${order.user_name}" readonly>
				</div>
				<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 110px;">진행상태</span> 
					<c:choose>
						<c:when test="${order.status == 0}">
							<c:set var="status" value="주문"></c:set>
						</c:when>
						<c:when test="${order.status == 1}">
							<c:set var="status" value="접수"></c:set>
						</c:when>
						<c:when test="${order.status == 2}">
							<c:set var="status" value="제작"></c:set>
						</c:when>
						<c:when test="${order.status == 3}">
							<c:set var="status" value="배송"></c:set>
						</c:when>
						<c:when test="${order.status == 4}">
							<c:set var="status" value="완료"></c:set>
						</c:when>
						<c:when test="${order.status == 5}">
							<c:set var="status" value="취소"></c:set>
						</c:when>
						<c:otherwise>
							<c:set var="status" value=""></c:set>
						</c:otherwise>
					</c:choose>
					<input type="text" class="form-control" name="status" id="status" value="${status}" readonly>
				</div>
				<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 110px;">주문날짜</span> 
					<fmt:formatDate var="orderdate" value="${order.orderdate }" pattern="yyyy-MM-dd" />
					<input type="text" class="form-control" name="orderdate" id="orderdate" value="${orderdate}" readonly>
				</div>
				<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 110px;">배송날짜</span> 
					<input type="text" class="form-control" name="distdate" id="distdate" value="${order.distdate}" readonly>
				</div>
				<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 110px;">완료날짜</span> 
					<input type="text" class="form-control" name="enddate" id="enddate" value="${order.enddate}" readonly>
				</div>
				<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 110px;">희망날짜</span> 
					<input type="text" class="form-control" name="recvdate" id="recvdate" value="${order.recvdate}" readonly>
				</div>
				<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 110px;">시작번호</span> 
					<input type="text" class="form-control" name="start" id="start" value="${order.start>0?order.start:''}" readonly>
				</div>
				<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 110px;">명함개수</span> 
					<input type="text" class="form-control" name="count" id="count" value="${order.count}" readonly>
				</div>
				<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 110px;">종료번호</span> 
					<input type="text" class="form-control" name="finish" id="finish" value="${order.finish>0?order.finish:''}" readonly>
				</div>
			</div>
		</div>
	</div>
</body>
</html>