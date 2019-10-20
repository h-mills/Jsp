<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>공지사항 등록</title>
<style>
*{text-decoration:none;}
</style>
<script type="text/javascript">
	function cancel() {
		window.close();
	}
	function addfn() {
		var title = $("#title").val();
		var content = $("#content").val();
		var pageNum = $('#pageNum').val();
		if (confirm('등록하시겠습니까?') != true)
			return;
		if (title.length <= 0) {
			alert('제목을 등록해주세요.');
			return;
		}
		if (content.length <= 0) {
			alert('내용을 등록해주세요.');
			return;
		}
		frm.action = "/pc/notice/insert";
		frm.submit();
	}
	function fn_kocheck(obj){
		var kocheck = /[ㄱ-ㅎㅏ-ㅣ|가-힣]/;
		var filename = obj.value;
		if(kocheck.test(filename)){ 
			alert("첨부파일명은 영어만 가능합니다.");
			obj.value="";
			return false;
		}
	}
</script>
</head>
<body style="overflow: hidden;">
	<div class="container-fluid cntbox radiall width:700px;">
		<div class="inbox">
			<div class="clearfix margin-b-10 margin-t-10">
				<div class="pull-left" style="position: relative; top: -2px;">
					<div class="input-group input-group-m">
						<h4 class="pull-left">
							<strong>공지사항</strong>
						</h4>
					</div>
				</div>
			</div>
		</div>
		<form name="frm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="pageNum" name="pageNum" size="10" value="0">
			<div class="clearfix margin-t-10" style="margin-bottom: 30px;">
				<div class="clearfix">
					<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 10%;">제목</span> 
						<input type="text" class="form-control" id="title" name="title" style="width: 100%;">
					</div>
					<div class="input-group input-group pull-left" style="width: 100%; margin-bottom: 12px; margin-top: 20px;">
						<p>
							<strong>내용</strong>
						</p>
						<textarea class="form-control" rows="5" id="content" name="content" style="resize: none;"></textarea>
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
						<input type="file" name="file" class="form-control pull-left" style="width: 100%;" onchange="fn_kocheck(this);"> 
						<input type="hidden" size="40" id="filepath" name="filepath" value="${imagePath }">
					</div>
				</div>
				<div class="input-group input-group pull-right" style="width: 100%; margin-bottom: 10px; margin-top: 20px;">
					<button type="button" class="btn btn-danger btn-m wd100 pull-right" style="margin-left: 20px;" onclick="cancel();">취소</button>
					<button type="button" class="btn btn-primary btn-m wd100 pull-right" onclick="addfn();">등록</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>
