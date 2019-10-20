<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Simple Map</title>
<meta name="viewport" content="initial-scale=1.0">
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAEBZGRiao46VZzFjDm2Srz8U9QRCUWb98&libraries=places" async defer></script>
<script type="text/javascript">
	function gpsClear() {
		$("#lat2").val('');
		$("#lng2").val('');
		$("#addr2").val('');
	}

	function gpsMix() {
		var data = "";
		data += $("#lat2").val()+";"+$("#lng2").val()+";"+$("#addr2").val();
		$("#data").val(data);
	}

	function initAutocomplete() {
		var map = new google.maps.Map(document.getElementById('map'), {
			center : {lat : 37.566535,lng : 126.97796919999996},
			zoom : 8,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		});

		// Create the search box and link it to the UI element.
		var input = document.getElementById('pac-input');
		var searchBox = new google.maps.places.SearchBox(input);
		map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

		// Bias the SearchBox results towards current map's viewport.
		map.addListener('bounds_changed', function() {
			searchBox.setBounds(map.getBounds());
		});

		var markers = [];

		// [START region_getplaces]
		// Listen for the event fired when the user selects a prediction and retrieve
		// more details for that place.
		searchBox.addListener('places_changed', function() {
			var places = searchBox.getPlaces();
			if (places.length == 0) {
				alert("검색된 주소가 없습니다.");
				return;
			}

			// Clear out the old markers.
			markers.forEach(function(marker) {
				marker.setMap(null);
			});

			markers = [];

			// For each place, get the icon, name and location.
			var bounds = new google.maps.LatLngBounds();
			places.forEach(function(place) {
				var icon = {
					url : place.icon,
					size : new google.maps.Size(71, 71),
					origin : new google.maps.Point(0, 0),
					anchor : new google.maps.Point(17, 34),
					scaledSize : new google.maps.Size(25, 25)
				};

				// Create a marker for each place.
				markers.push(new google.maps.Marker({
					map : map,
					icon : icon,
					title : place.name,
					position : place.geometry.location
				}));

				if (place.geometry.viewport) {
					// Only geocodes have viewport.
					document.getElementById('latHidden2').value = place.geometry.location.lat();
					document.getElementById('lngHidden2').value = place.geometry.location.lng();
					document.getElementById('address2').value = place.formatted_address;
					bounds.union(place.geometry.viewport);
				} else {
					bounds.extend(place.geometry.location);
				}
			});
			map.fitBounds(bounds);
		});
	}

	$(document).ready(function() {
		$('.btnMap2').on('click', function() {
			$("#myModal2").modal({backdrop: "static"});
		});

		$('#myModal2').on('show.bs.modal', function() {
			$("#myModal2 .modal-body").prepend("<input id='pac-input' class='controls' type='text' placeholder='주소 검색'>");
		});

		$('#myModal2').on('shown.bs.modal', function() {
			initAutocomplete();
		});

		$("#myModal2").on('hidden.bs.modal', function() {
			$("#map").empty();
			$("#pac-input").empty();
		});

		$('.btnChoice').on('click', function() {
			$("#myModal2").modal("hide");
			$("#lat2").val($("#latHidden2").val());
			$("#lng2").val($("#lngHidden2").val());
			$("#addr2").val($("#address2").val());
			});
		});
</script>
<style type="text/css">
/***** Google maps CSS *****/
#map {height: 100%;width: 100%;border: 2px solid darkgrey;}
.controls {margin-top: 10px;border: 1px solid transparent;border-radius: 2px 0 0 2px;box-sizing: border-box;-moz-box-sizing: border-box;height: 32px;outline: none;box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);}
#pac-input {background-color: #fff;font-family: Roboto;font-size: 15px;font-weight: 300;margin-left: 12px;padding: 0 11px 0 13px;text-overflow: ellipsis;width: 300px;}
#pac-input:focus {border-color: #4d90fe;}
.pac-container {font-family: Roboto;}
#type-selector {color: #fff;background-color: #4d90fe;padding: 5px 11px 0px 11px;}
#type-selector label {font-family: Roboto;font-size: 13px;font-weight: 300;}
.pac-container {background-color: #FFF;z-index: 20;position: fixed;display: inline-block;float: left;}
.modal {z-index: 20;}
</style>
</head>

<body>
	<c:if test="${data.data != null }">
	<div class="input-group input-group pull-right margin-t-10">
		<span class="input-group-addon" id="basic-addon" style="width: 5%;">주소</span>
		<input type="text" id="addr2" class="form-control" style="width: 80%;" value="${data.data[2] }"   readonly="readonly">
		<!-- 모달창을 띄울 버튼 -->
		<button type="button" class="btn btn-primary btnMap2" style="width: 20%;">주소검색</button>
		<input id="address2" type="hidden" value="">
	</div>
	<div class="input-group input-group pull-right margin-t-10">
		<input id="latHidden2" type="hidden" value="">
		<span class="input-group-addon" id="basic-addon" style="width: 5%;">위도</span>
		<input type="text" id="lat2"  class="form-control" style="width: 100%;" value="${data.data[1] }"  readonly="readonly">
	</div>
	<div class="input-group input-group pull-right margin-t-10">
		<input id="lngHidden2" type="hidden" value="">
		<span class="input-group-addon" id="basic-addon" style="width: 5%;">경도</span>
		<input type="text" id="lng2"  class="form-control" style="width: 100%;" value="${data.data[0] }" readonly="readonly">
	</div>
	<div class="input-group input-group pull-right margin-t-10"
		style="width: 100%; text-align: center;">
		<button type="button" class="btn btn-primary btn-m" onclick="update(3)"
			style="width: 15%;">데이터 수정</button>
	</div>
	</c:if>
	<!-- 모달창 -->
	<div class="modal fade" id="myModal2" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content" style="width: 730px; height: 500px;">
				<!-- 주소찾기 -->
				<div class="modal-header" style="">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<i class="fa fa-map-o" style="font-size: 24px"></i>주소찾기
					</h4>
				</div>
				<div class="modal-body" style="height: 70%; padding: 10px;">
					<div id="map"></div>
				</div>
				<div class="modal-footer" style="text-align: center;">
					<button type="button" class="btn btn-primary btnChoice">선택</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</body>

</html>