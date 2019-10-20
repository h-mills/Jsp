<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%
	String vidx = request.getParameter("vidx");
	String device_imei = request.getParameter("device_imei");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="robots" content="noindex, nofollow">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" type="text/css" href="/landing/muhak/css/good_day.css" />
<style type="text/css">
* {list-style: none; margin: 0; padding: 0; border: none;}
html {font-family: 'Nanum Gothic', '맑은 고딕', Arial, sans-serif; background: #fff;}
img {width: 100%;}
div.basic {width: 100%; text-align: center; position: relative; clear: both;}
div.btn {clear:both;width:100%;height:6%;margin:0 auto;position:relative;bottom:5%;font-size:1.0em;}
button.btn {border: none; color: white; padding: 3.5% 28.5%; cursor: pointer; font-size:1.0em;width:100%;}
button.info {background-color: #28316a;}
button.info:hover {background: #141a3f;}
</style>
<script src="/js/jquery2.1.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var idx = <%=device_imei%>;
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
					$('#datadiv').hide();
					$('#resultdiv').show();
				}else {
					document.getElementById("isapply").value = 1;
					if(result.video_luna == 1){$('#chk_1').attr("checked", true);}
					if(result.video_age == 1){$('#chk_2').attr("checked", true);}
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
<title>Aekyung Video Event</title>
</head>
<body>
	<input type="hidden" id="isapply">
	<div id="player" style="width: 100%; height: 500;"></div>
	<div class="btn" style="margin-top: 5%;" id="datadiv">
		<div class="basic" id="chkdiv" style="width: 100%; height: 30%; text-align: left;">
			<input type="checkbox" value="0" id="chk_1" disabled>luna<br>
			<input type="checkbox" value="0" id="chk_2" disabled>age<br>
			<input type="checkbox" value="0" id="chk_3" disabled>isolve
		</div>
		<div class="basic" id="applyDiv" style="width: 100%; height: 30%; display: none; text-align: left;">
			이름 : <input type="text" class="input-sm" style="width: 150px;" placeholder="이름을 입력해주세요." value="" id="apply_name"><br>
			휴대폰 번호 : <input type="text" class="input-sm" style="width: 250px;" placeholder="휴대폰 번호를 입력해주세요." value="" id="apply_mobile"><br>
			E-mail : <input type="text" class="input-sm" style="width: 200px;" placeholder="이메일을 입력해주세요." value="" id="apply_email">
		</div>
		<div class="btn" style="margin-top: 10%; padding-left: 0; padding-right: 0;">
			<button type="button" id="applyBtn" class="btn btn-info" onclick="fn_apply();" disabled>응모하기</button>
			<button type="button" id="reqBtn" class="btn btn-info" onclick="fn_request();" style="display: none;">완료</button>
		</div>
	</div>
	<div class="btn" style="margin-top: 5%; display: none;" id="resultdiv">
		<h3>응모완료!</h3>
		<h5>OOO 미션에 성공하셨습니다.</h5>
		<h5>참여해주셔서 감사합니다.</h5><br><br>
		<h5 style="color: red;">당첨발표 : 2018년 0월 0일</h5>
		<h5 style="color: red;">당첨안내 : 문자, E-mail로 개별적으로 전송</h5>
	</div>
	<script>
		var tag = document.createElement('script');

		tag.src = "https://www.youtube.com/iframe_api";
		var firstScriptTag = document.getElementsByTagName('script')[0];
		firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

		var player;
		var videoId = 'Op5pFdV_aaU';
		var vidx = <%=vidx%>;
		var device_imei = <%=device_imei%>;
		
		if (vidx == 2) {
			videoId = 'RGjeYJhczzY';
		} else if (vidx == 3) {
			videoId = 'yTYN0x9vKck';
		}
		function fn_apply() {
			$('#chkdiv').hide();
			$('#applyBtn').hide();
			$('#reqBtn').show();
			$('#applyDiv').show();
		}
		function fn_request() {
			var name = $('#apply_name').val().trim();
			var mobile = $('#apply_mobile').val().trim();
			var email = $('#apply_email').val().trim();
			if(name == '') {alert("이름을 입력해주세요."); $('#apply_name').focus(); return false;}
			if(mobile == '') {alert("휴대폰 번호를 입력해주세요."); $('#apply_mobile').focus(); return false;}
			if(email == '') {alert("이메일을 입력해주세요."); $('#apply_email').focus(); return false;}
			if(!confirm("위 정보로 응모 하시겠습니까?")) {return false;}
			$.ajax({
				type: 'post',
				url : "updateUserData.ak",
				data : {device_imei : device_imei , name : name , mobile : mobile , email : email},
			    async: false,
				success : function(data) {
					var JSONobj = JSON.parse(data);
					var result = JSONobj.result;
					if(result == "success"){
						$('#datadiv').hide();
						$('#resultdiv').show();
					}else {
						alert("응모에 실패했습니다. 관리자에게 문의해주세요.");
						return false;
					}
				}
			});
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
								alert("루나 홍보 영상 시청을 완료 하셨습니다!");
								return false;
							} else if(vidx == 2){
								alert("에이지20 홍보 영상 시청을 완료 하셨습니다!");
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
							if(!$('#chk_1').prop("checked") && vidx == 1){
								alert("루나 홍보 영상 시청을 완료 하셨습니다!");
								return false;
							} else if(!$('#chk_2').prop("checked") && vidx == 2){
								alert("에이지20 홍보 영상 시청을 완료 하셨습니다!");
								return false;
							} else if(!$('#chk_3').prop("checked") && vidx == 3){
								alert("아이솔브 홍보 영상 시청을 완료 하셨습니다!");
								return false;
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
</body>
</html>