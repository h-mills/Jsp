<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
	List<HashMap<String, Object>> gpsList = (List<HashMap<String, Object>>) request.getAttribute("gpsList");
	List<HashMap<String, Object>> gpsList2 = (List<HashMap<String, Object>>) request.getAttribute("gpsList2");
	Double lat = (Double) request.getAttribute("lat");
	Double lng = (Double) request.getAttribute("lng");
	int auth = (Integer) request.getAttribute("auth");
	String uniqno = (String) request.getAttribute("uniqno");
	int flag = (Integer) request.getAttribute("flag");
	String lang = (String) request.getAttribute("lang");
	%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>MAIN</title>
<head>
<meta charset="utf-8">
<title>OpenStreetMap &amp; OpenLayers - Marker Example</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="/common/leaflet/leaflet.css" />
<script src="/common/leaflet/leaflet-src.js"></script>
<link rel="stylesheet" href="/common/leaflet/screen.css" />
<link rel="stylesheet" href="/common/leaflet/MarkerCluster.css" />
<link rel="stylesheet" href="/common/leaflet/MarkerCluster.Default.css" />
<link rel="stylesheet" href="/map/map.css" />
<link rel="stylesheet" href="https://www.openstreetmap.org/assets/screen-ltr-616ae794d427cbf65287b1d38891f14064c3c934d989602f0282ff4e9b1d1b89.css">
<link rel="stylesheet" href="https://www.openstreetmap.org/assets/print-ltr-f0e982d0ba074e914962563e26dfc48b3d2d9a05e5442932889cec8769cd2eaf.css">
<!-- <link rel="stylesheet" href="https://www.openstreetmap.org/assets/leaflet-all-a878e71edd24dbf51d0e09442fa6bfab6fbc092ca273be4cb41948f751bafed6.css"> -->
<script src="/common/leaflet/DistanceGrid.js"></script>
<script src="/common/leaflet/MarkerCluster.js"></script>
<script src="/common/leaflet/MarkerCluster.QuickHull.js"></script>
<script src="/common/leaflet/MarkerClusterGroup.js"></script>
<script src="/common/leaflet/MarkerClusterGroup.Refresh.js"></script>
<script src="/common/leaflet/MarkerCluster.Spiderfier.js"></script>
<script src="/common/leaflet/MarkerOpacity.js"></script>
<script src="/common/js/jquery-1.8.2.js"></script>
<script src="/common/js/jquery.form.js"></script>
<script src="/common/js/util.js"></script>

