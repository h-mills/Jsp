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
// 페이지
function pageMove(pageNum) {
	$("#pageNum").val(pageNum);
	form.action = "/pc/member/umain";
	form.submit();
}

//검색
function fn_search() {
	if($('#st_company').val() == -1) {
		alert("업체를 선택하세요.");
		return false;
	}

	form.action = "/pc/member/umain";
	form.submit();
}

function fn_member() {
	location.href="/pc/member/main";
}

//수정창
function fn_userModify(obj, no) {
	var tr = $(obj).parent("tr");
	var company_name = $(tr).find("#company_name").text();
	var id = $(tr).find("#id").text();
	var name = $(tr).find("#name").text();
	var email = $(tr).find("#email").val();
	var mobile = $(tr).find("#mobile").val();
	var mDept = $(tr).find("#level #mDept").is(":checked");
	var mOrder = $(tr).find("#level #mOrder").is(":checked");
	var mNotice = $(tr).find("#level #mNotice").is(":checked");
	var mCard = $(tr).find("#level #mCard").is(":checked");
	var mStats = $(tr).find("#level #mStats").is(":checked");
	$("#modifyModal #m_rownum").val(rownum);
	$("#modifyModal #m_no").val(no);
	$("#modifyModal #m_company_name").val(company_name);
	$("#modifyModal #m_id").val(id);
	$("#modifyModal #m_name").val(name);
	$("#modifyModal #m_mobile").val(mobile);
	$("#modifyModal #m_email").val(email);
	$("#modifyModal #m_dept").prop('checked', mDept ? true : false);
	$("#modifyModal #m_order").prop('checked', mOrder ? true : false);
	$("#modifyModal #m_notice").prop('checked', mNotice ? true : false);
	$("#modifyModal #m_card").prop('checked', mCard ? true : false);
	$("#modifyModal #m_stats").prop('checked', mStats ? true : false);
	$("#modifyModal").modal();
}

function fn_modify() {
	var level = 0;
	var checkboxs = $("#modifyModal").find(":checkbox");
	for (var i=0; i<checkboxs.length; i++) {
		var checkbox = checkboxs[i];
		if ($(checkbox).is(":checked")) {
			level += parseInt($(checkbox).val());
		}
	}
	var no = $("#modifyModal #m_no").val();

	if (no.length <= 0){alert('코드를 확인해 주세요.'); return;}
	if (level <= 0){alert('권한을 선택해 주세요.'); return;}
	if (confirm('수정하시겠습니까?') != true) return;

	$.ajax({
		type: 'post',
		url : "/pc/member/usermodify",
		data : {no:no, level:level},
        async: true,
		success : function(data)
		{
			var JSONobj = JSON.parse(data);
			var result = JSONobj.result;

			if (result == 1) {
				alert("수정되었습니다.");
				fn_parentUpdate();
			} else {
				alert("수정실패! 관리자에게 문의하시기 바랍니다.");
			}
		}
	});
}

function fn_parentUpdate() {
	var no = $("#m_no").val();
	var tr = $("#tr_"+no);
	$(tr).find("#mDept").prop('checked', $("#modifyModal #m_dept").is(":checked") ? true : false);
	$(tr).find("#mOrder").prop('checked', $("#modifyModal #m_order").is(":checked") ? true : false);
	$(tr).find("#mNotice").prop('checked', $("#modifyModal #m_notice").is(":checked") ? true : false);
	$(tr).find("#mCard").prop('checked', $("#modifyModal #m_card").is(":checked") ? true : false);
	$(tr).find("#mStats").prop('checked', $("#modifyModal #m_stats").is(":checked") ? true : false);
}
</script>

