<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<!DOCTYPE html >

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>회원가입</title>
<link rel="stylesheet" href="/common/css/bootstrap.min.css"/>
<link rel="stylesheet" href="/common/bootstrap-select-1.12.4/css/bootstrap-select.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="/common/bootstrap-select-1.12.4/js/bootstrap-select.min.js"></script>
<link rel="stylesheet" href="/common/css/pop.css" rel="stylesheet">
<style>
*{margin:0; padding:0; list-style:none; text-decoration:none;}
.container-fluid {width:970px;}
</style>
<script type="text/javascript">
function onRegistSubmit()
{
	var v = document.getElementById('idcheck');
	if(v.value == '0')
	{
		alert('아이디 중복 체크를 해주세요.'); return;
	}
	
	if(document.getElementById('user_pwd').value != document.getElementById('user_pwd_confirm').value)
	{
		alert('비밀번호가 서로 틀립니다.'); return;
	}
	
	v = document.getElementById('biznumbercheck');
	if(v.value == '0')
	{
		alert('사업자 등록번호 중복 체크를 해주세요.'); return;
	}
	
	if(document.getElementById('check_law1').checked == false)
	{
		alert('약관 동의를 진행해 주세요.'); return;
	}
	if(document.getElementById('check_law2').checked == false)
	{
		alert('2');
		alert('약관 동의를 진행해 주세요.'); return;
	}
	
	v = grecaptcha.getResponse();

	if(v.length == 0)
	{
		alert('"로봇이 아닙니다."를 체크해 주세요'); return;
	}
	
	if(document.getElementById('user_id').value.length <= 0){alert('아이디를 입력해 주세요.'); return;}
	if(document.getElementById('user_pwd').value.length <= 0){alert('비밀번호를 입력해 주세요.'); return;}
	if(document.getElementById('user_pwd_confirm').value.length <= 0){alert('비밀번호 확인을 입력해 주세요.'); return;}
	if(document.getElementById('user_name').value.length <= 0){alert('이름을 입력해 주세요.'); return;}
	if(document.getElementById('mobile_first').value.length <= 0){alert('휴대폰 번호를 입력해 주세요.'); return;}
	if(document.getElementById('mobile_middle').value.length <= 0){alert('휴대폰 번호를 입력해 주세요.'); return;}
	if(document.getElementById('mobile_last').value.length <= 0){alert('휴대폰 번호를 입력해 주세요.'); return;}
	if(document.getElementById('tel_first').value.length <= 0){alert('전화 번호를 입력해 주세요.'); return;}
	if(document.getElementById('tel_middle').value.length <= 0){alert('전화 번호를 입력해 주세요.'); return;}
	if(document.getElementById('tel_last').value.length <= 0){alert('전화 번호를 입력해 주세요.'); return;}
	if(document.getElementById('email').value.length <= 0){alert('메일 주소를 입력해 주세요.'); return;}
	
	if(document.getElementById('biz_first').value.length <= 0){alert('사업자 등록번호를 입력해 주세요.'); return;}
	if(document.getElementById('biz_middle').value.length <= 0){alert('사업자 등록번호를 입력해 주세요.'); return;}
	if(document.getElementById('biz_last').value.length <= 0){alert('사업자 등록번호를 입력해 주세요.'); return;}
	if(document.getElementById('company').value.length <= 0){alert('업체명을 입력해 주세요.'); return;}
	if(document.getElementById('existcompany').value == '0')
	{
		if(document.getElementById('bizfile').value.length <= 0) {alert('사업자 등록증을 선택해 주세요.'); return;}
	}
	if(document.getElementById('ceo').value.length <= 0){alert('대표자명을 입력해 주세요.'); return;}
	if(document.getElementById('number_first').value.length <= 0){alert('대표번호를 입력해 주세요.'); return;}
	if(document.getElementById('number_middle').value.length <= 0){alert('대표번호를 입력해 주세요.'); return;}
	if(document.getElementById('number_last').value.length <= 0){alert('대표번호를 입력해 주세요.'); return;}
	if(document.getElementById('fax_first').value.length <= 0){alert('팩스번호를 입력해 주세요.'); return;}
	if(document.getElementById('fax_middle').value.length <= 0){alert('팩스번호를 입력해 주세요.'); return;}
	if(document.getElementById('fax_last').value.length <= 0){alert('팩스번호를 입력해 주세요.'); return;}
	if(document.getElementById('address').value.length <= 0){alert('주소를 입력해 주세요.'); return;}
	if(document.getElementById('st_industry').selectedIndex <= 0){alert('서비스업종을 선택해 주세요.'); return;}
	
	if(confirm('등록하시겠습니까?') == false) return;
	loadsubmit();
}

function onCancel()
{
	if(confirm('취소하시겠습니까?') == false) return;	
	frm.action = '/pc/login/login';
	frm.submit();
}

function idChange() 
{
	document.getElementById('idcheck').value = '0';
}

function idCheck()
{
	if(document.getElementById('user_id').value.length <= 0)
	{
		alert('아이디를 입력해 주세요.'); return;
	}
	loadidCheck();
}

function biznumberChange()
{
	document.getElementById('biznumbercheck').value = '0';
}

function biznumberCheck()
{
	if(document.getElementById('biz_first').value.length <= 0)
	{
		alert('사업자 등록번호를 입력해 주세요.'); return;
	}
	if(document.getElementById('biz_middle').value.length <= 0)
	{
		alert('사업자 등록번호를 입력해 주세요.'); return;
	}
	if(document.getElementById('biz_last').value.length <= 0)
	{
		alert('사업자 등록번호를 입력해 주세요.'); return;
	}
	loadbiznumbercheck();
}

function agreeall()
{
	if(document.getElementById('check_lawall').checked == true)
	{
		document.getElementById('check_law1').checked = true;
		document.getElementById('check_law2').checked = true;
	}
	else
	{
		document.getElementById('check_law1').checked = false;
		document.getElementById('check_law2').checked = false;
	}
}

function fn_nextfocus(obj) {
	var max = $(obj).attr("maxlength");
	var txt = $(obj).val();
	if (max <= txt.length) {
		$(obj).next().focus();
	}
}

function loadidCheck()
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
    
	xmlhttp.open('POST', '/pc/login/idcheck', true);
	var formData = new FormData();
    formData.append('user_id', document.getElementById('user_id').value);
	xmlhttp.send(formData);
	
    xmlhttp.onreadystatechange=function()
    {
    	if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
    		var JSONobj = JSON.parse(xmlhttp.responseText);
    		var user_id = JSONobj.user_id;
    		if(user_id == '-1')
    		{
    			alert('아이디를 입력해 주세요.');    			
    		}
    		else if(user_id == '0')
    		{
    			alert('현재 사용 중인 아이디 입니다.');
    		}
    		else
    		{
    			alert('사용 가능한 아이디 입니다.');
    			document.getElementById('idcheck').value = '1';
    		}
       	}
	};
};

