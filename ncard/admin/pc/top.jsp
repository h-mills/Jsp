<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<html lang="ko">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Top메뉴</title>

<script type="text/javascript">
	//페이지 이동
	function move(value) {
		parent.frame_move(value);
		$('#navbar li').removeClass("active");
		$("#m_" + value).addClass("active");
	}

	//로그 아웃
	function logout() {
		if (confirm("로그아웃 하시겠습니까?") != 1)
			return;
		location.href = "/pc/login/logout";
	}

	$(document).ready(function() {
		//레벨에 따른 메뉴 표시
		var first_menu = "";
		if ("${USER_INFO.m_order}" != "1") {$("#m_1").prop("style", "display:none");} else {if (first_menu == "") first_menu = "1"}
		if ("${USER_INFO.m_company}" != "1") {$("#m_2").prop("style", "display:none");} else {if (first_menu == "") first_menu = "2"}
		if ("${USER_INFO.m_card}" != "1") {$("#m_3").prop("style", "display:none");} else {if (first_menu == "") first_menu = "3"}
		if ("${USER_INFO.m_stats}" == "0") {$("#m_4").prop("style", "display:none");} else {if (first_menu == "") first_menu = "4"}
		if ("${USER_INFO.m_notice}" != "1") {$("#m_5").prop("style", "display:none");} else {if (first_menu == "") first_menu = "5"}
		if ("${USER_INFO.m_member}" != "1") {$("#m_6").prop("style", "display:none");} else {if (first_menu == "") first_menu = "6"}
		if ("${USER_INFO.m_industry}" != "1") {$("#m_7").prop("style", "display:none");} else {if (first_menu == "") first_menu = "7"}
		if ("${USER_INFO.m_dept}" != "1") {$("#m_8").prop("style", "display:none");} else {if (first_menu == "") first_menu = "8"}
		$("#m_" + first_menu).addClass("active");
		$("#home_menu").attr("onclick", "move(" + first_menu + ")");  //홈 메뉴 이미지
	});
</script>

<style>
* {text-decoration: none;}
li {list-style: none;text-decoration: none;float: left;}
</style>
</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top sd-n">
		<div class="container" style="padding: 0;">
			<div class="navbar-header">
				<a href="javascript:void(0);" class="navbar-brand" onclick="move(1);" id="home_menu"><img src="/image/logo.png" alt="" width="100px;"></a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li onclick="move(1);" id="m_1"><a href="javascript:void(0)">주문관리</a></li>
					<li onclick="move(2);" id="m_2"><a href="javascript:void(0)">업체관리</a></li>
					<li onclick="move(3);" id="m_3"><a href="javascript:void(0)">명함관리</a></li>
					<li onclick="move(4);" id="m_4"><a href="javascript:void(0)">통계</a></li>
					<li onclick="move(6);" id="m_6"><a href="javascript:void(0)">사용자관리</a></li>
					<li onclick="move(7);" id="m_7"><a href="javascript:void(0)">업종관리</a></li>
					<li onclick="move(8);" id="m_8"><a href="javascript:void(0)">직종관리</a></li>
					<li onclick="move(5);" id="m_5"><a href="javascript:void(0)">공지사항</a></li>
				</ul>
				<div class="navbar-form navbar-right" style="padding: 0;">
					<%=session.getAttribute("USER_NICKNAME")%>님 반갑습니다.&nbsp;
					<button type="button" class="btn btn-default btn-sm" onclick="logout();">로그아웃</button>
				</div>
			</div>
		</div>
	</nav>
</body>
</html>