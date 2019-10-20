<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<jsp:useBean id="now" class="java.util.Date" />
<html>
<head>
<title>QR관리</title>

<style>
*{text-decoration:none;}
#qrList tbody tr td{vertical-align: middle;}
</style>

<script type="text/javascript" charset="UTF-8">
	$(document).ready(function() {
		$(".colorPic").spectrum({
			preferredFormat: "rgb",
			showInput: true,
			clickoutFiresChange: false,
			chooseText: "선택",
		    cancelText: "닫기"
		});

		$("#loadingModal").on('show.bs.modal', function () {
			$("#currCount").text("0");
			$("#totalCount").text("0");
		});
	});

	//색상표 값 선택시
	function fn_PicChange(obj) {
		var id = "#" + $(obj).attr("id");
		var t = $(id).spectrum("get");
		id = id.replace("Pic", "");
		$(id).val(t.toHexString());
	}

	//색상값 변경시
	function fn_Change(obj) {
		var id = "#" + $(obj).attr("id") + "Pic";
		$(id).spectrum("set", $(obj).val());
	}

	//색상초기화
	function fn_colorReset() {
		var obj = $(".colorPic");
		for (var i=0; i<obj.length; i++) {
			var id = "#" + obj[i].id;
			if (id == "#bgcolorPic") {
				$(id).spectrum("set", "rgb(255, 255, 255)");
			} else {
				$(id).spectrum("set", "rgb(0, 0, 0)");
			}
		}

		var obj2 = $(".colorInput");
		for (var i=0; i<obj2.length; i++) {
			var id2 = "#" + obj2[i].id;
			if (id2 == "#bgcolor") {
				$(id2).val("#FFFFFF");
			} else {
				$(id2).val("#000000");
			}
		}
	}

	//보기페이지 이동
	function fn_viewPage() {
		form.action = "/qr/qr_view";
		form.submit();
	}

	//생성페이지 이동
	function fn_makePage() {
		form.action = "/qr/qr_make";
		form.submit();
	}

	//템플릿 다운로드
	function fn_templete()
	{
		form.action = '/qr/template';
		form.submit();
	}

	//색상변경 버튼
	function fn_color() {
		$("#colorModal").modal({backdrop: "static"});
	}

	//QR 다운로드
	function fn_qrDown() {
		form.action = '/qr/largedown';
		form.submit();
	}

	//파일선택 확장자 확인
	function checkext()
	{
		var thumbext = document.getElementById('file').value;
		thumbext = thumbext.slice(thumbext.indexOf(".") + 1).toLowerCase();
		if(thumbext != "xls")
		{
			alert('템플릿 파일 확장자는 xls여야 합니다.');
			document.getElementById('file').value = '';
			return;
		}
	}

	//생성
	function fn_create() {
		if($("#file").val() <= 0 || $("#file").val() == null || $("#file").val() == "")
		{
			alert('엑셀을 첨부해 주세요.');
			return;
		} else if($("#title").val() <= 0) {
			alert("제목을 입력하세요.");
			return;
		} else if ($("#gen_name").val() <= 0) {
			alert("생성자를 입력하세요.");
			return;
		}

		if(confirm("생성하시겠습니까?") == false) return;

		$("#loadingModal").modal({backdrop: "static"});
		fn_ajaxMake();
	}

	function fn_ajaxMake() {
		var form = $("form")[0];
		var formData = new FormData(form);

		$.ajax({
			type: 'post',
			url : "/qr/largegen",
			processData: false,
			contentType: false,
			data : formData,
	        async: true,
			success : function(data) {

				var JSONobj = JSON.parse(data);
				var result = JSONobj.result;

				if (result == 1) 
				{
		    		var htmlcode = "";
					var startRow = JSONobj.startRow;
					var totalRow = JSONobj.totalRow;
					var filePath = JSONobj.filePath;
        			var qr_config_no = JSONobj.qr_config_no;
					var qrList = JSONobj.qrList;

					if (qrList != null) 
					{
						if (qrList.length > 0) 
						{
							for (var i in qrList) 
							{
		            			var categoryName = qrList[i].categoryName;
		            			var gen_name = qrList[i].gen_name;
		            			var data = qrList[i].data;
		            			var rownum = qrList[i].rownum;
		            			var image = qrList[i].image;
		            			var active = (parseInt(rownum)%2==1) ? " class=\"active\"" : "";

		            			htmlcode += "<tr" + active + ">";
		            			htmlcode += "<td>" + rownum + "</td>";
		            			htmlcode += "<td>";
		           				htmlcode += "<div style=\"width: 100px;\">"
			           			htmlcode += "<img src=\"" + image + "\" onload=\"resize(this)\">";
			           			htmlcode += "</div>"
			           			htmlcode += "</td>";
		            			htmlcode += "<td>" + categoryName + "</td>";
		            			htmlcode += "<td>" + data + "</td>";
		            			htmlcode += "<td>" + gen_name + "</td>";
		            			htmlcode += "</tr>";
							}
							$(htmlcode).appendTo("#qrList > tbody");
						}
					}
					
					$("#startRow").val(startRow);
					$("#totalRow").val(totalRow);
					$("#filePath").val(filePath);
		    		$("#qr_config_no").val(qr_config_no);
		    		$("#currCount").text(parseInt(startRow) - 1);
		    		$("#totalCount").text(parseInt(totalRow) - 1);

		    		if (parseInt(startRow) != 1 && parseInt(startRow) >= parseInt(totalRow)) 
					{
						$("#loadingModal").modal("hide");
						$(".btnCreate").attr("disabled", true);
						$(".btnQrColor").attr("disabled", true);
						$(".btnQrDown").attr("disabled", false);
					}
					else 
					{
						fn_ajaxMake();
					}
				}
				else 
				{
					$("#startRow").val("0");
					$("#totalRow").val("0");
					$("#filePath").val("");
		    		$("#qr_config_no").val("0");
					alert("엑셀 데이터를 확인해 주세요.");
					$("#loadingModal").modal("hide");
				}
			}
		});
	}

	function resize(img)
	{
		// 원본 이미지 사이즈 저장
	   	var width = img.width;
	   	var height = img.height;
	 
	   	// 가로, 세로 최대 사이즈 설정
	   	var maxWidth = 100;   // 원하는대로 설정. 픽셀로 하려면 maxWidth = 100  이런 식으로 입력
	   	var maxHeight = 100;   // 원래 사이즈 * 0.5 = 50%
	 
	   	// 가로가 세로보다 크면 가로는 최대사이즈로, 세로는 비율 맞춰 리사이즈
	   	if(width > height)
	   	{
	 	  	resizeWidth = maxWidth;
	 	  	resizeHeight = (height * resizeWidth) / width;
	   		// 세로가 가로보다 크면 세로는 최대사이즈로, 가로는 비율 맞춰 리사이즈
	   	}
	   	else
	   	{
	      	resizeHeight = maxHeight;
	      	resizeWidth = (width * resizeHeight) / height;
	    }
	   	// 리사이즈한 크기로 이미지 크기 다시 지정
	   	img.width = resizeWidth;
	   	img.height = resizeHeight;
	}