function loadbiznumbercheck()
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
    
	xmlhttp.open('POST', '/pc/login/biznumbercheck', true);
	var formData = new FormData();
	var biznumber = document.getElementById('biz_first').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('biz_middle').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('biz_last').value.replace(/(^\s*)|(\s*$)/gi, ""); 
    formData.append('biznumber', biznumber);
	xmlhttp.send(formData);
	
    xmlhttp.onreadystatechange=function()
    {
    	if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
    		var JSONobj = JSON.parse(xmlhttp.responseText);
    		var biznumber = JSONobj.biznumber;
    		if(biznumber == '-1')
    		{
    			alert('사업자 등록번호를 입력해 주세요.');    			
    		}
    		else if(biznumber == '0')
    		{
    			alert('등록되어 있는 사업자 등록번호 입니다.');
    			var company = JSONobj.company;
    			var ceo = JSONobj.ceo;
    			var number_first = JSONobj.number_first;
    			var number_middle = JSONobj.number_middle;
    			var number_last = JSONobj.number_last;
    			var fax_first = JSONobj.fax_first;
    			var fax_middle = JSONobj.fax_middle;
    			var fax_last = JSONobj.fax_last;
    			var address = JSONobj.address;
    			var file = JSONobj.file;
    			var industry = JSONobj.industryInfo;

    			$('.selectpicker').selectpicker('deselectAll');
    			var st_industry = document.getElementById('st_industry');
    			for (var i=0; i<st_industry.length; i++) {
    				for (var j=0; j<industry.length; j++) {
        				if (st_industry.options[i].value == industry[j].industry_cd) {   
        					console.log(industry[j].industry_cd);    					
        					st_industry.options[i].selected = true;
        				}
    				}
    			}
    			$('.selectpicker').selectpicker('refresh');

    			document.getElementById('company').value = company;
    			document.getElementById('ceo').value = ceo;
    			document.getElementById('number_first').value = number_first;
    			document.getElementById('number_middle').value = number_middle;
    			document.getElementById('number_last').value = number_last;
    			document.getElementById('fax_first').value = fax_first;
    			document.getElementById('fax_middle').value = fax_middle;
    			document.getElementById('fax_last').value = fax_last;
    			document.getElementById('address').value = address;
				document.getElementById('bizfile').value = '';
    			document.getElementById('company').readOnly = true;
    			document.getElementById('ceo').readOnly = true;
    			document.getElementById('bizfile').disabled = true;
    			document.getElementById('biznumbercheck').value = '1';
    			document.getElementById('existcompany').value = '1';
    		}
    		else
    		{
    			alert('확인되었습니다.');
    			if (document.getElementById('existcompany').value == '1') {
    				document.getElementById('company').value = "";
    				document.getElementById('ceo').value = "";
    				document.getElementById('number_first').value = "";
    				document.getElementById('number_middle').value = "";
    				document.getElementById('number_last').value = "";
    				document.getElementById('fax_first').value = "";
    				document.getElementById('fax_middle').value = "";
    				document.getElementById('fax_last').value = "";
    				document.getElementById('address').value = "";
    				document.getElementById('bizfile').value = "";
    				document.getElementById('company').readOnly = false;
    				document.getElementById('ceo').readOnly = false;
    				document.getElementById('bizfile').disabled = false;
    				$('.selectpicker').selectpicker('deselectAll');
    			}
    			document.getElementById('biznumbercheck').value = '1';
    			document.getElementById('existcompany').value = '0';
    		}
       	}
	};
};

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
    
	xmlhttp.open('POST', '/pc/login/registsubmit', true);
	var formData = new FormData();
	var user_id = document.getElementById('user_id').value;
	var user_pwd = document.getElementById('user_pwd').value;
	var user_name = document.getElementById('user_name').value;
	var mobile = document.getElementById('mobile_first').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('mobile_middle').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('mobile_last').value.replace(/(^\s*)|(\s*$)/gi, "");
	var tel = document.getElementById('tel_first').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('tel_middle').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('tel_last').value.replace(/(^\s*)|(\s*$)/gi, "");
	var email = document.getElementById('email').value;
	var biznumber = document.getElementById('biz_first').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('biz_middle').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('biz_last').value.replace(/(^\s*)|(\s*$)/gi, "");
	var company = document.getElementById('company').value;
	var bizfile = document.getElementById('bizfile');
	var ceo = document.getElementById('ceo').value;
	var onenumber = document.getElementById('number_first').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('number_middle').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('number_last').value.replace(/(^\s*)|(\s*$)/gi, "");
	var fax = document.getElementById('fax_first').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('fax_middle').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('fax_last').value.replace(/(^\s*)|(\s*$)/gi, "");
	var address = document.getElementById('address').value;
	var existcompany = document.getElementById('existcompany').value;
	var st_industry = document.getElementById('st_industry');
	var st_industrys = new Array();
	for (var i=0; i<st_industry.length; i++) {
		if (st_industry.options[i].selected) {
			st_industrys.push(st_industry.options[i].value);
		}
	}

	formData.append('user_id', user_id);
	formData.append('user_pwd', user_pwd);
	formData.append('user_name', user_name);
	formData.append('mobile', mobile);
	formData.append('tel', tel);
	formData.append('email', email);
	formData.append('biznumber', biznumber);
	formData.append('company', company);
	formData.append('bizfile', bizfile.files[0]);
	formData.append('ceo', ceo);
	formData.append('onenumber', onenumber);
	formData.append('fax', fax);
    formData.append('address', address);
    formData.append('existcompany', existcompany);
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
    			alert('등록되었습니다.');
    			frm.action = '/pc/login/login';
    			frm.submit(); 
    		}
    		else
    		{
    			alert('등록에 실패하였습니다.');
    		}
		}
    }
}
function openmap() {
	window.open("/pc/login/jusopop","pop","width=600, height=420, left=500px; top=200px;");
}
function jusoCallBack(roadFullAddr){
	// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
	document.getElementById('address').value=roadFullAddr;
	$('#addrbtn').attr('onclick','addr_standard()');
}
</script>

<script src='https://www.google.com/recaptcha/api.js'></script>
</head>

