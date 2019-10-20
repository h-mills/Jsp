<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<html>
<head>
<title>직종관리</title>

<style>
*{text-decoration:none;}
li {list-style:none; text-decoration:none; float:left;}
</style>

<script language="javascript">
//체크박스 전체체크
function fn_checkAll() {
	if ($("#checkall").is(":checked") == true) {
		$("input:checkbox[name='box']").prop('checked', true);
	} else {
		$("input:checkbox[name='box']").prop('checked', false);
	}
}

//페이지
function pageMove(pageNum) {
	$("#pageNum").val(pageNum);
	form.action = "/pc/dept/main";
	form.submit();
}

//검색
function fn_search() {
	$("#keyword").val($("#keyword").val().trim());
	form.action = "/pc/dept/main";
	form.submit();
}

//삭제
function fn_del() {
	var pageNum = $("#pageNum").val();
	var count = 0;
	count = $("input:checkbox[name='box']:checked").size();
	if (count == 0) {
		alert('항목을 선택해 주세요.');
		return;
	}

	if (confirm('삭제 하시겠습니까?') != true) return;

	form.action = "/pc/dept/del?pageNum="+pageNum;
	form.submit();
}

//등록창
function fn_add()
{
	$("#addModal #name").val("");
	$("#addModal").modal();
}

//등록
function fn_addSubmit() {
	var name = $("#addModal #name").val();

	if (name.length <= 0){alert('직종명을 입력해 주세요.'); return;}
	if (confirm('등록하시겠습니까?') != true) return;

	$.ajax({
		type: 'post',
		url : "/pc/dept/add",
		data : {name:name},
        async: true,
		success : function(data)
		{
			var JSONobj = JSON.parse(data);
			var result = JSONobj.result;

			if (result == 1) {
				alert("저장되었습니다.");
				$("#addModal").modal("hide");
				location.reload();
			} else {
				alert("저장실패! 관리자에게 문의하시기 바랍니다.");
			}
		}
	});
}

//수정창
function fn_modify(no, name) {
	$("#modifyModal #no").val(no);
	$("#modifyModal #name").val(name);
	$("#modifyModal").modal();
}

//수정
function fn_modifySubmit() {
	var no = $("#modifyModal #no").val();
	var name = $("#modifyModal #name").val();

	if (no.length <= 0){alert('코드를 확인해 주세요.'); return;}
	if (name.length <= 0){alert('직종명을 입력해 주세요.'); return;}
	if (confirm('수정하시겠습니까?') != true) return;

	$.ajax({
		type: 'post',
		url : "/pc/dept/modify",
		data : {no:no, name:name},
        async: true,
		success : function(data)
		{
			var JSONobj = JSON.parse(data);
			var result = JSONobj.result;

			if (result == 1) {
				alert("수정되었습니다.");
				$("#modifyModal").modal("hide");
				location.reload();
			} else {
				alert("수정실패! 관리자에게 문의하시기 바랍니다.");
			}
		}
	});
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
		<input type="hidden" id="pageNum" name="pageNum" value="${param.pageNum }">
		<div class="container subnav" style="margin-top:20px; border-radius: 5px;">
			<div class="subnavcontainer">
				<div class="pull-left width-200">
					<div class="input-group input-group-sm">
						<input type="text" class="form-control" style="width: 200px;" id="keyword" name="keyword" value="${param.keyword}" onkeydown="fn_submit(event);" maxlength="50" placeholder="직종명"> 
						<span class="input-group-btn">
							<button class="btn btn-info wd50" type="button" onclick="fn_search();">검색</button>
						</span>
					</div>
				</div>
			</div>
		</div>

		<div class="container margin-t-10 cntbox radiall" style="padding: 20px 20px 0 20px;">
			<div class="inbox">
				<div class="clearfix margin-b-10">
					<div class="pull-left" style="position: relative; top: -2px;">
						<div class="input-group input-group-sm">
							<h4 class="pull-left" style="display: block; margin: 20px 0 20px 0;">
								<strong>직종관리</strong>
							</h4>
						</div>
					</div>
				</div>
			</div>
			<table class="table table-hover text-center table-striped ">
				<thead>
					<tr>
						<th class="text-center client-n" style="width: 30px;">
							<label><input type="checkbox" id="checkall" onClick="fn_checkAll();"></label>
						</th>
						<th class="text-center client-n" style="width: 50px;">번호</th>
						<th class="text-center client-num" style="width: 100px;">코드</th>
						<th class="text-center client-num" style="width: 300px;">직종명</th>
						<th class="text-center client-num" style="width: 100px;">등록일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${deptList }">
						<tr>
							<td><label><input type="checkbox" name="box" value="${list.no }"></label></td>
							<td onclick="fn_modify('${list.no }', '${list.name }');"><fmt:parseNumber value="${list.ROWNUM }" integerOnly="true"/></td>
							<td onclick="fn_modify('${list.no }', '${list.name }');">${list.no }</td>
							<td onclick="fn_modify('${list.no }', '${list.name }');">${list.name }</td>
							<td onclick="fn_modify('${list.no }', '${list.name }');"><fmt:formatDate value="${list.date }" pattern="yyyy-MM-dd"/></td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="5" class="text-center">
							<ul class="pagination">
								<%@ include file="/WEB-INF/jsp/include/paging.jsp" %>
							</ul>
						</td>
					</tr>
				</tfoot>
			</table>
	
			<div class="input-group input-group pull-left" style="width: 100%; margin-bottom: 20px;">
				<button type="button" class="btn btn-danger btn-m wd100 pull-right" style="margin-left: 20px;" onclick="fn_del();">삭제</button>
				<button type="button" class="btn btn-primary btn-m wd100 pull-right" onclick="fn_add();">등록</button>
			</div>
		</div>
	</form>

	<!-- Modal -->
	<div class="modal fade" id="addModal" role="dialog">
		<div class="modal-dialog">

			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">직종 추가</h4>
				</div>
				<div class="modal-body">
					<div class="clearfix">
						<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
							<span class="input-group-addon" id="basic-addon1" style="width: 20%;">직종명</span>
							<input type="text" class="form-control" name="name" id="name" maxlength="100" placeholder="직종명을 입력하세요." style="width: 100%;">
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary btn-m wd100" onclick="fn_addSubmit();">등록</button>
					<button type="button" class="btn btn-danger btn-m wd100" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="modifyModal" role="dialog">
		<div class="modal-dialog">

			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">직종 수정</h4>
				</div>
				<div class="modal-body">
					<div class="clearfix">
						<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
							<span class="input-group-addon" id="basic-addon1" style="width: 20%;">코드</span>
							<input type="text" class="form-control" name="no" id="no" placeholder="코드을 입력하세요." style="width: 100%;" readonly="readonly">
						</div>
						<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
							<span class="input-group-addon" id="basic-addon1" style="width: 20%;">직종명</span>
							<input type="text" class="form-control" name="name" id="name" maxlength="100" placeholder="직종명을 입력하세요." style="width: 100%;">
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary btn-m wd100" onclick="fn_modifySubmit();">수정</button>
					<button type="button" class="btn btn-danger btn-m wd100" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>