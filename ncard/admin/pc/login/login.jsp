<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<%@ include file="/WEB-INF/jsp/pc/login/session.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>

<title>로그인</title>

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

p {
	float: left;
}
</style>

<script type="text/javascript">
	function loginfn() {
		var userid = document.getElementById('user_id').value;
		if (userid.length <= 0) {
			alert("아이디를 입력해 주세요");
			return;
		}
		var passwd = document.getElementById('user_pwd').value;
		if (passwd.length <= 0) {
			alert("비번을 입력해 주세요");
			return;
		}
		frm.action = "/pc/login/submit";
		frm.submit();
	}

	function onEnterSubmit() {
		var keyCode = window.event.keyCode;
		if (keyCode == 13)
			loginfn();
	}
</script>
</head>
<body>
	<div class="container-fluid" style="width: 50%;">
		<form method="post" name="frm">
			<div class="box">
				<div class="inner">
					<div class="hh">
						<h4 class="">
							<img src="/image/png/glyphicons-4-user.png" width="18" alt="" />&nbsp;&nbsp;<strong>로그인</strong>
						</h4>
					</div>
					<div class="container">
						<ul class="list-group">
							<li class="list-group-item">
								<p>
									<strong>아이디</strong>
								</p> <input type="text" class="form-control" name="user_id"
								id="user_id" maxlength="30" placeholder="ID" tabindex="1">
							</li>
							<li class="list-group-item clearfix">
								<p>
									<strong>비밀번호</strong>
								</p> <input type="password" class="form-control" name="user_pwd"
								id="user_pwd" maxlength="30" placeholder="PASSWORD" tabindex="2"
								onkeydown="onEnterSubmit()">
							</li>
						</ul>
						<div class="row">
							<button class="btn btn-primary btn-lg btn-block" type="button"
								style="width: 400px;" onclick="loginfn()">로그인</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
</html>