</script>

</head>
<body>
	<form id="form" method="post" enctype="multipart/form-data">
		<input type="hidden" id="startRow" name="startRow" value="0">
		<input type="hidden" id="totalRow" name="totalRow" value="0">
		<input type="hidden" id="filePath" name="filePath" value="">
		<input type="hidden" id="qr_config_no" name="qr_config_no" value="0">
		<div class="container subnav subnav-top">
			<div class="subnavcontainer">
				<div class="pull-left margin-r-10" style="margin-left: -15px;">
					<div class="input-group input-group-sm pull-left" style="width: 700px;">
						<input type="file" class="form-control" name="file" id="file" style="width:100%; padding-top: 3px;" onchange="checkext();"/>
					</div>
				</div>
				<div class="pull-left margin-r-10">
					<button class="btn btn-danger wd100 btn-sm pull-left btnQrColor" type="button" onclick="fn_color()">색상변경</button>
				</div>
				<div class="pull-left">
					<button class="btn btn-info wd100 btn-sm pull-left" type="button" onclick="fn_templete();">템플릿 다운로드</button>
				</div>
			</div>
		</div>

		<div class="container subnav subnav-bottom">
			<div class="subnavcontainer">
				<div class="pull-left" style="margin-left: -15px;">
					<div class="input-group input-group-sm pull-left margin-r-10" style="width: 445px;">
						<span class="input-group-addon" id="basic-addon1" style="width: 100px;">제목</span> 
						<input type="text" class="form-control" name="title" id="title" maxlength="100" placeholder="제목을 입력하세요.">
					</div>
				</div>
				<div class="pull-left margin-r-10">
					<div class="input-group input-group-sm pull-left" style="width: 245px;">
						<span class="input-group-addon" id="basic-addon1" style="width: 100px;">생성자</span> 
						<input type="text" class="form-control" name="gen_name" id="gen_name" value="${sessionScope.USER_NICKNAME }" maxlength="16" placeholder="생성자를 입력하세요." readonly="readonly">
					</div>
				</div>
				<div class="pull-left margin-r-10">
					<button class="btn btn-info wd100 btn-sm btn-danger btnCreate" type="button" onclick="fn_create()">생성</button>
				</div>
				<div class="pull-left">
					<button class="btn btn-info wd100 btn-sm btn-primary btnQrDown" type="button" onclick="fn_qrDown();" disabled="disabled">QR 다운로드</button>
				</div>
			</div>
		</div>

		<div class="container margin-t-10 cntbox radiall" style="padding:20px 20px 0 20px;">
			<div class="pull-left center-block" style="width:100%;">
		    	<div class="btn-group center-block center-block text-center" style="width:100%;">
		        	<button type="button" class="btn btn-default navbar-btn wd100" style="width: 33%;" onclick="fn_viewPage()">보기</button>
		            <button type="button" class="btn btn-default navbar-btn wd100" style="width: 33%;" onclick="fn_makePage();">생성</button>
		            <button type="button" class="btn btn-primary navbar-btn wd100" style="width: 33%;">대량생성</button>  
		        </div>
			</div>
			<div>
		 		<div class="pull-left">
				<h4 class="pull-left" style="margin-bottom:30px;">
		        <strong>생성 리스트</strong>
		        </h4>
		    	</div>
			</div>
			<table class="table table-hover text-center" id="qrList">
				<thead>
					<tr>
						<th class="text-center client-n" style="width: 10%;">번호</th>
						<th class="text-center client-num" style="width:15%;">QR 이미지</th>
						<th class="text-center client-num" style="width:10%;">구분</th>
						<th class="text-center client-num" style="width:50%;">데이터</th>
						<th class="text-center client-num" style="width:15%;">담당자</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	
		<!-- 생성 진행상황 MODAL -->
		<div id="loadingModal" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<h2 class="modal-title" align="center">등록중</h2>
					</div>
					<div class="modal-body" align="center">
						<div><h3>현재:<span id="currCount">0</span> / 총:<span id="totalCount"></span></h3></div>
			  			<div><h3>※ 대량의 데이터는 시간이 다소 소요 됩니다.</h3></div>
					</div>
				</div>
			</div>
		</div>
	
		<!-- 색상 MODAL -->
		<div id="colorModal" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h2 class="modal-title" align="center">QR코드 색상변경</h2>
					</div>
					<div class="modal-body" align="center" style="height: 170px;">
						<div>
							<div class="input-group pull-left margin-t-10" style="width: 39%;">
								<span class="input-group-addon" id="basic-addon1" style="width: 135px;">배경색</span>
								<input type="text" class="form-control colorInput" id="bgcolor" name="bgcolor" value="#FFFFFF" onchange="fn_Change(this)" maxlength="7">
							</div>
							<div class="input-group pull-left margin-r-10" style="width: 10%; margin-top: 12px;">
								<input class="colorPic" type="text" id="bgcolorPic" name="bgcolorPic" value="rgb(255, 255, 255)" onchange="fn_PicChange(this)">
							</div>
							<div class="input-group pull-left margin-t-10" style="width: 39%;">
								<span class="input-group-addon" id="basic-addon1" style="width: 135px;">셀색</span> 
								<input type="text" class="form-control colorInput" id="fgcolor" name="fgcolor" value="#000000" onchange="fn_Change(this)" maxlength="7">
							</div>
							<div class="input-group pull-left" style="width: 10%; margin-top: 12px;">
								<input class="colorPic" type="text" id="fgcolorPic" name="fgcolorPic" value="rgb(0, 0, 0)" onchange="fn_PicChange(this)">
							</div>
							<div class="input-group pull-left margin-t-10" style="width: 39%;">
								<span class="input-group-addon" id="basic-addon1" style="width: 135px;">왼쪽 상단 싱크색</span> 
								<input type="text" class="form-control colorInput" id="ltcolor" name="ltcolor" value="#000000" onchange="fn_Change(this)" maxlength="7">
							</div>
							<div class="input-group pull-left margin-r-10" style="width: 10%; margin-top: 12px;">
								<input class="colorPic" type="text" id="ltcolorPic" name="ltcolorPic" value="rgb(0, 0, 0)" onchange="fn_PicChange(this)">
							</div>
							<div class="input-group pull-left margin-t-10" style="width: 39%;">
								<span class="input-group-addon" id="basic-addon1" style="width: 135px;">왼쪽 하단 싱크색</span> 
								<input type="text" class="form-control colorInput" id="lbcolor" name="lbcolor" value="#000000" onchange="fn_Change(this)" maxlength="7">
							</div>
							<div class="input-group pull-left" style="width: 10%; margin-top: 12px;">
								<input class="colorPic" type="text" id="lbcolorPic" name="lbcolorPic" value="rgb(0, 0, 0)" onchange="fn_PicChange(this)">
							</div>
							<div class="input-group pull-left margin-t-10" style="width: 39%;">
								<span class="input-group-addon" id="basic-addon1" style="width: 135px;">오른쪽 상단 싱크색</span> 
								<input type="text" class="form-control colorInput" id="rtcolor" name="rtcolor" value="#000000" onchange="fn_Change(this)" maxlength="7">
							</div>
							<div class="input-group pull-left margin-r-10" style="width: 10%; margin-top: 12px;">
								<input class="colorPic" type="text" id="rtcolorPic" name="rtcolorPic" value="rgb(0, 0, 0)" onchange="fn_PicChange(this)">
							</div>
						</div>
					</div>
					<div class="modal-footer" style="text-align: center;">
						<button type="button" class="btn btn-primary" onclick="fn_colorReset()">색상초기화</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</form>

</body>
</html>