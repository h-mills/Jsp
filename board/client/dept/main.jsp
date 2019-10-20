<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<link href="/common/treegrid/css/jquery.treegrid.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="/common/js/bootstrap.min.js"></script>
<script src="/common/treegrid/js/jquery.treegrid.min.js"></script>
</head>
<body>
	<div class="container margin-t-10 cntbox radiall" style="padding: 20px 20px 0 20px; margin-top: 20px;">
		<div class="inbox">
			<div class="clearfix margin-b-10">
				<div class="pull-left" style="position: relative; top: -2px;">
					<div class="input-group input-group-sm">
						<h4 class="pull-left" style="display: block; margin: 20px 0 20px 0;">
						<c:if test="${deptList.size() > 1 }">
							<strong>조직도</strong>
						</c:if>
						<c:if test="${deptList.size() <= 1 }">
							<strong>조직도를 생성해 주세요<small><br><br>생성된 조직도는 주문 및 통계서비스에 이용 됩니다.</small></strong>
						</c:if>
						</h4>
					</div>
				</div>
			</div>
		</div>

		<table class="table tree">
			<thead>
				<tr>
					<th class="text-center client-n" style="width: 60%;">이름</th>
					<th class="text-center client-n" style="width: 25%;">직종</th>
					<th class="text-center client-num" style="width: 5%;">추가</th>
					<th class="text-center client-num" style="width: 5%;">수정</th>
					<th class="text-center client-num" style="width: 5%;">삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${deptList}" var="list">
					<c:set value="treegrid-parent-${list.parent_cd}" var="pcd"></c:set>
					<tr class="treegrid-${list.cd} ${list.level != 0 ? pcd : ''}">
						<td>${list.name}</td>
						<td align="center">${list.level != 0 ? list.dept_nm : ''}</td>
						<td>
							<button type="button" class="btn btn-primary btn-sm wd50 addBtn" onclick="fn_addnode('${list.cd}');">추가</button>
						</td>
						<td>
							<button type="button" class="btn btn-success btn-sm wd50 modifyBtn" onclick="fn_modifynode(${list.no}, ${list.cd}, ${list.dept_no});">수정</button>
						</td>
						<td>
							<button type="button" class="btn btn-danger btn-sm wd50 removeBtn" onclick="fn_remove(this, ${list.no});">삭제</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="modifyModal" role="dialog">
		<div class="modal-dialog">

			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">수정</h4>
				</div>
				<div class="modal-body">
					<div class="clearfix">
						<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
							<span class="input-group-addon" id="basic-addon1" style="width: 30%;">부서명</span>
							<input type="text" class="form-control input-sm" id="modalDept" style="width: 100%;">
							<input type="hidden" id="modalNo">
							<input type="hidden" id="modalCd">
						</div>
						<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
							<span class="input-group-addon" id="basic-addon1" style="width: 30%;">직종명</span>
							<select class="form-control input-sm" id="modalJobClass">
								<option value="-1" selected="selected">직종 선택</option>
								<c:forEach items="${Stdept}" var="dept">
									<option value="${dept.no}">${dept.name}</option>
								</c:forEach>
							</select>
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

	<script type="text/javascript">
		$(document).ready(function()
		{
			//node
			$('.tree').treegrid();
			fn_display();
			var rootnode = $('.tree').treegrid('getRoots');
			$(rootnode).treegrid('expand');
		});
		//add node
		function fn_addnode(pcd) {
			fn_addBtnDisabled(1);
			fn_removeBtnDisabled(1);
			fn_modifyBtnDisabled(1);
			var classId = ".treegrid-" + pcd;

			var htmlcode = '<tr><td colspan="5">';
			htmlcode += '<input type="hidden" id="pcd">';
			htmlcode += '<input type="hidden" id="company">';
			htmlcode += '<input type="text" id="nm" style="margin-right: 10px;">';
			htmlcode += '<select class="input-sm" style="margin-right: 10px;" id="stDept"><option value="-1" selected="selected">직종 선택</option>';
			htmlcode += '<c:forEach items="${Stdept}" var="dept">';
			htmlcode += '<option value="${dept.no}">${dept.name}</option>';
			htmlcode += '</c:forEach>';
			htmlcode += '</select>';
			htmlcode += '<button type="button" class="btn btn-primary btn-sm wd50" style="margin-right: 10px;" onclick="fn_submit(this);">저장</button>';
			htmlcode += '<button type="button" class="btn btn-danger btn-sm wd50" onclick="fn_cancel(this);">취소</button></td></tr>';
			htmlcode += '</td></tr>';
			
			$(classId).treegrid('add', [ htmlcode
			]);
			$(classId).treegrid('expand');
			
			$("#pcd").closest("td").nextAll("td").remove();
			$("#pcd").val(pcd);
			$("#company").val("${company_no}");
			$("#nm").focus();
		}

		//remove
		function fn_remove(obj, no) {
			if (confirm('삭제 하시겠습니까?'))
			{
				if ($(obj).closest('tr').treegrid('getChildNodes').length > 0)
				{
					alert("하위 부서를 모두 삭제한 후 시도해주세요.");
					return;
				}

				$.ajax(
				{
					type : 'post',
					url : "/pc/dept/del",
					data :
					{
						no : no
					},
					async : true,
					success : function(data)
					{
						var JSONobj = JSON.parse(data);
						var result = JSONobj.result;

						if (result == 1)
						{
							alert("삭제되었습니다.");
							$(obj).closest('tr').treegrid('remove');
							fn_display();
						}
						else
						{
							alert("삭제실패! 관리자에게 문의하시기 바랍니다.");
						}
					}
				});
			}
		}

		//add subimt
		function fn_submit(obj)
		{
			var pcd = $('#pcd').val();
			var nm = $('#nm').val();
			var stdept = $("#stDept").val();
			var company_no = $("#company").val();
			var stdept_nm = $("#stDept option:selected").text();

			if (nm.length <= 0)
			{
				alert('부서명을 입력해 주세요.');
				return;
			}
			if (stdept < 0)
			{
				alert('직종을 선택해 주세요.');
				return;
			}
			if (!confirm('저장하시겠습니까?'))
				return;

			$.ajax(
			{
				type : 'post',
				url : "/pc/dept/deptsubmit",
				data :
				{
					pcd : pcd,
					nm : nm,
					stdept : stdept,
					company_no : company_no
				},
				async : true,
				success : function(data)
				{
					var JSONobj = JSON.parse(data);
					var no = JSONobj.no;
					var cd = JSONobj.maxcd;
					if (no > 0)
					{
						alert("저장되었습니다.");
						$(obj).closest('tr').treegrid('remove');

						var htmlcode = '<tr class="treegrid-' + cd + ' treegrid-parent-' + pcd + '">';
						htmlcode += '<td>' + nm + '</td>';
						htmlcode += '<td align="center"> ' + stdept_nm + '</td>';
						htmlcode += '<td><button type="button" class="btn btn-primary btn-sm wd50 addBtn" onclick="fn_addnode(\'' + cd + '\');">추가</button></td>';
						htmlcode += '<td><button type="button" class="btn btn-success btn-sm wd50 modifyBtn" onclick="fn_modifynode(' + no + ',' + cd + ',' + stdept + ');">수정</button></td>';
						htmlcode += '<td><button type="button" class="btn btn-danger btn-sm wd50 removeBtn" onclick="fn_remove(this, ' + no + ');">삭제</button></td>';
						htmlcode += '</tr>';
						$(".treegrid-" + pcd).closest('tr').treegrid('add', [ htmlcode
						]);
						fn_addBtnDisabled(0);
						fn_removeBtnDisabled(0);
						fn_modifyBtnDisabled(0);
						fn_display();
					}
					else
					{
						alert("저장실패! 관리자에게 문의하시기 바랍니다.");
					}
				}
			});
		}

		//cancel
		function fn_cancel(obj)
		{
			$(obj).closest('tr').treegrid('remove');
			fn_addBtnDisabled(0);
			fn_removeBtnDisabled(0);
			fn_modifyBtnDisabled(0);
		}

		function fn_display() {
			var rootnode = $('.tree').treegrid('getRoots');
			var nodes = $(rootnode).treegrid('getBranch');
			for (var i=0; i<nodes.length; i++) {
				//remove button display
				if ($(nodes[i]).treegrid('getChildNodes').length > 0 || $(nodes[i]).treegrid('getDepth') == 1) {
					$(nodes[i]).find(".removeBtn").css('display', 'none');
				} else {
					$(nodes[i]).find(".removeBtn").css('display', 'block');
				}
				//add button display
				if ($(nodes[i]).treegrid('getDepth') > 5) {
					$(nodes[i]).find(".addBtn").css('display', 'none');
				} else {
					$(nodes[i]).find(".addBtn").css('display', 'block');
				}
				//modify button display
				if ($(nodes[i]).treegrid('getDepth') == 1) {
					$(nodes[i]).find(".modifyBtn").css('display', 'none');
				} else {
					$(nodes[i]).find(".modifyBtn").css('display', 'block');
				}
				//row color
				switch ($(nodes[i]).treegrid('getDepth'))
				{
					case 1:	$(nodes[i]).addClass("danger"); break;
					case 2:	$(nodes[i]).addClass("default"); break;
					case 3:	$(nodes[i]).addClass("active"); break;
					case 4:	$(nodes[i]).addClass("warning"); break;
					case 5:	$(nodes[i]).addClass("success"); break;
					case 6:	$(nodes[i]).addClass("info"); break;
				}
			}
		}

		function fn_addBtnDisabled(flag)
		{
			if (flag == 1)
			{
				$('.addBtn').attr("disabled", true);
			}
			else
			{
				$('.addBtn').attr("disabled", false);
			}
		}

		function fn_removeBtnDisabled(flag)
		{
			if (flag == 1)
			{
				$('.removeBtn').attr("disabled", true);
			}
			else
			{
				$('.removeBtn').attr("disabled", false);
			}
		}

		function fn_modifyBtnDisabled(flag)
		{
			if (flag == 1)
			{
				$('.modifyBtn').attr("disabled", true);
			}
			else
			{
				$('.modifyBtn').attr("disabled", false);
			}
		}
		
		function fn_modifynode(no, cd, deptno) {
			var classId = ".treegrid-" + cd;
			var deptname = $(classId).find("td:eq(0) > div").text();

			$("#modalNo").val(no);
			$("#modalCd").val(cd);
			$("#modalJobClass").val(deptno);
			$("#modalDept").val(deptname);
			$("#modifyModal").modal();
		}
		
		function fn_modify() {
			var no = $("#modalNo").val();
			var nm = $('#modalDept').val();
			var cd = $("#modalCd").val();
			var stdept = $("#modalJobClass").val();
			var stdept_nm = $("#modalJobClass option:selected").text();

			if (nm.length <= 0)
			{
				alert('부서명을 입력해 주세요.');
				return;
			}
			if (stdept < 0)
			{
				alert('직종을 선택해 주세요.');
				return;
			}
			if (!confirm('수정하시겠습니까?'))
				return;

			$.ajax(
			{
				type : 'post',
				url : "/pc/dept/deptmodify",
				data :
				{
					no : no,
					nm : nm,
					stdept : stdept
				},
				async : true,
				success : function(data)
				{
					var JSONobj = JSON.parse(data);
					var result = JSONobj.result;

					if (result == 1)
					{
						alert("저장되었습니다.");
						var classId = ".treegrid-" + $("#modalCd").val();
						$(classId).find("td:eq(0) > div").text(nm);
						$(classId).find("td:eq(1)").text(stdept_nm);
						$(classId).find("td:eq(3) > button").attr("onclick", "fn_modifynode(" + no + ", " + cd + ", " + stdept + ");");
					}
					else
					{
						alert("저장실패! 관리자에게 문의하시기 바랍니다.");
					}
				}
			});
		}
	</script>

</body>
</html>