<body>
	<form method="post" name="frm" enctype="multipart/form-data">
		<input type="hidden" id="idcheck" name="idcheck" value="0"/>
		<input type="hidden" id="biznumbercheck" name="biznumbercheck" value="0"/>
		<input type="hidden" id="existcompany" name="existcompany" value="0"/>
		<div class="container-fluid">
			<h4 class="" style="display:block;margin:20px 0px 20px 0;"><img src="/img/png/glyphicons-4-user.png" width="18" alt="">&nbsp;&nbsp;<strong>회원가입</strong></h4>
  
        	<div class="panel panel-default pull-left" style="width:48%;">
            	<div class="panel-heading"  style="padding:5px 10px"><h4>회원정보<small>&nbsp;&nbsp;모든 항목을 입력해 주세요</small></h4></div>
				  <ul class="list-group">
                    <li class="list-group-item clearfix">
						<p><strong>아이디</strong></p>
						<div class="clearfix margin-b-10">
						  <div class="pull-left">
						  	<input type="text" class="form-control" name="user_id" id="user_id" maxlength="16" placeholder="ID"  style="width:310px; float:left;" onchange="idChange();"/>
						  </div>
						  <div class="pull-right">
							<button class="btn btn-primary btn-m wd100 pull-right" type="button" name="user_id_check" id="user_id_check" onclick="idCheck();">중복확인</button>
						  </div>
						 </div>
                    </li>
                    <li class="list-group-item clearfix">
						 <p><strong>비밀번호</strong></p>
						 <input type="password"class="form-control" name="user_pwd" id="user_pwd" maxlength="16"/>
                    </li>
					<li class="list-group-item clearfix">
						<p><strong>비밀번호 확인</strong></p>
						<input type="password" class="form-control" name="user_pwd_confirm" id="user_pwd_confirm" maxlength="16"/>
                    </li>
                    <li class="list-group-item clearfix">
						<p><strong>이름</strong></p>
						<input type="text" class="form-control" name="user_name" id="user_name" maxlength="16"/>
                    </li>
                    <li class="list-group-item clearfix">
						<p><strong>MOBILE</strong></p>
						<input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:32%;"name="mobile_first" id="mobile_first" maxlength="3" onkeyup="fn_nextfocus(this)"/>
						<input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:32%;"name="mobile_middle" id="mobile_middle" maxlength="4" onkeyup="fn_nextfocus(this)"/>
						<input type="text" class="form-control input-sm pull-left text-center" style="width:31%;"name="mobile_last" id="mobile_last" maxlength="4"/>
					<li class="list-group-item clearfix">
						<p><strong>TEL</strong></p>
						<input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:32%;" name="tel_first" id="tel_first" maxlength="4"/>
						<input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:32%;" name="tel_middle" id="tel_middle" maxlength="4"/>
						<input type="text" class="form-control input-sm pull-left text-center" style="width:31%;" name="tel_last" id="tel_last" maxlength="4"/>
                    </li>
                    <li class="list-group-item clearfix">
						<p><strong>EMAIL</strong></p>
						<input type="text" class="form-control input-sm margin-r-10" name="email" id="email" maxlength="26"/>
                    </li>
                  </ul>
        	</div>
			<div class="panel panel-default pull-right" style="width:48%; margin-left:30px;">
            	<div class="panel-heading"  style="padding:5px 10px"><h4>회원사정보<small>&nbsp;&nbsp;모든 항목을 입력해 주세요</small></h4></div>
				  <ul class="list-group">
                    <li class="list-group-item" style="height:95px;">
						<p><strong>사업자등록번호</strong></p>						
							<div class="pull-left">
							<input type="text" class="form-control  pull-left margin-r-10 text-center" style="width:23%;"name="biz_first" id="biz_first" maxlength="3" onchange="biznumberChange();"/>
							<input type="text" class="form-control  pull-left margin-r-10 text-center" style="width:23%;"name="biz_middle" id="biz_middle" maxlength="2" onchange="biznumberChange();"/>
							<input type="text" class="form-control  pull-left text-center" style="width:23%;"name="biz_last" id="biz_last" maxlength="5" onchange="biznumberChange();"/>
							</div>
							<div class="pull-right">
							<button name="biz_num_check" id="biz_num_check" type="button" class="btn btn-primary btn-m wd100 pull-right" style="margin-top:-34px;" onclick="biznumberCheck();">중복확인</button>
							</div>
                    </li>
                    <li class="list-group-item clearfix">
						<p><strong>업체명</strong></p>
						<input type="text" class="form-control" name="company" id="company" maxlength="32"/>
                    </li>
                    <li class="list-group-item" style="height:86px;">
						<p><strong>사업자등록증</strong></p>
						<div class="clearfix margin-b-10">
							<input type="file" name="bizfile" id="bizfile" class="form-control"/>
						</div>
                    </li>
                    <li class="list-group-item clearfix">
						<div class="input-group pull-left" style="width: 49%;">
							<p><strong>서비스업종</strong></p>
							<select class="form-control selectpicker" name="st_industry" id="st_industry" multiple title="업종 선택" data-selected-text-format="count > 1" data-size="15" data-live-search="true" data-live-search-placeholder="검색" data-width="200px">
								<c:forEach var="list" items="${industryList }">
									<c:choose>
										<c:when test="${list.level == '1' }">
											<optgroup label="${list.name }">
										</c:when>
										<c:when test="${list.level == '2' }">
											<option value="${list.cd }" disabled>${list.name }</option>
										</c:when>
										<c:otherwise>
											<option value="${list.cd }" title="${list.name }">&nbsp;&nbsp;&nbsp;${list.name }</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
                    	</div>
                    	<div class="input-group pull-right" style="width: 49%;">
							<p><strong>대표자명</strong></p>
							<input type="text" class="form-control" name="ceo" id="ceo" maxlength="16"/>
						</div>
                    </li>
                    <li class="list-group-item clearfix">
						<p><strong>대표번호</strong></p>
						<input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:32%;"name="number_first" id="number_first" maxlength="3"/>
						<input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:32%;"name="number_middle" id="number_middle" maxlength="4"/>
						<input type="text" class="form-control input-sm pull-left text-center" style="width:31%;"name="number_last" id="number_last" maxlength="4"/>
					</li>
					<li class="list-group-item clearfix">
						<p><strong>FAX</strong></p>
						<input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:32%;" name="fax_first" id="fax_first" maxlength="3"/>
						<input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:32%;" name="fax_middle" id="fax_middle" maxlength="4"/>
						<input type="text" class="form-control input-sm pull-left text-center" style="width:31%;" name="fax_last" id="fax_last" maxlength="4" style="width:100px;"/>
                    </li>
                    <li class="list-group-item">
						<p><strong>사업장주소</strong></p>
						<input type="text" class="form-control input-sm margin-r-10" name="address" id="address" maxlength="128" onclick="openmap();"/>
                    </li>
                  </ul>
        	</div>
        </div>
		<div class="container-fluid">
				<h4 class=""><img src="/img/png/1448441822_46_List.png" width="18" alt="">&nbsp;&nbsp;<strong>이용약관</strong></h4>
				<div class="panel panel-default pull-left" style="width:100%;">
					<div class="panel-heading"><h4>히든태그 명함서비스 이용약관</h4></div>
					<textarea class="form-control" rows="10" readonly="readonly" style="background-color: white; resize: none;">
제1조(목적) 이 약관은 주식회사 씨케이앤비(이하 회사)가 운영하는 히든태그 명함 신청몰 히든태그비즈(이하 “몰”이라 한다)에서 제공하는 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 사이버 몰과 이용자의 권리․의무 및 책임사항을 규정함을 목적으로 합니다.

  ※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다.」

제2조(정의)

  ① “몰”이란 회사가 재화 또는 용역(이하 “재화 등”이라 함)을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다.

  ② “이용자”란 “몰”에 접속하여 이 약관에 따라 “몰”이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.

  ③ ‘회원’이라 함은 “몰”에 회원등록을 한 자로서, 계속적으로 “몰”이 제공하는 서비스를 이용할 수 있는 자를 말합니다.

  ④ ‘비회원’이라 함은 회원에 가입하지 않고 “몰”이 제공하는 서비스를 이용하는 자를 말합니다.

제3조 (약관 등의 명시와 설명 및 개정) 

  ① “몰”은 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호․모사전송번호․전자우편주소, 사업자등록번호, 통신판매업 신고번호, 개인정보관리책임자등을 이용자가 쉽게 알 수 있도록 몰의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.

  ② “몰은 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회․배송책임․환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.

  ③ “몰”은 「전자상거래 등에서의 소비자보호에 관한 법률」, 「약관의 규제에 관한 법률」, 「전자문서 및 전자거래기본법」, 「전자금융거래법」, 「전자서명법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」, 「방문판매 등에 관한 법률」, 「소비자기본법」 등 관련 법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.

  ④ “몰”이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 몰의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다.  이 경우 "몰“은 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다. 

  ⑤ “몰”이 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간 내에 “몰”에 송신하여 “몰”의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.

  ⑥ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 정하는 전자상거래 등에서의 소비자 보호지침 및 관계법령 또는 상관례에 따릅니다.

제4조(서비스의 제공 및 변경) 

  ① “몰”은 다음과 같은 업무를 수행합니다.

    1. 재화 또는 용역에 대한 정보 제공 및 구매계약의 체결
    2. 구매계약이 체결된 재화 또는 용역의 배송
    3. 기타 “몰”이 정하는 업무

  ② “몰”은 재화 또는 용역의 품절 또는 기술적 사양의 변경 등의 경우에는 장차 체결되는 계약에 의해 제공할 재화 또는 용역의 내용을 변경할 수 있습니다. 이 경우에는 변경된 재화 또는 용역의 내용 및 제공일자를 명시하여 현재의 재화 또는 용역의 내용을 게시한 곳에 즉시 공지합니다.

  ③ “몰”이 제공하기로 이용자와 계약을 체결한 서비스의 내용을 재화등의 품절 또는 기술적 사양의 변경 등의 사유로 변경할 경우에는 그 사유를 이용자에게 통지 가능한 주소로 즉시 통지합니다.

  ④ 전항의 경우 “몰”은 이로 인하여 이용자가 입은 손해를 배상합니다. 다만, “몰”이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.
  
  ⑤ “몰”이 제공한 서비스에 하자가 있을 경우 이용자가 입은 손해를 배상합니다. 다만, 서비스 하자의 직접적인 원인이 “몰”에 있지 않은 경우에는 그러하지 아니합니다.

  ⑥ “몰”에서 제공한 제품 정보가 이용자가 주문한 제품과 다를 경우 이용자가 입은 손해를 배상합니다. 다만, 이용자의 주문 실수로 인한 경우에는 그러하지 아니합니다.
     제5조(서비스의 중단) 

  ① “몰”은 컴퓨터 등 정보통신설비의 보수점검․교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.

  ② “몰”은 제1항의 사유로 서비스의 제공이 일시적으로 중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단, “몰”이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.

  ③ 사업종목의 전환, 사업의 포기, 업체 간의 통합 등의 이유로 서비스를 제공할 수 없게 되는 경우에는 “몰”은 제8조에 정한 방법으로 이용자에게 통지하고 당초 “몰”에서 제시한 조건에 따라 소비자에게 보상합니다. 다만, “몰”이 보상기준 등을 고지하지 아니한 경우에는 이용자들의 마일리지 또는 적립금 등을 “몰”에서 통용되는 통화가치에 상응하는 현물 또는 현금으로 이용자에게 지급합니다.

