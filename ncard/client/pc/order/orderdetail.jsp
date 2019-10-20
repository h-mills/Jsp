<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주문등록</title>
<link href="/common/treegrid/css/jquery.treegrid.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>var tquery = jQuery.noConflict();</script>
<script src="/common/treegrid/js/jquery.treegrid.min.js"></script>
<style>
* {text-decoration: none;}
#typeDiv .tooltip.in {opacity: 1.0;}
.tooltip-inner {max-width: none;white-space: nowrap;}
#typeDiv .tooltip-inner {max-width: none;white-space: nowrap; border-radius: 50px; padding: 0 0 0 0;}

</style>

<script type="text/javascript">
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
	
	$("#q_ordercnt").tooltip({title: "[${data.info.name}]에서 발주한 총 횟수", placement: "top"});
	$("#exceldownload").tooltip({title: "업로드한 주문 엑셀을 다운로드 및 수정 할 수 있습니다.", placement: "top"});
	$("#dstip").tooltip({title: "오른쪽 파일박스를 클릭하여 업로드한 디자인 템플릿을 다운로드 받을 수 있습니다.", placement: "top"});
	$("#typetip").tooltip({title: "각 타입 글자에 마우스를 올리면 정보를 확인하실 수 있습니다.", placement: "top"});
	$("#typetip_normal").tooltip({title: typetip_normal, html: true, placement: "top"});
	$("#typetip_wide").tooltip({title: typetip_wide, html: true, placement: "top"});
	$("#typetip_micro").tooltip({title: typetip_micro, html: true, placement: "top"});
	$("#typetip_microwide").tooltip({title: typetip_microwide, html: true, placement: "top"});
	$("#q_status").tooltip({title: str, html: true, placement: "top"});
});

function checkext(obj, index)
{
	var thumbext = obj.value;
	thumbext = thumbext.slice(thumbext.indexOf(".") + 1).toLowerCase();
	if(thumbext != "xls")
	{
		alert('템플릿 파일 확장자는 xls여야 합니다.');
		obj.value = '';
		return;
	}
}
function  refresh() {
	if(confirm("수정 작업을 취소하시겠습니까?") == false) return;
	else{location.reload();}
}
function onReady(step)
{
	if(step == 0)
	{
		if(confirm('수정 하시겠습니까?') == false) return;
		document.getElementById('title').readOnly = false;
		document.getElementById('tel_first').readOnly = false;
		document.getElementById('tel_middle').readOnly = false;
		document.getElementById('tel_last').readOnly = false;
		document.getElementById('email').readOnly = false;
		document.getElementById('address').readOnly = false;
		document.getElementById('recvDate').disabled = false;
		document.getElementById('check_ko').disabled = false;
		document.getElementById('check_en').disabled = false;
		document.getElementById('check_cn').disabled = false;
		document.getElementById('check_jp').disabled = false;
		document.getElementById('content').readOnly = false;
		document.getElementById('modify').value = "확인";
		document.getElementById('modify').setAttribute('onclick', 'onReady(1)');
		document.getElementById('cancel').value = "수정 취소";
		document.getElementById('cancel').setAttribute('onclick', 'refresh()');
		document.getElementById('addrbtn').disabled = false;
		var obj = document.getElementsByName('dstype');
		for(var i=0; i<obj.length; i++ ) {
			obj[i].disabled = false;
		}

		var fileDivhtml = "";
		fileDivhtml += '<span class="input-group-addon" id="basic-addon1" style="width:80px; border:1px solid #ccc; border-radius:2px;">디자인 템플릿';
		fileDivhtml += '<a href="javascript:void(0);" id="dstip">';
		fileDivhtml += '<img src="/img/png/glyphicons-195-circle-question-mark.png" style="width: 16px;">';
		fileDivhtml += '</a>';
		fileDivhtml += '</span>';
		fileDivhtml += '<input type="file" style="width: 70%;" id="dsfile" name="dsfile" class="form-control input-sm" onchange="fn_dsfilecheck(this)">';
		fileDivhtml += '<div style="margin-top: 3px;">';
		fileDivhtml += '<input type="checkbox" onclick="fn_dsno(0)" style="margin-left: 5px;" id="dsno" name="dsno" value="1">수정안함';
		fileDivhtml += '</div>';
		$("#fileDiv").html(fileDivhtml);
	}
	else
	{
		var cnt = 0;
		var fileobj = $(".filenameclass");
		
		for (var i=0; i<fileobj.length; i++) {
			if (fileobj[i].text != "-") {
				++cnt;
			}
		}
		if(document.getElementById('title').value.length <= 0){alert('제목을 입력해 주세요.'); return;}
		if(document.getElementById('tel_first').value.length <= 0){alert('연락처를 입력해 주세요.'); return;}
		if(document.getElementById('tel_middle').value.length <= 0){alert('연락처를 입력해 주세요.'); return;}
		if(document.getElementById('tel_last').value.length <= 0){alert('연락처를 입력해 주세요.'); return;}
		if(document.getElementById('email').value.length <= 0){alert('메일주소를 입력해 주세요.'); return;}
		if(document.getElementById('address').value.length <= 0){alert('배송주소를 입력해 주세요.'); return;}
		if(document.getElementById('dsfile').value.length <= 0 &&
				document.getElementById('dsno').value==1){alert('디자인 템플릿을 업로드 해주세요.'); return;}
		if(cnt <= 0){alert('엑셀을 첨부해 주세요.'); return;}
		if(document.getElementById('check_ko').chekced ==  false
		&& document.getElementById('check_en').chekced ==  false
		&& document.getElementById('check_cn').chekced ==  false
		&& document.getElementById('check_jp').chekced ==  false){alert('언어를 선택해 주세요.'); return;}
		if(confirm("수정을 진행합니다.") == false) return;
		loadsubmit();
	}
}

