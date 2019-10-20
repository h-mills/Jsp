<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<script language="javascript" src="/common/js/util.js"></script>
<title>회원사정보변경</title>
<link href="/common/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/common/bootstrap-select-1.12.4/css/bootstrap-select.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="/common/bootstrap-select-1.12.4/js/bootstrap-select.min.js"></script>
<link rel="stylesheet" href="/common/css/pop.css" rel="stylesheet">
<style>
*{margin:0; padding:0; list-style:none; text-decoration:none;}
.container-fluid {width:700px;}
.captcha {width:45%; float:left; display:block;}
.half {width:45%; float:right; display:block; margin-top:10px; margin-left:10px;}
</style>
<script type="text/javascript">
function onRegistSubmit()
{
	var v = grecaptcha.getResponse();
	if(v.length == 0)
	{
		alert('"로봇이 아닙니다."를 체크해 주세요'); return;
	}
	
	if(document.getElementById('bizfile').value.length <= 0) {alert('사업자 등록증을 선택해 주세요.'); return;}
	if(document.getElementById('ceo').value.length <= 0){alert('대표자명을 입력해 주세요.'); return;}
	if(document.getElementById('number_first').value.length <= 0){alert('대표번호를 입력해 주세요.'); return;}
	if(document.getElementById('number_middle').value.length <= 0){alert('대표번호를 입력해 주세요.'); return;}
	if(document.getElementById('number_last').value.length <= 0){alert('대표번호를 입력해 주세요.'); return;}
	if(document.getElementById('fax_first').value.length <= 0){alert('팩스번호를 입력해 주세요.'); return;}
	if(document.getElementById('fax_middle').value.length <= 0){alert('팩스번호를 입력해 주세요.'); return;}
	if(document.getElementById('fax_last').value.length <= 0){alert('팩스번호를 입력해 주세요.'); return;}
	if(document.getElementById('address').value.length <= 0){alert('주소를 입력해 주세요.'); return;}
	if(document.getElementById('st_industry').selectedIndex <= 0){alert('서비스업종을 선택해 주세요.'); return;}
	
	if(confirm('수정하시겠습니까?') == false) return;
	loadsubmit();
}

function onCancel()
{
	if(confirm('취소하시겠습니까?') == false) return;
	window.open('about:blank','_self').self.close();
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
    
	xmlhttp.open('POST', '/pc/login/companymodifysubmit', true);
	var formData = new FormData();
	var bizfile = document.getElementById('bizfile');
	var ceo = document.getElementById('ceo').value;
	var onenumber = document.getElementById('number_first').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('number_middle').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('number_last').value.replace(/(^\s*)|(\s*$)/gi, "");
	var fax = document.getElementById('fax_first').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('fax_middle').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('fax_last').value.replace(/(^\s*)|(\s*$)/gi, "");
	var address = document.getElementById('address').value;
	var st_industry = document.getElementById('st_industry');
	var st_industrys = new Array();
	for (var i=0; i<st_industry.length; i++) {
		if (st_industry.options[i].selected) {
			st_industrys.push(st_industry.options[i].value);
		}
	}
		
	formData.append('bizfile', bizfile.files[0]);
	formData.append('ceo', ceo);
	formData.append('tel', onenumber);
	formData.append('fax', fax);
    formData.append('address', address);
    formData.append('st_industry', st_industrys);
    
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
    			window.open('about:blank','_self').self.close();
    		}
    		else
    		{
    			alert('수정에 실패하였습니다.');
    		}
		}
    }
}
//주소 검색
function openmap() {
	window.open("/pc/order/jusopop","pop","width=600, height=420, left=500px; top=200px;");
}
function jusoCallBack(roadFullAddr){
	// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
	document.getElementById('addrbtn').value="변경 취소";
	document.getElementById('address').value=roadFullAddr;
	$('#addrbtn').attr('onclick','addr_standard()');
}
function addr_standard(){
	document.getElementById('address').value='${data.info.address}';
	$('#addrbtn').val("주소 검색");
	$('#addrbtn').attr('onclick','openmap()');
}
</script>

<script src='https://www.google.com/recaptcha/api.js'></script>
</head>

