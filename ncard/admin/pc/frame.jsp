<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/include.jsp"%>

<html>
<head>
<title>BODY</title>
<script type="text/javascript">
	function frame_move(value) {
		if (value == "1") {
			document.getElementById("body").src = "/pc/order/main?";
		} else if (value == "2") {
			document.getElementById("body").src = "/pc/company/companylist";
		} else if (value == "3") {
			document.getElementById("body").src = "/pc/card/card_view";
		} else if (value == "4") {
			document.getElementById("body").src = "/pc/statistics/stats_scan";
		} else if (value == "5") {
			document.getElementById("body").src = "/pc/notice/noticelist";
		} else if (value == "6") {
			document.getElementById("body").src = "/pc/member/main";
		} else if (value == "7") {
			document.getElementById("body").src = "/pc/industry/main";
		} else if (value == "8") {
			document.getElementById("body").src = "/pc/dept/main";
		}
	}

	$(document).ready(function() {
		var first_menu_url = "";
		if ("${USER_INFO.m_order}" == "1" && first_menu_url == "") first_menu_url = "/pc/order/main?";
		if ("${USER_INFO.m_company}" == "1" && first_menu_url == "") first_menu_url = "/pc/company/companylist";
		if ("${USER_INFO.m_card}" == "1" && first_menu_url == "") first_menu_url = "/pc/card/card_view";
		if ("${USER_INFO.m_stats}" == "1" && first_menu_url == "") first_menu_url = "/pc/statistics/stats_scan";
		if ("${USER_INFO.m_notice}" == "1" && first_menu_url == "") first_menu_url = "/pc/notice/noticelist";
		if ("${USER_INFO.m_member}" == "1" && first_menu_url == "") first_menu_url = "/pc/member/main";
		if ("${USER_INFO.m_industry}" == "1" && first_menu_url == "") first_menu_url = "/pc/industry/main";
		if ("${USER_INFO.m_dept}" == "1" && first_menu_url == "") first_menu_url = "/pc/dept/main";
		$("frameset > frame[name='body']").attr("src", first_menu_url);
	});
</script>
</head>

<frameset rows="60,*,10" frameborder="no" border="0" framespacing="0">
	<frame src="/pc/main/top" name="top" scrolling="No" noresize="noresize" marginwidth="0" marginheight="0" id="top" />
	<frame src="/pc/notice/noticelist" name="body" marginwidth="0" marginheight="0" id="body" frameborder="0" />
</frameset>

<noframes>
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	</body>
</noframes>
</html>