<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="/WEB-INF/jsp/include/include.jsp"%>

<html>
<head>
<title>사용자관리</title>

<style>
*{text-decoration:none;}
li {list-style:none; text-decoration:none; float:left;}
</style>

<script language="javascript">
// 체크박스 전체체크
function fn_checkAll() {
	if ($("#checkall").is(":checked") == true) {
		$("input:checkbox[name='box']").prop('checked', true);
	} else {
		$("input:checkbox[name='box']").prop('checked', false);
	}
}

// 사용자 등록
function fn_userAdd()
{
	var pageNum = $("#pageNum").val();
	window.open("/pc/member/addmain?pageNum="+pageNum,"사용자등록",
			"width=1000,height=400,scrollbars=no,resizeable=yes,left=450,top=150");
}

// 사용자 수정
function fn_userModify(no) {
	var pageNum = $("#pageNum").val();
	window.open("/pc/member/modmain?no="+no+"&pageNum="+pageNum,"사용자수정", 
			"width=1000,height=400,scrollbars=no,resizeable=yes,left=450,top=150");
}

// 사용자 삭제
function fn_del() {
	var pageNum = $("#pageNum").val();
	var count = 0;
	count = $("input:checkbox[name='box']:checked").size();
	if (count == 0) {
		alert('항목을 선택해 주세요.');
		return;
	}

	if (confirm('삭제 하시겠습니까?') != true) return;

	form.action = "/pc/member/del?pageNum="+pageNum;
	form.submit();
}

// 페이지
function pageMove(pageNum) {

	$("#pageNum").val(pageNum);
	form.action = "/pc/member/main";
	form.submit();
}

//검색
function fn_search() {
	$("#keyword").val($("#keyword").val().trim());
	form.action = "/pc/member/main";
	form.submit();
}

function fn_user() {
	location.href="/pc/member/umain";
}

function fn_submit(e) {
	if (e.keyCode==13) {
		fn_search();
	}
}
</script>

</head>
<body>
	<form id="form" method="post">
		<input type="hidden" id="pageNum" name="pageNum" value="${ pagingValues.pageNum }">
		<div class="container subnav" style="margin-top:20px; border-radius: 5px;">
			<div class="subnavcontainer">
				<div class="pull-left width-200">
					<div class="input-group input-group-sm">
						<input type="text" class="form-control" style="width: 200px;" id="keyword" name="keyword" value="${param.keyword}" onkeydown="fn_submit(event);" maxlength="20" placeholder="이름"> 
						<span class="input-group-btn">
							<button class="btn btn-info wd50" type="button" onclick="fn_search();">검색</button>
						</span>
					</div>
				</div>
			</div>
		</div>

		<div class="container margin-t-10 cntbox radiall" style="padding: 20px 20px 0 20px;">
			<div class="pull-left center-block" style="width: 100%;">
				<div class="btn-group center-block center-block text-center" style="width: 200px;">
					<button type="button" class="btn btn-primary navbar-btn wd100 active">관리자</button>
					<button type="button" class="btn btn-default navbar-btn wd100" onclick="fn_user();">고객</button>
				</div>
			</div>
			<div class="inbox">
				<div class="clearfix margin-b-10">
					<div class="pull-left" style="position: relative; top: -2px;">
						<div class="input-group input-group-sm">
							<h4 class="pull-left"
								style="display: block; margin: 20px 0 20px 0;">
								<strong>사용자관리(관리자)</strong>
							</h4>
						</div>
					</div>
				</div>
			</div>
			
			<table class="table table-hover text-center table-striped ">
				<thead>
					<tr>
						<th class="text-center client-n" style="width: 30px;"><label><input type="checkbox" id="checkall" onClick="fn_checkAll();"></label></th>
						<th class="text-center client-n" style="width: 50px;">번호</th>
						<th class="text-center client-num" style="width: 300px;">권한</th>
						<th class="text-center client-num" style="width: 100px;">아이디</th>
						<th class="text-center client-num" style="width: 100px;">비밀번호</th>
						<th class="text-center client-num" style="width: 80px;">이름</th>
						<th class="text-center client-num" style="width: 80px;">등록날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${memberList }">
						<tr>
							<td>
								<label><input type="checkbox" name="box"value="${list.no }"></label>
							</td>
							<td onClick="fn_userModify('${list.no }');">${list.rownum }</td>
							<td onClick="fn_userModify('${list.no }');">
								<label class="checkbox-inline"> <input type="checkbox" ${list.levels.order == true?"checked":""} disabled="disabled">주문</label> 
								<label class="checkbox-inline"> <input type="checkbox" ${list.levels.company == true?"checked":""} disabled="disabled">업체</label> 
								<label class="checkbox-inline"> <input type="checkbox" ${list.levels.card == true?"checked":""} disabled="disabled">명함</label> 
								<label class="checkbox-inline"> <input type="checkbox" ${list.levels.stats == true?"checked":""} disabled="disabled">통계</label> 
								<label class="checkbox-inline"> <input type="checkbox" ${list.levels.notice == true?"checked":""} disabled="disabled">공지</label>
								<label class="checkbox-inline"> <input type="checkbox" ${list.levels.member == true?"checked":""} disabled="disabled">사용자</label>
								<label class="checkbox-inline"> <input type="checkbox" ${list.levels.industry == true?"checked":""} disabled="disabled">업종</label>
								<label class="checkbox-inline"> <input type="checkbox" ${list.levels.dept == true?"checked":""} disabled="disabled">부서</label>
							</td>
							<td onClick="fn_userModify('${list.no }');">${list.id }</td>
							<td onClick="fn_userModify('${list.no }');">${list.passwd }</td>
							<td onClick="fn_userModify('${list.no }');">${list.name }</td>
							<td onClick="fn_userModify('${list.no }');"><fmt:formatDate value="${list.date }" pattern="yyyy-MM-dd" /></td>
						</tr>
					</c:forEach>	
				</tbody>
				<tfoot>
					<tr>
						<td colspan="7" class="text-center">
							<ul class="pagination">
								<%@ include file="/WEB-INF/jsp/include/paging.jsp" %>
							</ul>
						</td>
					</tr>
				</tfoot>
			</table>

			<div class="input-group input-group pull-left" style="width: 100%; margin-bottom: 20px;">
				<button type="button" class="btn btn-danger btn-m wd100 pull-right" style="margin-left: 20px;" onclick="fn_del();">삭제</button>
				<button type="button" class="btn btn-primary btn-m wd100 pull-right" onclick="fn_userAdd();">등록</button>
			</div>
		</div>
	</form>
</body>
</html>