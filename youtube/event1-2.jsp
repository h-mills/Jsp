<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String device_imei = request.getParameter("device_imei");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="robots" content="noindex, nofollow">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/js/jquery2.1.4.min.js"></script>
<script type="text/javascript">
	function maxLengthCheck(object) {
		if (object.value.length > object.maxLength) {
			object.value = object.value.slice(0, object.maxLength);
		}
	}
	function fn_request() {
		location.href = "/landing/aekyung/event1-3.jsp";
	<%-- 
		var device_imei = "<%=device_imei%>";
		var chk = $('#isagree').prop("checked");
		if(!chk) {
			alert("개인 정보 제공에 동의해주세요.");
			return false;
		}
		var name = $('#apply_name').val().trim();
		var mobile_1 = $('#apply_mobile_1').val();
		var mobile_2 = $('#apply_mobile_2').val();
		var mobile_3 = $('#apply_mobile_3').val();
		var mobile = mobile_1 + mobile_2 + mobile_3;
		
		var email = $('#apply_email').val().trim();
		if (name == '') {
			alert("이름을 입력해주세요.");
			$('#apply_name').focus();
			return false;
		}
		if (mobile_1 == '') {
			alert("휴대폰 번호를 입력해주세요.");
			$('#apply_mobile_1').focus();
			return false;
		}
		if (mobile_2 == '') {
			alert("휴대폰 번호를 입력해주세요.");
			$('#apply_mobile_2').focus();
			return false;
		}
		if (mobile_3 == '') {
			alert("휴대폰 번호를 입력해주세요.");
			$('#apply_mobile_3').focus();
			return false;
		}
		if (email == '') {
			alert("이메일을 입력해주세요.");
			$('#apply_email').focus();
			return false;
		}
		if (!confirm("위 정보로 응모 하시겠습니까?")) {
			return false;
		}
		
		$.ajax({
			type : 'post',
			url : "updateUserData.ak",
			data : {
				device_imei : device_imei,
				name : name,
				mobile : mobile,
				email : email
			},
			async : false,
			success : function(data) {
				var JSONobj = JSON.parse(data);
				var result = JSONobj.result;
				if (result == "success") {
					location.href = "/landing/aekyung/event1-3.jsp";
				} else {
					alert("응모에 실패했습니다. 관리자에게 문의해주세요.");
					return false;
				}
			}
		}); --%>
	}
</script>
<title>HiddenTag for AGE20s EVENT</title>
<style>
* {
	list-style: none;
	margin: 0;
	padding: 0;
	border: none;
	text-decoration: none;
}

html {
	font-family: 'Nanum Gothic', '맑은 고딕', Arial, sans-serif;
	background-image: url("./img/age20s_event_02.jpg");
	background-repeat: no-repeat;
	background-size: cover;
}

img {
	width: 100%;
}

div.basic {
	width: 100%;
	text-align: center;
	position: relative;
	clear: both;
}

::-webkit-input-placeholder { /* WebKit browsers */
	color: #bbb;
}

:-moz-placeholder { /* Mozilla Firefox 4 to 18 */
	color: #bbb;
	opacity: 1;
}

::-moz-placeholder { /* Mozilla Firefox 19+ */
	color: #bbb;
	opacity: 1;
}

:-ms-input-placeholder { /* Internet Explorer 10+ */
	color: #bbb;
}

.content1 {
	position: relative;
	width: 100%;
	display: block;
	height: 220px;
}

#content {
	position: relative;
	width: 100%;
	display: block;
	height: 200px;
}

#content .clear {
	clear: both;
	width: 85%;
	padding-top: 2%;
	margin-left: 8%;
}

.clear label {
	color: #000;
	font-weight: bold;
	display: block;
	float: left;
	width: 75px;
	text-decoration: none;
	margin-top: 5%;
	font-size: 0.8em;
}

.clear label span {
	display: inline-block;
	text-align: left;
}

.clear input[type=text] {
	border: 1px solid #d8d8d8;
	border-radius: 0px;
	outline: none;
	font-size: 0.7em;
	color: #333;
	resize: none;
	padding: 2.5% 4%;
	width: 65%;
	clear: both;
	margin: 2% 0;
	-webkit-appearance: none;
	-moz-appearance: none;
	background: #fff;
	display: inline-block;
}

.clear input[type=number] {
	border: 1px solid #d8d8d8;
	border-radius: 0px;
	outline: none;
	font-size: 0.7em;
	color: #333;
	resize: none;
	padding: 2.5% 4%;
	width: 14.5%;
	clear: both;
	margin: 2% 0;
	-webkit-appearance: none;
	-moz-appearance: none;
	background: #fff;
	display: inline-block;
}

#check_all {
	width: 80%;
	margin: 0 auto;
	position: relative;
}

