<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>아이디 찾기</title>
    <link href="/common/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/common/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="/common/css/pop.css" rel="stylesheet">
	<style>
	*{margin:0; padding:0; list-style:none; text-decoration:none;}
	.container-fluid {width: 465px;}
	.panel-heading {padding:5px 10px}
	</style>
<script type="text/javascript">
function onFindIDSubmit()
{
	var v= grecaptcha.getResponse();

	if(v.length == 0)
	{
		alert('"로봇이 아닙니다."를 체크해 주세요');
		return;
	}
	grecaptcha.reset();
	loadfindid();
}

function onCancel(value)
{
	if(value == 0)
	{
		if(confirm("취소하시겠습니까?") == false) return;
	}
	frm.action = "/pc/login/login";
	frm.submit();
}

function loadfindid()
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
    
	xmlhttp.open('POST', '/pc/login/findidsubmit', true);
	
	var name = document.getElementById('user_name').value
	var mobile = document.getElementById('mobile_first').value.replace(/(^\s*)|(\s*$)/gi, "") + '-' + document.getElementById('mobile_middle').value.replace(/(^\s*)|(\s*$)/gi, "") + '-' + document.getElementById('mobile_last').value.replace(/(^\s*)|(\s*$)/gi, "");
	var tel = document.getElementById('tel_first').value.replace(/(^\s*)|(\s*$)/gi, "") + '-' + document.getElementById('tel_middle').value.replace(/(^\s*)|(\s*$)/gi, "") + '-' + document.getElementById('tel_last').value.replace(/(^\s*)|(\s*$)/gi, "");
	var email = document.getElementById('email').value
	
	var formData = new FormData();
	formData.append('name', name);
	formData.append('mobile', mobile);
	formData.append('tel', tel);
	formData.append('email', email);
	
	xmlhttp.send(formData);
	
    xmlhttp.onreadystatechange=function()
    {
    	if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
    		var JSONobj = JSON.parse(xmlhttp.responseText);
    		var user_id = JSONobj.user_id;
    		if(user_id == null)
    		{
    			alert('사용자 정보가 존재하지 않습니다.');
    		}
    		else
    		{
    			alert('조회 되었습니다.');
    			document.getElementById('user_id').value = user_id;
    			document.getElementById('user_id').style.backgroundColor = "ivory";
    			document.getElementById('cancel').value = "login";
    			document.getElementById('cancel').setAttribute("onclick", "onCancel(1)");
    		}
       	}
	};
};
</script>

<script src='https://www.google.com/recaptcha/api.js'></script>
</head>

<body>
	<form method="post" name="frm" enctype="multipart/form-data">
		<div class="container-fluid">
			<h4 class="" style="display:block;margin:20px 0px 20px 0;"><img src="/img/png/glyphicons-4-user.png" width="18" alt="">&nbsp;&nbsp;<strong>아이디 찾기</strong></h4>
        	<div class="panel panel-default pull-left" style="width:100%;">
            	<div class="panel-heading"><h4>회원정보</h4></div>
				  <ul class="list-group">
                    <li class="list-group-item clearfix">
					 <p><strong>아이디</strong></p>
					 <input type="text" class="form-control" name="user_id" id="user_id" maxlength="16" readonly="readonly" disabled="disabled"/>
                    </li>
                    <li class="list-group-item clearfix">
					 <p><strong>이름</strong></p>
					 <input type="text" class="form-control" name="user_name" id="user_name" maxlength="16"/>
                    </li>
                    <li class="list-group-item clearfix">
					 <p><strong>MOBILE</strong></p>
					 <input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:32%;" name="mobile_first" id="mobile_first" maxlength="3"/>
					 <input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:32%;" name="mobile_middle" id="mobile_middle" maxlength="4"/>
					 <input type="text" class="form-control input-sm pull-left text-center" style="width:31%;" name="mobile_last" id="mobile_last" maxlength="4"/>
					</li>
					<li class="list-group-item clearfix">
						<p><strong>TEL</strong></p>
					<input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:32%;" name="tel_first" id="tel_first" maxlength="3"/>
					<input type="text" class="form-control input-sm pull-left margin-r-10 text-center" style="width:32%;" name="tel_middle" id="tel_middle" maxlength="4"/>
					<input type="text" class="form-control input-sm pull-left text-center" style="width:31%;" name="tel_last" id="tel_last" maxlength="4"/>
                    </li>
                    <li class="list-group-item clearfix">
						<p><strong>EMAIL</strong></p>
						<input type="text" class="form-control input-sm margin-r-10" name="email" id="email" maxlength="26"/>
                    </li>
                  </ul>
                  <!-- <div class="g-recaptcha" data-sitekey="6Lf7BRcUAAAAAMuKP2fxFpXPNgjfX_xy1sXKT6Yr" style="clear:both;"></div>
				<noscript>
			  <div class="container-fluid">
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
			</noscript> -->
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
			<div class="container-fluid" style="margin-top: 20px; margin-bottom: 20px;">
				<button type="button" class="confirm btn btn-primary btn-m wd100" onclick="onFindIDSubmit();">확인</button>
				<button type="button" class="btn btn-default btn-m wd100" style="margin-left:10px;" onclick="onCancel(0);">취소</button>
			</div>
	</form>
</body>
</html>