function golist() 
{
	frm.action = "/pc/order/order";
	frm.submit();
}

function setCancel()
{
	if(confirm("주문을 취소하시겠습니까?") == false) return;
	
	cancelsubmit();
}

function registreply()
{
	if(document.getElementById('replycontent').value.length <= 0){alert('내용을 입력해 주세요.'); return;}
	if(document.getElementById('replycontent').value.length >= 100){alert('100자 이내로 입력해 주세요.'); return;}
	if(confirm('등록 하시겠습니까?') == false) return;
	replysubmit();
}

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
	var orderno = document.getElementById('orderno').value;
	var title = document.getElementById('title').value;
	var tel = document.getElementById('tel_first').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('tel_middle').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('tel_last').value.replace(/(^\s*)|(\s*$)/gi, "");
	var email = document.getElementById('email').value;
	var recvdate = document.getElementById('recvDate').value;
	var address = document.getElementById('address').value;
	var pagenum = document.getElementById('pagenum').value;
	var content = document.getElementById('content').value;
	var dsfile = document.getElementById('dsfile');
	var radiocheck = false;
	
	var obj = document.getElementsByName('dstype');
	for(var i=0; i<obj.length; i++ ) {
		if(obj[i].checked) {
			radiocheck = i;
			break;
		}
	}
	
	var language = 0;
	if(document.getElementById('check_ko').checked == true) language += 8;
	if(document.getElementById('check_en').checked == true) language += 4;
	if(document.getElementById('check_cn').checked == true) language += 2;
	if(document.getElementById('check_jp').checked == true) language += 1;
		
	formData.append('category',radiocheck);
	formData.append('title', title);
	formData.append('tel', tel);
	formData.append('email', email);
	formData.append('recvdate', recvdate);
    formData.append('address', address);
    formData.append('pagenum', pagenum);
    formData.append('language', language);
    formData.append('content', content);
    formData.append('orderno', orderno);
    if(dsfile.value.length>0){
    	formData.append('dsfile',dsfile.files[0]);
    }
    //formData.append('category', obj[radiocheck].value);    
    
    xmlhttp.open('POST', '/pc/order/updateorder', true);
	xmlhttp.send(formData);
	xmlhttp.onreadystatechange=function()
    {
    	if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
    		var JSONobj = JSON.parse(xmlhttp.responseText);
    		var result = JSONobj.result;
    		if(result == '1')
    		{
    			alert('갱신되었습니다.');
    			frm.action = '/pc/order/order';
    			frm.submit(); 
    		}
    		else
    		{
    			alert('수정을 다시 진행해주세요.');
    		}
		}
    }
}

