<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%
	String vidx = request.getParameter("vidx");
	String device_imei = request.getParameter("device_imei");
	System.out.println("ak_vidx = " + vidx);
	System.out.println("device_imei = " + device_imei);
%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="robots" content="noindex, nofollow">
<title>HiddenTag for AGE20s EVENT</title>
<script src="/js/jquery2.1.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var idx = "<%=device_imei%>";
	$.ajax({
		type: 'post',
		url : "getApplyInfo.ak",
		data : {device_imei : idx},
	    async: false,
		success : function(data) {
			var JSONobj = JSON.parse(data);
			var result = JSONobj.result;
			if(result != null){
				var namechk = result.applyer_name.length;
				if(namechk > 1){
					document.getElementById("isapply").value = 1;
					location.href = "/landing/aekyung/event1-3.jsp";
				}else {
					document.getElementById("isapply").value = 1;
					if(result.video_age == 1){$('#chk_1').attr("checked", true);}
					if(result.video_luna == 1){$('#chk_2').attr("checked", true);}
					if(result.video_isolve == 1){$('#chk_3').attr("checked", true);}
					var sum = 0;
					for(var i=1; i<=3; i++){
						var chk = $('#chk_'+i).prop("checked");
						if(chk) sum += 1;
						if(sum == 3){
							$('#applyBtn').attr("disabled", false);
						}
					}
				}
			}
		}
	});
});
</script>
<style>
* {
	list-style: none;
	margin: 0;
	padding: 0;
	border: none;
	font-family: 'Nanum Gothic', '맑은 고딕', Arial, sans-serif;
}

html {
	background: #fff; 
}

body {
	-webkit-text-size-adjust:100%;
}

div.basic {
	width: 100%;
	text-align: center;
	position: relative;
	clear: both;
}
.content1 {
	position: relative;
    width: 100%;
    display: block;
    height: 220px;
}
img {
	width: 100%;
}

div.no {
	display: block;
    margin: 0 auto;
    width: 70%;
    position: absolute;
    top: 66%;
    left: 15%;
}

.no #num {
	margin: 0 auto;
	width: 85%;
	text-align: center;
}

.no #num input[type="text"] {
	text-align: center;
	width: 1.1em;
	height: 1.1em;
	margin: 6% 2% 2% 2%;
	padding: 5%;
	font-size: 1.2em;
	border: 2px solid #de8d93; /* 입력 칸 테두리 */
	border-radius:0;
	border-top-left-radius: 0;
	border-top-right-radius: 0;
	border-bottom-right-radius: 0;
	border-bottom-left-radius: 0;
	-webkit-appearance: none;
}
.btn {
	position: absolute;
    width: 37%;
    height: 5.7%;
    display: block;
    background-color: transparent;
    top: 88.7%;
    left: 31.5%;
}
.btn a {
	display: inline-block;
	width: 100%;
	height: 100%;
	border-radius: 15px;
}
.container {
 	display: block;
    float: left;
    position: relative;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    margin-left: 3%;
}

/* Hide the browser's default checkbox */
.container input {
  position: absolute;
  opacity: 0;
  cursor: pointer;
  height: 0;
  width: 0;
}

/* Create a custom checkbox */
.checkmark {
  position: absolute;
  top: 0;
  left: 0;
  height: 25px;
  width: 25px;
  background-color: #fff;
  border: 1px solid #eb7979;
}

/* On mouse-over, add a grey background color */
.container:hover input ~ .checkmark {
  background-color: #fff;
  border: 1px solid #eb7979;
}

/* When the checkbox is checked, add a blue background */
.container input:checked ~ .checkmark {
  background-color: #eb7979;
}

/* Create the checkmark/indicator (hidden when not checked) */
.checkmark:after {
  content: "";
  position: absolute;
  display: none;
}

/* Show the checkmark when checked */
.container input:checked ~ .checkmark:after {
  display: block;
}

