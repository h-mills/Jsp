<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주문등록</title>
<style>
*{text-decoration:none;}
#typeDiv .tooltip.in {opacity: 1.0;}
.tooltip-inner {max-width: none;white-space: nowrap;}
#typeDiv .tooltip-inner {max-width: none;white-space: nowrap; border-radius: 50px; padding: 0 0 0 0;}
</style>
<link href="/common/treegrid/css/jquery.treegrid.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>var tquery = jQuery.noConflict();</script>
<script src="/common/treegrid/js/jquery.treegrid.min.js"></script>
<script type="text/javascript">
var flag = 0; // 디자인템플릿 유무 판단 flag
$(document).ready(function(){
	var str = "<h4>* 접수 이후에는 수정 및 취소가 불가합니다.";
	str += "</h4><p align=\"left\">주문 : 주문 신청</p>";
	str += "<p align=\"left\">접수 : 관리자가 주문 접수</p>";
	str += "<p align=\"left\">제작중 : 관리자가 명함 제작중</p>";
	str += "<p align=\"left\">배송중 : 고객에게 배송중</p>";
	var typetip_normal = "<img src='/brand/images/namecard/normal_type.png' style='width:600px; height:190px;'>";
	var typetip_wide = "<img src='/brand/images/namecard/wide_type.png' style='width:600px; height:190px;'>";
	var typetip_micro = "<img src='/brand/images/namecard/micro_type.png' style='width:600px; height:190px;'>";
	var typetip_microwide = "<img src='/brand/images/namecard/microwide_type.png' style='width:600px; height:190px;'>";
	
	$("#dstip").tooltip({title: "명함 디자인시 참고할 파일(.psd/.ai)을 업로드 해주세요.", placement: "top"});
	$("#q_ordercnt").tooltip({title: "[${data.info.name}]에서 발주한 총 횟수", placement: "top"});
	$("#templet").tooltip({title: "템플릿 엑셀을 다운 받아 명함 정보를 입력 후 파일을 업로드 해주세요.", placement: "top"});
	$("#excel").tooltip({title: "클릭하여 조직도에 명함 엑셀을 업로드 해주세요.", placement: "top"});
	$("#typetip").tooltip({title: "각 타입 글자에 마우스를 올리면 정보를 확인하실 수 있습니다.", placement: "top"});
	$("#typetip_normal").tooltip({title: typetip_normal, html: true, placement: "top"});
	$("#typetip_wide").tooltip({title: typetip_wide, html: true, placement: "top"});
	$("#typetip_micro").tooltip({title: typetip_micro, html: true, placement: "top"});
	$("#typetip_microwide").tooltip({title: typetip_microwide, html: true, placement: "top"});
	$("#q_status").tooltip({title: str, html: true, placement: "top"});
});
// 명함 엑셀 확장자 체크
function checkext(obj, index)
{
	var thumbext = obj.value;
	thumbext = thumbext.slice(thumbext.indexOf(".") + 1).toLowerCase();
	if(thumbext != "xls")
	{
		alert('템플릿 파일 확장자는 xls여야 합니다.');
		obj.value = '';
		return;
	}else{
		document.getElementById('isfile').value = document.getElementById('isfile').value + index + ',';
	}
}
// 목록으로
function golist() 
{
	if(confirm('취소하시겠습니까?') == false) return;
	frm.action = '/pc/order/order';
	frm.submit();
}
// 주문데이터 유효성 검사
function onregistsubmit()
{
	if(document.getElementById('title').value.length <= 0){alert('제목을 입력해 주세요.'); return;}
	if(document.getElementById('tel_first').value.length <= 0){alert('연락처를 입력해 주세요.'); return;}
	if(document.getElementById('tel_middle').value.length <= 0){alert('연락처를 입력해 주세요.'); return;}
	if(document.getElementById('tel_last').value.length <= 0){alert('연락처를 입력해 주세요.'); return;}
	if(document.getElementById('email').value.length <= 0){alert('메일주소를 입력해 주세요.'); return;}
	if(document.getElementById('address').value.length <= 0){alert('배송주소를 입력해 주세요.'); return;}
	if(document.getElementById('dsfile').value.length <= 0 &&
			document.getElementById('dsno').value==1){alert('디자인 템플릿을 업로드 해주세요.'); return;}
	if(document.getElementById('check_ko').chekced ==  false
	&& document.getElementById('check_en').chekced ==  false
	&& document.getElementById('check_cn').chekced ==  false
	&& document.getElementById('check_jp').chekced ==  false){alert('언어를 선택해 주세요.'); return;}
	var xlscnt = 0;
	var xlses = document.getElementsByName('excelfile');
	for(var i=0; i<xlses.length; i++){
		if(xlses[i].value.length > 0)
			xlscnt ++;
	}
	if(xlscnt <= 0){alert('명함 엑셀을 업로드 해주세요.'); return;}
	
	if(confirm('주문하시겠습니까?') == false) return;
	
	loadsubmit();
}
// 주문데이터 등록
function loadsubmit()
{
	var xmlhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
    	xmlhttp=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
    	xmlhttp=new ActiveXObject('Microsoft.XMLHTTP');
    }
	var formData = new FormData();
	var title = document.getElementById('title').value;
	var tel = document.getElementById('tel_first').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('tel_middle').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('tel_last').value.replace(/(^\s*)|(\s*$)/gi, "");
	var email = document.getElementById('email').value;
	var recvdate = document.getElementById('distDate').value;
	var address = document.getElementById('address').value;
	var pagenum = document.getElementById('pagenum').value;
	var content = document.getElementById('content').value;
	var orderth = document.getElementById('orderth').value;
	var dsfile = document.getElementById('dsfile');
	var language = 0;
	if(document.getElementById('check_ko').checked == true) language += 8;
	if(document.getElementById('check_en').checked == true) language += 4;
	if(document.getElementById('check_cn').checked == true) language += 2;
	if(document.getElementById('check_jp').checked == true) language += 1;
	var radiocheck = false;
	
	var obj = document.getElementsByName('dstype');
	for(var i=0; i<obj.length; i++ ) {
		if(obj[i].checked) {
			radiocheck = i;
			break;
		}
	}
	formData.append('category',radiocheck);
	formData.append('title', title);
	formData.append('tel', tel);
	formData.append('email', email);
	formData.append('recvdate', recvdate);
    formData.append('address', address);
    formData.append('pagenum', pagenum);
    formData.append('language', language);
    formData.append('content', content);
    formData.append('orderth', orderth);
    if(dsfile.value.length>0){
    	formData.append('dsfile',dsfile.files[0]);
    }
	// order_data
	var excelfile = document.getElementsByName('excelfile');
	var cd = document.getElementsByName("cd");
	var pcd = document.getElementsByName("pcd");
	var dept_no = document.getElementsByName("dept_no");
	var name = document.getElementsByName("name");
	var isfile = document.getElementsByName("isfile");
	 for (var i = 0; i < cd.length; i++) {
		 formData.append('isfile',isfile[i].value);
		 formData.append('cd',cd[i].value);
		 formData.append('pcd',pcd[i].value);
		 formData.append('dept_no',dept_no[i].value);
		 formData.append('name',name[i].value);
         formData.append('excelfile',excelfile[i].files[0]);
     }
    
    xmlhttp.open('POST', '/pc/order/insertorder', true);
	xmlhttp.send(formData);
	xmlhttp.onreadystatechange=function()
    {
    	if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
    		var JSONobj = JSON.parse(xmlhttp.responseText);
    		var result = JSONobj.result;
    		if(result == '1')
    		{
    			alert('주문되었습니다.');
    			frm.action = '/pc/order/order';
    			frm.submit(); 
    		}
    		else
    		{
    			alert('주문을 다시 진행해주세요.');
    		}
		}
    }
}
// 명함 엑셀템플릿 다운로드
function templete()
{
	frm.action = '/pc/order/templete';
	frm.submit();
}
// 엑셀 업로드 완료
function fn_complete(){
	var xlscnt = 0;
	var xlses = document.getElementsByName('excelfile');
	for(var i=0; i<xlses.length; i++){
		if(xlses[i].value.length > 0)
			xlscnt ++;
	}
	if(xlscnt > 0){
		if(confirm('명함 엑셀 업로드를 완료 하시겠습니까?') == false) return;
		else alert("완료 되었습니다.");
		$('#combtn').attr("data-dismiss","modal");
	}else {
		alert("엑셀을 업로드 해주세요");
	}
}
// 명함 엑셀 모든파일 삭제
function fn_xlsdeleteall(){
	if(confirm('모든 명함 엑셀의 업로드를 취소 하시겠습니까?') == false) return;
	else {
		$('#delbtn').attr("data-dismiss","modal");
		for (var i=0; i<document.getElementsByName('excelfile').length; i++) {
			document.getElementsByName('excelfile')[i].value = "";
		}
		alert("취소 되었습니다.");
	}
}
// 명함 엑셀 단일파일 삭제
function fn_xlsdelete(cd, dname){
	var classId = ".treegrid-" + cd;
	var item = $(classId).find('#excelfile').val();
	if(item.length > 0){
		if(confirm(dname+'에 업로드된 파일을 삭제 하시겠습니까?') == false) return;
		$(classId).find('#excelfile').val('');		
	}else{
		alert("삭제할 파일이 없습니다.");
	}
}
// 주소검색
function openmap() {
	window.open("/pc/order/jusopop","pop","width=600, height=420, left=500px; top=200px;");
}
// openmap() 호출 후 callback 함수
function jusoCallBack(roadFullAddr){
	// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록
	document.getElementById('addrbtn').value="기본주소로 변경";
	document.getElementById('address').value=roadFullAddr;
	$('#addrbtn').attr('onclick','addr_standard()');
}
// 기존 주소로 변경
function addr_standard(){
	document.getElementById('address').value='${data.info.address}';
	$('#addrbtn').val("주소 검색");
	$('#addrbtn').attr('onclick','openmap()');
}
// 디자인 템플릿 파일 확장자 체크
function fn_dsfilecheck(obj) {
	var ext = obj.value;
	ext = ext.slice(ext.indexOf(".") + 1).toLowerCase();
	if(ext != "psd" && ext != "ai"){
		alert("psd 혹은 ai 파일만 업로드 해주세요.");
		obj.value = "";
	}
}
// 디자인 템플릿 유/무 선택
function fn_dsno(flag){
	if(flag == 0){
		$('#dsfile').attr('disabled',true);
		$('#dsfile').val('');
		$('#dsno').attr('onclick','fn_dsno(1)');
		$('#dsno').val(0);
	}else {
		$('#dsfile').attr('disabled',false);
		$('#dsno').attr('checked',false);
		$('#dsno').attr('onclick','fn_dsno(0)');
		$('#dsno').val(1);
	}
}
</script>

