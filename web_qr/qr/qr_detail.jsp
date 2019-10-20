<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<jsp:useBean id="now" class="java.util.Date" />
<jsp:useBean id="sysdate" class="java.util.Date"/>
<fmt:formatDate value="${sysdate }" pattern="HH:mm:ss" var="sysdate"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>QR 상세보기</title>
    <style>
*{text-decoration:none;}
	</style>

<script type="text/javascript">
var currentCa = "";
$(document).ready(function() {
	var no = "${masterno}";
	var pageNum = "${data.pageNum}";
	$(".colorPic").spectrum({
		preferredFormat: "rgb",
		showInput: true,
		clickoutFiresChange: false,
		chooseText: "선택",
	    cancelText: "닫기"
	});
	if("${data.info.category}" == null || "${data.ca}" == null) {
		$('#category2').val(1);
		$("#ca").val(1);
	} else {
		$('#category2').val("${data.info.category}");
		var c = $('#category2').val("${data.info.category}");
	}
});

// qr 타입 변경
function resize(img)
	{
		// 원본 이미지 사이즈 저장
	   	var width = img.width;
	   	var height = img.height;
	 
	   	// 가로, 세로 최대 사이즈 설정
	   	var maxWidth = 200;   // 원하는대로 설정. 픽셀로 하려면 maxWidth = 100  이런 식으로 입력
	   	var maxHeight = 200;   // 원래 사이즈 * 0.5 = 50%
	 
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
function fn_filedown() {
	frm.action="/qr/filedown";
	frm.submit(); 
	/* var form = $("#frm")[0];
	var formData = new FormData(form);

	$.ajax({
		type: 'post',
		url : "/qr/filedown",
		processData: false,
		contentType: false,
		data : formData,
        async: true,
		success : function(data) {

			var JSONobj = JSON.parse(data);
			var result = JSONobj.result;
			if (result == 'fail') 
			{
				alert("다운로드 할 파일이 없습니다.");
			}else{
				alert("완료");
			}
		}
	}); */
}
function changesubmit(c){
	currentCa = (currentCa == ""?${data.info.category}:currentCa); 
	if(c != currentCa){
		if(c==1) urlClear();
		else if(c==2) emailClear();
		else if(c==3) gpsClear();
		else if(c==4) telClear();
		else if(c==5) smsClear();
		else if(c==6) namecardClear();
		else if(c==7) messageClear();
	}
	var i = 0;
	for(i = 1; i <= 7; i++)
	{
		var id = "jspDiv"+parseInt(i);
		var optdiv = document.getElementById(id);
		if(i == c)
		{
			optdiv.style.display="block";
		}
		else
		{
			optdiv.style.display="none";
		}
	}
}
// qr 데이터 수정
function update(num) {
	if(num == 1) urlMix();
	else if(num == 2) emailMix();
	else if(num == 3) gpsMix();
	else if(num == 4) telMix();
	else if(num == 5) faxMix();
	else if(num == 6) nameCardMix();
	else if(num == 7) updateMessage();
	var no = document.getElementById('no').value;
	if (document.getElementById('data').value.length <= 0 && num != 5) {alert("데이터를 입력하세요"); return;}
	if (document.getElementById('data').value.length <= 0 && num == 5) { return;}
	if (confirm('수정 하시겠습니까?') != true) return;
	fn_update();
}
function fn_update() {
	var form = $("#frm")[0];
	var formData = new FormData(form);

	$.ajax({
		type: 'post',
		url : "/qr/update",
		processData: false,
		contentType: false,
		data : formData,
        async: true,
		success : function(data) {

			var JSONobj = JSON.parse(data);
			var result = JSONobj.result;
			currentCa = JSONobj.ca;
			if (result == 'success') 
			{
				alert("수정 되었습니다.");
			}
			else 
			{
				alert("수정에 실패 했습니다.");
			}
		}
	});
}
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
			$(id).spectrum("set", "#FFFFFF");
		} else {
			$(id).spectrum("set", "#000000");
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
function fn_color() {
	$("#colorModal").modal({backdrop: "static"});
}
function fn_updateImage() {
	if (confirm('QR 이미지를 수정 하시겠습니까?') != true) return;
	
	fn_upImage();
}
function fn_upImage(){
	var form = $("#frm")[0];
	var formData = new FormData(form);

	$.ajax({
		type: 'post',
		url : "/qr/updateImage",
		processData: false,
		contentType: false,
		data : formData,
        async: true,
		success : function(data) {

			var JSONobj = JSON.parse(data);
			var result = JSONobj.result;
			var masterno = JSONobj.masterno;
			if (result == 'success') 
			{
				var date = new Date();
				var imagePath = $("#qrImage").attr("src");
				$("#qrImage").attr("src", imagePath + "?" + date.getTime());
				alert("이미지가 수정 되었습니다.");
				fn_colorReset();
			}
			else 
			{
				alert("수정에 실패 했습니다.");
			}
		}
	});
}
function gotoList() {
	frm.action="/qr/qr_view";
	frm.submit();
}
</script>

</head>
<body>
	<form id="frm" method="post">
		<input type="hidden" id="no" name="no" value="${data.info.no }"/>
		<input type="hidden" id="category2" name="category2" value="0">
		<input type="hidden" id="pageNum" name="pageNum" value="${data.pageNum }">
		<input type="hidden" id="data" name="data" value="">
		<input type="hidden" id="imagePath" name="imagePath" value="/${ data.info.image}">
		<div class="container cntbox radiall" style="padding:20px 20px 0 20px; margin-bottom:30px;">
			<div class="inbox">
				<div class="clearfix margin-b-10 margin-t-10">
					<div class="pull-left" style="position:relative; top:-2px;">
						<div class="input-group input-group-m">
							<h4 class="pull-left"><strong>QR 상세보기</strong></h4>
						</div>
					</div>
				</div>
			</div>
			<div class="inbox">
				<div class="clearfix margin-b-10 margin-t-10">
					<div class="pull-right" style="position:relative; top:-2px;">
						<div class="input-group input-group-m">
							<button class="btn btn-info" type="button"onclick="gotoList()" style="width: 100%;">목록으로</button>
						</div>
					</div>
				</div>
			</div>
			<div class="clearfix margin-t-10" style="margin-bottom:30px;">
				<div class="clearfix">
					<div class="input-group input-group pull-left margin-t-10" style="width:100%;">
						<span class="input-group-addon" id="basic-addon1" style="width:80px;">제목</span>
						<input type="text" id="title2" name="title2" class="form-control"style="width:100%;" value="${data.info.title }"  readonly="readonly">
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width:100%;">
						<span class="input-group-addon" id="basic-addon1" style="width:80px;">생성자</span>
						<input type="text"  id="gen_name" name="gen_name" class="form-control"style="width:100%;" value="${data.info.gen_name }" readonly="readonly">
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width:100%;">
						<span class="input-group-addon" id="basic-addon1" style="width:80px;">생성타입</span>
						<input value="1"  type="radio" onclick="changesubmit(1)" name="ca" id="ca" style="width:3%;" ${data.info.category==1?'checked':'' }>URL
						<input value="2"  type="radio" onclick="changesubmit(2)" name="ca" id="ca" style="width:3%;" ${data.info.category==2?'checked':'' }>EMAIL
						<input value="3"  type="radio" onclick="changesubmit(3)" name="ca" id="ca" style="width:3%;" ${data.info.category==3?'checked':'' }>GPS
						<input value="4"  type="radio" onclick="changesubmit(4)" name="ca" id="ca" style="width:3%;" ${data.info.category==4?'checked':'' }>전화번호
						<input value="5"  type="radio" onclick="changesubmit(5)" name="ca" id="ca" style="width:3%;" ${data.info.category==5?'checked':'' }>SMS
						<input value="6"  type="radio" onclick="changesubmit(6)" name="ca" id="ca" style="width:3%;" ${data.info.category==6?'checked':'' }>명함
						<input value="7"  type="radio" onclick="changesubmit(7)" name="ca" id="ca" style="width:3%;" ${data.info.category==7?'checked':'' }>메시지
					</div>
					<div id="qrImageDiv" class="input-group input-group pull-left margin-t-10">
						<span class="input-group-addon" id="basic-addon1" style="width:80px;">생성된 QR 이미지</span>
						<img src="/${data.info.image }?${sysdate}" id="qrImage" onload="resize(this)">
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width:100%;">
						<button type="button" class="btn btn-primary btn-m" onclick="fn_color()" style="width: 10%; margin-right: 1%;">색 설정</button>
						<button type="button" class="btn btn-primary btn-m" onclick="fn_updateImage()" style="width: 13%; margin-right: 1%;">이미지 수정</button>
						<button type="button" class="btn btn-primary btn-m" onclick="fn_filedown()" style="width: 15%;">이미지 다운로드</button>
					</div>
					<c:if test="${data.info.category != 0 }">
					<div id="jspDiv1" style="display: ${data.info.category==1?'':'none'}">
					<c:import url="/WEB-INF/jsp/pc/qr/url.jsp"></c:import>
					</div>
					<div id="jspDiv2" style="display: ${data.info.category==2?'':'none'}">
					<c:import url="/WEB-INF/jsp/pc/qr/email.jsp"></c:import>
					</div>
					<div id="jspDiv3" style="display: ${data.info.category==3?'':'none'}">
					<c:import url="/WEB-INF/jsp/pc/qr/gps.jsp"></c:import>
					</div>
					<div id="jspDiv4" style="display: ${data.info.category==4?'':'none'}">
					<c:import url="/WEB-INF/jsp/pc/qr/tel.jsp"></c:import>
					</div>
					<div id="jspDiv5" style="display: ${data.info.category==5?'':'none'}">
					<c:import url="/WEB-INF/jsp/pc/qr/fax.jsp"></c:import>
					</div>
					<div id="jspDiv6" style="display: ${data.info.category==6?'':'none'}">
					<c:import url="/WEB-INF/jsp/pc/qr/namecard.jsp"></c:import>
					</div>
					<div id="jspDiv7" style="display: ${data.info.category==7?'':'none'}">
					<c:import url="/WEB-INF/jsp/pc/qr/message.jsp"></c:import>
					</div>
					</c:if>
				</div>
			</div><!--.clearfix margin-t-10-->
		</div>
		<!-- 색상표 -->
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
								<input class="colorPic" type="text" id="bgcolorPic" name="bgcolorPic" value="#FFFFFF" onchange="fn_PicChange(this)">
							</div>
							<div class="input-group pull-left margin-t-10" style="width: 39%;">
								<span class="input-group-addon" id="basic-addon1" style="width: 135px;">셀색</span> 
								<input type="text" class="form-control colorInput" id="fgcolor" name="fgcolor" value="#000000" onchange="fn_Change(this)" maxlength="7">
							</div>
							<div class="input-group pull-left" style="width: 10%; margin-top: 12px;">
								<input class="colorPic" type="text" id="fgcolorPic" name="fgcolorPic" value="#000000" onchange="fn_PicChange(this)">
							</div>
							<div class="input-group pull-left margin-t-10" style="width: 39%;">
								<span class="input-group-addon" id="basic-addon1" style="width: 135px;">왼쪽 상단 싱크색</span> 
								<input type="text" class="form-control colorInput" id="ltcolor" name="ltcolor" value="#000000" onchange="fn_Change(this)" maxlength="7">
							</div>
							<div class="input-group pull-left margin-r-10" style="width: 10%; margin-top: 12px;">
								<input class="colorPic" type="text" id="ltcolorPic" name="ltcolorPic" value="#000000" onchange="fn_PicChange(this)">
							</div>
							<div class="input-group pull-left margin-t-10" style="width: 39%;">
								<span class="input-group-addon" id="basic-addon1" style="width: 135px;">왼쪽 하단 싱크색</span> 
								<input type="text" class="form-control colorInput" id="lbcolor" name="lbcolor" value="#000000" onchange="fn_Change(this)" maxlength="7">
							</div>
							<div class="input-group pull-left" style="width: 10%; margin-top: 12px;">
								<input class="colorPic" type="text" id="lbcolorPic" name="lbcolorPic" value="#000000" onchange="fn_PicChange(this)">
							</div>
							<div class="input-group pull-left margin-t-10" style="width: 39%;">
								<span class="input-group-addon" id="basic-addon1" style="width: 135px;">오른쪽 상단 싱크색</span> 
								<input type="text" class="form-control colorInput" id="rtcolor" name="rtcolor" value="#000000" onchange="fn_Change(this)" maxlength="7">
							</div>
							<div class="input-group pull-left margin-r-10" style="width: 10%; margin-top: 12px;">
								<input class="colorPic" type="text" id="rtcolorPic" name="rtcolorPic" value="#000000" onchange="fn_PicChange(this)">
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