/* Style the checkmark/indicator */
.container .checkmark:after {
  left: 9px;
  top: 5px;
  width: 5px;
  height: 10px;
  border: solid white;
  border-width: 0 3px 3px 0;
  -webkit-transform: rotate(45deg);
  -ms-transform: rotate(45deg);
  transform: rotate(45deg);
}
img.imgbox {
	width:80%;
	float: left;
	margin-bottom: 3%;
}
.basic button {
	width: 50%;
    margin-top: 23%;
    padding: 5%;
    font-size: 0.9em;
    background-color: #303433;
    color: #fff;
    border-radius: 10px;
}
</style>
<!-- <script>
function moveFocus(num, fromform, toform) {
	var str = fromform.value.length;
	if (str == num) {
		toform.focus();
	}
}
</script> 기존 자동 탭 넘김 스크립트-->
</head>
<body>	
<input type="hidden" id="isapply">
	<div id="player" style="width: 100%; height: 500;"></div> <!-- 유투브 영역  -->
	<script>
		var tag = document.createElement('script');

		tag.src = "https://www.youtube.com/iframe_api";
		var firstScriptTag = document.getElementsByTagName('script')[0];
		firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

		var player;
		var videoId = 'RGjeYJhczzY';

		var vidx = <%=vidx%>;
		var device_imei = "<%=device_imei%>";
		
		if (vidx == 2) {
			videoId = 'Op5pFdV_aaU';
		} else if (vidx == 3) {
			videoId = 'yTYN0x9vKck';
		}
		function fn_apply() {
			location.href = "/landing/aekyung/event1-2.jsp?device_imei="+device_imei;
		}		
		function fn_end() {
			$('#chk_'+vidx).attr("checked", true);
			var isapply = $('#isapply').val();
			
			if(isapply == 0){
				$.ajax({
					type: 'post',
					url : "insertApplyInfo.ak",
					data : {device_imei : device_imei, vidx : vidx},
				    async: false,
					success : function(data) {
						var JSONobj = JSON.parse(data);
						var result = JSONobj.result;
						if(result == "success"){
							if(vidx == 1){
								alert("에이지20 홍보 영상 시청을 완료 하셨습니다!");
								return false;
							} else if(vidx == 2){
								alert("루나 홍보 영상 시청을 완료 하셨습니다!");
								return false;
							} else if(vidx == 3){
								alert("아이솔브 홍보 영상 시청을 완료 하셨습니다!");
								return false;
							}
						}else {
							alert("동영상 시청여부 확인에 실패 했습니다. 다시 시청해주세요.");
							return false;
						}
					}
				});
			} else {
				$.ajax({
					type: 'post',
					url : "updateApplyInfo.ak",
					data : {device_imei : device_imei, vidx : vidx},
				    async: false,
					success : function(data) {
						var JSONobj = JSON.parse(data);
						var result = JSONobj.result;
						if(result == "success"){
							if($('#chk_1').prop("checked") && vidx == 1){
								alert("에이지20 홍보 영상 시청을 완료 하셨습니다!");
							} else if($('#chk_2').prop("checked") && vidx == 2){
								alert("루나 홍보 영상 시청을 완료 하셨습니다!");
							} else if($('#chk_3').prop("checked") && vidx == 3){
								alert("아이솔브 홍보 영상 시청을 완료 하셨습니다!");
							}
							var sum = 0;
							for(var i=1; i<=3; i++){
								var chk = $('#chk_'+i).prop("checked");
								if(chk) sum += 1;
								if(sum == 3){
									$('#applyBtn').attr("disabled", false);
								}
							}
						}else {
							alert("동영상 시청여부 확인에 실패 했습니다. 다시 시청해주세요.");
							return false;
						}
					}
				});
			}
		}

		function onYouTubeIframeAPIReady() {
			player = new YT.Player('player', {
				videoId : videoId,
				playerVars : {
					'controls' : 0
				},
				events : {
					'onReady' : onPlayerReady,
					'onStateChange' : onPlayerStateChange,
				}
			});
		}

		function onPlayerReady(event) {
			
		}

		var done = false;
		function onPlayerStateChange(event) {
			if (event.data == YT.PlayerState.ENDED) {
				fn_end();
			}
		}
		function stopVideo() {
			player.stopVideo();
		}
	</script>
	<div class="basic">
		<img src="./img/age20s_event_01.jpg" /><!-- 배경이미지 -->
		<div class="no">
			<div>
				<img src="./img/age20s_event_box1.png" class="imgbox">
				<label class="container">
				  <input type="checkbox" value="0" id="chk_1" disabled>
				  <span class="checkmark"></span>
				</label>
			</div>
			<div>
				<img src="./img/age20s_event_box2.png" class="imgbox">
				<label class="container">
				  <input type="checkbox" value="0" id="chk_2" disabled>
				  <span class="checkmark"></span>
				</label>
			</div>
			<div>
				<img src="./img/age20s_event_box3.png" class="imgbox">
				<label class="container">
				  <input type="checkbox" value="0" id="chk_3" disabled>
				  <span class="checkmark"></span>
				</label>
			</div>
			<div class="basic">
				<button type="button" id="applyBtn" onclick="fn_apply();" disabled>응모하기</button>
			</div>
		</div>		
	</div>
</body>
</html>