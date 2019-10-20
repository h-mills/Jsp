<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>비밀번호 찾기</title>
<link href="/common/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/common/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="/common/css/pop.css" rel="stylesheet">
<style>
* {
	margin: 0;
	padding: 0;
	list-style: none;
	text-decoration: none;
}

.container-fluid {
	width: 970px;
}
</style>
<script type="text/javascript">
	function onFindPWSubmit() {
		var v = grecaptcha.getResponse();

		if (v.length == 0) {
			alert('"로봇이 아닙니다."를 체크해 주세요');
			return;
		}
		grecaptcha.reset();
		loadsubmit();
	}

	function onCancel(value) {
		if (value == 0) {
			if (confirm("취소하시겠습니까?") == false)
				return;
		}
		frm.action = "/pc/login/login";
		frm.submit();
	}

	function loadsubmit() {
		var xmlhttp;
		if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {// code for IE6, IE5
			xmlhttp = new ActiveXObject('Microsoft.XMLHTTP');
		}

		var formData = new FormData();
		var user_id = document.getElementById('user_id').value;
		var user_name = document.getElementById('user_name').value;
		var mobile = document.getElementById('mobile_first').value.replace(
				/(^\s*)|(\s*$)/gi, "")
				+ '-'
				+ document.getElementById('mobile_middle').value.replace(
						/(^\s*)|(\s*$)/gi, "")
				+ '-'
				+ document.getElementById('mobile_last').value.replace(
						/(^\s*)|(\s*$)/gi, "");
		var tel = document.getElementById('tel_first').value.replace(
				/(^\s*)|(\s*$)/gi, "")
				+ '-'
				+ document.getElementById('tel_middle').value.replace(
						/(^\s*)|(\s*$)/gi, "")
				+ '-'
				+ document.getElementById('tel_last').value.replace(
						/(^\s*)|(\s*$)/gi, "");
		var email = document.getElementById('email').value;
		var biznumber = document.getElementById('biz_first').value.replace(
				/(^\s*)|(\s*$)/gi, "")
				+ '-'
				+ document.getElementById('biz_middle').value.replace(
						/(^\s*)|(\s*$)/gi, "")
				+ '-'
				+ document.getElementById('biz_last').value.replace(
						/(^\s*)|(\s*$)/gi, "");
		var ceo = document.getElementById('ceo').value;
		var onenumber = document.getElementById('number_first').value.replace(
				/(^\s*)|(\s*$)/gi, "")
				+ '-'
				+ document.getElementById('number_middle').value.replace(
						/(^\s*)|(\s*$)/gi, "")
				+ '-'
				+ document.getElementById('number_last').value.replace(
						/(^\s*)|(\s*$)/gi, "");
		var fax = document.getElementById('fax_first').value.replace(
				/(^\s*)|(\s*$)/gi, "")
				+ '-'
				+ document.getElementById('fax_middle').value.replace(
						/(^\s*)|(\s*$)/gi, "")
				+ '-'
				+ document.getElementById('fax_last').value.replace(
						/(^\s*)|(\s*$)/gi, "");

		formData.append('user_id', user_id);
		formData.append('user_name', user_name);
		formData.append('mobile', mobile);
		formData.append('tel', tel);
		formData.append('email', email);
		formData.append('biznumber', biznumber);
		formData.append('ceo', ceo);
		formData.append('onenumber', onenumber);
		formData.append('fax', fax);

		xmlhttp.open('POST', '/pc/login/findpwsubmit', true);
		xmlhttp.send(formData);
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var JSONobj = JSON.parse(xmlhttp.responseText);
				var result = JSONobj.result;

				if (result == '1') {
					alert('조회 되었습니다.');
					document.getElementById('user_pwd').value = JSONobj.passwd;
					document.getElementById('user_pwd').style.backgroundColor = "ivory";
					document.getElementById('cancel').value = "login";
					document.getElementById('cancel').setAttribute("onclick",
							"onCancel(1)");
				} else {
					alert('사용자 정보가 존재하지 않습니다.');
				}
			}
		}
	}
</script>

<script src='https://www.google.com/recaptcha/api.js'></script>
</head>