</head>
<body>
	<form id="form" method="post" onsubmit="return false;">
		<input type="hidden" id="pageNum" name="pageNum" value="${ pagingValues.pageNum }">
		<div class="container subnav" style="margin-top:20px; border-radius: 5px;">
			<div class="subnavcontainer">
				<div class="font-w pull-left" style="margin: 0 auto;">
					<div class="pull-left margin-r-10" style="width: 200px;">
						<select class="form-control input-sm" name="st_company" id="st_company">
							<option value="0" ${(param.st_company == "0" || param.st_company == null) ? "selected" : ""}>전체</option>
							<c:forEach var="companylist" items="${companyList}">
								<option value="${companylist.no}" ${param.st_company == companylist.no ? "selected" : ""}>${companylist.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="pull-left width-200">
					<div class="input-group input-group-sm">
						<input type="text" class="form-control" style="width: 200px;" id="keyword" name="keyword" value="${param.keyword}" maxlength="20" placeholder="이름"> 
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
					<button type="button" class="btn btn-default navbar-btn wd100" onclick="fn_member();">관리자</button>
					<button type="button" class="btn btn-primary navbar-btn wd100 active">고객</button>
				</div>
			</div>
			<div class="inbox">
				<div class="clearfix margin-b-10">
					<div class="pull-left" style="position: relative; top: -2px;">
						<div class="input-group input-group-sm">
							<h4 class="pull-left"
								style="display: block; margin: 20px 0 20px 0;">
								<strong>사용자관리(고객)</strong>
							</h4>
						</div>
					</div>
				</div>
			</div>
			
			<table class="table table-hover text-center table-striped">
				<thead>
					<tr>
						<th class="text-center client-n" style="width: 50px;">번호</th>
						<th class="text-center client-num" style="width: 150px;">업체명</th>
						<th class="text-center client-num" style="width: 200px;">권한</th>
						<th class="text-center client-num" style="width: 100px;">아이디</th>
						<th class="text-center client-num" style="width: 70px;">이름</th>
						<th class="text-center client-num" style="width: 70px;">등록일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${userList }">
						<tr id="tr_${list.no}">
							<td onClick="fn_userModify(this, '${list.no}');" id="rownum">
								<fmt:formatNumber value="${list.ROWNUM }" type="number"/>
								<input type="hidden" id="email" value="${list.email}">
								<input type="hidden" id="mobile" value="${list.mobile}">
							</td>
							<td onClick="fn_userModify(this, '${list.no}');" id="company_name">${list.company_name }</td>
							<td onClick="fn_userModify(this, '${list.no}');" id="level">
								<label class="checkbox-inline"> <input type="checkbox" ${list.mDept == "1"?"checked":""} disabled="disabled" id="mDept">부서</label> 
								<label class="checkbox-inline"> <input type="checkbox" ${list.mOrder == "1"?"checked":""} disabled="disabled" id="mOrder">주문</label> 
								<label class="checkbox-inline"> <input type="checkbox" ${list.mCard == "1"?"checked":""} disabled="disabled" id="mCard">명함</label> 
								<label class="checkbox-inline"> <input type="checkbox" ${list.mStats == "1"?"checked":""} disabled="disabled" id="mStats">통계</label> 
								<label class="checkbox-inline"> <input type="checkbox" ${list.mNotice == "1"?"checked":""} disabled="disabled" id="mNotice">공지</label>
							</td>
							<td onClick="fn_userModify(this, '${list.no}');" id="id">${list.id }</td>
							<td onClick="fn_userModify(this, '${list.no}');" id="name">${list.name }</td>
							<td onClick="fn_userModify(this, '${list.no}');"><fmt:formatDate value="${list.date }" pattern="yyyy-MM-dd" /></td>
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
		</div>
	</form>

	<!-- Modal -->
	<div class="modal fade" id="modifyModal" role="dialog">
		<div class="modal-dialog">

			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">권한 수정</h4>
				</div>
				<div class="modal-body">
					<div class="clearfix">
						<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
							<span class="input-group-addon" id="basic-addon1" style="width: 20%;">번호</span>
							<input type="text" class="form-control" name="m_no" id="m_no" style="width: 100%;" readonly="readonly">
						</div>
						<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
							<span class="input-group-addon" id="basic-addon1" style="width: 20%;">회사명</span>
							<input type="text" class="form-control" name="m_company_name" id="m_company_name" style="width: 100%;" readonly="readonly">
						</div>
						<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
							<span class="input-group-addon" id="basic-addon1" style="width: 20%;">아이디</span>
							<input type="text" class="form-control" name="m_id" id="m_id" style="width: 100%;" readonly="readonly">
						</div>
						<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
							<span class="input-group-addon" id="basic-addon1" style="width: 20%;">이름</span>
							<input type="text" class="form-control" name="m_name" id="m_name" style="width: 100%;" readonly="readonly">
						</div>
						<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
							<span class="input-group-addon" id="basic-addon1" style="width: 20%;">모바일</span>
							<input type="text" class="form-control" name="m_mobile" id="m_mobile" style="width: 100%;" readonly="readonly">
						</div>
						<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
							<span class="input-group-addon" id="basic-addon1" style="width: 20%;">E-MAIL</span>
							<input type="text" class="form-control" name="m_email" id="m_email" style="width: 100%;" readonly="readonly">
						</div>
						<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
							<span class="input-group-addon" id="basic-addon1" style="width: 20%;">권한</span>
							<label class="checkbox-inline" style="margin-left: 10px;"> <input type="checkbox" id="m_dept" value="16">부서</label>
							<label class="checkbox-inline"> <input type="checkbox" id="m_order" value="1">주문</label> 
							<label class="checkbox-inline"> <input type="checkbox" id="m_card" value="4">명함</label> 
							<label class="checkbox-inline"> <input type="checkbox" id="m_stats" value="8">통계</label> 
							<label class="checkbox-inline"> <input type="checkbox" id="m_notice" value="2">공지</label>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary btn-m wd100" onclick="fn_modify();">수정</button>
					<button type="button" class="btn btn-danger btn-m wd100" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>