</head>
<body>
	<form id="frm" method="post" enctype="multipart/form-data">
		<input type="hidden" id="pagenum" name="pagenum" value="${data.pagenum }"/>
		<input type="hidden" id="orderth" name="orderth" value="${data.info.ordercnt+1 }"/>
		<div class="container margin-t-10 cntbox radiall" style="padding:20px 20px 0 20px; margin-bottom:30px;">
			<div class="inbox">
				<div class="clearfix margin-b-10 margin-t-10">
					<div class="pull-left" style="position:relative; top:-2px;">
						<div class="input-group input-group-m">
							<h4 class="pull-left"><strong>등록</strong></h4>
						</div>
					</div>
				</div>
			</div>

			<div class="clearfix margin-t-10">
				<div class="clearfix">	
					<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 125px;">${data.info.ordercnt + 1 }차 발주
							<a href="javascript:void(0);" id="q_ordercnt">
								<img src="/img/png/glyphicons-195-circle-question-mark.png" style="width: 16px;">
							</a>
						</span>
						<input type="text" class="form-control" name="title" id="title" placeholder="예) 회사명 일반 1차">
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width:49%;">
						<span class="input-group-addon" id="basic-addon1" style="width:125px;">업체이름</span>
						<input type="text" class="form-control" value="${data.info.name }" disabled>
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width:49%;">
						<span class="input-group-addon" id="basic-addon1" style="width:125px;">주문자</span>
						<input type="text" class="form-control" value="${data.user_id }" disabled>
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width:49%;">
						<span class="input-group-addon" id="basic-addon1" style="width:125px;">연락처</span>
						<input type="text" class="form-control" id="tel_first" name="tel_first" maxlength="4" style="width: 32%;" value="${data.info.tel_first }">
						<input type="text" class="form-control" id="tel_middle" name="tel_middle" maxlength="4"style="width: 34%;" value="${data.info.tel_middle }">
						<input type="text" class="form-control" id="tel_last" name="tel_last" maxlength="4"style="width: 34%;" value="${data.info.tel_last }">
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width:49%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 125px;">메일주소</span>
						<input type="text" class="form-control" id="email" name="email" value="${data.info.email }">
					</div>
					<div class="input-group input-group pull-left margin-t-10">
						<span class="input-group-addon" id="basic-addon1" style="width: 125px;">배송주소</span>
						<input type="text" class="form-control" style="width: 679px;" id="address" name="address" value="${data.info.address }">
						<input type="button" class="btn btn-standard" id="addrbtn" name="addrbtn" style="width: 125px;" value="주소 검색" onclick="openmap();">
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width:49%;">
						<span class="input-group-addon" id="basic-addon1" style="width:125px;">배송희망날짜</span>
						<input type="text"  class="form-control"id="distDate" name="distDate" style="width: 30%;" size=11 value="${data.today }">
						<span style="color: red;">&nbsp;&nbsp;*디자인 결정 후 1주 정도 소요</span>
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width:49%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 125px;">진행상태
							<a href="javascript:void(0);" id="q_status">
								<img src="/img/png/glyphicons-195-circle-question-mark.png" style="width: 16px;">
							</a>
						</span>
						<input type="text" class="form-control" value="주문" disabled>
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width:49%;">
						<span class="input-group-addon" id="basic-addon1" style="width:125px; border:1px solid #ccc; border-radius:2px;">언어</span>
						<input type="checkbox" style="margin-left: 10px;" name="check_ko" id="check_ko" value="0" checked/> 한글
						<input type="checkbox" style="margin-left: 10px;" name="check_en" id="check_en" value="0"/> 영어
						<input type="checkbox" style="margin-left: 10px;" name="check_cn" id="check_cn" value="0"/> 중국어
						<input type="checkbox" style="margin-left: 10px;" name="check_jp" id="check_jp" value="0"/> 일어
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width:49%;">
						<span class="input-group-addon" id="basic-addon1" style="width:125px; border:1px solid #ccc; border-radius:2px;">디자인 템플릿
							<a href="javascript:void(0);" id="dstip">
								<img src="/img/png/glyphicons-195-circle-question-mark.png" style="width: 16px;">
							</a>
						</span>
						<input type="file" style="width: 80%;" id="dsfile" name="dsfile" class="form-control input-sm" onchange="fn_dsfilecheck(this)">
						<div style="margin-top: 3px;">
							<input type="checkbox" onclick="fn_dsno(0)" style="margin-left: 10px;" id="dsno" name="dsno" value="1">&nbsp;없음
						</div>
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width:49%;">
						<button type="button" class="btn" id="templet" name="templet" style= "width:130px; border:1px solid #ccc; border-radius:2px; padding-left: 5px; padding-right: 5px;" onclick="templete();">템플릿 다운로드 
							<img src="/img/png/glyphicons-195-circle-question-mark.png" style="width: 16px;">
						</button>
						<button type="button" class="btn" id="excel" name="excel" style= "width:135px; margin-left:10px; border:1px solid #ccc; border-radius:2px; padding-left: 5px; padding-right: 5px;" onclick="excelmodal();">명함 엑셀 업로드 
							<img src="/img/png/glyphicons-195-circle-question-mark.png" style="width: 16px;">
						</button>
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width:49%;">
						<span class="input-group-addon" id="basic-addon1" style="width:125px; border:1px solid #ccc; border-radius:2px;">히든태그 타입
							<img src="/img/png/glyphicons-195-circle-question-mark.png" id="typetip" style="width: 16px;">
						</span>
						<div style="width: 90%; margin-top: 3px; margin-left: 10px;" id="typeDiv">
							<input type="radio" name="dstype" value="0"checked><span id="typetip_normal" style="cursor: default;"> 타입1</span>
							<input type="radio" name="dstype" value="1"><span id="typetip_wide" style="cursor: default;"> 타입2</span>
							<input type="radio" name="dstype" value="2"><span id="typetip_micro" style="cursor: default;"> 타입3</span>
							<input type="radio" name="dstype" value="3"><span id="typetip_microwide" style="cursor: default;"> 타입4</span>
						</div>
					</div>
					<div class="input-group input-group pull-left" style="width:100%; margin-bottom:20px; margin-top:20px;">
						<p><strong>내용</strong></p>
						<textarea class="form-control" name="content" id="content" rows="3" placeholder="200자 내외로 입력해주세요." style="resize: none;"></textarea>
					</div>
					<div class="input-group input-group pull-left" style="width:100%; margin-bottom:30px;">
						<button type="button" class="btn btn-default btn-m wd100" onclick="onregistsubmit();">주문</button>
						<button type="button" class="btn btn-default btn-m wd100 pull-right" onclick="golist();">목록</button>
					</div>
				</div>
			</div>
		</div>
		<!-- Modal -->
	<div class="modal fade" id="excelModal" role="dialog" style="width: 100%;">
		<div class="modal-dialog" style="width: 100%;" align="center">
			<div class="modal-content" style="width: 800px;">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">명함 엑셀 업로드</h4>
				</div>
				<div class="modal-body">
					<div class="clearfix">
						<table class="table table-striped tree">
			<thead>
				<tr>
					<th class="text-center client-n" style="width: 70%;">이름</th>
					<th class="text-center client-num" style="width: 25%;">엑셀파일</th>
					<th class="text-center client-num" style="width: 5%;"></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${data.deptList}" var="list">
					<input type="hidden" value="" id="isfile" name="isfile">
					<input type="hidden" value="${list.cd }" id="cd" name="cd">
					<input type="hidden" value="${list.parent_cd }" id="pcd" name="pcd">
					<input type="hidden" value="${list.dept_no }" id="dept_no" name="dept_no">
					<input type="hidden" value="${list.name }" id="name" name="name">
					<c:set value="treegrid-parent-${list.parent_cd}" var="pcd"></c:set>
					<tr class="treegrid-${list.cd} ${list.level != 0 ? pcd : ''}">
						<td>${list.name}</td>
						<td align="right">
							<input type="file" id="excelfile" name="excelfile" onchange="checkext(this, '${list.cd }');">
						</td>
						<td><input type="button" value="x" style="background-color: white; color: red; border: 0" onclick="fn_xlsdelete('${list.cd}','${list.name }');"></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
					</div>
				</div>
				<div class="modal-footer">
					<button id="combtn" type="button" class="btn btn-primary btn-m wd100" onclick="fn_complete();">완료</button>
					<button id="delbtn" type="button" class="btn btn-info btn-m wd100" onclick="fn_xlsdeleteall();">전체취소</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function excelmodal(){
			$("#excelModal").modal();
		};
		(function ($){
			$('.tree').treegrid();
			var rootnode = $('.tree').treegrid('getRoots');
			$(rootnode).treegrid('expand');
		})(tquery)
	</script>
	</form>
</body>
</html>