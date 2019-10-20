<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
	List<HashMap<String, Object>> worldInfo = (List<HashMap<String, Object>>) request.getAttribute("worldInfo");
	String lang = (String) request.getAttribute("lang");
	
	String uniqno = (String)request.getParameter("uniqno");
	String lat = (String)request.getParameter("lat");
	String lng = (String)request.getParameter("lng");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>OpenStreetMap &amp; OpenLayers - Marker Example</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="/common/leaflet/leaflet.css" />
<script src="/common/js/jquery-1.8.2.js"></script>
<script src="/common/leaflet/leaflet-src.js"></script>
<link rel="stylesheet" href="/common/leaflet/screen.css" />
<link rel="stylesheet" href="/common/leaflet/MarkerCluster.css" />
<link rel="stylesheet" href="/common/leaflet/MarkerCluster.HiddenTag.css" />
<link rel="stylesheet" href="/map/map.css" />
<link rel="stylesheet" href="https://www.openstreetmap.org/assets/screen-ltr-616ae794d427cbf65287b1d38891f14064c3c934d989602f0282ff4e9b1d1b89.css">
<link rel="stylesheet" href="https://www.openstreetmap.org/assets/print-ltr-f0e982d0ba074e914962563e26dfc48b3d2d9a05e5442932889cec8769cd2eaf.css">
<script src="/common/leaflet/DistanceGrid.js"></script>
<script src="/common/leaflet/MarkerCluster.js"></script>
<script src="/common/leaflet/MarkerCluster.QuickHull.js"></script>
<script src="/common/leaflet/MarkerClusterGroup.js"></script>
<script src="/common/leaflet/MarkerClusterGroup.Refresh.js"></script>
<script src="/common/leaflet/MarkerCluster.Spiderfier.js"></script>
<script src="/common/leaflet/MarkerOpacity.js"></script>
<script src="/common/js/jquery.form.js"></script>
<script src="/common/js/util.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0"/>
<meta name="csrf-param" content="authenticity_token" />
<meta name="csrf-token" content="50egy/JqmJKp83gqmP1Q0u+LuokoytcrZES7IxbgO3PXoFmkuJ8EQrp40gQ7F7pxGl5XR5a8f0OMkfc8rYNMiA==" />
<style type="text/css">
@import
https://fonts.googleapis.com/css?family=Noto+Sans:400,
700;
body,ul,ol,li,dl,dt,dd,p,h1,h2,h3,h4,h5,h6,input,textarea {
	margin: 0;
	padding: 0;
}

ul,ol,dl {
	list-style: none;
}

img {
	width: 100%;
	border: 0;
	vertical-align: top;
}
body {
	font-family: 'Noto Sans', sans-serif;
	font-size: 1em;
}

html,body {
	margin: 0;
	padding: 0;
	overflow-x: hidden;
	max-width: 100%;
}
* {
	box-sizing: border-box;
}
div.mapCycle {
	width: 100%;
    position: absolute;
    top: 0;
    z-index: 1000;
    margin-top: 2%;
}
div.mapCycle .inner_btn {
	width: 20%;
    display: block;
    float: left;
    border: 2px solid #f5f5f5;
    padding: 2.4% 0;
    height: 50px;
    text-align: -webkit-center;
    background-color: #fff;
}
div.mapCycle .inner_btn button {
	width: 100%;
    border: 0;
    background-color: #fff;
    text-align: center;
    display: contents;
}
div.mapCycle .active {
	background-color:#2078a1;
}
div.mapCycle .active button {
	color:#fff;
	font-weight:600;
	font-size:1.05em;
	background-color:#2078a1;
}
/* 미디어쿼리 */
@media only screen and (min-device-width : 768px) and (max-device-width: 1024px) {
div.mapCycle .inner_btn {
	height: 75px;
}
div.mapCycle .inner_btn button {
	font-size: 1.5em;
}
div.mapCycle .inner_btn button:hover {
	font-size:1.65em;
}
}

