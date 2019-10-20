<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script language="javascript">
document.onkeydown=function() {  
	if(event.srcElement.type != "text" && event.srcElement.type != "textarea"){
		if(event.keyCode==8)return false;
		}
	
	if(event.keyCode == 116){
		event.keyCode = 0;
		window.location.reload();
		return false;
	}
}
	function checkfn() {
		var checkbox = document.getElementsByName('box');
		if (document.getElementById('checkall').checked == true) {
			for (var i = 0; i < checkbox.length; i++) {
				checkbox[i].checked = true;
			}
		} else {
			for (var i = 0; i < checkbox.length; i++) {
				checkbox[i].checked = false;
			}
		}
	};
	function notice_add() {
		var pageNum = $('#pageNum').val();
		window.open("/pc/notice/notice_add?pageNum="+pageNum,"공지사항등록",
		 "width=1000,height=400,scrollbars=no,resizeable=yes,left=450,top=150");
	}
	function delfn()
	{
		var pageNum = $('#pageNum').val();
		if (confirm('삭제 하시겠습니까?') != true) return;
			var count = 0;
			count = $("input:checkbox[name='box']:checked").size();
			if(count == 0) {alert('항목을 선택해 주세요.'); return;}
			form.action = '/pc/notice/del';
			form.submit();
	}
	function notice_detail(no){
		var pageNum = $('#pageNum').val();
		window.open("/pc/notice/mod?no="+no,"공지사항상세보기",
		"width=1000,height=400,scrollbars=no,resizeable=yes,left=450,top=150");
		//location.href="/pc/notice/noticelist?pageNum="+pageNum;
	}
	function pageMove(pageNum) {
		document.getElementById('pageNum').value = pageNum;
		form.action = "/pc/notice/noticelist";
		form.submit();
	}
</script>
<title>공지 사항</title>
<style>
* {
	text-decoration: none;
}

li {
	list-style: none;
	text-decoration: none;
	float: left;
}
</style>
</head>
<body>
	<form id="form" method="post" name="form">
		<input type="hidden" id="pageNum" name="pageNum" size="10" value="0">
		<input type="hidden" id="pagingURL" name="pagingURL" size="100">
		<div class="container margin-t-10 cntbox radiall" style="margin-top:20px; padding: 20px 20px 0 20px;">
			<div class="inbox">
				<div class="clearfix margin-b-10">
					<div class="pull-left" style="position: relative;">
						<div class="input-group input-group-sm">
							<h4 class="pull-left"
								style="display: block; margin: 20px 0 20px 0;">
								<strong>공지사항</strong>
							</h4>
						</div>
					</div>
				</div>
			</div>
			<table class="table table-hover text-center table-striped ">
				<thead>
					<tr>
						<th class="text-center client-num" style="width: 30px;"><label><input
								type="checkbox" id="checkall" onClick="checkfn();"></label></th>
						<th class="text-center client-n" style="width: 50px;">번호</th>
						<th class="text-center client-num" style="width: 310px;">제목</th>
						<th class="text-center client-num" style="width: 110px;">등록일자</th>
						<th class="text-center client-num" style="width: 70px;">조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${noticeList }" var="list">
						<tr>
							<td align="center"><label><input type="checkbox"
									name="box" value="${list.no }"></label></td>
							<td align="center" onclick="notice_detail(${list.no})">${list.rownum }</td>
							<td align="center" onclick="notice_detail(${list.no})">${list.title }</td>
							<td align="center" onclick="notice_detail(${list.no})"><fmt:formatDate
									value="${list.date }" pattern="yyyy-MM-dd" /></td>
							<td align="center" onclick="notice_detail(${list.no})">${list.count }</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="5" class="text-center">
							<ul class="pagination">
								<%@ include file="/WEB-INF/jsp/include/paging.jsp"%>
							</ul>
						</td>

					</tr>
					<c:if test="${data.pagingValues.totalListCount == 0}">
						<tr>
							<td colspan="7">리스트 정보가 없습니다.</td>
						</tr>
					</c:if>
				</tfoot>
			</table>
			<div class="input-group input-group pull-left"
				style="width: 100%; margin-bottom: 20px;">
				<button type="button" class="btn btn-danger btn-m wd100 pull-right"
					style="margin-left: 20px;" onclick="delfn();">삭제</button>
				<button type="button" class="btn btn-primary btn-m wd100 pull-right"
					onclick="notice_add();">등록</button>
			</div>
		</div>
	</form>
</body>
</html>