제6조(회원가입) 

  ① 이용자는 “몰”이 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.

  ② “몰”은 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각 호에 해당하지 않는 한 회원으로 등록합니다.

    1. 가입신청자가 이 약관 제7조제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 다만 제7조제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 “몰”의 회원재가입 승낙을 얻은 경우에는 예외로 한다.
    2. 등록 내용에 허위, 기재누락, 오기가 있는 경우
    3. 기타 회원으로 등록하는 것이 “몰”의 기술상 현저히 지장이 있다고 판단되는 경우

  ③ 회원가입계약의 성립 시기는 “몰”의 승낙이 회원에게 도달한 시점으로 합니다.

  ④ 회원은 회원가입 시 등록한 사항에 변경이 있는 경우, 상당한 기간 이내에 “몰”에 대하여 회원정보 수정 등의 방법으로 그 변경사항을 알려야 합니다.

제7조(회원 탈퇴 및 자격 상실 등) 

  ① 회원은 “몰”에 언제든지 탈퇴를 요청할 수 있으며 “몰”은 즉시 회원탈퇴를 처리합니다.

  ② 회원이 다음 각 호의 사유에 해당하는 경우, “몰”은 회원자격을 제한 및 정지시킬 수 있습니다.

    1. 가입 신청 시에 허위 내용을 등록한 경우
    2. “몰”을 이용하여 구입한 재화 등의 대금, 기타 “몰”이용에 관련하여 회원이 부담하는 채무를 기일에 지급하지 않는 경우
    3. 다른 사람의 “몰” 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협하는 경우
    4. “몰”을 이용하여 법령 또는 이 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우

  ③ “몰”이 회원 자격을 제한․정지 시킨 후, 동일한 행위가 2회 이상 반복되거나 30일 이내에 그 사유가 시정되지 아니하는 경우 “몰”은 회원자격을 상실시킬 수 있습니다.

  ④ “몰”이 회원자격을 상실시키는 경우에는 회원등록을 말소합니다. 이 경우 회원에게 이를 통지하고, 회원등록 말소 전에 최소한 30일 이상의 기간을 정하여 소명할 기회를 부여합니다.

제8조(회원에 대한 통지)

  ① “몰”이 회원에 대한 통지를 하는 경우, 회원이 “몰”과 미리 약정하여 지정한 전자우편 주소로 할 수 있습니다.

  ② “몰”은 불특정다수 회원에 대한 통지의 경우 1주일이상 “몰” 게시판에 게시함으로서 개별 통지에 갈음할 수 있습니다. 다만, 회원 본인의 거래와 관련하여 중대한 영향을 미치는 사항에 대하여는 개별통지를 합니다.

제9조(구매신청 및 개인정보 제공 동의 등) 

  ① “몰”이용자는 “몰”상에서 다음 또는 이와 유사한 방법에 의하여 구매를 신청하며, “몰”은 이용자가 구매신청을 함에 있어서 다음의 각 내용을 알기 쉽게 제공하여야 합니다. 
      1. 재화 등의 검색 및 선택
      2. 받는 사람의 성명, 주소, 전화번호, 전자우편주소(또는 이동전화번호) 등의 입력
      3. 약관내용, 청약철회권이 제한되는 서비스, 배송료․설치비 등의 비용부담과 관련한 내용에 대한 확인
      4. 이 약관에 동의하고 위 3.호의 사항을 확인하거나 거부하는 표시
         (예, 마우스 클릭)
      5. 재화등의 구매신청 및 이에 관한 확인 또는 “몰”의 확인에 대한 동의
      6. 결제방법의 선택

  ② “몰”이 제3자에게 구매자 개인정보를 제공할 필요가 있는 경우 1) 개인정보를 제공받는 자, 2)개인정보를 제공받는 자의 개인정보 이용목적, 3) 제공하는 개인정보의 항목, 4) 개인정보를 제공받는 자의 개인정보 보유 및 이용기간을 구매자에게 알리고 동의를 받아야 합니다. (동의를 받은 사항이 변경되는 경우에도 같습니다.)


  ③ “몰”이 제3자에게 구매자의 개인정보를 취급할 수 있도록 업무를 위탁하는 경우에는 1) 개인정보 취급위탁을 받는 자, 2) 개인정보 취급위탁을 하는 업무의 내용을 구매자에게 알리고 동의를 받아야 합니다. (동의를 받은 사항이 변경되는 경우에도 같습니다.) 다만, 서비스제공에 관한 계약이행을 위해 필요하고 구매자의 편의증진과 관련된 경우에는 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」에서 정하고 있는 방법으로 개인정보 취급방침을 통해 알림으로써 고지절차와 동의절차를 거치지 않아도 됩니다.


  ④ “몰”은 이용자가 명함 제작을 위하여 제공한 제반 정보가 위조된 바 없는지 확인을 위하여 전화, 서면, 기타의 방법으로 사실 관계를 확인할 수 있으며, 이용자는 “몰”에 서비스 신청을 하고 명함 정보를 제공함과 동시에 이에 대하여 동의하는 것으로 간주합니다.


제10조 (계약의 성립)

  ①  “몰”은 제9조와 같은 구매신청에 대하여 다음 각 호에 해당하면 승낙하지 않을 수 있습니다. 다만, 미성년자와 계약을 체결하는 경우에는 법정대리인의 동의를 얻지 못하면 미성년자 본인 또는 법정대리인이 계약을 취소할 수 있다는 내용을 고지하여야 합니다.

    1. 신청 내용에 허위, 기재누락, 오기가 있는 경우
    2. 미성년자가 담배, 주류 등 청소년보호법에서 금지하는 재화 및 용역을 구매하는 경우
    3. 기타 구매신청에 승낙하는 것이 “몰” 기술상 현저히 지장이 있다고 판단하는 경우

  ② “몰”의 승낙이 제12조제1항의 수신확인통지형태로 이용자에게 도달한 시점에 계약이 성립한 것으로 봅니다.

  ③ “몰”의 승낙의 의사표시에는 이용자의 구매 신청에 대한 확인 및 판매가능 여부, 구매신청의 정정 취소 등에 관한 정보 등을 포함하여야 합니다.

제11조(지급방법) “몰”에서 구매한 재화 또는 용역에 대한 대금지급방법은 다음 각 호의 방법중 가용한 방법으로 할 수 있습니다. 단, “몰”은 이용자의 지급방법에 대하여 재화 등의 대금에 어떠한 명목의 수수료도  추가하여 징수할 수 없습니다.

    1. 폰뱅킹, 인터넷뱅킹, 메일 뱅킹 등의 각종 계좌이체 
    2. 선불카드, 직불카드, 신용카드 등의 각종 카드 결제(서비스 준비 이후)
    3. 온라인무통장입금
    4. 전자화폐에 의한 결제
    5. 주문 시 대금지급
    6. 마일리지 등 “몰”이 지급한 포인트에 의한 결제
    7. “몰”과 계약을 맺었거나 “몰”이 인정한 상품권에 의한 결제  
    8. 기타 전자적 지급 방법에 의한 대금 지급 등

