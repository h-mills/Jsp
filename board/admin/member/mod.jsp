<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="/WEB-INF/jsp/include/include.jsp"%>

<html>
<head>
<title>사용자관리_팝업_수정</title>

<style>
* {text-decoration: none;}
</style>

<script language="javascript">
$(document).ready(function() {
	var msgvar = "${res}";
	var no = "${no}";
	var pageNum = "${pageNum}";
	if(msgvar == 'success')
	{
		alert('수정되었습니다.');
		location.href = "/pc/member/modmain?no="+no+"&pageNum="+pageNum;
		//opener.location.href ="/pc/member/main?pageNum="+pageNum;  // 등록되면 부모 페이지 refresh
	}
	else if(msgvar == 'fail')
	{
		alert('수정 실패하였습니다.');
	}
});

function fn_mod(no)
{
	if ($("input:checkbox[name='level']:checked").length <= 0) {alert('권한을 선택해주세요.'); return;}
	if(document.getElementById('id').value.length <= 0) {alert('아이디를 등록해주세요.'); return;}
	if(document.getElementById('passwd').value.length <= 0) {alert('비밀번호를 등록해주세요.'); return;}
	if(document.getElementById('name').value.length <= 0) {alert('이름을 등록해주세요.'); return;}
	if(document.getElementById('number').value.length <= 0) {alert('내선번호를 등록해주세요.'); return;}
	if(document.getElementById('email').value.length <= 0) {alert('이메일을 등록해주세요.'); return;}
	if(confirm('수정하시겠습니까?') != true) return;
	
	form.action = "/pc/member/mod?no="+no;
	form.submit();
};

</script>

</head>
<body style="overflow: hidden;">
	<div class="container-fluid cntbox radiall width:100%;">
		<div class="inbox">
			<div class="clearfix margin-b-10 margin-t-10">
				<div class="pull-left" style="position: relative; top: -2px;">
					<div class="input-group input-group-m">
						<h4 class="pull-left">
							<strong>사용자관리</strong>
						</h4>
					</div>
				</div>
			</div>
		</div>
		<div class="clearfix margin-t-10" style="margin-bottom: 30px;">
			<form id="form" method="post">
			<input type="hidden" id="pageNum" name="pageNum" size="10" value="${pageNum }">
				<div class="clearfix">
					<div class="pull-left margin-t-10" style="width: 100%;">
						<label class="checkbox-inline"> <input type="checkbox" name="level" value="1" ${member.levels.order == true?"checked":""}> 주문관리</label> 
						<label class="checkbox-inline"> <input type="checkbox" name="level" value="2" ${member.levels.company == true?"checked":""}> 업체관리</label> 
						<label class="checkbox-inline"> <input type="checkbox" name="level" value="4" ${member.levels.card == true?"checked":""}> 명함관리</label> 
						<label class="checkbox-inline"> <input type="checkbox" name="level" value="8" ${member.levels.stats == true?"checked":""}> 통계</label> 
						<label class="checkbox-inline"> <input type="checkbox" name="level" value="16" ${member.levels.notice == true?"checked":""}> 공지사항</label>
						<label class="checkbox-inline"> <input type="checkbox" name="level" value="32" ${member.levels.member == true?"checked":""}> 사용자관리</label>
						<label class="checkbox-inline"> <input type="checkbox" name="level" value="64" ${member.levels.industry == true?"checked":""}> 업종관리</label>
						<label class="checkbox-inline"> <input type="checkbox" name="level" value="128" ${member.levels.dept == true?"checked":""}> 부서관리</label>
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 10%;">이름</span> 
						<input type="text" class="form-control" name="name" id="name" maxlength="16" value="${member.name}" placeholder="이름을 입력하세요." style="width: 100%;">
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 10%;">아이디</span> 
						<input type="text" class="form-control" name="id" id="id" maxlength="16" value="${member.id}" placeholder="아이디를 입력하세요." style="width: 100%;">
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 10%;">비밀번호</span> 
						<input type="text" class="form-control" name="passwd" id="passwd" maxlength="16" value="${member.passwd}" placeholder="비밀번호를 입력하세요." style="width: 100%;">
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 10%;">이메일</span> 
						<input type="text" class="form-control" name="email" id="email" maxlength="26" value="${member.email}" placeholder="이메일을 입력하세요." style="width: 100%;">
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 10%;">내선번호</span> 
						<input type="text" class="form-control" name="number" id="number" maxlength="4" value="${member.number}" placeholder="내선번호를 입력하세요." style="width: 100%;">
					</div>
				</div>
				<div class="input-group input-group pull-right" style="width: 100%; margin-bottom: 10px; margin-top: 20px;">
					<button type="button" class="btn btn-primary btn-m wd100 pull-right" onClick="fn_mod(${member.no});">수정</button>
				</div>
			</form>
		</div>
	</div>	
</body>
</html>
