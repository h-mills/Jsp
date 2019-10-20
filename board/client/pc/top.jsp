<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
<title>Top메뉴</title>
<style>
* {text-decoration: none;}
li {list-style: none;text-decoration: none;float: left;}
</style>

<script type="text/javascript">
$(document).ready(function() {
	//레벨에 따른 메뉴 표시
	var first_menu = "";
	if ("${LEVEL.m_dept}" != "1") {$("#m_1").prop("style", "display:none");} else {if (first_menu == "") first_menu = "1"}
	if ("${LEVEL.m_order}" != "1") {$("#m_2").prop("style", "display:none");} else {if (first_menu == "") first_menu = "2"}
	if ("${LEVEL.m_card}" != "1") {$("#m_3").prop("style", "display:none");} else {if (first_menu == "") first_menu = "3"}
	if ("${LEVEL.m_stats}" != "1") {$("#m_4").prop("style", "display:none");} else {if (first_menu == "") first_menu = "4"}
	if ("${LEVEL.m_notice}" != "1") {$("#m_5").prop("style", "display:none");} else {if (first_menu == "") first_menu = "5"}
	$("#m_" + first_menu).addClass("active");
	$("#home_menu").attr("onclick", "move(" + first_menu + ")");  //홈 메뉴 이미지
});

//페이지 이동
function move(value)
{  
	parent.frame_move(value);
	$('#navbar li').removeClass("active");
	$("#m_" + value).addClass("active");
}

//로그 아웃
function logout()
{
	if(confirm("로그아웃 하시겠습니까?") != 1) return;
	location.href = "/pc/login/logout";
} 

function userchange()
{
	var option = document.getElementById("usersel").value;
	if(option == "1")
	{
		window.open('/pc/login/usermodify', '관리자정보변경', 'width=1000, height=870, status=1, scrollbars=1, location=1');
	}
	else if(option == "2")
	{
		window.open('/pc/login/companymodify', '회원사정보변경', 'width=1000, height=870, status=1, scrollbars=1, location=1');
	}
	else if(option == "3")
	{
		if(confirm("탈퇴 하시겠습니까?") != true) {
			document.getElementById("usersel").selectedIndex = "0";
			return;
		}
		frm.action = "/pc/login/deleteuser";
		frm.submit();
	}
	document.getElementById("usersel").selectedIndex = "0";
}

</script>
	
</head>   
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<form method="post" name="frm">
		<nav class="navbar navbar-default navbar-fixed-top sd-n">
		<div class="container">
			<div class="navbar-header">
				<a href="javascript:void(0);" class="navbar-brand" onclick="move(1);" id="home_menu"><img src="/img/logo.png" alt="" width="100px;"></a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li class="active" onclick="move(1);" id="m_1"><a href="javascript:void(0)">부서관리</a></li>
					<li onclick="move(2);" id="m_2"><a href="javascript:void(0)">주문내역</a></li>
					<li onclick="move(3);" id="m_3"><a href="javascript:void(0)">명함관리</a></li>
					<li onclick="move(4);" id="m_4"><a href="javascript:void(0)">통계</a></li>
					<li onclick="move(5);" id="m_5"><a href="javascript:void(0)">공지사항</a></li>
				</ul>
				<div class="navbar-form navbar-right">
					<select name="usersel" id="usersel" onchange="userchange();">
					<option value="0" selected="selected"><%=session.getAttribute("USER_ID") %></option>
					<option value="1">관리자정보변경</option>
					<option value="2">회원사정보변경</option>
					<option value="3">회원탈퇴</option>
					</select>
					님 환영합니다.&nbsp;
					<button type="button" class="btn btn-default btn-sm" onclick="logout();">로그아웃</button>
				</div>
			</div>
		</div>
	</nav>
	</form>
</body>
</html>