제12조(수신확인통지․구매신청 변경 및 취소)

  ① “몰”은 이용자의 구매신청이 있는 경우 이용자에게 수신확인통지를 합니다.

  ② 수신확인통지를 받은 이용자는 의사표시의 불일치 등이 있는 경우에는 수신확인통지를 받은 후 즉시 구매신청 변경 및 취소를 요청할 수 있고 “몰”은 제작 전에 이용자의 요청이 있는 경우에는 지체 없이 그 요청에 따라 처리하여야 합니다. 다만 이미 대금을 지불한 경우에는 제15조의 청약철회 등에 관한 규정에 따릅니다.

제13조(재화 등의 공급)

  ① “몰”은 이용자와 재화 등의 공급시기에 관하여 별도의 약정이 없는 이상, 이용자가 청약을 한 날부터 7일 이내에 재화 등을 배송할 수 있도록 주문제작, 포장 등 기타의 필요한 조치를 취합니다. 다만, “몰”이 이미 재화 등의 대금의 전부 또는 일부를 받은 경우에는 대금의 전부 또는 일부를 받은 날부터 3영업일 이내에 조치를 취합니다.  이때 “몰”은 이용자가 재화 등의 공급 절차 및 진행 사항을 확인할 수 있도록 적절한 조치를 합니다.

  ② “몰”은 이용자가 구매한 재화에 대해 배송수단, 수단별 배송비용 부담자, 수단별 배송기간 등을 명시합니다. 만약 “몰”이 약정 배송기간을 초과한 경우에는 그로 인한 이용자의 손해를 배상하여야 합니다. 다만 “몰”이 고의․과실이 없음을 입증한 경우에는 그러하지 아니합니다.

제14조(환급) “몰”은 이용자가 구매신청한 재화 등이 품절 등의 사유로 인도 또는 제공을 할 수 없을 때에는 지체 없이 그 사유를 이용자에게 통지하고 사전에 재화 등의 대금을 받은 경우에는 대금을 받은 날부터 3영업일 이내에 환급하거나 환급에 필요한 조치를 취합니다.

제15조(청약철회 등)

  ① “몰”과 재화등의 구매에 관한 계약을 체결한 이용자는 「전자상거래 등에서의 소비자보호에 관한 법률」 제13조 제2항에 따른 계약내용에 관한 서면을 받은 날(그 서면을 받은 때보다 재화 등의 공급이 늦게 이루어진 경우에는 재화 등을 공급받거나 재화 등의 공급이 시작된 날을 말합니다)부터 7일 이내에는 청약의 철회를 할 수 있습니다. 다만, 청약철회에 관하여 「전자상거래 등에서의 소비자보호에 관한 법률」에 달리 정함이 있는 경우에는 동 법 규정에 따릅니다. 

  ② 이용자는 재화 등을 배송 받은 경우 다음 각 호의 1에 해당하는 경우에는 반품 및 교환을 할 수 없습니다.

    1. 이용자에게 책임 있는 사유로 재화 등이 멸실 또는 훼손된 경우(다만, 재화 등의 내용을 확인하기 위하여 포장 등을 훼손한 경우에는 청약철회를 할 수 있습니다)
    2. 이용자의 사용 또는 일부 소비에 의하여 재화 등의 가치가 현저히 감소한 경우
    3. 시간의 경과에 의하여 재판매가 곤란할 정도로 재화등의 가치가 현저히 감소한 경우
    4. 같은 성능을 지닌 재화 등으로 복제가 가능한 경우 그 원본인 재화 등의 포장을 훼손한 경우

  ③ 제2항제2호 내지 제4호의 경우에 “몰”이 사전에 청약철회 등이 제한되는 사실을 소비자가 쉽게 알 수 있는 곳에 명기하거나 시용상품을 제공하는 등의 조치를 하지 않았다면 이용자의 청약철회 등이 제한되지 않습니다.

  ④ 이용자는 제1항 및 제2항의 규정에 불구하고 재화 등의 내용이 표시·광고 내용과 다르거나 계약내용과 다르게 이행된 때에는 당해 재화 등을 공급받은 날부터 3월 이내, 그 사실을 안 날 또는 알 수 있었던 날부터 30일 이내에 청약철회 등을 할 수 있습니다.

제16조(청약철회 등의 효과)

  ① “몰”은 이용자로부터 재화 등을 반환받은 경우 3영업일 이내에 이미 지급받은 재화 등의 대금을 환급합니다. 이 경우 “몰”이 이용자에게 재화등의 환급을 지연한때에는 그 지연기간에 대하여 「전자상거래 등에서의 소비자보호에 관한 법률 시행령」제21조의2에서 정하는 지연이자율을 곱하여 산정한 지연이자를 지급합니다.

  ② “몰”은 위 대금을 환급함에 있어서 이용자가 신용카드 또는 전자화폐 등의 결제수단으로 재화 등의 대금을 지급한 때에는 지체 없이 당해 결제수단을 제공한 사업자로 하여금 재화 등의 대금의 청구를 정지 또는 취소하도록 요청합니다.

  ③ 청약철회 등의 경우 공급받은 재화 등의 반환에 필요한 비용은 이용자가 부담합니다. “몰”은 이용자에게 청약철회 등을 이유로 위약금 또는 손해배상을 청구하지 않습니다. 다만 재화 등의 내용이 표시·광고 내용과 다르거나 계약내용과 다르게 이행되어 청약철회 등을 하는 경우 재화 등의 반환에 필요한 비용은 “몰”이 부담합니다.

  ④ 이용자가 재화 등을 제공받을 때 발송비를 부담한 경우에 “몰”은 청약철회 시 그 비용을  누가 부담하는지를 이용자가 알기 쉽도록 명확하게 표시합니다.

제17조(개인정보보호)

  ① “몰”은 이용자의 개인정보 수집시 서비스제공을 위하여 필요한 범위에서 최소한의 개인정보를 수집합니다. 

  ② “몰”은 회원가입시 구매계약이행에 필요한 정보를 미리 수집하지 않습니다. 다만, 관련 법령상 의무이행을 위하여 구매계약 이전에 본인확인이 필요한 경우로서 최소한의 특정 개인정보를 수집하는 경우에는 그러하지 아니합니다.

  ③ “몰”은 이용자의 개인정보를 수집·이용하는 때에는 당해 이용자에게 그 목적을 고지하고 동의를 받습니다. 

  ④ “몰”은 수집된 개인정보를 목적외의 용도로 이용할 수 없으며, 새로운 이용목적이 발생한 경우 또는 제3자에게 제공하는 경우에는 이용·제공단계에서 당해 이용자에게 그 목적을 고지하고 동의를 받습니다. 다만, 관련 법령에 달리 정함이 있는 경우에는 예외로 합니다.

  ⑤ “몰”이 제2항과 제3항에 의해 이용자의 동의를 받아야 하는 경우에는 개인정보관리 책임자의 신원(소속, 성명 및 전화번호, 기타 연락처), 정보의 수집목적 및 이용목적, 제3자에 대한 정보제공 관련사항(제공받은자, 제공목적 및 제공할 정보의 내용) 등 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」 제22조제2항이 규정한 사항을 미리 명시하거나 고지해야 하며 이용자는 언제든지 이 동의를 철회할 수 있습니다.

  ⑥ 이용자는 언제든지 “몰”이 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 요구할 수 있으며 “몰”은 이에 대해 지체 없이 필요한 조치를 취할 의무를 집니다. 이용자가 오류의 정정을 요구한 경우에는 “몰”은 그 오류를 정정할 때까지 당해 개인정보를 이용하지 않습니다.
 
  ⑦ “몰”은 개인정보 보호를 위하여 이용자의 개인정보를 취급하는 자를  최소한으로 제한하여야 하며 신용카드, 은행계좌 등을 포함한 이용자의 개인정보의 분실, 도난, 유출, 동의 없는 제3자 제공, 변조 등으로 인한 이용자의 손해에 대하여 모든 책임을 집니다.

  ⑧ “몰” 또는 그로부터 개인정보를 제공받은 제3자는 개인정보의 수집목적 또는 제공받은 목적을 달성한 때에는 당해 개인정보를 지체 없이 파기합니다.

  ⑨ “몰”은 개인정보의 수집·이용·제공에 관한 동의 란을 미리 선택한 것으로 설정해두지 않습니다. 또한 개인정보의 수집·이용·제공에 관한 이용자의 동의거절시 제한되는 서비스를 구체적으로 명시하고, 필수수집항목이 아닌 개인정보의 수집·이용·제공에 관한 이용자의 동의 거절을 이유로 회원가입 등 서비스 제공을 제한하거나 거절하지 않습니다.

