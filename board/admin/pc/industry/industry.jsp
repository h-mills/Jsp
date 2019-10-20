<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<html>
<head>
<title>업종관리</title>

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
	form.action = "/pc/industry/main";
	form.submit();
}

//검색
function fn_search() {
	$("#keyword").val($("#keyword").val().trim());
	form.action = "/pc/industry/main";
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

	form.action = "/pc/industry/del?pageNum="+pageNum;
	form.submit();
}

//등록창
function fn_add()
{
	$("#addModal #cd").val("");
	$("#addModal #pcd").val("");
	$("#addModal #name").val("");
	$("#addModal").modal();
}

//등록
function fn_addSubmit() {
	var cd = $("#addModal #cd").val();
	var pcd = $("#addModal #pcd").val();
	var name = $("#addModal #name").val();

	if (cd.length <= 0){alert('코드를 입력해 주세요.'); return;}
	if (pcd.length <= 0){alert('상위코드를 입력해 주세요.'); return;}
	if (name.length <= 0){alert('업종명을 입력해 주세요.'); return;}
	if (confirm('등록하시겠습니까?') != true) return;

	if (!fn_numCheck(cd, pcd)) {
		alert("코드와 상위코드는 숫자만 가능합니다.");
		return;
	}

	$.ajax({
		type: 'post',
		url : "/pc/industry/add",
		data : {cd:cd, pcd:pcd, name:name},
        async: true,
		success : function(data)
		{
			var JSONobj = JSON.parse(data);
			var result = JSONobj.result;

			if (result == 1) {
				alert("저장되었습니다.");
			} else if (result == -1) {
				alert("동일한 코드가 존재합니다.");
			} else {
				alert("저장실패! 관리자에게 문의하시기 바랍니다.");
			}
		}
	});
}

//수정창
function fn_modify(cd, pcd, name) {
	$("#modifyModal #cd").val(cd);
	$("#modifyModal #pcd").val(pcd);
	$("#modifyModal #name").val(name);
	$("#modifyModal").modal();
}

//수정
function fn_modifySubmit() {
	var cd = $("#modifyModal #cd").val();
	var pcd = $("#modifyModal #pcd").val();
	var name = $("#modifyModal #name").val();

	if (cd.length <= 0){alert('코드를 입력해 주세요.'); return;}
	if (pcd.length <= 0){alert('상위코드를 입력해 주세요.'); return;}
	if (name.length <= 0){alert('업종명을 입력해 주세요.'); return;}
	if (confirm('수정하시겠습니까?') != true) return;

	if (!fn_numCheck(cd, pcd)) {
		alert("코드와 상위코드는 숫자(11자리)만 가능합니다.");
		return;
	}

	$.ajax({
		type: 'post',
		url : "/pc/industry/modify",
		data : {cd:cd, pcd:pcd, name:name},
        async: true,
		success : function(data)
		{
			var JSONobj = JSON.parse(data);
			var result = JSONobj.result;

			if (result == 1) {
				alert("수정되었습니다.");
			} else {
				alert("수정실패! 관리자에게 문의하시기 바랍니다.");
			}
		}
	});
}

//코드 상위코드 숫자 체크
function fn_numCheck(cd, pcd) {
	var numberCheck = /^[0-9]+$/;

	if (!numberCheck.test(cd)) {
		return false;
	}
	if (!numberCheck.test(pcd)) {
		return false;		
	}

	return true;
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
						<input type="text" class="form-control" style="width: 200px;" id="keyword" name="keyword" value="${param.keyword}" onkeydown="fn_submit(event);" maxlength="50" placeholder="업종명"> 
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
								<strong>업종관리</strong>
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
						<th class="text-center client-num" style="width: 100px;">상위코드</th>
						<th class="text-center client-num" style="width: 100px;">레벨</th>
						<th class="text-center client-num" style="width: 300px;">업종명</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${industryList }">
						<tr>
							<td><label><input type="checkbox" name="box" value="${list.cd }"></label></td>
							<td onclick="fn_modify('${list.cd }', '${list.pcd }', '${list.name }');"><fmt:parseNumber integerOnly="true">${list.ROWNUM }</fmt:parseNumber></td>
							<td onclick="fn_modify('${list.cd }', '${list.pcd }', '${list.name }');">${list.cd }</td>
							<td onclick="fn_modify('${list.cd }', '${list.pcd }', '${list.name }');">${list.pcd }</td>
							<td onclick="fn_modify('${list.cd }', '${list.pcd }', '${list.name }');" style="color: ${list.level == 3 ? 'red' : ''}">${list.level }</td>
							<td onclick="fn_modify('${list.cd }', '${list.pcd }', '${list.name }');">${list.name }</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="6" class="text-center">
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
					<h4 class="modal-title">서비스업종 추가</h4>
				</div>
				<div class="modal-body">
					<div class="clearfix">
						<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
							<span class="input-group-addon" id="basic-addon1" style="width: 20%;">코드</span>
							<input type="text" class="form-control" name="cd" id="cd" maxlength="11" placeholder="코드을 입력하세요." style="width: 100%;">
						</div>
						<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
							<span class="input-group-addon" id="basic-addon1" style="width: 20%;">상위코드</span>
							<input type="text" class="form-control" name="pcd" id="pcd" maxlength="11" placeholder="상위코드를 입력하세요." style="width: 100%;">
						</div>
						<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
							<span class="input-group-addon" id="basic-addon1" style="width: 20%;">업종명</span>
							<input type="text" class="form-control" name="name" id="name" maxlength="100" placeholder="업종명을 입력하세요." style="width: 100%;">
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
					<h4 class="modal-title">서비스업종 수정</h4>
				</div>
				<div class="modal-body">
					<div class="clearfix">
						<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
							<span class="input-group-addon" id="basic-addon1" style="width: 20%;">코드</span>
							<input type="text" class="form-control" name="cd" id="cd" maxlength="11" placeholder="코드을 입력하세요." style="width: 100%;" readonly="readonly">
						</div>
						<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
							<span class="input-group-addon" id="basic-addon1" style="width: 20%;">상위코드</span>
							<input type="text" class="form-control" name="pcd" id="pcd" maxlength="11" placeholder="상위코드를 입력하세요." style="width: 100%;">
						</div>
						<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
							<span class="input-group-addon" id="basic-addon1" style="width: 20%;">업종명</span>
							<input type="text" class="form-control" name="name" id="name" maxlength="100" placeholder="업종명을 입력하세요." style="width: 100%;">
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