<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<!DOCTYPE html >

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<script language="javascript" src="/common/js/util.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>마이페이지</title>
    <link href="/common/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/common/css/bootstrap.min.css" rel="stylesheet">
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
	if(document.getElementById('user_pwd').value != document.getElementById('user_pwd_confirm').value)
	{
		alert('비밀번호가 서로 틀립니다.'); return;
	}
		
	var v = grecaptcha.getResponse();
	if(v.length == 0)
	{
		alert('"로봇이 아닙니다."를 체크해 주세요'); return;
	}
		
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
    
	xmlhttp.open('POST', '/pc/login/usermodifysubmit', true);
	var formData = new FormData();
	var user_pwd = document.getElementById('user_pwd').value;
	var user_name = document.getElementById('user_name').value;
	var mobile = document.getElementById('mobile_first').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('mobile_middle').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('mobile_last').value.replace(/(^\s*)|(\s*$)/gi, "");
	var tel = document.getElementById('tel_first').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('tel_middle').value.replace(/(^\s*)|(\s*$)/gi, "")  + '-' + document.getElementById('tel_last').value.replace(/(^\s*)|(\s*$)/gi, "");
	var email = document.getElementById('email').value;
	
	formData.append('passwd', user_pwd);
	formData.append('name', user_name);
	formData.append('mobile', mobile);
	formData.append('tel', tel);
	formData.append('email', email);
	
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

function fn_nextfocus(obj) {
	var max = $(obj).attr("maxlength");
	var txt = $(obj).val();
	if (max <= txt.length) {
		$(obj).next().focus();
	}
}
</script>

<script src='https://www.google.com/recaptcha/api.js'></script>
</head>

<body>	
	<form method="post" name="frm" enctype="multipart/form-data">
		<div class="container-fluid">
			<h4 class="" style="display:block;margin:20px 0px 20px 0;"><img src="/img/png/glyphicons-4-user.png" width="18" alt="">&nbsp;&nbsp;<strong>관리자정보 변경</strong></h4>
  
        	<div class="panel panel-default pull-left" style="width:100%;">
            	<div class="panel-heading" style="padding:5px 10px"><h4>회원정보<small>&nbsp;&nbsp;모든 항목을 입력해 주세요</small></h4></div>
				  <ul class="list-group">
                    <li class="list-group-item clearfix">
						 <p><strong>아이디</strong></p>
						 <input type="text" class="form-control" name="user_id" id="user_id" maxlength="16" value="${data.info.id }" readonly="readonly" disabled="disabled"/>
                    </li>
                    <li class="list-group-item clearfix">
						 <p><strong>비밀번호</strong></p>
						 <input type="password" class="form-control" name="user_pwd" id="user_pwd" maxlength="16" />
                    </li>
					<li class="list-group-item clearfix">
						<p><strong>비밀번호 확인</strong></p>
						<input type="password" name="user_pwd_confirm" id="user_pwd_confirm" maxlength="16" class="form-control"/>
                    </li>
                    <li class="list-group-item clearfix">
						<p><strong>이름</strong></p>
						<input type="text" class="form-control" name="user_name" id="user_name" maxlength="16" value="${data.info.name }" readonly="readonly" />
                    </li>
                    <li class="list-group-item clearfix">
						<p><strong>MOBILE</strong></p>
						<input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:32%;" name="mobile_first" id="mobile_first" maxlength="3" value="${data.info.mobile_first }" onkeyup="fn_nextfocus(this)"/>
						<input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:32%;" name="mobile_middle" id="mobile_middle" maxlength="4" value="${data.info.mobile_middle }" onkeyup="fn_nextfocus(this)"/>
						<input type="text" class="form-control input-sm pull-left text-center" style="width:31%;" name="mobile_last" id="mobile_last" maxlength="4" value="${data.info.mobile_last }"/>
					<li class="list-group-item clearfix">
						<p><strong>TEL</strong></p>
						<input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:32%;" name="tel_first" id="tel_first" maxlength="4" value="${data.info.tel_first }"/>
						<input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:32%;" name="tel_middle" id="tel_middle" maxlength="4" value="${data.info.tel_middle }"/>
						<input type="text" class="form-control input-sm pull-left text-center" style="width:31%;" name="tel_last" id="tel_last" maxlength="4" value="${data.info.tel_last }"/>
                    </li>
                    <li class="list-group-item clearfix">
						<p><strong>EMAIL</strong></p>
						<input type="text" class="form-control input-sm margin-r-10"name="email" id="email" maxlength="26" value="${data.info.email }"/>
                    </li>
                  </ul>
        	</div>
        </div>
        <div class="container-fluid">
					<div class="captcha"style="width:100%; top:0; margin-left:-24px; padding:0;">
					<div class="g-recaptcha" style="width:100%; top:0; margin-left:25px; padding:0;"data-sitekey="6Lf7BRcUAAAAAMuKP2fxFpXPNgjfX_xy1sXKT6Yr" ></div>
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
		 	<div class="container-fluid" style="margin-top: 20px;">
						<button type="button" class="confirm btn btn-primary btn-m wd100" onclick="onCancel();">취소</button>
						<button type="button" class="btn btn-default btn-m wd100" onclick="onRegistSubmit();">수정</button>
			</div>
	</form>
</body>
</html>