<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0"/>
<meta name="csrf-param" content="authenticity_token" />
<meta name="csrf-token" content="50egy/JqmJKp83gqmP1Q0u+LuokoytcrZES7IxbgO3PXoFmkuJ8EQrp40gQ7F7pxGl5XR5a8f0OMkfc8rYNMiA==" />
</head>
<body class="map-layout small">

   <!-- <div id="tap_panel" style="position: fixed; z-index: 1000;">
          <ul class="tab">
          	<li><a id="genuine" class="selected"><img src="/images/map/map_genuine_out.png" style="width: 10%; margin-top: 10%;"></a></li>
          	<li><a id="fake"><img src="/images/map/map_warn_in.png" style="width: 10%; margin-top: 10%;"></a></li>
          </ul>
    </div> -->
	<!-- <button id="genuine" style="z-index : 1000; position: fixed;">정품</button>
	<button id="fake" style="z-index : 1000; position: fixed; left: 12%">가품</button> -->
	<div id="map-area">
	<div class="map-div" id="map" style="padding: 20px 0px 20px 0px; height: 100vh;">
	</div>
	</div>
	<form id="frm" method="post">
		<input type="hidden" id="lat" name="lat" value="<%=lat%>">
		<input type="hidden" id="lng" name="lng" value="<%=lng%>">
		<input type="hidden" id="size" name="size" value="1078">
		<input type="hidden" id="auth" name="auth" value="<%=auth%>">
		<input type="hidden" id="uniqno" name="uniqno" value="<%=uniqno%>">
	</form>
	<div id="mapdiv"">
		<div style="width: 100%;">
			<%if(lang.equals("ko")) {%>
	         	<div id = "confirm" style="z-index: 1000;">
		        	<div class="confirm_title1"><span>안전해요!</span></div>
		        	<div style="padding: 10px; word-break: keep-all;">
		        	<span class="message"></span><br>
		        	<span>정품인증 완료!</span><br>
		        	<button class = "yes">확인</button>
		        	</div>
				</div>
	        	<div id = "n-confirm" style="z-index: 1000;">
		        	<div class="confirm_title2"><span>위험해요!</span></div>
		        	<div style="padding: 10px; word-break: keep-all;">
		        	<span class="message"></span><br>
		        	<span>위험인증!</span><br>
		        	<button class = "yes">확인</button>
		        	</div>
				</div>
	        <%}else if(lang.equals("cn")){ %>
	          	<div id = "confirm" style="z-index: 1000;">
		        	<div class="confirm_title1"><span>安全!</span></div>
		        	<div style="padding: 10px; word-break: keep-all;">
		        	<span class="message"></span><br>
		        	<span>正品认证完成!</span><br>
		        	<button class = "yes">确认</button>
		        	</div>
	        	</div>
	        	<div id = "n-confirm" style="z-index: 1000;">
		        	<div class="confirm_title2"><span>危险!</span></div>
		        	<div style="padding: 10px; word-break: keep-all;">
		        	<span class="message"></span><br>
		        	<span>风险认证!</span><br>
		        	<button class = "yes">确认</button>
		        	</div>
				</div>
	        <%}else if(lang.equals("jp")){ %>
	          	<div id = "confirm" style="z-index: 1000;">
		        	<div class="confirm_title1"><span>安全!</span></div>
		        	<div style="padding: 10px; word-break: keep-all;">
		        	<span class="message"></span><br>
		        	<span>正規品認証完了!</span><br>
		        	<button class = "yes">確認</button>
		        	</div>
	        	</div>
	        	<div id = "n-confirm" style="z-index: 1000;">
		        	<div class="confirm_title2"><span>模倣品の可能性あり!</span></div>
		        	<div style="padding: 10px; word-break: keep-all;">
		        	<span class="message"></span><br>
		        	<span>模倣品!</span><br>
		        	<button class = "yes">確認</button>
		        	</div>		        	
				</div>
	        <%}else { %>
	          	<div id = "confirm" style="z-index: 1000;">
		        	<div class="confirm_title1"><span>Safe!</span></div>
		        	<div style="padding: 10px; word-break: keep-all;">
		        	<span class="message"></span><br>
		        	<span>Authenticity verification completed!</span><br>
		        	<button class = "yes">Check</button>
		        	</div>
	        	</div>
	        	<div id = "n-confirm" style="z-index: 1000;">
		        	<div class="confirm_title2"><span>Suspicious!</span></div>
		        	<div style="padding: 10px; word-break: keep-all;">
		        	<span class="message"></span><br>
		        	<span>Suspicious authentication!</span><br>
		        	<button class = "yes">Check</button>
		        	</div>
				</div>
	        <%} %>
		</div>
	</div>
	
	<div id="reload" style="z-index: 1000; position: fixed; margin-top: 25%; left: 90%;">
		<img src="/images/map/blk.png" style="width: 80%">
	</div>
	
	<div id="reload_div" style="z-index: 1000; position: fixed; margin-top: 25%; left: 3%;">
		<img id="reload2" src="/images/map/map_loading.png" style="width: 15%">
	</div>
	
	<%if(lang.equals("ko")) {%>
    	<div class="consumer_address" style="top:93%; margin-left: 36%; z-index: 1000; position: fixed;">
			<button id="my-iqr">내가 체크한 위치</button>
		</div>
    <%}else if(lang.equals("cn")){ %>
        <div class="consumer_address" style="margin-top: 88%; margin-left: 36%; z-index: 1000; position: fixed;">
			<button id="my-iqr">我确认过的位置</button>
		</div>
    <%}else if(lang.equals("jp")){ %>
        <div class="consumer_address" style="margin-top: 88%; margin-left: 36%; z-index: 1000; position: fixed;">
			<button id="my-iqr">マイスキャン位置</button>
		</div>
    <%}else { %>
        <div class="consumer_address" style="margin-top: 88%; margin-left: 36%; z-index: 1000; position: fixed;">
			<button id="my-iqr">My scan location</button>
		</div>
    <%} %>			
	
	

	<script>
		
		function getGps(lat, lng) {
/* 			$(".consumer_address").html("<h1>"+lat+"</h1><h1>"+lng+"</h1>"); */

			 $("#map-area").html('<div class="map-div" id="map" style="padding: 20px 0px 20px 0px; height: 100vh;"></div>');
			    
			    setTimeout(function() {
			    	 tiles = L.tileLayer(
			    			'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
			    			{
			    				maxZoom : 15,
			    				attribution : '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
			    			}), latlng = L.latLng(lat, lng);

			    		 map = L.map('map', {
			    			center : latlng,
			    			zoom : 15,
			    			minZoom : 2,
			    			layers: [tiles]
			    		});
			    		
			 			markers2.clearLayers();
			 			for(var i=0; i<markerList.length; i++){
							map.removeLayer(markerList[i]);
						}
			 			if(map.getZoom() > 2){
			 			for(var i=0; i<markerList2.length; i++){
							map.removeLayer(markerList2[i]);
						}
			 			}
			 			markerList.length = 0;
			 			
			 			mapBound2	= map.getBounds();
			 			topCenter2	= L.latLng(mapBound2.getNorth(), map.getCenter().lng);
			 			bottomCenter2= L.latLng(mapBound2.getSouth(), map.getCenter().lng);
			 			leftCenter2	= L.latLng(map.getCenter().lat, mapBound2.getWest());
			 			rightCenter2	= L.latLng(map.getCenter().lat, mapBound2.getEast());
			 			verDist2	= topCenter2.distanceTo(bottomCenter2);
			 			horDist2		= leftCenter2.distanceTo(rightCenter2);
			 			circleSize	= ((verDist2 < horDist2 ? verDist2 : horDist2)) * 0.95;
			    		
			    		$(".map-div").append("<img id='loading' src='/appservice/img/ajax-loader.gif' style='width: 5%; position: fixed; z-index: 1000; left: 49%; top: 50%;'>");
    					mapmove(L.latLng(lat, lng), circleSize);
    					
			    		
			    		/* map.addLayer(markers2); */
			    		
			    		map.on('moveend', function(e)
			    				{
			    					latlng = map.getBounds().getCenter();

			    					var mapBound	= map.getBounds();
			    					var topCenter	= L.latLng(mapBound.getNorth(), map.getCenter().lng);
			    					var bottomCenter= L.latLng(mapBound.getSouth(), map.getCenter().lng);
			    					var leftCenter	= L.latLng(map.getCenter().lat, mapBound.getWest());
			    					var rightCenter	= L.latLng(map.getCenter().lat, mapBound.getEast());
			    					var verDist		= topCenter.distanceTo(bottomCenter);
			    					var horDist		= leftCenter.distanceTo(rightCenter);
			    					circleSize	= ((verDist < horDist ? verDist : horDist)) * 0.95;
			    					
			    					
			    				    
			    				    if(map.getZoom() > 2){		
			    				    	map.dragging.disable();
				    					map.touchZoom.disable();
				    				    map.doubleClickZoom.disable();
				    				    map.scrollWheelZoom.disable();
			    				    	$(".map-div").append("<img id='loading' src='/appservice/img/ajax-loader.gif' style='width: 5%; position: fixed; z-index: 1000; left: 49%; top: 50%;'>");
			    					}
			    				    
			    				   	
			    					markers2.clearLayers();
			    					for(var i=0; i<markerList.length; i++){
			    						map.removeLayer(markerList[i]);
			    					}
			    					if(map.getZoom() > 2){
			    					for(var i=0; i<markerList2.length; i++){
			    						map.removeLayer(markerList2[i]);
			    					}
			    					}
			    					markerList.length = 0;
			    					if(map.getZoom() > 2){
			    						worldFlag = 1;
			    						mapmove(latlng, circleSize);
			    					}else if(map.getZoom() == 2 && worldFlag == 1){
			    						worldFlag = 0;
			    						populate2(L.latLng(0.0, 0.0));
			    					}
			    					/* map.addLayer(markers2); */
			    					
			    			
			    				});
			    	}, 300);
 
		};
		
		$(document).ready(function () {
			if(auth == 0){
				$("#genuine").addClass("selected");
				$("#fake").removeClass("selected");
			}else{
				$("#fake").addClass("selected");
				$("#genuine").removeClass("selected");
				$("#fake").html('<img src="/images/map/map_warn_out.png" style="width: 10%; margin-top: 10%;">');
				$("#genuine").html('<img src="/images/map/map_genuine_in.png" style="width: 10%; margin-top: 10%;">');			
			}
			
			$('html, body').css({'overflow': 'hidden', 'height': '100%'});
			$('.tab, .consumer_address, #reload, #reload_div').on('scroll touchmove mousewheel', function(event) {
			  event.preventDefault();
			  event.stopPropagation();
			  return false;
			});
			
			if(flag == 1){
				$(".consumer_address").attr("class", "consumer_address2")
			}else if(flag == 0){	
				$(".consumer_address2").attr("class", "consumer_address")
			}

		});
	
		var endFlag = 0;
		var center_lat = '<%=lat%>';
		var center_lng = '<%=lng%>';
		var auth = '<%=auth%>';
		var flag = '<%=flag%>';
		var lang = '<%=lang%>';
		
		var tiles = L.tileLayer(
			'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
			{
				maxZoom : 15,
				attribution : '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
			}), latlng = L.latLng(center_lat, center_lng);

		var map = L.map('map', {
			center : latlng,
			zoom : 2,
			minZoom : 2,
			layers: [tiles],
			maxBounds : [
				[-87.71179927260242, -180],
				[89.45016124669523, 180]
			]
		});
		
		var mapBound2	= map.getBounds();
		var topCenter2	= L.latLng(mapBound2.getNorth(), map.getCenter().lng);
		var bottomCenter2= L.latLng(mapBound2.getSouth(), map.getCenter().lng);
		var leftCenter2	= L.latLng(map.getCenter().lat, mapBound2.getWest());
		var rightCenter2	= L.latLng(map.getCenter().lat, mapBound2.getEast());
		var verDist2	= topCenter2.distanceTo(bottomCenter2);
		var horDist2		= leftCenter2.distanceTo(rightCenter2);
		var circleSize	= ((verDist2 < horDist2 ? verDist2 : horDist2)) * 0.95;
		
		var markeri = '';
		var markers2 = L.markerClusterGroup();
		/* var markers = L.markerClusterGroup(
				{
					spiderfyOnMaxZoom: false,
					removeOutsideVisibleBounds : true,
					zoomToBoundsOnClick: false,
					showCoverageOnHover: false,
					iconCreateFunction: function (cluster)
					{
						var childCount = cluster.getChildCount();

						var c = '';
						if (childCount < 1000)
						{
							if(auth == 0){	
								c = 'marker-cluster marker-cluster-small';
							}else{
								c = 'marker-cluster marker-cluster-large';
							}
						}
						else if (childCount < 1000000)
						{
							if(auth == 0){	
								c = 'marker-cluster marker-cluster-small';
							}else{
								c = 'marker-cluster marker-cluster-large';
							}
							childCount = (childCount/1000).toFixed(1) + 'k';
						}
						else
						{
							if(auth == 0){	
								c = 'marker-cluster marker-cluster-small';
							}else{
								c = 'marker-cluster marker-cluster-large';
							}
							childCount = (childCount/1000000).toFixed(1) + 'm';
						}
						

						return new L.DivIcon({ html: '<div id="adr"><span>' + childCount + '</span></div>', className: c, iconSize: new L.Point(40, 40) });
					}
				}); */
		var markerList = [];
		var markerList2 = [];		
		var worldFlag = 0;
				function populate2(latLng)
				{
					$.ajax({
						type: 'get',
						url : "/worldData.map",
						processData: false,
						contentType: false,
				        async: true,
						success : function(data) {
							console.log(data);
							var JSONobj = JSON.parse(data);
							for(var i=0; i<JSONobj.list.length; i++){
								title = JSONobj.list[i].address_n;
								if (JSONobj.list[i].count < 1000)
								{
									marker = L.marker(L.latLng(JSONobj.list[i].lat, JSONobj.list[i].lng),{
										title : title,
										icon: new L.divIcon({
											html: '<div class="leaflet-marker-icon marker-cluster marker-cluster-small leaflet-zoom-animated leaflet-interactive" tabindex="0" style=" width: 40px; height: 40px;  z-index: 175;"><div><span>'+JSONobj.list[i].count+'<span></div></div>',
											/* iconUrl: 'https://www.openstreetmap.org/assets/images/marker-icon-2x.png', */
											iconSize: [15, 25]
										})
									}).on('click', function (e) {
										$("#map-area").html('<div class="map-div" id="map" style="padding: 20px 0px 20px 0px; height: 100vh;"></div>');
									    
									    setTimeout(function() {
									    	 tiles = L.tileLayer(
									    			'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
									    			{
									    				maxZoom : 15,
									    				attribution : '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
									    			}), latlng = L.latLng(e.latlng.lat, e.latlng.lng);

									    		 map = L.map('map', {
									    			center : latlng,
									    			zoom : 15,
									    			minZoom : 2,
									    			layers: [tiles],
									    			maxBounds : [
									    				[-87.71179927260242, -180],
									    				[89.45016124669523, 180]
									    			]
									    		});

									 			markers2.clearLayers();
									 			for(var i=0; i<markerList.length; i++){
						    						map.removeLayer(markerList[i]);
						    					}
									 			if(map.getZoom() > 2){
									 			for(var i=0; i<markerList2.length; i++){
													map.removeLayer(markerList2[i]);
												}
									 			}
						    					markerList.length = 0;
									 			
									 			mapBound2	= map.getBounds();
									 			topCenter2	= L.latLng(mapBound2.getNorth(), map.getCenter().lng);
									 			bottomCenter2= L.latLng(mapBound2.getSouth(), map.getCenter().lng);
									 			leftCenter2	= L.latLng(map.getCenter().lat, mapBound2.getWest());
									 			rightCenter2	= L.latLng(map.getCenter().lat, mapBound2.getEast());
									 			verDist2	= topCenter2.distanceTo(bottomCenter2);
									 			horDist2		= leftCenter2.distanceTo(rightCenter2);
									 			circleSize	= ((verDist2 < horDist2 ? verDist2 : horDist2)) * 0.95;
									    		
									 			$(".map-div").append("<img id='loading' src='/appservice/img/ajax-loader.gif' style='width: 5%; position: fixed; z-index: 1000; left: 49%; top: 50%;'>");
									    		mapmove(L.latLng(e.latlng.lat, e.latlng.lng), circleSize);
									    		
									    		/* map.addLayer(markers2); */
									    		
									    		map.on('moveend', function(e)
									    				{
									    					latlng = map.getBounds().getCenter();

									    					var mapBound	= map.getBounds();
									    					var topCenter	= L.latLng(mapBound.getNorth(), map.getCenter().lng);
									    					var bottomCenter= L.latLng(mapBound.getSouth(), map.getCenter().lng);
									    					var leftCenter	= L.latLng(map.getCenter().lat, mapBound.getWest());
									    					var rightCenter	= L.latLng(map.getCenter().lat, mapBound.getEast());
									    					var verDist		= topCenter.distanceTo(bottomCenter);
									    					var horDist		= leftCenter.distanceTo(rightCenter);
									    					circleSize	= ((verDist < horDist ? verDist : horDist)) * 0.95;
									    					
									    					
									    				    
									    				    if(map.getZoom() > 2){		
									    				    	map.dragging.disable();
										    					map.touchZoom.disable();
										    				    map.doubleClickZoom.disable();
										    				    map.scrollWheelZoom.disable();
									    				    	$(".map-div").append("<img id='loading' src='/appservice/img/ajax-loader.gif' style='width: 5%; position: fixed; z-index: 1000; left: 49%; top: 50%;'>");
									    					}
									    				    
									    				   	for(var i=0; i<markerList.length; i++){
									    						map.removeLayer(markerList[i]);
									    					}
									    				   	if(map.getZoom() > 2){
									    				   	for(var i=0; i<markerList2.length; i++){
									    						map.removeLayer(markerList2[i]);
									    					}
									    				   	}
									    					markerList.length = 0;
									    					
									    					console.log(map.getZoom()+":"+worldFlag);
									    					
									    					if(map.getZoom() > 2){
									    						worldFlag = 1;
									    						mapmove(latlng, circleSize);
									    					}else if(map.getZoom() == 2 && worldFlag == 1){
									    						worldFlag = 0;
									    						populate2(L.latLng(0.0, 0.0));
									    					}
									    					/* map.addLayer(markers2); */

									    					
									    			
									    				});
									    	}, 300);
									});
								}
								else if (JSONobj.list[i].count < 1000000)
								{
									marker = L.marker(L.latLng(JSONobj.list[i].lat, JSONobj.list[i].lng),{
										title : title,
										icon: new L.divIcon({
											html: '<div class="leaflet-marker-icon marker-cluster marker-cluster-small leaflet-zoom-animated leaflet-interactive" tabindex="0" style=" width: 40px; height: 40px;  z-index: 175;"><div><span>'+(JSONobj.list[i].count/1000).toFixed(1)+'k<span></div></div>',
											/* iconUrl: 'https://www.openstreetmap.org/assets/images/marker-icon-2x.png', */
											iconSize: [15, 25]
										})
									}).on('click', function (e) {
										$("#map-area").html('<div class="map-div" id="map" style="padding: 20px 0px 20px 0px; height: 100vh;"></div>');
									    
									    setTimeout(function() {
									    	 tiles = L.tileLayer(
									    			'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
									    			{
									    				maxZoom : 15,
									    				attribution : '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
									    			}), latlng = L.latLng(e.latlng.lat, e.latlng.lng);

									    		 map = L.map('map', {
									    			center : latlng,
									    			zoom : 15,
									    			minZoom : 2,
									    			layers: [tiles],
									    			maxBounds : [
									    				[-87.71179927260242, -180],
									    				[89.45016124669523, 180]
									    			]
									    		});
									    		 for(var i=0; i<markerList.length; i++){
							    						map.removeLayer(markerList[i]);
							    					}
									    		 if(map.getZoom() > 2){
									    		 for(var i=0; i<markerList2.length; i++){
									 				map.removeLayer(markerList2[i]);
									 			}
									    		 }
							    				markerList.length = 0;
									 			markers2.clearLayers();
									 			
									 			
									 			mapBound2	= map.getBounds();
									 			topCenter2	= L.latLng(mapBound2.getNorth(), map.getCenter().lng);
									 			bottomCenter2= L.latLng(mapBound2.getSouth(), map.getCenter().lng);
									 			leftCenter2	= L.latLng(map.getCenter().lat, mapBound2.getWest());
									 			rightCenter2	= L.latLng(map.getCenter().lat, mapBound2.getEast());
									 			verDist2	= topCenter2.distanceTo(bottomCenter2);
									 			horDist2		= leftCenter2.distanceTo(rightCenter2);
									 			circleSize	= ((verDist2 < horDist2 ? verDist2 : horDist2)) * 0.95;
									    		
									 			$(".map-div").append("<img id='loading' src='/appservice/img/ajax-loader.gif' style='width: 5%; position: fixed; z-index: 1000; left: 49%; top: 50%;'>");
									    		mapmove(L.latLng(e.latlng.lat, e.latlng.lng), circleSize);
									    		
									    		/* map.addLayer(markers2); */
									    		
									    		map.on('moveend', function(e)
									    				{
									    					latlng = map.getBounds().getCenter();

									    					var mapBound	= map.getBounds();
									    					var topCenter	= L.latLng(mapBound.getNorth(), map.getCenter().lng);
									    					var bottomCenter= L.latLng(mapBound.getSouth(), map.getCenter().lng);
									    					var leftCenter	= L.latLng(map.getCenter().lat, mapBound.getWest());
									    					var rightCenter	= L.latLng(map.getCenter().lat, mapBound.getEast());
									    					var verDist		= topCenter.distanceTo(bottomCenter);
									    					var horDist		= leftCenter.distanceTo(rightCenter);
									    					circleSize	= ((verDist < horDist ? verDist : horDist)) * 0.95;
									    					
									    					
									    				    
									    				    if(map.getZoom() > 2){		
									    				    	map.dragging.disable();
										    					map.touchZoom.disable();
										    				    map.doubleClickZoom.disable();
										    				    map.scrollWheelZoom.disable();
									    				    	$(".map-div").append("<img id='loading' src='/appservice/img/ajax-loader.gif' style='width: 5%; position: fixed; z-index: 1000; left: 49%; top: 50%;'>");
									    					}
									    				    
									    				   	for(var i=0; i<markerList.length; i++){
									    						map.removeLayer(markerList[i]);
									    					}
									    				   	if(map.getZoom() > 2){
									    				   	for(var i=0; i<markerList2.length; i++){
									    						map.removeLayer(markerList2[i]);
									    					}
									    				   	}
									    					markerList.length = 0;
									    					markers2.clearLayers();
									    			
									    					if(map.getZoom() > 2){
									    						worldFlag = 1;
									    						mapmove(latlng, circleSize);
									    					}else if(map.getZoom() == 2 && worldFlag == 1){
									    						worldFlag = 0;
									    						populate2(L.latLng(0.0, 0.0));
									    					}
									    					/* map.addLayer(markers2); */
									    					
									    					
									    			
									    				});
									    	}, 300);
									});
									
								}
								
								console.log(markerList2);
								markerList2.push(marker);
		/* 						marker.bindPopup(title); */
								
							}
							for(var i =0; i<markerList2.length; i++){
								map.addLayer(markerList2[i]);
							}
						}
					}).done(function (response) {
						$(".leaflet-control-attribution").remove();
					});
				}	
				
		populate2(L.latLng(0.0, 0.0));		
				
		<%-- function populate(latLng, size)
		{
			var title = "현재 위치";
			markeri = L.marker(latLng, {
				title : title,
				icon: new L.icon({
					iconUrl: 'https://www.openstreetmap.org/assets/marker-red-b8123e4c4dfb37f82e57056da8d1caa9a865c07b8b4dd254c923cdb7ea5964b0.png',
					iconSize: [5,5]
				})
			});
			markers2.addLayer(markeri);
			/* markerList.push(markeri); */
			<% for (int i=0; i < gpsList.size(); i++){%>
				title = "<%= gpsList.get(i).get("address")%>"+",<%= gpsList.get(i).get("address_n")%>";
				<%if(Integer.parseInt(gpsList.get(i).get("iqr_condition").toString()) == 0){%>
				marker = L.marker(L.latLng(<%= gpsList.get(i).get("lat")%> , <%= gpsList.get(i).get("lng")%>), {
					title : title,
					icon: L.icon({
						iconUrl: '/common/leaflet/images/marker-icon-2x.png',
						iconSize: [8,8]
					})
				}).on('click', onClick);
				<%}else if(Integer.parseInt(gpsList.get(i).get("iqr_condition").toString()) == 2){%>
				marker = L.marker(L.latLng(<%= gpsList.get(i).get("lat")%> , <%= gpsList.get(i).get("lng")%>), {
					title : title,
					icon: L.icon({
						iconUrl: '/common/leaflet/images/marker-icon-3x.png',
						iconSize: [8,8]
					})
				}).on('click', onClick);
				<%}%>
				/* map.addLayer(marker); */
				markerList.push(marker);
			<%} %> 
			for(var i=0; i<markerList.length; i++){
				map.addLayer(markerList[i]);
			}
		}
		populate(L.latLng(center_lat, center_lng), circleSize); --%>
		
		
		/* map.addLayer(markers2); */
		
		
		
		function mapmove(latLng, size)
		{
			if(endFlag == 0){
				
			var temp = latLng.toString();
			var lat = temp.substring(temp.indexOf('(')+1, temp.lastIndexOf(','));
			var lng = temp.substring(temp.indexOf(',')+2, temp.lastIndexOf(')'));
			
			$('#lat').val(lat);
			$('#lng').val(lng);
			$('#size').val(parseInt(size/1000));
			if($('#size').val() < 1){ // distance 0 방지
				$('#size').val(1);
			}
			var form = $("#frm")[0];
			var formData = new FormData(form);
			var url = "/move.map?lat="+$('#lat').val()+"&lng="+$('#lng').val()+"&size="+$('#size').val()+"&auth="+$('#auth').val()+"&uniqno="+$('#uniqno').val()+"&flag="+flag;
			var url2 = "/move2.map?lat="+$('#lat').val()+"&lng="+$('#lng').val()+"&size="+$('#size').val()+"&auth="+$('#auth').val()+"&uniqno="+$('#uniqno').val()+"&flag="+flag;
			endFlag = 1;
			$.ajax({
				type: 'get',
				url : url,
				processData: false,
				contentType: false,
				data : formData,
		        async: true,
				success : function(data) {
					var JSONobj = JSON.parse(data);
					for(var i=0; i<JSONobj.list.length; i++){
						title = JSONobj.list[i].address+","+JSONobj.list[i].address_n;
						if(JSONobj.list[i].iqr_condition == "0"){
							marker = L.marker(L.latLng(JSONobj.list[i].lat, JSONobj.list[i].lng), {
								title : title,
								icon: L.icon({
									iconUrl: '/common/leaflet/images/marker-icon-2x.png',
									iconSize: [8,8]
								})
							});
						}else{
							marker = L.marker(L.latLng(JSONobj.list[i].lat, JSONobj.list[i].lng), {
								title : title,
								icon: L.icon({
									iconUrl: '/common/leaflet/images/marker-icon-3x.png',
									iconSize: [8,8]
								})
							});
						}
						map.addLayer(marker);
						markerList.push(marker);
					}
					for(var i=0; i<markerList.length; i++){
						map.addLayer(markerList[i]);
					}
				}
			}).done(function (response) {
				endFlag = 0;
				map.dragging.enable();
				map.touchZoom.enable();
			    map.doubleClickZoom.enable();
			    map.scrollWheelZoom.enable();
			    $(".map-div #loading").remove();
			    
			    var title = "현재 위치";
				markeri = L.marker(latLng, {
					icon: new L.icon({
						iconUrl: 'https://www.openstreetmap.org/assets/marker-red-b8123e4c4dfb37f82e57056da8d1caa9a865c07b8b4dd254c923cdb7ea5964b0.png',
						iconSize: [25,41]
					})
				});
		  		/* markers2.addLayer(markeri); */ 
				/* markerList.push(markeri); */
			});
			
			
		}
		}
		
		map.on('moveend', function(e)
		{
			
			latlng = map.getBounds().getCenter();

			var mapBound	= map.getBounds();
			var topCenter	= L.latLng(mapBound.getNorth(), map.getCenter().lng);
			var bottomCenter= L.latLng(mapBound.getSouth(), map.getCenter().lng);
			var leftCenter	= L.latLng(map.getCenter().lat, mapBound.getWest());
			var rightCenter	= L.latLng(map.getCenter().lat, mapBound.getEast());
			var verDist		= topCenter.distanceTo(bottomCenter);
			var horDist		= leftCenter.distanceTo(rightCenter);
			circleSize	= ((verDist < horDist ? verDist : horDist)) * 0.95;
			
			
		    
		    if(map.getZoom() > 2){	
		    	map.dragging.disable();
				map.touchZoom.disable();
			    map.doubleClickZoom.disable();
			    map.scrollWheelZoom.disable();
		    	$(".map-div").append("<img id='loading' src='/appservice/img/ajax-loader.gif' style='width: 5%; position: fixed; z-index: 1000; left: 49%; top: 50%;'>");
			}
		   	
		    
		   /* 	markerList.length = 0; */
			markers2.clearLayers();
			for(var i=0; i<markerList.length; i++){
				map.removeLayer(markerList[i]);
			}
			console.log(map.getZoom());
			if(map.getZoom() > 2){
			for(var i=0; i<markerList2.length; i++){
				map.removeLayer(markerList2[i]);
			}
			}
			markerList.length = 0;
			
			if(map.getZoom() > 2){
				worldFlag = 1;
				mapmove(latlng, circleSize);
			}else if(map.getZoom() == 2 && worldFlag == 1){
				worldFlag = 0;
				populate2(L.latLng(0.0, 0.0));
			}
			
			
			/* map.addLayer(markers2); */
			
		});
		
		
		$("#my-iqr").on("click", function () {
			
			latlng = map.getBounds().getCenter();
			
			
			/* markers.clearLayers(); */
			markers2.clearLayers();
			for(var i=0; i<markerList.length; i++){
				map.removeLayer(markerList[i]);
			}
			if(map.getZoom() > 2){
			for(var i=0; i<markerList2.length; i++){
				map.removeLayer(markerList2[i]);
			}
			}
			markerList.length = 0;
			
			var mapBound	= map.getBounds();
			var topCenter	= L.latLng(mapBound.getNorth(), map.getCenter().lng);
			var bottomCenter= L.latLng(mapBound.getSouth(), map.getCenter().lng);
			var leftCenter	= L.latLng(map.getCenter().lat, mapBound.getWest());
			var rightCenter	= L.latLng(map.getCenter().lat, mapBound.getEast());
			var verDist		= topCenter.distanceTo(bottomCenter);
			var horDist		= leftCenter.distanceTo(rightCenter);
			circleSize	= ((verDist < horDist ? verDist : horDist)) * 0.95;
			
			
		   
		    
			if(flag == 1){
				flag = 0;
				$(".consumer_address2").attr("class", "consumer_address")
				if(map.getZoom() > 2){
					map.dragging.disable();
					map.touchZoom.disable();
				    map.doubleClickZoom.disable();
				    map.scrollWheelZoom.disable();
					 $(".map-div").append("<img id='loading' src='/appservice/img/ajax-loader.gif' style='width: 5%; position: fixed; z-index: 1000; left: 49%; top: 50%;'>");
					worldFlag = 1;
					mapmove(latlng, circleSize);
				}else if(map.getZoom() == 2 && worldFlag == 1){
					worldFlag = 0;
					populate2(L.latLng(0.0, 0.0));
				}
			}else if(flag == 0){
				flag = 1;
				$(".consumer_address").attr("class", "consumer_address2")
				if(map.getZoom() > 2){
					map.dragging.disable();
					map.touchZoom.disable();
				    map.doubleClickZoom.disable();
				    map.scrollWheelZoom.disable();
					 $(".map-div").append("<img id='loading' src='/appservice/img/ajax-loader.gif' style='width: 5%; position: fixed; z-index: 1000; left: 49%; top: 50%;'>");
					worldFlag = 1;
					mapmove(latlng, circleSize);
				}else if(map.getZoom() == 2 && worldFlag == 1){
					worldFlag = 0;
					populate2(L.latLng(0.0, 0.0));
				}
			}
			
			
			/* map.addLayer(markers2); */
			
		});
	
		
		function functionAlert(msg, myYes, p_count) {
			var confirmBox = "";
			if(auth == 0){
				confirmBox = $("#confirm");
			}else{
				confirmBox = $("#n-confirm");
			}
           
            if(p_count != 0){
        		if(lang == 'ko'){
            		confirmBox.find(".message").text(msg+" "+p_count+" 명");
        		}else if(lang == 'cn'){
        			confirmBox.find(".message").text(msg+" "+p_count+" 个人");
        		}else if(lang == 'jp'){
        			confirmBox.find(".message").text(msg+" "+p_count+" 人");
        		}else{
        			confirmBox.find(".message").text(msg+" "+p_count+" People");
        		}
            }else{
            	confirmBox.find(".message").text(msg);
            }
            
            confirmBox.find(".yes").unbind().click(function() {
               confirmBox.hide();
            });
            confirmBox.find(".yes").click(myYes);
            confirmBox.show();
         }
		
		function onClick(e)
		{
			var address = getAddress(e.target.options.title, 1);
			
			functionAlert(address, "yes", 0);
		}
		
		function getAddress(address, isMarker)
		{
			var arrAddress = address.split(' ');
			var mapZoom = map.getZoom();
			var addr = "";
		
			if(arrAddress[0] == '대한민국')
			{
				if(isMarker == 1)
				{
					addr = arrAddress[0] + " " + arrAddress[1] + " " + arrAddress[2] + " " + arrAddress[3];
				}
				else
				{
					if(mapZoom >= 3 && mapZoom <= 4)
					{
						addr = arrAddress[0];
					}
					else if(mapZoom >= 5 && mapZoom <= 9)
					{
						addr = arrAddress[0] + " " + arrAddress[1];
					}
					else if(mapZoom >= 10 && mapZoom <= 13)
					{
						addr = arrAddress[0] + " " + arrAddress[1] + " " + arrAddress[2];
					}
					else
					{
						addr = arrAddress[0] + " " + arrAddress[1] + " " + arrAddress[2] + " " + arrAddress[3];
					}
				}
			}
			else
			{
				arrAddress = address.split(',');
				if(isMarker == 1)
				{
					addr = arrAddress[arrAddress.length-4] + "," + 
					   arrAddress[arrAddress.length-3];
				}
				else
				{
					if(mapZoom >= 3 && mapZoom <= 4)
					{
						addr = arrAddress[arrAddress.length-1];
					}
					else if(mapZoom >= 5 && mapZoom <= 9)
					{
						addr = arrAddress[arrAddress.length-3];
					}
					else if(mapZoom >= 10 && mapZoom <= 14)
					{
						addr = arrAddress[arrAddress.length-4] + "," + 
							   arrAddress[arrAddress.length-3];
					}
					else
					{
						addr = arrAddress[arrAddress.length-4] + "," + 
							   arrAddress[arrAddress.length-3];
					}
				}
			}
			
			if(addr.includes("undefined")){
				addr = "";
			}
			
			return addr;
		}

	/* 	markers.on('clusterclick', function(e){
			var p_count = 0;
			var childs = e.layer.getAllChildMarkers();
			var address = getAddress(childs[parseInt(childs.length/2)].options.title, 0);
			functionAlert(address, "yes", childs.length);
		}); */
		
		
		$("#genuine").on("click", function () {
			location.href = "/main.map?auth=0&uniqno="+$('#uniqno').val()+"&flag="+flag+"&lang="+lang+"&lat="+center_lat+"&lng="+center_lng;
		});
		
		$("#fake").on("click", function () {
			location.href = "/main.map?auth=2&uniqno="+$('#uniqno').val()+"&flag="+flag+"&lang="+lang+"&lat="+center_lat+"&lng="+center_lng;
		});
		
		$("#reload").on("click", function () {
			/* map.dragging.disable();
			map.touchZoom.disable();
		    map.doubleClickZoom.disable();
		    map.scrollWheelZoom.disable();
			location.reload(true); */
			
			var agent = navigator.userAgent;
			if (agent.match('Android')) {
				Mobile.getGps();
			} else if (agent.match('iPhone') || agent.match('iPad')) {
				var param = 'jscall*getGps';
				document.location = param;
			} 
			
		});
		
		$("#reload2").on("click", function () {
			latlng = map.getBounds().getCenter();
			
		
		    var mapBound	= map.getBounds();
			var topCenter	= L.latLng(mapBound.getNorth(), map.getCenter().lng);
			var bottomCenter= L.latLng(mapBound.getSouth(), map.getCenter().lng);
			var leftCenter	= L.latLng(map.getCenter().lat, mapBound.getWest());
			var rightCenter	= L.latLng(map.getCenter().lat, mapBound.getEast());
			var verDist		= topCenter.distanceTo(bottomCenter);
			var horDist		= leftCenter.distanceTo(rightCenter);
			circleSize	= ((verDist < horDist ? verDist : horDist)) * 0.95;

		   	
			/* markers.clearLayers(); */
			markers2.clearLayers();
			for(var i=0; i<markerList.length; i++){
				map.removeLayer(markerList[i]);
			}
			if(map.getZoom() > 2){
			for(var i=0; i<markerList2.length; i++){
				map.removeLayer(markerList2[i]);
			}
			}
			markerList.length = 0;
			if(map.getZoom() > 2){
				map.dragging.disable();
				map.touchZoom.disable();
			    map.doubleClickZoom.disable();
			    map.scrollWheelZoom.disable();
				$(".map-div").append("<img id='loading' src='/appservice/img/ajax-loader.gif' style='width: 5%; position: fixed; z-index: 1000; left: 49%; top: 50%;'>");
				worldFlag = 1;
				mapmove(latlng, circleSize);
			}else if(map.getZoom() == 2 && worldFlag == 1){
				worldFlag = 0;
				populate2(L.latLng(0.0, 0.0));
			}
			
			/* map.addLayer(markers2); */
			
			
		});
		
		
		
		
		
		
	</script>
</body>
</html>