제18조(“몰“의 의무)

  ① “몰”은 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고, 안정적으로 재화․용역을 제공하는데 최선을 다하여야 합니다.

  ② “몰”은 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추어야 합니다.

  ③ “몰”이 상품이나 용역에 대하여 「표시․광고의 공정화에 관한 법률」 제3조 소정의 부당한 표시․광고행위를 함으로써 이용자가 손해를 입은 때에는 이를 배상할 책임을 집니다.

  ④ “몰”은 이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다.

제19조(회원의 ID 및 비밀번호에 대한 의무)

  ① 제17조의 경우를 제외한 ID와 비밀번호에 관한 관리책임은 회원에게 있습니다.

  ② 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.

  ③ 회원이 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 “몰”에 통보하고 “몰”의 안내가 있는 경우에는 그에 따라야 합니다.

제20조(이용자의 의무) 이용자는 다음 행위를 하여서는 안 됩니다.

    1. 신청 또는 변경시 허위 내용의 등록
    2. 타인의 정보 도용
    3. “몰”에 게시된 정보의 변경
    4. “몰”이 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시
    5. “몰” 기타 제3자의 저작권 등 지적재산권에 대한 침해
    6. “몰” 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위
    7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 몰에 공개 또는 게시하는 행위

제21조(연결“몰”과 피연결“몰” 간의 관계)

  ① 상위 “몰”과 하위 “몰”이 하이퍼링크(예: 하이퍼링크의 대상에는 문자, 그림 및 동화상 등이 포함됨)방식 등으로 연결된 경우, 전자를 연결 “몰”(웹 사이트)이라고 하고 후자를 피연결 “몰”(웹사이트)이라고 합니다.

  ② 연결“몰”은 피연결“몰”이 독자적으로 제공하는 재화 등에 의하여 이용자와 행하는 거래에 대해서 보증 책임을 지지 않는다는 뜻을 연결“몰”의 초기화면 또는 연결되는 시점의 팝업화면으로 명시한 경우에는 그 거래에 대한 보증 책임을 지지 않습니다.

제22조(저작권의 귀속 및 이용제한)

  ① “몰“이 작성한 저작물에 대한 저작권 기타 지적재산권은 ”몰“에 귀속합니다.

  ② 이용자는 “몰”을 이용함으로써 얻은 정보 중 “몰”에게 지적재산권이 귀속된 정보를 “몰”의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.

  ③ “몰”은 약정에 따라 이용자에게 귀속된 저작권을 사용하는 경우 당해 이용자에게 통보하여야 합니다.

  ④ 이용자가 “몰”의 서비스 이용을 위하여 제공한 정보(이미지, 텍스트 등의 각종 정보)에 대한 저작권은 이용자에게 있으며, 이용자가 제공한 정보에 대한 분쟁이 발생할 경우 이용자가 책임을 집니다. “몰”은 이용자가 제공한 정보의 저작권을 확인하기 위하여 이용자에게 저작권 증명 문서 및 허위정보 사실을 확인하기 위한 기타 조치를 취할 수 있습니다.

제23조(분쟁해결)

  ① “몰”은 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해를 보상처리하기 위하여 피해보상처리기구를 설치․운영합니다.

  ② “몰”은 이용자로부터 제출되는 불만사항 및 의견은 우선적으로 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 즉시 통보해 드립니다.

  ③ “몰”과 이용자 간에 발생한 전자상거래 분쟁과 관련하여 이용자의 피해구제신청이 있는 경우에는 공정거래위원회 또는 시·도지사가 의뢰하는 분쟁조정기관의 조정에 따를 수 있습니다.

제24조(재판권 및 준거법)

  ① “몰”과 이용자 간에 발생한 전자상거래 분쟁에 관한 소송은 제소 당시의 이용자의 주소에 의하고, 주소가 없는 경우에는 거소를 관할하는 지방법원의 전속관할로 합니다. 다만, 제소 당시 이용자의 주소 또는 거소가 분명하지 않거나 외국 거주자의 경우에는 민사소송법상의 관할법원에 제기합니다.

  ② “몰”과 이용자 간에 제기된 전자상거래 소송에는 한국법을 적용합니다.
					</textarea>
					<div class="one-success">
						  <div class="checkbox">
							<label style="margin-left:10px;">
							  <input type="checkbox" name="check_law1" id="check_law1" value="0">
							  예, 위 이용약관에 동의합니다.
							</label>
						  </div>
					</div>

				</div>
				
				<div class="panel panel-default pull-left" style="width:100%;">
					<div class="panel-heading"><h4>히든태그 명함서비스 개인정보 보호정책</h4></div>
					<textarea class="form-control" rows="10" readonly="readonly" style="background-color: white; resize: none;">
	o	1. 수집하는 개인정보의 항목 및 수집방법
	가. 수집하는 개인정보의 항목
회사는 회원이 입력한 정보를 기반으로 회원가입, 몰 서비스의 제공, 원활한 고객상담 등을 위하여 다음과 같은 정보를 수집합니다
	1) 필수 항목
	- 회원의 아이디(이메일), 비밀번호
	- 회원 및 회원 인맥의 명함이미지, 회사부서직책주소 등 직장정보, 이름, 휴대폰번호이메일 등 연락처, 관계정보 등 정보
	- 이용행태, 이용빈도, 인맥지수 등 서비스 이용 과정 상의 생성정보
	- OS 버전, 단말기 정보 등 운영체제 및 하드웨어 환경정보
	2) 선택 항목
- 프로필 사진, 이력 정보, 홈페이지 및 블로그 주소, 페이스북 등 회원이 선택한 외부 서비스의 계정 및 서비스 이용 정보 등
	3) 서비스 이용시 아래와 같은 정보들이 자동으로 생성되어 수집될 수 있습니다.
- IP Address, 쿠키, 방문 일시, 서비스 이용 기록, 불량 이용 기록, 추천 내역 등
	4) 유료 서비스 이용 과정에서 결제 등을 위하여 불가피하게 필요한 때에는 다음의 정보가 수집될 수 있습니다.
- 신용카드 정보, 통신사 정보, 상품권 번호 등과 같이 결제에 필요한 정보
	나. 개인정보의 수집방법
회사는 다음과 같은 방법으로 개인정보를 수집합니다.
	1) 서비스 가입이나 사용 중 이용자의 자발적 제공을 통한 수집
	2) 회원의 선택에 따라 네이버, 페이스북, 구글 등의 아이디를 이용하여 로그인하는 회원의 경우 해당 협력회사로부터 자동으로 수집
	3) 그 외 협력회사로부터 제공
	4) 생성정보 수집 툴을 통한 수집
o	2. 개인정보의 수집 및 이용 목적
회사는 다음과 같은 목적으로 이용자 등의 개인정보를 수집합니다.
	가. 몰 서비스의 기본 기능의 제공
회사는 회원이 저장한 명함정보, 인맥정보 등 관계정보를 회원의 계정을 통하여 이용할 수 있는 서비스 등을 제공합니다.
	나. 서비스 제공에 관한 계약 이행 및 필요 시 유료 서비스 제공에 따른 요금정산
	다. 회원관리
회원제 서비스 이용에 따른 본인확인, 회원 식별을 위한 목적, 원활한 의사소통 경로의 확보, 고객 문의에 대한 응답, 새로운 정보의 소개 및 고지사항 전달, 불량회원의 부정이용방지와 비인가 사용방지, 가입의사 확인, 가입 및 가입횟수 제한, 본인확인 및 분쟁 조정을 위한 기록보존, 불만 등 민원처리 등
	라. 신규 서비스 개발 및 마케팅광고에의 활용
