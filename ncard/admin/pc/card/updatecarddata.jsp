<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HiddentagBiz</title>
<style>
*{text-decoration:none;}
li {list-style:none; text-decoration:none; float:left;}
</style>
<script type="text/javascript">
$(document).ready(function() {
	// 메뉴 설정
	fn_menuDisplay();

	// 메뉴 Active
	fn_menuActive();

	// 수정 성공 여부
	var msgvar = "${res}";
	if(msgvar == 'success')
	{
		var category = "${data.category}";
		var card_master_no = "${data.card_master_no}";
		var lang = "${data.lang}";
		alert('수정되었습니다.');
		location.href = "/pc/card/getcarddata?category="+category+"&card_master_no="+card_master_no+"&lang="+lang;
	}
	else if(msgvar == 'fail')
	{
		alert('수정 실패하였습니다.');
	}
});

// 수정
function fn_update() {
	if(confirm('수정하시겠습니까?') != true) return;

	$("#form").attr("action", "/pc/card/updatecarddata");
	$("#form").submit();
}

// 메뉴 클릭
function fn_move(lang) {
	$("#lang").val(lang);
	$("#form").attr("action", "/pc/card/getcarddata");
	$("#form").submit();
}

// 이미지 수정
function fn_updateimage() {
	if ($("#file").val().length <= 0) {
		alert('이미지를 첨부해 주세요.'); return;
	}
	if(confirm('이미지를 수정하시겠습니까?') != true) return;

	$("#formimage").attr("action", "/pc/card/updateimage");
	$("#formimage").submit();
}

function fn_menuDisplay() {
	//언어 메뉴 설정
	if ("${data.info.ko}" != "1") {
		$("#menu_ko").attr("style", "display:none");
	}
	if ("${data.info.en}" != "1") {
		$("#menu_en").attr("style", "display:none");
	}
	if ("${data.info.cn}" != "1") {
		$("#menu_cn").attr("style", "display:none");
	}
	if ("${data.info.jp}" != "1") {
		$("#menu_jp").attr("style", "display:none");
	}
}

function fn_menuActive() {
	$("#menu_" + "${data.info.lang}").addClass("active");	
}

function resize(img)
{
	// 원본 이미지 사이즈 저장
   	var width = img.width;
   	var height = img.height;
 
   	// 가로, 세로 최대 사이즈 설정
   	var maxWidth = 150;   // 원하는대로 설정. 픽셀로 하려면 maxWidth = 100  이런 식으로 입력
   	var maxHeight = 150;   // 원래 사이즈 * 0.5 = 50%
 
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

<body style="overflow: hidden;">
	<nav class="navbar navbar-default navbar-fixed-top sd-n">
		<div class="container">
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li onclick="fn_move('ko');" id="menu_ko"><a href="javascript:void(0)">한글</a></li>
					<li onclick="fn_move('en');" id="menu_en"><a href="javascript:void(0)">ENG</a></li>
					<li onclick="fn_move('cn');" id="menu_cn"><a href="javascript:void(0)">中文</a></li>
					<li onclick="fn_move('jp');" id="menu_jp"><a href="javascript:void(0)">日文</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container-fluid cntbox radiall width:100%;" style="padding-top:60px;">
		<div class="clearfix margin-t-10" style="margin-bottom: 30px;">
			<div class="clearfix">
				<form id="formimage" method="post" enctype="multipart/form-data">
					<input type="hidden" id="category2" name="category" value="${data.info.category}">
					<input type="hidden" id="lang2" name="lang" value="${data.info.lang}">
					<input type="hidden" id="card_master_no2" name="card_master_no" value="${data.info.no}">
					<input type="hidden" id="image" name="image" value="${data.info.image}">
					<div class="input-group input-group pull-left margin-t-10" style="width:60%;">
						<img src="${data.info.imagepath}" onload="resize(this)">
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width:100%;">
						<input type="file" class="form-control" name="file" id="file" style="width:49%; background-color:#eee; margin-right: 22px;"/>
						<button type="button" class="btn" style= "width:10%; border:1px solid #ccc; border-radius:2px;" onclick="fn_updateimage();">이미지 수정</button>
					</div>
				</form>
				<form id="form" method="post">
					<input type="hidden" id="category" name="category" value="${data.info.category}">
					<input type="hidden" id="lang" name="lang" value="${data.info.lang}">
					<input type="hidden" id="card_master_no" name="card_master_no" value="${data.info.no}">
					<input type="hidden" id="data_no" name="data_no" value="${data.info.data_no}">
					<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="t_name" style="width: 20%;">이름</span> 
						<input type="text" class="form-control" name="name" id="name" maxlength="16" style="width: 100%;" value="${data.info.name}">
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="t_part" style="width: 20%;">부서</span> 
						<input type="text" class="form-control" name="part" id="part" maxlength="64" style="width: 100%;" value="${data.info.part}">
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="t_position" style="width: 20%;">직급</span> 
						<input type="text" class="form-control" name="position" id="position" maxlength="64" style="width: 100%;" value="${data.info.position}">
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="t_duty" style="width: 20%;">직책</span> 
						<input type="text" class="form-control" name="duty" id="duty" maxlength="64" style="width: 100%;" value="${data.info.duty}">
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
						<span class="input-group-addon" id="t_address" style="width: 10%;">주소</span> 
						<input type="text" class="form-control" name="address" id="address" maxlength="128" style="width: 100%;" value="${data.info.address}">
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="t_email" style="width: 20%;">메일</span> 
						<input type="text" class="form-control" name="email" id="email" maxlength="26" style="width: 100%;" value="${data.info.email}">
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="t_tel" style="width: 20%;">전화</span> 
						<input type="text" class="form-control" name="tel" id="tel" maxlength="20" style="width: 100%;" value="${data.info.tel}">
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="t_fax" style="width: 20%;">팩스</span> 
						<input type="text" class="form-control" name="fax" id="fax" maxlength="20" style="width: 100%;" value="${data.info.fax}">
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="t_mobile" style="width: 20%;">모바일</span> 
						<input type="text" class="form-control" name="mobile" id="mobile" maxlength="20" style="width: 100%;" value="${data.info.mobile}">
					</div>
				</form>
			</div>
			<div class="input-group input-group pull-right" style="width: 100%; margin-top: 20px; margin-bottom: 100%;">
				<button type="button" class="btn btn-primary btn-m wd100 pull-right" onClick="fn_update();">수정</button>
			</div>
		</div>
	</div>

</body>
</html>