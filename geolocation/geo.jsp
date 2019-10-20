<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HiddenTag for MEFACTORY</title>
<script src="/js/jquery-2.1.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		if ("geolocation" in navigator) {
			getLocation();
		} else {
			alert("위치정보 서비스를 지원하지 않는 브라우저입니다.");
		}
	});
	
	function getLocation() {
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(showPosition);
		} else {
			alert("위치 정보를 확인 할 수 없습니다.");
		}
	}
	function showPosition(position) {
		var lat = position.coords.latitude;
		var lng = position.coords.longitude;
		if(lat != null && lng != null){
			gpsToAddress(lat,lng);
		}
	}
	function gpsToAddress(lat,lng) {
		var no = document.getElementById('no').value;
		$.ajax({
			type : 'post',
			url : "/det.cop",
			data : {
				lat : lat,
				lng : lng,
				no : no
			},
			async : true,
			success : function(data) {}
		});
	}
</script>
</head>
<body>
</body>
</html>