회원을 위한 통계학적 특성 분석에 기반한 새로운 맞춤형 서비스 제공 및 광고 게재, 각종 이벤트 및 광고성 정보 제공 등
	마. 법령 등의 이행 및 준수
법령 등에 규정된 의무의 이행, 법령이나 이용약관에 반하여 이용자에게 피해를 줄 수 있는 잘못된 이용행위의 방지 등
o	3. 개인정보의 제3자 제공 및 처리위탁
회사는 회원의 개인정보를 '개인정보의 수집 및 이용 목적'에서 명시한 범위에서 사용하며, 이에 따라 서비스 이용과정에서 다음의 정보가 공개될 수 있습니다. 또한, 서비스의 목적상 필수적으로 제공되어야 하거나 회원의 사전 동의가 있는 경우 또는 아래 예외적인 경우를 제외하고는, 그 범위를 초과하여 이용하거나 제3자에 제공하지 않습니다.
	가. 개인정보의 공개
회원 및 회원이 제공한 명함신청 정보는 회원 및 몰의 명함서비스 이용자가 명함을 배포하고, 명함을 수령한 타인이 몰에서 제공하는 앱으로 명함 정보를 인식할 경우 앱을 통하여 명함의 정보가 타인에게 공개/공유/저장 될 수 있습니다.
또한 몰 서비스 이용 도중 회원의 명함 정보 및 회원이 선택적으로 입력한 기타 정보가 연결된 회원 간에 공개될 수 있습니다. 또한 회원이 상대방을 초대할 경우, 설정에 따라 초대자 식별을 위해 이름, 프로필 사진, 일부 명함 정보가 피초대자에게 공개될 수 있습니다.
	나. 개인정보의 제3자 제공
	1) 회원이 제공에 동의한 정보
	- 제휴관계에 있다는 점을 미리 알리고 동의를 받은 경우
	2) 법령에 특별한 규정이 있는 경우
	3) 수사기관이 수사 목적으로 정해진 절차와 방법에 따라 요구한 경우
	다. 개인정보의 위탁제공
회사는 서비스의 향상을 위하여 아래와 같이 개인정보를 위탁하고 있으며, 관련 법령에 따라 위탁계약시 개인정보가 안전하게 관리될 수 있도록 필요한 사항을 규정하고 있습니다. 회사는 수탁자가 변경되는 경우 지체없이 본 개인정보 처리방침을 통하여 공개합니다.
	1) 수탁업체 : 명함 인쇄업체(불특정 복수)
	- 위탁업무 내용 : 명함 제작을 위하여 명함 정보 및 히든태그 라벨 이미지
	- 개인정보의 보유 및 이용기간 : 명함 제작 완료시 즉시 폐기
	2) 수탁업체 : 배송 업체 (불특정 복수)
	- 위탁업무 내용 : 상품 배송
	- 개인정보의 보유 및 이용기간 : 회원 탈퇴시 또는 위탁계약 종료시
o	4. 개인정보 보유 및 이용기간
회원의 개인정보는 원칙적으로 개인정보의 수집 및 이용 목적이 달성되면 지체 없이 파기합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보관합니다.
	가. 회사 내부 방침에 의한 정보공유
정상적인 정보의 유지: 몰에서 제공하는 앱을 통하여 명함을 인식할 경우 명함의 정보를 제공하기 위하여 기록 보유하며, 기본 1년이며 명함 재 발주 또는 데이터 유지보수 연장 시 마다 1년간 연장
부정이용기록 보유 : 1년 (부정 이용 방지)
	나. 관련 법령에 의한 정보공유
상법, 전자상거래 등에서의 소비자보호에 관한 법률 등 관련법령의 규정에 의하여 일정기간 정보를 보유하여야 할 필요가 있을 경우 회사는 보관하는 정보를 일정기간 보유하며, 보유기간은 아래와 같습니다.
	1) 계약 또는 청약철회 등에 관한 기록 보유 : 5년 (전자상거래 등에서의 소비자보호에 관한 법률)
	2) 대금결제 및 재화 등의 공급에 관한 기록 보유 : 5년 (전자상거래 등에서의 소비자보호에 관한 법률)
	3) 소비자 불만 또는 분쟁처리에 관한 기록 보유 : 3년 (전자상거래 등에서의 소비자보호에 관한 법률)
	4) 본인확인에 관한 기록 보유 : 6개월 (정보통신망 이용촉진 및 정보보호 등에 관한 법률)
	5) 방문에 관한 기록 보유 : 3개월 (통신비밀보호법)
o	5. 개인정보의 열람, 수정, 삭제 및 개인정보의 도용
회원은 언제든지 자신의 개인정보를 열람, 공개 및 비공개 처리하거나 수정할 수 있으며, 삭제 및 파기를 요청할 수 있습니다.
	가. 개인정보의 열람 및 수정 요청
회원 및 법정대리인은 언제든지 등록되어 있는 본인 또는 만 14세미만 아동의 개인정보를 조회, 수정할 수 있습니다. 회원 또는 법정대리인은 당해 개인정보의 조회, 수정을 위하여 몰 서비스에 등록된 명함 정보를 클릭하거나, 설정 메뉴를 클릭하여 계정 등 등록된 개인정보를 직접 열람하거나 수정할 수 있습니다.
	나. 개인정보의 삭제(회원탈퇴)
회원 및 만 14세 미만 아동의 법정대리인이 회원탈퇴를 원하는 경우, 모바일 애플리케이션 또는 웹사이트로 로그인한 후 '설정-몰 탈퇴하기'를 통해 직접 탈퇴할 수 있습니다. 만일, 직접 탈퇴가 어려운 경우 개인정보관리담당자에게 서면, 전화 또는 이메일로 연락하시면 지체없이 조치를 취하겠습니다.
	다. 개인정보의 도용
회사는 타인의 주민등록번호, 페이스북 등 제휴업체 아이디 또는 기타 개인정보를 도용하여 회원가입한 자 또는 몰을 이용한 자를 발견한 경우 지체 없이 해당 아이디에 대한 서비스 이용 정지 또는 회원 탈퇴 등 필요한 조치를 취합니다.
o	6. 개인정보의 파기
회원의 개인정보는 원칙적으로 개인정보의 수집 및 이용 목적이 달성되면 지체 없이 파기합니다. 회사의 개인정보 파기절차 및 방법은 다음과 같습니다.
	가. 파기절차
회원이 서비스 가입 등을 위해 입력한 정보는 목적이 달성된 후 별도의 DB 또는 보관 장소로 옮겨져 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라(개인정보 보유 및 이용기간 참조) 일정 기간 저장된 후 파기됩니다. 위 별도 보관된 개인정보는 정해진 목적 이외의 다른 목적으로 이용되지 않습니다.
	나. 파기방법
종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다. 전자적 파일 형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.
o	7. 쿠키의 운영
쿠키란 몰 사이트 접속시 이용자의 하드디스크(hard disk)에 전송하는 특별한 텍스트 파일(text file)을 말합니다. 쿠키는 웹사이트의 서버(server)에서만 읽어드릴 수 있는 형태로 전송되며 개인이 사용하는 브라우저(browser)의 디렉터리(directory) 하위에 저장됩니다.
	가. 쿠키의 사용 목적
몰이 쿠키를 통해 수집하는 정보는 '수집하는 개인정보 항목'과 같으며 '개인정보의 수집 및 이용목적' 외의 용도로는 이용되지 않습니다.
	나. 쿠키 설정 거부