<body>
	<form method="post" name="frm" enctype="multipart/form-data">
		<div class="container-fluid">
			<h4 class="" style="display: block; margin: 20px 0px 20px 0;">
				<img src="/img/png/glyphicons-4-user.png" width="18" alt="">&nbsp;&nbsp;<strong>비밀번호
					찾기</strong>
			</h4>
			<div class="panel panel-default pull-left" style="width: 48%;">
				<div class="panel-heading" style="padding: 5px 10px">
					<h4>회원정보</h4>
				</div>
				<ul class="list-group">
					<li class="list-group-item clearfix">
						<p>
							<strong>아이디</strong>
						</p> <input type="text" class="form-control" name="user_id"
						id="user_id" maxlength="16" />
					</li>
					<li class="list-group-item clearfix">
						<p>
							<strong>비밀번호</strong>
						</p> <input type="text" class="form-control" name="user_pwd"
						id="user_pwd" maxlength="16" readonly="readonly"
						disabled="disabled" />
					</li>
					<li class="list-group-item clearfix">
						<p>
							<strong>비밀번호 확인</strong>
						</p> <input type="password" class="form-control"
						name="user_pwd_confirm" id="user_pwd_confirm" maxlength="16"
						readonly="readonly" disabled="disabled" />
					</li>
					<li class="list-group-item clearfix">
						<p>
							<strong>이름</strong>
						</p> <input type="text" class="form-control" name="user_name"
						id="user_name" maxlength="16" />
					</li>
					<li class="list-group-item clearfix">
						<p>
							<strong>MOBILE</strong>
						</p> <input type="text"
						class="form-control input-sm pull-left margin-r-10 text-center"
						style="width: 32%;" name="mobile_first" id="mobile_first"
						maxlength="3" /> <input type="text"
						class="form-control input-sm pull-left margin-r-10 text-center"
						style="width: 32%;" name="mobile_middle" id="mobile_middle"
						maxlength="4" /> <input type="text"
						class="form-control input-sm pull-left text-center"
						style="width: 31%;" name="mobile_last" id="mobile_last"
						maxlength="4" />
					</li>
					<li class="list-group-item clearfix">
						<p>
							<strong>TEL</strong>
						</p> <input type="text"
						class="form-control input-sm pull-left margin-r-10 text-center"
						style="width: 32%;" name="tel_first" id="tel_first" maxlength="3" />
						<input type="text"
						class="form-control input-sm pull-left margin-r-10 text-center"
						style="width: 32%;" name="tel_middle" id="tel_middle"
						maxlength="4" /> <input type="text"
						class="form-control input-sm pull-left text-center"
						style="width: 31%;" name="tel_last" id="tel_last" maxlength="4" />
					</li>
					<li class="list-group-item clearfix">
						<p>
							<strong>EMAIL</strong>
						</p> <input type="text" class="form-control input-sm margin-r-10"
						name="email" id="email" maxlength="26" />
					</li>
				</ul>
			</div>
			<div class="panel panel-default pull-right"
				style="width: 48%; margin-left: 30px;">
				<div class="panel-heading" style="padding: 5px 10px">
					<h4>회원사정보</h4>
				</div>
				<ul class="list-group">
					<li class="list-group-item" style="height: 86px;">
						<p>
							<strong>사업자등록번호</strong>
						</p>
						<div class="clearfix margin-b-10">
							<div class="pull-left">
								<input type="text"
									class="form-control input-sm pull-left margin-r-10 text-center"
									style="width: 31%;" name="biz_first" id="biz_first"
									maxlength="3" /> <input type="text"
									class="form-control input-sm pull-left margin-r-10 text-center"
									style="width: 31%;" name="biz_middle" id="biz_middle"
									maxlength="2" /> <input type="text"
									class="form-control input-sm pull-left text-center"
									style="width: 31%;" name="biz_last" id="biz_last" maxlength="5" />
							</div>
						</div>
					</li>
					<li class="list-group-item clearfix">
						<p>
							<strong>업체명</strong>
						</p> <input type="text" class="form-control" name="company"
						id="company" maxlength="32" readonly="readonly"
						disabled="disabled" />
					</li>
					<li class="list-group-item clearfix">
						<p>
							<strong>사업자등록증</strong>
						</p> <input type="text" class="form-control" name="file" id="file"
						readonly="readonly" disabled="disabled" />
					</li>
					<li class="list-group-item clearfix">
						<p>
							<strong>대표자명</strong>
						</p> <input type="text" class="form-control input-sm" name="ceo"
						id="ceo" maxlength="16" />
					</li>
					<li class="list-group-item clearfix">
						<p>
							<strong>대표번호</strong>
						</p> <input type="text"
						class="form-control input-sm pull-left margin-r-10 text-center"
						style="width: 32%;" name="number_first" id="number_first"
						maxlength="3" /> <input type="text"
						class="form-control input-sm pull-left margin-r-10 text-center"
						style="width: 32%;" name="number_middle" id="number_middle"
						maxlength="4" /> <input type="text"
						class="form-control input-sm pull-left text-center"
						style="width: 31%;" name="number_last" id="number_last"
						maxlength="4" />
					</li>
					<li class="list-group-item clearfix">
						<p>
							<strong>FAX</strong>
						</p> <input type="text"
						class="form-control input-sm pull-left margin-r-10 text-center"
						style="width: 32%;" name="fax_first" id="fax_first" maxlength="3" />
						<input type="text"
						class="form-control input-sm pull-left margin-r-10 text-center"
						style="width: 32%;" name="fax_middle" id="fax_middle"
						maxlength="4" /> <input type="text"
						class="form-control input-sm pull-left text-center"
						style="width: 31%;" name="fax_last" id="fax_last" maxlength="4" />
					</li>
					<li class="list-group-item">
						<p>
							<strong>사업장주소</strong>
						</p> <input type="text" class="form-control" name="address"
						id="address" maxlength="26" readonly="readonly"
						disabled="disabled" />
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
		<div class="container-fluid" style="margin-top: 20px; margin-bottom: 20px;">
			<button type="button" class="confirm btn btn-primary btn-m wd100"
				onclick="onFindPWSubmit();">확인</button>
			<button type="button" id="cancel" name="cancel"
				class="btn btn-default btn-m wd100" style="margin-left: 10px;"
				onclick="onCancel(0);">취소</button>
		</div>
	</form>
</body>
</html>