@media only screen and (min-device-width : 1024px) and (max-device-width: 1366px) {
div.mapCycle .inner_btn {
	height: 85px;
}
div.mapCycle .inner_btn button {
	font-size: 1.7em;
}
div.mapCycle .inner_btn button:hover {
	font-size:1.75em;
}
}
</style>
</head>
<body class="map-layout small">
	<input hidden="period" id="period">
	<%-- <a id="s_btn" href="/main.map?auth=0&uniqno=<%=uniqno%>&flag=0&lang=ko&lat=<%=lat %>&lng=<%=lng%>" target="_parent"> --%>
	<div id="map_main" style="height: 60vw; width: 100%;">
		<div class="pull-left inbox" id="map_loading" style="width: 110%; right:10%; text-align: center;">
			<img alt='loading' src='/appservice/img/ajax-loader.gif' style='width: 5%; position: fixed; z-index: 1000; left: 49%; top: 50%;'>
		</div>
		<div id="map-area">
			<div class="map-div" id="map" style="padding: 20px 0px 20px 0px; height: 100vh;">
				<div class="mapCycle">
					<div class="inner_btn" id="menu0" onclick="populate(0);">
						<button>1<br>Day</button>
					</div>
					<div class="inner_btn" id="menu1" class="active" onclick="populate(1);">
						<button>1<br>Week</button>
					</div>
					<div class="inner_btn" id="menu2" onclick="populate(2);">
						<button>1<br>Month</button>
					</div>
					<div class="inner_btn" id="menu3"onclick="populate(3);">
						<button>2<br>Month</button>
					</div>
					<div class="inner_btn" id="menu4" onclick="populate(4);">
						<button>3<br>Month</button>
					</div>
				</div>
				<!-- <button type="button" style='width: 15%; position: fixed; z-index: 1000;' onclick="populate(0);">1일</button>
				<button type="button" style='width: 15%; margin-left:16%; position: fixed; z-index: 1000;' onclick="populate(1);">1주</button>
				<button type="button" style='width: 15%; margin-left:32%; position: fixed; z-index: 1000;' onclick="populate(2);">1개월</button>
				<button type="button" style='width: 15%; margin-left:48%; position: fixed; z-index: 1000;' onclick="populate(3);">2개월</button>
				<button type="button" style='width: 15%; margin-left:64%; position: fixed; z-index: 1000;' onclick="populate(4);">3개월</button> -->
			</div>
		</div>
	</div>
	
	<div id="mapdiv">
		<div style="width: 100%;">
			<%if(lang.equals("ko")) {%>
	         	<div id = "confirm" style="z-index: 1000;">
		        	<div class="confirm_title1"><span>안전해요!</span></div>
		        	<div style="padding: 10px; word-break: keep-all;">
		        	<span class="message"></span><br>
		        	<span>정품인증 완료!</span><br>
		        	<button type="button" class = "yes">확인</button>
		        	</div>
				</div>
	        	<div id = "n-confirm" style="z-index: 1000;">
		        	<div class="confirm_title2"><span>위험해요!</span></div>
		        	<div style="padding: 10px; word-break: keep-all;">
		        	<span class="message"></span><br>
		        	<span>위험인증!</span><br>
		        	<button type="button" class = "yes">확인</button>
		        	</div>
				</div>
	        <%}else if(lang.equals("cn")){ %>
	          	<div id = "confirm" style="z-index: 1000;">
		        	<div class="confirm_title1"><span>安全!</span></div>
		        	<div style="padding: 10px; word-break: keep-all;">
		        	<span class="message"></span><br>
		        	<span>正品认证完成!</span><br>
		        	<button type="button" class = "yes">确认</button>
		        	</div>
	        	</div>
	        	<div id = "n-confirm" style="z-index: 1000;">
		        	<div class="confirm_title2"><span>危险!</span></div>
		        	<div style="padding: 10px; word-break: keep-all;">
		        	<span class="message"></span><br>
		        	<span>风险认证!</span><br>
		        	<button type="button" class = "yes">确认</button>
		        	</div>
				</div>
	        <%}else if(lang.equals("jp")){ %>
	          	<div id = "confirm" style="z-index: 1000;">
		        	<div class="confirm_title1"><span>安全!</span></div>
		        	<div style="padding: 10px; word-break: keep-all;">
		        	<span class="message"></span><br>
		        	<span>正規品認証完了!</span><br>
		        	<button type="button" class = "yes">確認</button>
		        	</div>
	        	</div>
	        	<div id = "n-confirm" style="z-index: 1000;">
		        	<div class="confirm_title2"><span>模倣品の可能性あり!</span></div>
		        	<div style="padding: 10px; word-break: keep-all;">
		        	<span class="message"></span><br>
		        	<span>模倣品!</span><br>
		        	<button type="button" class = "yes">確認</button>
		        	</div>		        	
				</div>
	        <%}else { %>
	          	<div id = "confirm" style="z-index: 1000;">
		        	<div class="confirm_title1"><span>Safe!</span></div>
		        	<div style="padding: 10px; word-break: keep-all;">
		        	<span class="message"></span><br>
		        	<span>Authenticity verification completed!</span><br>
		        	<button type="button" class = "yes">Check</button>
		        	</div>
	        	</div>
	        	<div id = "n-confirm" style="z-index: 1000;">
		        	<div class="confirm_title2"><span>Suspicious!</span></div>
		        	<div style="padding: 10px; word-break: keep-all;">
		        	<span class="message"></span><br>
		        	<span>Suspicious authentication!</span><br>
		        	<button type="button" class = "yes">Check</button>
		        	</div>
				</div>
	        <%} %>
		</div>
	</div>
	<!-- </a> -->
	<script>
		var dist = 0;
	
		var center_lat = 37.54703;
		var center_lng = 127.05154;
		var tiles = L.tileLayer(
				'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
				{
					maxZoom : 18,
					noWrap : true
				}), latlng = L.latLng(center_lat, center_lng);
		
		var map, zoomset = 0;
		var cknb_zoom = 1;
		if(document.getElementById("map").offsetWidth > 1024)
		{
			zoomset = 3;
		}
		else if(document.getElementById("map").offsetWidth > 512)
		{
			zoomset = 2;
		}
		else
		{
			zoomset = 2;
		}
		map = L.map('map', {
			center : latlng,
			zoom : 1,
			minZoom : 1,
			maxZoom : 18,
			zoomControl : false,
			layers: [tiles],
			maxBounds : [
				[-87.71179927260242, -180],
				[89.45016124669523, 180]
			]
		});
		
		map.on("moveend", moveEnd);
		map.on("dragend", dragEnd);
		//map.on("click", onClick);
		
		//$('#map').css("display", "none");

		var title = "";
		var lang = '<%=lang%>';
		var markerList = [];
		//var isload_1 = false;
		//var isload_2 = false;
		//var isload_3 = false;
		//var isload_4 = false;
		var markers = L.markerClusterGroup({
			spiderfyOnMaxZoom: false,
			showCoverageOnHover: false,
			zoomToBoundsOnClick: false,
			maxClusterRadius: 40,
			iconCreateFunction: function (cluster)
			{
				var childCount = cluster.getChildCount();
				var clustCount = 0;
				var childs = cluster.getAllChildMarkers();
				var authSum = 0;
				var color = 'blue';
				
				for(var i=0; i<childs.length; i++){
					var data = childs[i].options.alt.split(";");
					var auth = data[0];
					clustCount += parseInt(data[1]);
					if(auth == 2) authSum ++;
					else authSum --;
				}

				if(map.getZoom() <= 5){
					childCount = clustCount;
				} 
				//data = childs[parseInt(childs.length/2)].options.alt.split(";");
				//auth = data[0];
				//console.log("childlength = " + childs.length + " / authSum = " + authSum);
				if(authSum > 0){
					color = 'red';
				}
				
				var c = '';
				if (childCount < 1000)
				{
					c = 'marker-cluster marker-cluster-'+color+'-small';
				}
				else if (childCount < 1000000)
				{
					c = 'marker-cluster marker-cluster-'+color+'-medium';
					childCount = (childCount/1000).toFixed(1) + 'k';
				}
				else
				{
					c = 'marker-cluster marker-cluster-'+color+'-large';
					childCount = (childCount/1000000).toFixed(1) + 'm';
				}

				return new L.DivIcon({ html: '<div><span>' + childCount + '</span></div>', className: c, iconSize: new L.Point(40, 40) });
			}
		});
		
		function onClick(e)
		{
			
			var address = getAddress(e.target.options.title, 1);
			if(address != "null" && address != null){
				var data = e.target.options.alt.split(";");
				var auth = data[0];
				var count = data[1];
				functionAlert(address, "yes", 1, auth);					
			}
		}
		
		function onClusterClick(e) {
			//map.setView(e.latlng, map.getZoom()+4, map.options);
			//if(cknb_zoom == 4 || map.getZoom() == 18){
				var childs = e.layer.getAllChildMarkers();
				address = getAddress(childs[parseInt(childs.length/2)].options.title, 0);
				if(address != "null" && address != null){
					data = childs[parseInt(childs.length/2)].options.alt.split(";");
					var authSum = 0;
					var clustCount = 0;
					for(var i=0; i<childs.length; i++){
						var data = childs[i].options.alt.split(";");
						clustCount += parseInt(data[1]);
						var auth = data[0];
						if(auth == 2) authSum ++;
						else authSum --;
					}
					count = e.layer.getChildCount();
					var auth = 0;
					if(authSum > 0) auth = 2;
					else auth = 0;
					if(map.getZoom() > 5){
						clustCount = parseInt(childs.length);
					}
					functionAlert(address, "yes", clustCount, auth);					
				}
			//}
		}
		
		function dragEnd(e) {
			dist = e.distance;	
		}
		
		//지도 움직임 이벤트 처리 
		function moveEnd(e) {
			if(dist > 0 && dist <= 15) return;
			else populate($("#period").val());
			/* if(curZoom == map.getMinZoom()){
				cknb_zoom = 1;
			} 
			else if(map.getMinZoom() < curZoom && curZoom <= 5){
				cknb_zoom = 2;
				populate();
			} else if(5 < curZoom && curZoom <= 10){
				cknb_zoom = 3;
				populate();
			} else if(10 < curZoom && curZoom <= map.getMaxZoom()){
				cknb_zoom = 4;
				populate();
			} */
		}
		
		function functionAlert(msg, myYes, p_count, auth) {
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
            
            confirmBox.find(".yes").unbind().on('click', function() {
               confirmBox.hide();
            });
            //confirmBox.find(".yes").click(myYes);
            confirmBox.show();
        }
		
		function getAddress(no, isMarker)
		{
			var addr = "";
			$.ajax({
				type: 'get',
				url : "/getAddress.map?no="+no,
				processData: false,
				contentType: false,
		        async: false,
				success : function(data) {
					var JSONobj = JSON.parse(data);
					var address_n = JSONobj.addressMap.address_n;
					var address_a = JSONobj.addressMap.address_a;
					var address = JSONobj.addressMap.address;
					if(address == null) return null;
					var arrAddress = address.split(' ');
					var mapZoom = map.getZoom();
					
					if (isMarker == 1) {
						addr = address;
					} else {
						if (mapZoom <= 5) {
							addr = address_n;
						} else if (mapZoom >= 6 && mapZoom <= 13) {
							addr = address_a + ", " + address_n;
						} else {
							addr = address;
						}
					}
					/* if(arrAddress[0] == '대한민국')
					{
						if(isMarker == 1)
						{
							addr = address;
						}
						else
						{
							if(mapZoom >= 1 && mapZoom <= 4)
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
							if(mapZoom >= 1 && mapZoom <= 4)
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
					} */
					
					if(addr.includes("undefined")){
						addr = "";
					}
				}
			});
			return addr;
		}
		
		var xhr = null;

		function populate(period)
		{
			if (xhr != null) {
				xhr.abort();
				xhr = null;
			}

			var currentZoom = map.getZoom();
			var north = map.getBounds().getNorth();
			var south = map.getBounds().getSouth();
			var west = map.getBounds().getWest();
			var east = map.getBounds().getEast();

			$("#period").val(period);
			$("div.mapCycle .inner_btn").removeClass("active");
			$("#menu"+period).addClass("active");
			//$("div.mapCycle .inner_btn button").attr("disabled", "disabled");
			
			markers.clearLayers();
			map.removeLayer(markers);
			/*
			Remove noClusted Markers
			for(var i=0; i<markerList.length; i++){
				map.removeLayer(markerList[i]);
			} */
			$('#map_loading').css("display", "block");
			xhr = $.ajax({
				type: 'get',
				url : "/worldData.map?period="+period+"&zoom="+currentZoom+"&north="+north+"&south="+south+"&west="+west+"&east="+east,
				processData: false,
				contentType: false,
		        async: true,
				success : function(data) {
					var JSONobj = JSON.parse(data);
					for(var i=0; i<JSONobj.list.length; i++){
						title = JSONobj.list[i].no;
						var condition = JSONobj.list[i].iqr_condition;
						var count = JSONobj.list[i].count;
						var iconUrl = '';
						
						if(condition == 0){
							iconUrl = '/common/leaflet/images/marker-icon-2x.png';
						} else if(condition == 2){
							iconUrl = '/common/leaflet/images/marker-icon-3x.png';
						} else {
							continue;
						}
						marker = L.marker(L.latLng(JSONobj.list[i].gps.split(";")[0], JSONobj.list[i].gps.split(";")[1]),{
							title : title,
							alt : condition+";"+count,
							icon: new L.icon({
								iconUrl: iconUrl,
								iconSize: [30,30]
							})
						}).on('click', onClick);
						
						markers.addLayer(marker);
					}
					markers.on('clusterclick', onClusterClick);
					map.addLayer(markers);
					$('#map_loading').css("display", "none");
				}
			}).done(function(response) {
				$(".leaflet-control-attribution").remove();
				/* map.dragging.enable();
				map.touchZoom.enable();
			    map.doubleClickZoom.enable();
			    map.scrollWheelZoom.enable(); */
			}).fail(function(error) {

			}).always(function(response) {
				/* for(var i=0; i<5; i++){
					if(i != period) {
						$('#menu'+i).removeAttr("disabled");
			    	}
			    } */
			});

			/* map.dragging.disable();
			map.touchZoom.disable();
		    map.doubleClickZoom.disable();
		    map.scrollWheelZoom.disable(); */
		}
		
		// 최초 로드
		populate(1);
		
		/* 
		클러스팅 없이 마커 찍기
		function populate_noCluster()
		{
			markers.clearLayers();
			map.removeLayer(markers);
			for(var i=0; i<markerList.length; i++){
				map.removeLayer(markerList[i]);
			}
			$('#map_loading').css("display", "block");
			$.ajax({
				type: 'get',
				url : "/worldData.map?cknb_zoom="+cknb_zoom,
				processData: false,
				contentType: false,
		        async: true,
				success : function(data) {
					var JSONobj = JSON.parse(data);
					//console.log(JSONobj.list.length);
					for(var i=0; i<JSONobj.list.length; i++){
						title = JSONobj.list[i].address;
						var condition = JSONobj.list[i].iqr_condition;
						var count = JSONobj.list[i].count;
						var iconUrl = '';
						
						if(condition == 0){
							iconUrl = '/common/leaflet/images/marker-icon-2x.png';
						} else if(condition == 2){
							iconUrl = '/common/leaflet/images/marker-icon-3x.png';
						} else {
							continue;
						}
						marker = L.marker(L.latLng(JSONobj.list[i].lat, JSONobj.list[i].lng),{
							title : title,
							alt : condition+";"+count,
							icon: new L.icon({
								iconUrl: iconUrl,
								iconSize: [8,8]
							})
						}).on('click', onClick);
						
						markerList.push(marker);
						map.addLayer(markerList[i]);							
					}
					$('#map_loading').css("display", "none");
					//$('#map').css("display", "block");
				}
			}).done(function (response) {
				$(".leaflet-control-attribution").remove();
				map.dragging.enable();
				map.touchZoom.enable();
			    map.doubleClickZoom.enable();
			    map.scrollWheelZoom.enable();
			    isload_1 = true;
			});
			map.dragging.disable();
			map.touchZoom.disable();
		    map.doubleClickZoom.disable();
		    map.scrollWheelZoom.disable();
		} */
		/* map.on('resize', function(e)
		{
			if(document.getElementById("map").offsetWidth > 1024)
			{
				map.setMaxZoom(3);
				map.setMinZoom(3);
				map.zoomIn(1);
			}
			else if(document.getElementById("map").offsetWidth > 512)
			{
				map.setMaxZoom(2);
				map.setMinZoom(2);
				map.zoomOut(1);
			}
			else
			{
				if(map.getZoom() > 1)
				{
					map.setMaxZoom(1);
					map.setMinZoom(1);
					map.zoomOut(1);
					if(map.getZoom() > 1)
					{
						map.zoomOut(1);
					}
				}
			}
		}); */
	</script>
</body>
</html>
