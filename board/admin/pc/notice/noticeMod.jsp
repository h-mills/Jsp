<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.addHeader("Cache-Control", "no-store");
	response.setDateHeader("Expries", 1L);
	String res = (String) request.getAttribute("msg");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>공지사항 수정</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link href="/common/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/common/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="/common/css/pop.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="/common/js/bootstrap.min.js"></script>
<script type="text/javascript">
	function cancel(){
		window.close();
	}
	function modOkfn(no) {
		var title = $("#title").val();
		var content = $("#content").val();
		var pageNum = $('#pageNum').val();
		if (confirm('수정하시겠습니까?') != true)
			return;
		if (title.length <= 0) {
			alert('제목을 등록해주세요.');
			return;
		}
		if (content.length <= 0) {
			alert('내용 등록해주세요.');
			return;
		}
		frm.action="/pc/notice/modOk?no="+no+"&pageNum="+pageNum;
		frm.submit();
		alert("수정되었습니다.");
		//opener.location.href ="/pc/notice/noticelist";
	}
	function fileupload()
	{
		if(document.getElementById("file").value.length <= 0)
		{
			alert("파일을 선택해 주세요!");
			return;
		}
		fileFrm.action = "/pc/notice/upload2";
		fileFrm.submit();
 	}
</script>
</head>
<body style="overflow: hidden;">
<div class="container-fluid cntbox radiall width:100%; height:100%;">
			<div class="inbox">
				<div class="clearfix margin-b-10 margin-t-10">
					<div class="pull-left" style="position:relative; top:-2px;">
						<div class="input-group input-group-m">
							<h4 class="pull-left"><strong>공지사항</strong></h4>
						</div>
					</div>
				</div>
			</div>
		<form name="frm" method="post" enctype="multipart/form-data">
		<input type="hidden" id="pageNum" name="pageNum" size="10" value="${pageNum }">
			<div class="clearfix margin-t-10" style="margin-bottom:30px;">
				<div class="clearfix">
					<div class="input-group input-group pull-left margin-t-10" style="width:100%;">
						<span class="input-group-addon" id="basic-addon1" style="width:10%;">제목</span>
						<input type="text" class="form-control" id="title" name="title" style="width: 100%;" value="${model.title }">		
					</div>
					<div class="input-group input-group pull-left" style="width:100%; margin-bottom:12px; margin-top:20px;">
						<p><strong>내용</strong></p>
						<textarea class="form-control" rows="5" id="content" name="content" style="resize: none;">${model.content }</textarea>
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width:100%;">
					<span class="input-group-addon" id="basic-addon1" style="width:80px;">첨부파일</span>
					<c:choose>
							<c:when test="${showPath != null }">
								<span style="cursor: pointer">
									<a href="/pc/notice/download?no=${model.no}" class="form-control">${showPath }</a>
								</span>
							</c:when>
							<c:otherwise>
								<span class="form-control" style="width:100%;">첨부된 파일이 없습니다.</span>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="input-group input-group pull-right" style="width:100%; margin-bottom:10px; margin-top:20px;">
					<button type="button" class="btn btn-danger btn-m wd100 pull-right"style="margin-left: 20px;" onclick="cancel();">취소</button>
					<button type="button" class="btn btn-primary btn-m wd100 pull-right" onclick="modOkfn(${model.no});">수정완료</button>
				</div>
			</div><!--.clearfix margin-t-10-->
			</form>
		</div>
</body>
</html>