function cancelsubmit()
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
	var orderno = document.getElementById('orderno').value;
		
	formData.append('orderno', orderno);    
    
    xmlhttp.open('POST', '/pc/order/cancelorder', true);
	xmlhttp.send(formData);
	xmlhttp.onreadystatechange=function()
    {
    	if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
    		var JSONobj = JSON.parse(xmlhttp.responseText);
    		var result = JSONobj.result;
    		if(result == '1')
    		{
    			alert('취소되었습니다.');
    			frm.action = '/pc/order/order';
    			frm.submit(); 
    		}
    		else
    		{
    			alert('다시 진행해주세요.');
    		}
		}
    }
}

function replysubmit()
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
	var orderno = document.getElementById('orderno').value;
	var content = document.getElementById('replycontent').value;
	
    formData.append('content', content);
    formData.append('orderno', orderno);    
    
    xmlhttp.open('POST', '/pc/order/replysubmit', true);
	xmlhttp.send(formData);
	xmlhttp.onreadystatechange=function()
    {
    	if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
    		var JSONobj = JSON.parse(xmlhttp.responseText);
    		var result = JSONobj.result;
    		if(result == '1')
    		{
    			alert('등록 되었습니다.');
    			var table = document.getElementById("replytable");
    			var row = table.insertRow(1);
    			var cell1 = row.insertCell(0);
    			var cell2 = row.insertCell(1);
    			var cell3 = row.insertCell(2);
    			var cell4 = row.insertCell(3);
    			   			
    			cell1.innerHTML = '고객님';
    			cell2.innerHTML = JSONobj.content;
    			cell3.innerHTML = JSONobj.regdate;
    			cell4.innerHTML = '';
    			document.getElementById('replycontent').value = '';
    		}
    		else
    		{
    			alert('수정을 다시 진행해주세요.');
    		}
		}
    }
}

function fn_xlsdown(filepath)
{
	if(filepath == '-'){
		alert("해당 부서의 명함 엑셀이 없습니다.");
		return false;
	}else{
		document.getElementById('file').value = filepath;
		frm.action = '/pc/order/exceldown';
		frm.submit();
	}
}
// 엑셀 파일 수정
function xlsupdate(cd){
	var file = document.getElementById('updatefile'+cd);
	if(file.value.length <= 0){
		alert("수정할 파일을 업로드 해주세요");
		return false;
	}else{
		if(confirm('엑셀 파일을 수정 하시겠습니까?') == false) return;
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
	    var orderno = document.getElementById('orderno').value;
	    
	    formData.append('cd', cd);    
	    formData.append('updatefile',file.files[0]);
	    formData.append('orderno',orderno);
	    xmlhttp.open('POST', '/pc/order/xlsupdate', true);
		xmlhttp.send(formData);
		xmlhttp.onreadystatechange=function()
	    {
	    	if (xmlhttp.readyState==4 && xmlhttp.status==200)
			{
	    		var JSONobj = JSON.parse(xmlhttp.responseText);
	    		var result = JSONobj.result;
	    		if(result == '1')
	    		{
	    			alert('수정되었습니다.');
	    			$("#span_" + cd).attr("onclick", "fn_xlsdown('" + JSONobj.realpath + "');");
	    			$('#atag_' + cd).text(JSONobj.realpath.substring(JSONobj.realpath.lastIndexOf('/')+1));
	    			document.getElementById('updatefile'+cd).value='';
	    		}
	    		else
	    		{
	    			alert('다시 진행해주세요.');
	    		}
			}
	    }
	}
}
// 주소 검색
function openmap() {
	window.open("/pc/order/jusopop","pop","width=600, height=420, left=500px; top=200px;");
}
function jusoCallBack(roadFullAddr){
	// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
	document.getElementById('addrbtn').value="기존주소로 변경";
	document.getElementById('address').value=roadFullAddr;
	$('#addrbtn').attr('onclick','addr_standard()');
}
function addr_standard(){
	document.getElementById('address').value='${data.info.address}';
	$('#addrbtn').val("주소 검색");
	$('#addrbtn').attr('onclick','openmap()');
}

