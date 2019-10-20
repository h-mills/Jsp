<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="/WEB-INF/jsp/include/include.jsp"%>

<html>
<head>
<title>댓글삭제</title>

<style>
* {	text-decoration: none;}
</style>

<script language="javascript">
$(document).ready(function() {
	var msgvar = "${res}";
	var pageNum = "${pageNum}";
	if(msgvar == 'success')
	{
		alert('등록되었습니다.');
		//opener.location.href ="/pc/member/main?pageNum="+pageNum;  // 등록되면 부모 페이지 refresh
	}
	else if(msgvar == 'fail')
	{
		alert('등록 실패하였습니다.');
	}
});

// 삭제
function fn_replydel(no)
{
	if (document.getElementById('passwd').value.length <= 0) {alert('비밀번호를 입력해주세요.'); return;}
	if (confirm('삭제하시겠습니까?') != true) return; 

	var passwd = $("#passwd").val();

	$.ajax({
		type: 'post',
		url : '/mobile/replydel',
		data : {no:no,passwd:passwd},
        async: true,
		success : function(data) {
			var JSONobj = JSON.parse(data);
			var result = JSONobj.result;

			if (result == 1) {
				window.close();
				window.opener.fn_getReply(0, 0);
			} else if (result == -1) {
				alert("비밀번호가 틀렸습니다.");
			} else {
				alert("삭제 실패했습니다.");
			}
		}
	});
}

function fn_cancel() {
	window.close();
}
</script>

</head>
<body style="overflow: hidden;">
	<div class="container-fluid cntbox radiall width:100%;">
		<div class="inbox">
			<div class="clearfix margin-b-10 margin-t-10">
				<div class="pull-left" style="position: relative; top: -2px;">
					<div class="input-group input-group-m">
						<h4 class="pull-left">
							<strong>댓글삭제</strong>
						</h4>
					</div>
				</div>
			</div>
		</div>
		<div class="clearfix margin-t-10" style="margin-bottom: 30px;">
			<div class="clearfix">
				<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
					<input type="text" class="form-control" name="passwd" id="passwd" maxlength="16" placeholder="비밀번호를 입력하세요." style="width: 450px;">
				</div>
			</div>
			<div class="input-group input-group pull-left" style="width: 100%; margin-bottom: 10px; margin-top: 20px;">
				<button type="button" class="btn btn-primary btn-m wd100 pull-left margin-r-10" onClick="fn_cancel();">취소</button>
				<button type="button" class="btn btn-primary btn-m wd100 pull-left" onClick="fn_replydel('${no}');">삭제</button>
			</div>
		</div>
	</div>
</body>
</html>
