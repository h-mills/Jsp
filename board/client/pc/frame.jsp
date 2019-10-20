<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/include.jsp" %>

<html>
<head>
<title>BODY</title>
<script type="text/javascript">	
function frame_move(value)
{
	 if (value == 1) 
	 {
		 document.getElementById("body").src = "/pc/dept/main";  	 
	}
	 else if (value == 2) 
	 {
		 document.getElementById("body").src = "/pc/order/order";
  	 }
	 else if (value == 3) 
	 {
		 document.getElementById("body").src = "/pc/card/card_view";
  	 }
	 else if (value == 4)
	 {
		 document.getElementById("body").src = "/pc/statistics/stats_scan";
	 }else if (value ==5)
	 {
		 document.getElementById("body").src = "/pc/notice/notice";
	 }
};

$(document).ready(function() {
	var first_menu_url = "";
	if ("${LEVEL.m_dept}" == "1" && first_menu_url == "") first_menu_url = "/pc/dept/main";
	if ("${LEVEL.m_order}" == "1" && first_menu_url == "") first_menu_url = "/pc/order/order";
	if ("${LEVEL.m_notice}" == "1" && first_menu_url == "") first_menu_url = "/pc/notice/notice";
	if ("${LEVEL.m_card}" == "1" && first_menu_url == "") first_menu_url = "/pc/card/card_view";
	if ("${LEVEL.m_stats}" == "1" && first_menu_url == "") first_menu_url = "/pc/statistics/stats_scan";
	$("frameset > frame[name='body']").attr("src", first_menu_url);
});
</script>
</head>

<frameset rows="60,*,70" frameborder="no" border="0" framespacing="0">
	<frame src="/pc/main/top" name="top" scrolling="No" noresize="noresize" marginwidth="0" marginheight="0" id="top" />
	<frame src="/pc/dept/main" name="body" marginwidth="0" marginheight="0" id="body" frameborder="0"/>
	<frame src="/pc/main/bottom" name="bottom" scrolling="No" noresize="noresize" id="bottom" />
</frameset>

<noframes>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
</body>
</noframes>
</html>