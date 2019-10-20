<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 1L);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HiddentagBiz</title>
<style>
*{list-style:none; text-decoration:none; margin:0; padding:0; border:none; letter-spacing:-1px; color:#222;}
html{font-family:'Noto Sans KR', 'Nanum Gothic', '맑은 고딕', '굴림', Arial, sans-serif; background:#fff;}
body{padding:0; margin:0; font-size:100%; width: 100%;max-width: none !important;}
.basic topnav {position:fixed; top:0; z-index:2; font-size:2.0em;width:100%;letter-spacing:1px;}
.nav_left {overflow:hidden; width:41%; float:left; height:100px;}
.nav_left img {width: 200px; margin-top: 30px; margin-left:30px;}
.nav_left a {display:block; width:260px; height:100px;}
.nav_right {overflow:hidden; width:59%; float:left;}
.nav_right ul {height:100px; width:100%; list-style-type:none;}
.nav_right ul li {float:left; text-align:center; height:100px; font-size:1.8em; width:25%;}
.nav_right ul li a {display:inline-block;padding-top:30px;padding-right: 40px;padding-bottom: 30px;padding-left: 40px; border: 1px solid transparent; vertical-align:middle;}
.nav_right ul li.active {background-color:#0080b6;}
.nav_right ul li.active a {color:#fff; font-weight:bold;}
.nav_right ul li:hover{background-color:#0080b6;}
.nav_right ul li a:hover{color:#fff; font-weight:bold;}
.basic{width:100%; margin:0 auto; position:relative; box-sizing:border-box; overflow:hidden;}
.bg {position:relative;background-image:url('/img/landing/1/1/backgroundimg.png'); width:100%; height:650px; background-repeat: no-repeat; background-size: cover;}
.bg .content {position:absolute; bottom:0; left:0;width:100%; height:40%; background: rgba(0, 0, 0, 0.5); text-align:center; line-height:300px;}
.bg .content .cont1 {width:30%;float:left;height:100%;}
.bg .content .cont1 .circle {position:absolute;width:220px; height:220px; border-radius:50%;border: 5px #1378a0; top:10px; left:10px;;}
.bg .content .cont2 {width:70%;float:left;text-align:left;position:relative;display:table-cell;height:100%;}
.bg .content .cont2 .inner {width:60%;float:left;text-align:left;position:relative;display:table-cell;height:100%;margin-left:0%;vertical-align:top;}
.bg .content .cont2 span {color:#fff; font-size:3.0em;width:100%;height:30%;display:block; box-sizing:border-box; text-align:left; vertical-align:top;}
.bg .content .cont2 span.t1 {margin-top:-20%; text-overflow:ellipsis;}
.bg .content .cont2 span.t2 {font-size:2.0em; text-overflow:ellipsis;}
.bg .content .cont2 span.t3 {font-size:2.0em;margin-top:-5%;}/*margin-top퍼센트로 전화번호 위치 조정가능*/
.bg .content .cont2 span.t3 a {color:#fff;}
.dataDiv {width:99%; border-radius:15px; height:auto; position:relative;margin:0 auto; font-size:1.9em; border-collapse:collapse;}
.line {width:100%; position:relative; height: auto; min-height:100px; overflow: auto; border-bottom:2px solid #e9e9e9; }
.left {width:25%; height:auto; float:left;}
.right {width:75%; height:auto; float:left;}
p.nm {padding:30px; color:#0080b6;margin-left:10px;}
p.nm2 {padding:30px;}
.center{width:95%; margin:0 auto; border:2px solid #c0c0c0; border-radius:10px; overflow:hidden; display:-webkit-box;}
.btn{width:95%; margin:2% auto; border-radius:10px; overflow:hidden;}
button{width:100%; margin:0; padding:2.5% 0; font-size:2.0em; color:#fff; background:#0080b6; box-shadow:0 3px 0 rgba(0,120,170,1.0); text-align:center;}
.footer{background:#f6f6f6; margin:8% 0 0 0; padding:5% 0 15% 0;}
.copyright{width:100%; padding:2% 0; text-align:center; background:#a7a7a7; color:#fff;float:left;}
#replyInputDiv {width:100%;border-top:solid 1px #c0c0c0;padding:3% 0 2% 0;}
#replyInputDiv table td input {font-size:1.9em;border:solid 1px #848484;padding:1%;}
#replyInputDiv table {width:100%;padding:2% 4%;}
#replyInputDiv table td {padding:1% 0;}
#replyInputDiv p {padding:0 4%;}
#replyDiv {width:100%;float:left;}
#replyInputDiv button {width:100px;}
#replycontent {width:100%;}
.u_cbox_content_wrap {width:100%;float:left;border-top:solid 1px #c0c0c0;margin-bottom:4%;}
.u_cbox_list {display:block;}
.u_cbox_comment {display:block;float:left;width:100%;border-bottom:solid 1px #c0c0c0;}
.u_cbox_comment_box {display:block;background:#eee;padding:0 4%;}
.u_cbox_area {font-size:1.9em;float:left;margin:2% 0;}
.u_cbox_nick {display:block;float:left;font-weight:600;color:#0080b6;margin:1% 0;width:100%;}
.u_cbox_contents {display:block;float:left;margin:1% 0;width:100%;}
.u_cbox_date {display:block;float:left;margin:1% 0;width:100%;color:#888;}
.u_cbox_del {display:block;float:left;margin:1% 0;width:100%;color:#848484;}
#youtubuDiv {width:100%;text-align:center;padding-bottom:2%;}
.c_title {font-size:1.9em;font-weight:600;color:#0080b6;}
.c_more_box {width:100%;height:40px;text-align:center;float:left;padding:0 0 4% 0;}
#lineDiv img {width:80px;margin-top:3%;padding-left:30px;margin-left:10px;}
#kakaoDiv img {width:80px;margin-top:3%;padding-left:30px;margin-left:10px;}
.c_more {display:block;font-size:1.9em;font-weight:600;}
</style>
</head>
<%@include file="/WEB-INF/jsp/landing/landingInclude.jsp"%>
<!-- 스크립트 자리 -->
<body>
	<div class="basic topnav" style="background-color: #f8f8f8;">
		<div class="nav_left">
			<a href="http://hiddentag.co.kr/"><img src="/img/logo.png"/></a>
		</div>

		<div class="nav_right">
			<ul class="navi">
				<li id="menu_ko"><a href="javascript:void(0);">한글</a></li>
				<li id="menu_en"><a href="javascript:void(0);">ENG</a></li>
				<li id="menu_cn"><a href="javascript:void(0);">中文</a></li>
				<li id="menu_jp"><a href="javascript:void(0);">日文</a></li>
			</ul>
		</div>
	</div>

	<div class="body">
		<div class="basic header">
			<div class="bg">
				<img src="/img/landing/1/1/cknb-logo.png" style="position:relative; margin-top:5%; margin-left:58%; width:40%;"/>
				<div class="content">
					<div class="cont1">
						<div class="circle"><img id="image" src="" style="position:relative; border-radius:50%;border: solid 5px #1378a0;"></div>
					</div>
					<div class="cont2">
						<div class="inner">
						<span id="show_name" class="t1"></span>
						<span id="show_part" class="t2"></span>
						<span id="show_mobile" class="t3"></span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="basic center" style="margin-top: 70px; position: relative;">
			<div id="dataDiv" class="dataDiv">
				<div class="line">
					<div class="left"><p id="t_name" class="nm">이름</p></div>
					<div class="right"><p id="name" class="nm2"></p></div>
				</div>
				<div class="line">
					<div class="left"><p id="t_company" class="nm">회사</p></div>
					<div class="right"><p id="company" class="nm2"></p></div>
				</div>
				<div class="line">
					<div class="left"><p id="t_part" class="nm">부서</p></div>
					<div class="right"><p id="part" class="nm2"></p></div>
				</div>
				<div class="line">
					<div class="left"><p id="t_position" class="nm">직급</p></div>
					<div class="right"><p id="position" class="nm2"></p></div>
				</div>
				<div class="line">
					<div class="left"><p id="t_address" class="nm">주소</p></div>
					<div class="right"><p id="address" class="nm2"></p></div>
				</div>
				<div class="line">
					<div class="left"><p id="t_email" class="nm">메일</p></div>
					<div class="right"><p id="email" class="nm2"></p></div>
				</div>
				<div class="line">
					<div class="left"><p id="t_tel" class="nm">전화</p></div>
					<div class="right"><p id="tel" class="nm2"></p></div>
				</div>
				<div class="line">
					<div class="left"><p id="t_fax" class="nm">팩스</p></div>
					<div class="right"><p id="fax" class="nm2"></p></div>
				</div>
				<div class="line">
					<div class="left"><p id="t_mobile" class="nm">모바일</p></div>
					<div class="right"><p id="mobile" class="nm2"></p></div>
				</div>
				<div class="line" id="kakaoDiv">
					<div class="left"><img src="/img/landing/kakaolink_btn_medium.png"></div>
					<div class="right"><p id="kakao" class="nm2"></p></div>
				</div>
				<div class="line" id="lineDiv">
					<div class="left"><img src="/img/landing/LINE_Icon.png"></div>
					<div class="right"><p id="line" class="nm2"></p></div>
				</div>
			</div>
		</div>

		<div style="margin-top: 40px;">
			<div id="siteDiv" class="basic btn">
				<center>
					<a href="http://www.cknb.co.kr/"><button>http://www.cknb.co.kr</button></a>
				</center>
			</div>

			<div class="saveContact">
				<div id="saveDiv" class="basic btn">
					<center><a href=""><button>주소록 저장하기</button></a></center>
				</div>
			</div>
		</div>
	</div>

	<div id="youtubuDiv"></div>

	<div class="copyright">Copyright&copy;2016 CK&amp;B All rights reserved.</div>
</body>
</html>