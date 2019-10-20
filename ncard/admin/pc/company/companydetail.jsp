<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="/WEB-INF/jsp/include/include.jsp"%>

<html>
<head>
<title>업체관리_회원사정보</title>

<style>
*{text-decoration:none;}
li {list-style:none; text-decoration:none; float:left;}
td:nth-child(2):hover {text-decoration:underline;}
</style>

</head>
<body style="overflow: hidden;">
	<div class="container-fluid cntbox radiall width:100%;">
		<div class="inbox">
			<div class="clearfix margin-b-10 margin-t-10">
				<div class="pull-left" style="position: relative; top: -2px;">
					<div class="input-group input-group-m">
						<h4 class="pull-left">
							<strong>회원사정보</strong>
						</h4>
					</div>
				</div>
			</div>
		</div>
		<div class="clearfix margin-t-10" style="margin-bottom: 30px;">
			<div class="clearfix">
				<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 110px;">사업자번호</span> 
					<input type="text" class="form-control" name="biznumber" id="biznumber" value="${company.biznumber}" readonly>
				</div>
				<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 110px;">업체이름</span> 
					<input type="text" class="form-control" name="name" id="name" value="${company.name}" readonly>
				</div>
				<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 15%;">사업자등록증</span> 
					<input type="text" class="form-control pull-left" value="${company.fileName }" style="width: 70%;" readonly>
					<a href="/pc/company/bizdownload?filepath=${company.file }"><input type="button" class="form-control btn-primary pull-right" value="다운로드" style="width: 30%;"></a>
				</div>
				<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 110px;">대표자명</span> 
					<input type="text" class="form-control" name="ceo" id="ceo" value="${company.ceo}" readonly>
				</div>
				<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 110px;">대표번호</span> 
					<input type="text" class="form-control" name="tel" id="tel" value="${company.tel}" readonly>
				</div>
				<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 110px;">사업장주소</span> 
					<input type="text" class="form-control" name="address" id="address" value="${company.address}" readonly>
				</div>
				<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 110px;">팩스</span> 
					<input type="text" class="form-control" name="fax" id="fax" value="${company.fax}" readonly>
				</div>
				<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 110px;">회원수</span> 
					<input type="text" class="form-control" name="usercount" id="usercount" value="${company.usercount}" readonly>
				</div>
				<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 110px;">주문수</span> 
					<input type="text" class="form-control" name="ordercount" id="ordercount" value="${company.ordercount}" readonly>
				</div>
				<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
					<span class="input-group-addon" id="basic-addon1" style="width: 110px;">명함개수</span> 
					<input type="text" class="form-control" name="cardcount" id="cardcount" value="${company.cardcount}" readonly>
				</div>
			</div>
		</div>
	</div>
</body>
</html>