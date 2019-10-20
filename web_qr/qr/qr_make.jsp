<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<jsp:useBean id="now" class="java.util.Date" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
<title>QR 생성하기</title>
<style>
*{text-decoration:none;}
</style>

<script type="text/javascript">
$(document).ready(function() {
	$('#category').val(1);
	$(".colorPic").spectrum({
		preferredFormat: "rgb",
		showInput: true,
		clickoutFiresChange: false,
		chooseText: "선택",
	    cancelText: "닫기"
	});
	if("${data.info.category}" == null || "${data.ca}" == null) {
		$("#ca").val(1);
	} else {
		$('#category').val("${data.info.category}");
		var c = $('#category').val("${data.info.category}");
	}
});

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
// qr 타입 변경
function changesubmit(c){
	$('#category').val(c);
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
// qr 데이터 생성
function create(num) {
	if(num == 1) createUrl();
	else if(num == 2) createEmail();
	else if(num == 3) createGps();
	else if(num == 4) createTel();
	else if(num == 5) createFax();
	else if(num == 6) createNamecard();
	else if(num == 7) createMessage();
	if (document.getElementById('title').value.length <= 0) {alert("제목을 입력하세요"); return;}
	if (document.getElementById('data').value.length <= 0 && num != 5) {alert("데이터를 입력하세요"); return;}
	if (document.getElementById('data').value.length <= 0 && num == 5) { return;}
	
	if (confirm('생성 하시겠습니까?') != true) return;

	fn_Make();
}
function fn_Make() {
	var form = $("#frm")[0];
	var formData = new FormData(form);

	$.ajax({
		type: 'post',
		url : "/qr/gen",
		processData: false,
		contentType: false,
		data : formData,
        async: true,
		success : function(data) {

			var JSONobj = JSON.parse(data);
			var result = JSONobj.qr_master_no;
			if (result != null) 
			{
				alert("생성에 성공 했습니다.");
	    		form.action="/qr/detail?masterno="+result;
	    		form.submit();
			}
			else 
			{
				alert("생성에 실패 했습니다.");
			}
		}
	});
}

function fn_largeMake(){
	frm.action = "/qr/largemake";
	frm.submit();
}
function fn_viewPage() {
	frm.action="/qr/qr_view";
	frm.submit();
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
</script>

</head>
<body>
	<form id="frm" method="post">
		<input type="hidden" id="category" name="category" value="0">
		<input type="hidden" id="data" name="data" value="">
		<input type="hidden" id="pageNum" name="pageNum" value="0">
		<div class="container cntbox radiall" style="padding:20px 20px 0 20px; margin-bottom:30px;">
			<div class="pull-left center-block" style="width:100%;">
		    	<div class="btn-group center-block center-block text-center" style="width:100%;">
		        	<button type="button" class="btn btn-default navbar-btn wd100" style="width: 33%;" onclick="fn_viewPage()">보기</button>
		            <button type="button" class="btn btn-primary navbar-btn wd100" style="width: 33%;">생성</button>
		            <button type="button" class="btn btn-default navbar-btn wd100" style="width: 33%;" onclick="fn_largeMake()">대량생성</button>  
		        </div>
			</div>
			<div class="inbox">
				<div class="clearfix margin-b-10 margin-t-10">
					<div class="pull-left" style="position:relative; top:-2px;">
						<div class="input-group input-group-m">
							<h4 class="pull-left"><strong>QR 생성하기</strong></h4>
						</div>
					</div>
				</div>
			</div>
			<div class="clearfix margin-t-10" style="margin-bottom:30px;">
				<div class="clearfix">
					<div class="input-group input-group pull-left margin-t-10" style="width:100%;">
						<span class="input-group-addon" id="basic-addon1" style="width:80px;">제목</span>
						<input type="text" id="title" name="title" class="form-control"style="width:100%;" value="" placeholder="제목을 입력하세요" >
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width:100%;">
						<span class="input-group-addon" id="basic-addon1" style="width:80px;">생성자</span>
						<input type="text" id="gen_name" name="gen_name" class="form-control"style="width:100%;" value="${sessionScope.USER_NICKNAME }" readonly="readonly">
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width:100%;">
						<span class="input-group-addon" id="basic-addon1" style="width:80px;">생성타입</span>
						<input value="1" onclick="changesubmit(1)" type="radio"  name="ca" id="ca1" style="width:3%;" checked="checked">URL
						<input value="2" onclick="changesubmit(2)" type="radio"  name="ca" id="ca2" style="width:3%;">EMAIL
						<input value="3" onclick="changesubmit(3)" type="radio"  name="ca" id="ca3" style="width:3%;">GPS
						<input value="4" onclick="changesubmit(4)"  type="radio"  name="ca" id="ca4" style="width:3%;">전화번호
						<input value="5" onclick="changesubmit(5)"  type="radio"  name="ca" id="ca5" style="width:3%;">SMS
						<input value="6" onclick="changesubmit(6)"  type="radio"  name="ca" id="ca6" style="width:3%;">명함
						<input value="7" onclick="changesubmit(7)"  type="radio"  name="ca" id="ca7" style="width:3%;">메시지
					</div>
					<div class="input-group input-group pull-left margin-t-10">
						<span class="input-group-addon" id="basic-addon1" style="width:80px;">QR 이미지 예시</span>
						<img src="/image/sample.jpg"  id="qrImage" name="qrImage" onload="resize(this)">
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width:100%;">
						<button type="button" class="btn btn-primary btn-m" onclick="fn_color()">색상 설정</button>
					</div>
					<div id="jspDiv1" style="display: block">
					<c:import url="/WEB-INF/jsp/pc/qr/url.jsp"></c:import>
					</div>
					<div id="jspDiv2" style="display: none">
					<c:import url="/WEB-INF/jsp/pc/qr/email.jsp"></c:import>
					</div>
					<div id="jspDiv3" style="display: none">
					<c:import url="/WEB-INF/jsp/pc/qr/cgps.jsp"></c:import>
					</div>
					<div id="jspDiv4" style="display: none">
					<c:import url="/WEB-INF/jsp/pc/qr/tel.jsp"></c:import>
					</div>
					<div id="jspDiv5" style="display: none">
					<c:import url="/WEB-INF/jsp/pc/qr/fax.jsp"></c:import>
					</div>
					<div id="jspDiv6" style="display: none">
					<c:import url="/WEB-INF/jsp/pc/qr/namecard.jsp"></c:import>
					</div>
					<div id="jspDiv7" style="display: none">
					<c:import url="/WEB-INF/jsp/pc/qr/message.jsp"></c:import>
					</div>
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