#check_all input[type=checkbox] {
	border: 1px solid #8e8e8e;
	resize: none;
	height: 1.5em;
	float: left;
	margin-left: 7%;
	border-radius: 20%;
}

#check_all label {
	font-size: 0.7em;
	padding: 0.2%;
	display: block;
	text-align: left;
	float: left;
	margin-left: 5%;
}

.btn {
	position: absolute;
	width: 100%;
	height: 6.5%;
	display: block;
	background-color: transparent;
	top: 73.2%;
	left: 0%;
}

.btn a {
	display: inline-block;
	width: 100%;
	height: 100%;
	border-radius: 0;
}

/* 미디어쿼리 */
@media only screen and (min-device-width : 320px) and (max-device-width
	: 568px) {
	.content1 {
		height: 190px;
	}
	#content {
		height: 160px;
	}
	.clear label {
		width: 60px;
		font-size: 0.7em;
	}
	#check_all input[type=checkbox] {
		margin-left: 0;
	}
	#check_all label {
		font-size: 0.6em;
	}
}

@media only screen and (min-device-width : 360px) and (max-device-width
	: 640px) {
	.content1 {
		height: 220px;
	}
	#content {
		height: 180px;
	}
	.clear label {
		width: 75px;
		font-size: 0.8em;
	}
	#check_all input[type=checkbox] {
		margin-left: 0;
	}
	#check_all label {
		font-size: 0.7em;
	}
}

@media only screen and (min-device-width : 375px) and (max-device-width
	: 667px) {
	#check_all label {
		font-size: 0.75em;
	}
}

@media only screen and (min-device-width : 414px) and (max-device-width
	: 736px) {
	.content1 {
		height: 260px;
	}
	#content {
		height: 190px;
	}
	.clear label {
		margin-top: 4%;
		font-size: 0.9em;
	}
}

@media only screen and (min-device-width : 768px) and (max-device-width
	: 1024px) {
	.content1 {
		height: 440px;
	}
	#content {
		height: 380px;
	}
	.clear label {
		width: 150px;
		font-size: 1.6em;
	}
	.clear input[type=text] {
		font-size: 1.2em;
		padding: 3.5%;
	}
	.clear input[type=number] {
		font-size: 1.2em;
		padding: 3.5%;
		width: 16.2%;
	}
	#check_all input[type=checkbox] {
		height: 30px;
		width: 30px;
	}
	#check_all label {
		font-size: 1.2em;
	}
}

@media only screen and (min-device-width : 1024px) and (max-device-width
	: 1366px) {
	.content1 {
		height: 570px;
	}
	#content {
		height: 510px;
	}
	.clear label {
		width: 220px;
		font-size: 2.0em;
	}
	.clear input[type=text] {
		font-size: 1.8em;
	}
	#check_all input[type=checkbox] {
		height: 50px;
		width: 50px;
	}
	#check_all label {
		font-size: 1.7em;
	}
}

@media only screen and (min-device-width : 1440px) and (max-device-width
	: 2960px) {
	.content1 {
		height: 800px;
	}
	#content {
		height: 800px;
	}
	.clear label {
		width: 280px;
		font-size: 3.0em;
	}
	.clear input[type=text] {
		font-size: 2.8em;
		padding: 3.5%;
	}
	.clear input[type=number] {
		font-size: 2.8em;
		padding: 3.5%;
		width: 16.5%;
	}
	#check_all input[type=checkbox] {
		height: 80px;
		width: 80px;
		margin-left: 0%;
	}
	#check_all label {
		font-size: 2.7em;
	}
}
</style>
</head>
<body>
	<div class="content1"></div>
	<div id="content">
		<div class="clear">
			<label for="product"><span>이름</span></label> <input type="text"
				name="col1" id="apply_name" placeholder="홍길동">
		</div>
		<div class="clear">
			<label for="product"><span>전화번호</span></label> 
			<input type="number" id="apply_mobile_1" name="col2" min="1" maxLength="3" placeholder="010" oninput="maxLengthCheck(this)"> 
			<input type="number" id="apply_mobile_2" name="col2" min="1" maxLength="4" placeholder="1234" oninput="maxLengthCheck(this)"> 
			<input type="number" id="apply_mobile_3" name="col2" min="1" maxLength="4" placeholder="5678" oninput="maxLengthCheck(this)">
		</div>
		<div class="clear">
			<label for="product"><span>이메일</span></label> <input type="text"
				name="col3" id="apply_email" placeholder="">
		</div>
	</div>
	<div id="check_all">
		<div class="inside">
			<input type="checkbox" name="check1" id="isagree"> 
			<label for="check1">이벤트 참여를 위한 개인 정보 제공에 동의합니다. </label>
		</div>
	</div>
	<div class="btn">
		<a href="/landing/aekyung/event1-3.jsp"></a>
	</div>
</body>
</html>