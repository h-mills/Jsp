<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>로그인</title>
<link href="/common/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/common/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="/common/css/pop.css" rel="stylesheet">
<link rel="stylesheet" href="/common/css/style.css" rel="stylesheet">
<style>
.container-fluid {
	width: 50%;
	height: 30%;
	margin: 0 auto;
} /*style수정*/
.box {
	position: relative;
	width: 100%;
	height: 100%;
	display: table;
} /*style추가*/
.inner {
	display: table-cell;
	vertical-align: middle;
	text-align: center;
} /*style추가*/
.hh {
	margin: 0;
	position: relative;
	margin-left: -320px;
} /*style추가*/
h4 {
	margin-left: 3%;
} /*style수정*/
.container {
	width: 440px;
	height: 30%;
	margin: 0 auto;
	margin-top: 20px;
} /*style수정*/
.row {
	display: inline-block;
	margin: 2px
}

.row_b {
	display: block;
	width: 100%;
	text-align: center;
}

span a {
	text-decoration: none;
}
p {float:left;}
</style>
<script type="text/javascript">
	function loginfn() {
		var userid = document.getElementById('user_id').value;
		if (userid.length <= 0) {
			alert('아이디를 입력해 주세요');
			return;
		}
		var passwd = document.getElementById('user_pwd').value;
		if (passwd.length <= 0) {
			alert('비번을 입력해 주세요');
			return;
		}
		frm.action = '/pc/login/submit';
		frm.submit();
	}

	function onEnterSubmit() {
		var keyCode = window.event.keyCode;
		if (keyCode == 13)
			loginfn();
	}

	function onRegist() {
		frm.action = '/pc/login/regist';
		frm.submit();
	}

	function onFind(option) {
		if (option == '1') {
			frm.action = '/pc/login/findid';
		} else {
			frm.action = '/pc/login/findpw';
		}
		frm.submit();
	}
</script>
</head>

<body>
	<form method="post" name="frm">
		<div class="container-fluid" style="width: 50%;">
			<div class="box">
				<div class="inner">
					<div class="hh">
						<h4 class="">
							<img src="/img/png/glyphicons-4-user.png" width="18" alt="">&nbsp;&nbsp;<strong>로그인</strong>
						</h4>
					</div>
					<div class="container">
						<ul class="list-group">
							<li class="list-group-item">
								<p>
									<strong>아이디</strong>
								</p> <input type="text" name="user_id" id="user_id" maxlength="16"
								class="form-control">
							</li>
							<li class="list-group-item clearfix">
								<p>
									<strong>비밀번호</strong>
								</p> <input type="password" class="form-control" name="user_pwd"
								id="user_pwd" maxlength="16" onkeydown="onEnterSubmit();">
							</li>
						</ul>

						<div class="row">
							<button class="btn btn-primary btn-lg btn-block" type="button"
								style="width: 400px;" onclick="loginfn();">로그인</button>
						</div>
						<div class="row_b">
							<button type="button" class="btn btn-link btn-m"
								onclick="onFind(1);">
								<span>아이디 찾기</span>
							</button>
							<button type="button" class="btn btn-link btn-m"
								onclick="onFind(2);">
								<span>비밀번호 찾기</span>
							</button>
							<button type="button" class="btn btn-link btn-m"
								onclick="onRegist();">
								<span>회원가입</span>
							</button>
						</div>
					</div>
					<!-- Query (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
					<script
						src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
					<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
					<script src="/common/js/bootstrap.min.js"></script>
				</div>
			</div>
		</div>
	</form>
	<%@ include file="/WEB-INF/jsp/pc/login/session.jsp"%>
</body>
</html>