<body>
	<form method="post" name="frm" enctype="multipart/form-data">
		<input type="hidden" id="idcheck" name="idcheck" value="0"/>
		<input type="hidden" id="biznumbercheck" name="biznumbercheck" value="0"/>
		<input type="hidden" id="existcompany" name="biznumbercheck" value="0"/>
		<div class="container-fluid">
			<h4 class="" style="display:block;margin:20px 0px 20px 0;"><img src="/img/png/glyphicons-4-user.png" width="18" alt="">&nbsp;&nbsp;<strong>회원사정보 수정</strong></h4>
			<div class="panel panel-default pull-left" style="width:100%;">
            	<div class="panel-heading" style="padding:5px 10px"><h4>회원사정보<small>&nbsp;&nbsp;모든 항목을 입력해 주세요</small></h4></div>
				  <ul class="list-group">
                    <li class="list-group-item" style="height:85px;">
						<p><strong>사업자등록번호</strong></p>
						 <div class="clearfix margin-b-10">
							<div class="pull-left">
							<input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:31%;" name="biz_first" id="biz_first" maxlength="3" value="${data.info.biz_first }" readonly="readonly" disabled="disabled"/>
							<input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:31%;" name="biz_middle" id="biz_middle" maxlength="2" value="${data.info.biz_middle }" readonly="readonly" disabled="disabled"/>
							<input type="text" class="form-control input-sm pull-left text-center" style="width:31%;" name="biz_last" id="biz_last" maxlength="5" value="${data.info.biz_last }" readonly="readonly" disabled="disabled"/>
							</div>
						 </div>
                    </li>
                    <li class="list-group-item clearfix">
						<p><strong>업체명</strong></p>
						<input type="text" class="form-control" name="company" id="company" maxlength="32" value="${data.info.name }" readonly="readonly" disabled="disabled"/>
                    </li>
                    <li class="list-group-item" style="height:86px;">
						<p><strong>사업자등록증</strong></p>
						<div class="clearfix margin-b-10">
							<input type="file" class="form-control" name="bizfile" id="bizfile">
						</div>
                    </li>
                    <li class="list-group-item clearfix">
						<div class="input-group pull-left" style="width: 49%;">
							<p><strong>서비스업종</strong></p>
							<select class="form-control selectpicker" name="st_industry" id="st_industry" multiple title="업종 선택" data-selected-text-format="count > 1" data-size="12" data-live-search="true" data-live-search-placeholder="검색" data-width="310px">
								<c:forEach var="list" items="${data.industryList }">
									<c:choose>
										<c:when test="${list.level == '1' }">
											<optgroup label="${list.name }">
										</c:when>
										<c:when test="${list.level == '2' }">
											<option value="${list.cd }" disabled>${list.name }</option>
										</c:when>
										<c:otherwise>
											<option value="${list.cd }" title="${list.name }" ${list.select=="1"?"selected":""}>&nbsp;&nbsp;&nbsp;${list.name }</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
                    	</div>
                    	<div class="input-group pull-right" style="width: 49%;">
							<p><strong>대표자명</strong></p>
							<input type="text" class="form-control" name="ceo" id="ceo" maxlength="16" value="${data.info.ceo }"/>
						</div>
                    </li>
                    <li class="list-group-item clearfix">
						<p><strong>대표번호</strong></p>
						<input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:32%;" name="number_first" id="number_first" maxlength="3" value="${data.info.tel_first }"/>
						<input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:32%;" name="number_middle" id="number_middle" maxlength="4" value="${data.info.tel_middle }"/>
						<input type="text" class="form-control input-sm pull-left text-center" style="width:31%;" name="number_last" id="number_last" maxlength="4" value="${data.info.tel_last }"/>
					</li>
					<li class="list-group-item clearfix">
						<p><strong>FAX</strong></p>
						<input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:32%;" name="fax_first" id="fax_first" maxlength="3" value="${data.info.fax_first }"/>
						<input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:32%;" name="fax_middle" id="fax_middle" maxlength="4" value="${data.info.fax_middle }"/>
						<input type="text" class="form-control input-sm pull-left text-center" style="width:31%;" name="fax_last" id="fax_last" maxlength="4" value="${data.info.fax_last }"/>
                    </li>
                    <li class="list-group-item clearfix">
						<p><strong>사업장주소</strong></p>
						<input type="text" class="form-control pull-left" style="width: 85%;" name="address" id="address" maxlength="128" value="${data.info.address }"/>
						<input type="button" id="addrbtn" name="addrbtn" class="btn btn-standard" style="width: 15%;" value="주소 검색" onclick="openmap();">
                    </li>
                  </ul>
        	</div>
        </div>
		<div class="container-fluid">
			<div class="captcha" style="width: 100%; top: 0; margin-left: -24px; padding: 0;">
				<div class="g-recaptcha" data-sitekey="6Lf7BRcUAAAAAMuKP2fxFpXPNgjfX_xy1sXKT6Yr" style="width: 100%; top: 0; margin-left: 25px; padding: 0;"></div>
				<noscript>
					<div>
						<div style="width: 302px; height: 422px; position: relative;">
							<div style="width: 302px; height: 422px; position: absolute;">
								<iframe src="https://www.google.com/recaptcha/api/fallback?k=6Lf7BRcUAAAAAMuKP2fxFpXPNgjfX_xy1sXKT6Yr" frameborder="0" scrolling="no" style="width: 302px; height: 422px; border-style: none;"> </iframe>
							</div>
						</div>
						<div style="width: 300px; height: 60px; border-style: none; bottom: 12px; left: 25px; margin: 0px; padding: 0px; right: 25px; background: #f9f9f9; border: 1px solid #c1c1c1; border-radius: 3px;">
							<textarea id="g-recaptcha-response" name="g-recaptcha-response" class="g-recaptcha-response" style="width: 250px; height: 40px; border: 1px solid #c1c1c1; margin: 10px 25px; padding: 0px; resize: none;"></textarea>
						</div>
					</div>
				</noscript>
			</div>
		</div>
		<div class="container-fluid" style="margin-top: 20px;">
			<button type="button" class="confirm btn btn-primary btn-m wd100" onclick="onCancel();">취소</button>
			<button type="button" class="btn btn-default btn-m wd100" onclick="onRegistSubmit();">수정</button>
		</div>
	</form>
</body>
</html>