function fn_dsfiledown(dspath){
	if(dspath == '-' || dspath == null){
		alert("첨부된 디자인 템플릿이 없습니다.");
		return false;
	}else{
		document.getElementById('file').value = dspath;
		frm.action = '/pc/order/dsfiledown';
		frm.submit();
	}
}

function fn_dsfilecheck(obj) {
	var ext = obj.value;
	ext = ext.slice(ext.indexOf(".") + 1).toLowerCase();
	if(ext != "psd" && ext != "ai"){
		alert("psd 혹은 ai 파일만 업로드 해주세요.");
		obj.value = "";
	}
}
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
		<input type="hidden" id="pagenum" name="pagenum" value="${data.pagenum }" />
		<input type="hidden" id="orderno" name="orderno" value="${data.info.no }" />
		<input type="hidden" id="file" name="file" value="" />
		<div class="container margin-t-10 cntbox radiall" style="padding: 20px 20px 0 20px; margin-bottom: 30px; margin-top: 20px;">
			<div class="inbox">
				<div class="clearfix margin-b-10 margin-t-10">
					<div class="pull-left" style="position: relative; top: -2px;">
						<div class="input-group input-group-m">
							<h4 class="pull-left">
								<strong>수정</strong>
							</h4>
						</div>
					</div>
				</div>
			</div>

			<div class="clearfix margin-t-10">
				<div class="clearfix">
					<div class="input-group input-group pull-left margin-t-10" style="width: 100%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 125px;">${data.info.orderth }차
							발주
							<a href="javascript:void(0);" id="q_ordercnt">
								<img src="/img/png/glyphicons-195-circle-question-mark.png" style="width: 16px;">
							</a>
						</span>
						<input type="text" class="form-control" id="title" name="title" value="${data.info.title }" readonly>
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 125px;">업체이름</span>
						<input type="text" class="form-control" value="${data.info.name }" readonly>
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 125px;">주문자</span>
						<input type="text" class="form-control" value="${data.user_id }" readonly>
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 125px;">연락처</span>
						<input type="text" class="form-control" id="tel_first" name="tel_first" maxlength="4" value="${data.info.tel_first}" style="width: 32%;" readonly>
						<input type="text" class="form-control" id="tel_middle" name="tel_middle" maxlength="4" value="${data.info.tel_middle}" style="width: 34%;" readonly>
						<input type="text" class="form-control" id="tel_last" name="tel_last" maxlength="4" value="${data.info.tel_last}" style="width: 34%;" readonly>
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 125px;">메일주소</span>
						<input type="text" class="form-control" id="email" name="email" value="${data.info.email}" readonly>
					</div>
					<div class="input-group input-group pull-left margin-t-10">
						<span class="input-group-addon" id="basic-addon1" style="width: 125px;">배송주소</span>
						<input type="text" class="form-control" style="width: 679px;" id="address" name="address" value="${data.info.address }" readonly>
						<input type="button" class="btn btn-standard" id="addrbtn" name="addrbtn" style="width: 125px;" value="주소 검색" onclick="openmap();" disabled>
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 125px;">배송희망날짜</span>
						<input type="text" class="form-control" id="recvDate" name="recvDate" value="${data.info.recvdate }" disabled="disabled">
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 125px;">
							진행상태
							<a href="javascript:void(0);" id="q_status">
								<img src="/img/png/glyphicons-195-circle-question-mark.png" style="width: 16px;">
							</a>
						</span>
						<c:if test="${data.info.status == '0'}">
							<input type="text" class="form-control" value="주문" readonly="readonly">
						</c:if>
						<c:if test="${data.info.status == '1'}">
							<input type="text" class="form-control" value="접수" readonly="readonly">
						</c:if>
						<c:if test="${data.info.status == '2'}">
							<input type="text" class="form-control" value="제작중" readonly="readonly">
						</c:if>
						<c:if test="${data.info.status == '3'}">
							<input type="text" class="form-control" value="배송중" readonly="readonly">
						</c:if>
						<c:if test="${data.info.status == '4'}">
							<input type="text" class="form-control" value="완료" readonly="readonly">
						</c:if>
						<c:if test="${data.info.status == '5'}">
							<input type="text" class="form-control" value="취소" readonly="readonly">
						</c:if>
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
						<span class="input-group-addon" id="basic-addon1" style="width: 125px; border: 1px solid #ccc; border-radius: 2px;">언어 </span>
						<c:choose>
							<c:when test="${data.info.ko == '1'}">
								<label class="checkbox-inline" style="margin-left: 10px;"> <input type="checkbox" id="check_ko" name="check_ko" value="0" checked disabled />한글</label>
							</c:when>
							<c:otherwise>
								<label class="checkbox-inline" style="margin-left: 10px;"> <input type="checkbox" id="check_ko" name="check_ko" value="0" disabled />한글</label>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${data.info.en == '1'}">
								<label class="checkbox-inline" style="margin-left: 10px;"> <input type="checkbox" id="check_en" name="check_en" value="0" checked disabled />영어</label>
							</c:when>
							<c:otherwise>
								<label class="checkbox-inline" style="margin-left: 10px;"> <input type="checkbox" id="check_en" name="check_en" value="0" disabled />영어</label>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${data.info.cn == '1'}">
								<label class="checkbox-inline" style="margin-left: 10px;"> <input type="checkbox" id="check_cn" name="check_cn" value="0" checked disabled />중국어</label>
							</c:when>
							<c:otherwise>
								<label class="checkbox-inline" style="margin-left: 10px;"> <input type="checkbox" id="check_cn" name="check_cn" value="0" disabled />중국어</label>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${data.info.jp == '1'}">
								<label class="checkbox-inline" style="margin-left: 10px;"> <input type="checkbox" id="check_jp" name="check_jp" value="0" checked disabled />일어</label>
							</c:when>
							<c:otherwise>
								<label class="checkbox-inline" style="margin-left: 10px;"> <input type="checkbox" id="check_jp" name="check_jp" value="0" disabled />일어</label>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width: 49%;" id="fileDiv">
						<span class="input-group-addon" id="basic-addon1" style="width: 125px; border: 1px solid #ccc; border-radius: 2px;">
							디자인 템플릿
							<a href="javascript:void(0);" id="dstip">
								<img src="/img/png/glyphicons-195-circle-question-mark.png" style="width: 16px;">
							</a>
						</span>
						<c:set value="${fn:length(data.info.dsfile) }" var="dslen"></c:set>
						<c:choose>
							<c:when test="${data.info.dsfile == '-' || data.info.dsfile == null}">
								<span class="form-control input-sm filenameclass"> 등록된 디자인 템플릿이 없습니다. </span>
							</c:when>
							<c:otherwise>
								<span style="cursor: pointer" onclick="fn_dsfiledown('${data.info.dsfile}');">
									<a href="#" class="form-control input-sm filenameclass">${fn:substring(data.info.dsfile,23,dslen) }</a>
								</span>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="input-group input-group pull-left margin-t-10" style="width: 49%;">
						<button type="button" class="btn" id="exceldownload" name="exceldownload" style="width: 125px; border: 1px solid #ccc; border-radius: 2px;" onclick="excelmodal();">
							주문 엑셀 확인
							<img src="/img/png/glyphicons-195-circle-question-mark.png" style="width: 16px;">
						</button>
					</div>
					<div class="input-group input-group pull-right margin-t-10" style="width:49%;">
						<span class="input-group-addon" id="basic-addon1" style="width:125px; border:1px solid #ccc; border-radius:2px;">히든태그 타입
							<a href="javascript:void(0);" id="typetip">
								<img src="/img/png/glyphicons-195-circle-question-mark.png" style="width: 16px;">
							</a>
						</span>
						<div style="width: 90%; margin-top: 3px; margin-left: 10px;" id="typeDiv">
							<input type="radio" name="dstype" value="0" ${data.info.category==0?'checked':'' } disabled><span id="typetip_normal" style="cursor: default;"> 타입1</span>
							<input type="radio" name="dstype" value="1" ${data.info.category==1?'checked':'' } disabled><span id="typetip_wide" style="cursor: default;"> 타입2</span>
							<input type="radio" name="dstype" value="2" ${data.info.category==2?'checked':'' } disabled><span id="typetip_micro" style="cursor: default;"> 타입3</span>
							<input type="radio" name="dstype" value="3" ${data.info.category==3?'checked':'' } disabled><span id="typetip_microwide" style="cursor: default;"> 타입4</span>
						</div>
					</div>
					<div class="input-group input-group pull-left" style="width: 100%; margin-bottom: 20px; margin-top: 20px;">
						<p>
							<strong>내용</strong>
						</p>
						<textarea class="form-control" id="content" name="content" rows="3" readonly style="resize: none;">${data.info.content }</textarea>
					</div>
					<div class="input-group input-group pull-left" style="width: 100%; margin-bottom: 20px; margin-top: 20px;">
						<c:if test="${data.info.status == 0 }">
							<input type="button" class="btn btn-default btn-m wd100 pull-left" id="modify" onclick="onReady(0);" value="수정">
							<input type="button" class="btn btn-default btn-m wd100" style="margin-left: 35%;" id="cancel" onclick="setCancel();" value="주문취소">
						</c:if>
						<c:if test="${data.info.status != 0 }">
							<button type="button" class="btn btn-default btn-m wd100 pull-left" onclick="onReady(0);" disabled>수정</button>
							<button type="button" class="btn btn-default btn-m wd100" style="margin-left: 35%;" onclick="setCancel();" disabled>주문취소</button>
						</c:if>
						<button type="button" class="btn btn-default btn-m wd100 pull-right" value="목록" id="list" onclick="golist();">목록</button>
					</div>
				</div>
				<div class="clearfix">
					<div class="input-group input-group pull-left" style="width: 100%; margin-bottom: 20px; margin-top: 20px;">
						<table id="replytable" class="table table-hover text-center table-striped" style="margin-top: 30px;">
							<tr style="height: 30px;">
								<td style="width: 10%;">고객님</td>
								<td style="width: 65%">
									<input type="text" id="replycontent" name="replycontent" style="width: 95%;" placeholder="100자 이내로 입력하세요." />
								</td>
								<td style="width: 10%;">
									<button type="button" class="btn btn-primary btn-m wd100 pull-right" onclick="registreply();">등록</button>
								<td style="width: 10%;"></td>
							</tr>
							<c:if test="${data.list != null}">
								<c:forEach var="list" items="${data.list }">
									<tr style="height: 30px;">
										<td style="width: 10%;">
											<c:if test="${list.isuser == 0}">고객님</c:if>
											<c:if test="${list.isuser == 1}">관리자</c:if>
										</td>
										<td style="width: 65%;">${list.content }</td>
										<td style="width: 10%;">${list.regdate }</td>
										<td style="width: 10%;">${list.ansdate }</td>
									</tr>
								</c:forEach>
							</c:if>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- Modal -->
		<div class="modal fade" id="excelModal" role="dialog" style="width: 100%;">
			<div class="modal-dialog" style="width: 100%;" align="center">
				<div class="modal-content" style="width: 1000px;">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">명함 엑셀 확인</h4>
					</div>
					<div class="modal-body">
						<div class="clearfix">
							<table class="table table-striped tree">
								<thead>
									<tr>
										<th class="text-center client-n" style="width: 65%;">이름</th>
										<th class="text-center client-num" style="width: 5%;">엑셀파일</th>
										<th class="text-center client-num" style="width: 25%;">수정파일</th>
										<th class="text-center client-num" style="width: 5%;">수정</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${data.deptList}" var="list">
										<c:set value="treegrid-parent-${list.parent_cd}" var="pcd"></c:set>
										<c:set value="${fn:length(list.file) }" var="len"></c:set>
										<tr class="treegrid-${list.cd} ${list.cd != 0 ? pcd : ''}">
											<td>${list.name}</td>
											<td align="right">
												<span style="cursor: pointer" id="span_${list.cd }" onclick="fn_xlsdown('${list.file}');">
													<a href="#" class="form-control input-sm filenameclass" id="atag_${list.cd }">${fn:substring(list.file,len-9,len) }</a>
												</span>
											</td>
											<td>
												<input onchange="checkext(this, '${list.cd }');" class="form-control" type="file" id="updatefile${list.cd }" name="updatefile${list.cd }" value="" ${data.info.status==0?'':'disabled' }>
											</td>
											<td>
												<input type="button" class="btn btn-info wd50" value="수정" ${data.info.status==0?'':'disabled' } onclick="xlsupdate('${list.cd}')">
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary btn-m wd100" data-dismiss="modal">닫기</button>
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