이용자는 쿠키에 대한 선택권을 가지고 있습니다. 웹 브라우저 옵션(option)을 선택함으로써 모든 쿠키의 허용, 동의를 통한 쿠키의 허용, 모든 쿠키의 차단을 스스로 결정할 수 있습니다. 단, 쿠키 저장을 거부할 경우에는 로그인이 필요한 일부 서비스를 이용하지 못할 수도 있습니다.
o	8. 회원의 권리와 의무
회원이 입력한 부정확한 정보로 인해 발생하는 사고의 책임은 이용자 자신에게 있습니다. 회원은 개인정보를 최신의 상태로 정확하게 입력하여 불의의 사고를 예방하여야 할 의무가 있습니다. 회원은 개인정보를 보호받을 권리와 함께 스스로를 보호하고 타인의 정보를 침해하지 않을 의무도 가지고 있습니다. 비밀번호를 포함한 회원의 개인정보가 유출되지 않도록 조심하시고 게시물을 포함한 타인의 개인정보를 훼손하지 않도록 유의해 주십시오. 회원이 위 책임을 다하지 못하고 타인의 정보 및 존엄성을 훼손할 시에는 『정보통신망 이용촉진 및 정보보호 등에 관한 법률』등 관련 법률에 의해 처벌받을 수 있습니다.
o	9. 개인정보의 기술적/관리적 보호대책
회사는 회원의 개인정보를 처리함에 있어 개인정보가 분실, 도난, 유출, 변조 또는 훼손되지 않도록 안전성 확보를 위하여 다음과 같은 기술적/관리적 대책을 강구하고 있습니다.
	가. 해킹 등에 대비한 대책
회사는 해킹이나 컴퓨터 바이러스 등에 의해 회원의 개인정보가 유출되거나 훼손되는 것을 막기 위해 최선을 다하고 있습니다. 회원의 개인정보나 자료가 유출되거나 손상되지 않도록 방지하고 있으며, 암호화 통신 등을 통하여 네트워크상에서 개인정보를 안전하게 전송할 수 있도록 하고 있습니다. 그리고 침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있습니다.
	나. 처리 직원의 최소화 및 교육
회사의 개인정보관련 처리 직원은 담당자에 한정시키고 있고 이를 위한 별도의 비밀번호를 부여하여 정기적으로 갱신하고 있으며, 담당자에 대한 수시 교육을 통하여 회사의 개인정보처리방침의 준수를 항상 강조하고 있습니다.
	다. 개인정보보호전담기구의 운영
회사는 사내 개인정보보호전담기구 등을 통하여 회사의 개인정보처리방침의 이행사항 및 담당자의 준수여부를 확인하여 문제가 발견될 경우 즉시 수정하고 바로 잡을 수 있도록 노력하고 있습니다. 단, 회원 본인의 부주의나 회사의 고의 또는 중대한 과실이 아닌 사유로 개인정보가 유출되어 발생한 문제에 대해 회사는 일체의 책임을 지지 않습니다.
o	10. 개인정보보호책임자 및 담당자의 연락처
귀하께서는 회사의 서비스를 이용하시며 발생하는 모든 개인정보보호 관련 민원을 개인정보보호책임자 혹은 담당부서로 신고하실 수 있습니다. 회사는 회원의 신고사항에 대하여 신속하게 답변을 드릴 것입니다.
	
	1) 개인정보보호책임자
	- 이름 : 조인제
	- 소속 : 주식회사 씨케이앤비
	- 직위 : 이사
	- 전화 : 02-453-8416
	- 이메일 : partners@cknb.co.kr
	2) 개인정보관리담당자
	- 이름 : 정재승
	- 소속 : 주식회사 씨케이앤비
	- 직위 : 부장
	- 전화 : 02-453-8416
	- 이메일 : partners@cknb.co.kr
기타 개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다.
	- 개인정보침해신고센터 (www.118.or.kr / 118)
	- 정보보호마크인증위원회 (www.eprivacy.or.kr / 02-580-0533~4)
	- 대검찰청 첨단범죄수사과 (www.spo.go.kr / 02-3480-2000)
	- 경찰청 사이버테러대응센터 (www.ctrc.go.kr / 02-392-0330)
o	11. 기타
몰 서비스 내에 링크되어 있는 웹사이트 등 타 서비스들이 개인정보를 수집하는 행위에 대해서는 본 몰 개인정보처리방침이 적용되지 않음을 알려드립니다.
o	12. 고지의 의무
현 개인정보처리방침 내용 추가, 삭제 및 수정이 있을 시에는 시행일 최소 7일전부터 몰 웹사이트(http://www.hiddentagbiz.com) 또는 서비스 내 '공지사항'을 통해 공고할 것입니다.

공고일자 : 2017.04.07
시행일자 : 2017.04.07 
					</textarea>
					<div class="one-success">
						  <div class="checkbox">
							<label style="margin-left:10px;">
							  <input type="checkbox" name="check_law2" id="check_law2" value="0">
							  예, 위 이용약관에 동의합니다.
							</label>
						  </div>
					</div>
					<div class="all-success">
						  <div class="checkbox" onclick="agreeall();">
							<label style="margin-left:10px;">
							  <input type="checkbox" name="check_lawall" id="check_lawall" value="0">
							  전체 동의합니다.
							</label>
						  </div>
					</div>
				</div>
		</div>
		<div class="container-fluid">
		<h4 class=""><img src="/img/png/glyphicons-197-circle-exclamation-mark.png" width="18" alt="">&nbsp;&nbsp;<strong>매크로방지</strong></h4>
					<div class="captcha"style="width:100%; top:0; margin-left:-24px; padding:0;">
					<div class="g-recaptcha" style="width:100%; top:0; margin-left:25px; padding:0;" data-sitekey="6Lf7BRcUAAAAAMuKP2fxFpXPNgjfX_xy1sXKT6Yr"></div>
			<noscript>
			  <div>
			    <div style="width: 302px; height: 422px; position: relative;">
			      <div style="width: 302px; height: 422px; position: absolute;">
			        <iframe src="https://www.google.com/recaptcha/api/fallback?k=6Lf7BRcUAAAAAMuKP2fxFpXPNgjfX_xy1sXKT6Yr"
			                frameborder="0" scrolling="no"
			                style="width: 302px; height:422px; border-style: none;">
			        </iframe>
			      </div>
			    </div>
			    <div style="width: 300px; height: 60px; border-style: none;
			                   bottom: 12px; left: 25px; margin: 0px; padding: 0px; right: 25px;
			                   background: #f9f9f9; border: 1px solid #c1c1c1; border-radius: 3px;">
			      <textarea id="g-recaptcha-response" name="g-recaptcha-response"
			                   class="g-recaptcha-response"
			                   style="width: 250px; height: 40px; border: 1px solid #c1c1c1;
			                          margin: 10px 25px; padding: 0px; resize: none;" >
			      </textarea>
			    </div>
			  </div>
			</noscript>
				</div>
		 </div>
		<!-- <div class="container-fluid" style="height:400px;">
			
				<div class="inbox pull-right margin-b-10" id="join">
					<div class="panel panel-default pull-left" style="width:100%;">
						<div class="panel-heading"><h4>보안확인</h4></div>
						<div class="g-recaptcha" data-sitekey="6Lf7BRcUAAAAAMuKP2fxFpXPNgjfX_xy1sXKT6Yr" style="clear:both;"></div>
			<noscript>
			  <div>
			    <div style="width: 302px; height: 422px; position: relative;">
			      <div style="width: 302px; height: 422px; position: absolute;">
			        <iframe src="https://www.google.com/recaptcha/api/fallback?k=6Lf7BRcUAAAAAMuKP2fxFpXPNgjfX_xy1sXKT6Yr"
			                frameborder="0" scrolling="no"
			                style="width: 302px; height:422px; border-style: none;">
			        </iframe>
			      </div>
			    </div>
			  </div>
			</noscript>
		</div> -->
		<div class="container-fluid" style="margin-top: 20px; margin-bottom: 20px;">
			<button class="btn btn-primary btn-sm wd100 pull-center" type="button" alt="cancel" onclick="onRegistSubmit();">가입</button>
			<button class="btn btn-default btn-sm wd100 pull-center" type="button" alt="join" onclick="onCancel()">취소</button>
		</div>
	</form>
</body>
</html>