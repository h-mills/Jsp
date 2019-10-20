<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<jsp:useBean id="now" class="java.util.Date" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>공지사항_상세보기</title>
    <style>
*{text-decoration:none;}
	</style>

<script type="text/javascript">
$(document).ready(function() {
	
});
//페이지
function filedown() 
{
	frm.action = "/pc/notice/filedown";
	frm.submit();
}

</script>

</head>
<body>
	<form id="frm" method="post">
		<input type="hidden" id="no" name="no" value="${data.info.no }"/>
		<div class="container-fluid cntbox radiall width:100%;">
			<div class="inbox">
				<div class="clearfix margin-b-10 margin-t-10">
					<div class="pull-left" style="position:relative; top:-2px;">
						<div class="input-group input-group-m">
							<h4 class="pull-left"><strong>공지사항</strong></h4>
						</div>
					</div>
				</div>
			</div>
			<div class="clearfix margin-t-10" style="margin-bottom:30px;">
				<div class="clearfix">
					<div class="input-group input-group pull-left margin-t-10" style="width:100%;">
						<span class="input-group-addon" id="basic-addon1" style="width:80px;">제목</span>
						<input type="text" class="form-control"style="width:100%;" value="${data.info.title }" disabled="disabled">
					</div>
					<div class="input-group input-group pull-left" style="width:100%; margin-bottom:12px; margin-top:20px;">
						<p><strong>내용</strong></p>
						<textarea class="form-control" rows="7" disabled="disabled">${data.info.content }</textarea>
					</div>
					
					<div class="input-group input-group pull-left" style="width:100%; margin-bottom:12px; margin-top:20px;">
						<span class="input-group-addon" id="basic-addon1" style="width:80px;">첨부파일</span>
						<c:choose>
							<c:when test="${data.info.filepath != null && data.info.filepath != '' }">
								<span style="cursor: pointer" onclick="filedown();">
								<a href="#" class="form-control">${data.file }</a>
								</span>
							</c:when>
							<c:otherwise>
								<span>
									<input type="text" class="form-control" value="첨부된 파일이 없습니다." disabled>
								</span>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div><!--.clearfix margin-t-10-->
		</div>
	</form>
</body>
</html>