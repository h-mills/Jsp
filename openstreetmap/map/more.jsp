<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
	Double	lat 	= (Double) request.getAttribute("lat");
	Double	lng 	= (Double) request.getAttribute("lng");
	Integer	auth	= (Integer)request.getAttribute("auth");
	String	uniqno	= (String) request.getAttribute("uniqno");
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
<link rel="stylesheet" href="/common/leaflet/MarkerCluster.HiddenTag.css" />
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
<script>
	function functionAlert(msg, myYes) {
            var confirmBox = $("#confirm");
            confirmBox.find(".message").text(msg);
            confirmBox.find(".yes").unbind().click(function() {
               confirmBox.hide();
            });
            confirmBox.find(".yes").click(myYes);
            confirmBox.show();
         }
      </script>
      <style>
         #confirm {
            display: none;
            border: 1px solid #aaa;
            position: fixed;
            width: 50%;
            height: 20%;
            left: 25%;
            top: 40%;
            padding: 6px 8px 8px;
            box-sizing: border-box;
            text-align: center;
            font-size: 36px;
            background-color: white;
         }
         #confirm button {
            background-color: #48E5DA;
            display: inline-block;
            border-radius: 5px;
            border: 1px solid #aaa;
            padding: 5px;
            text-align: middle;
            width: 30%;
            cursor: pointer;
            font-size: 30px;
         }
         #confirm .message {
            text-align: center;
         }
      </style>
</head>
<body style="margin: 0px; padding: 0px;">
	<div id="mapdiv" style="width: 100vw; height: 100vh;">
		<div class="pull-left inbox" id="map" style="width: 100%; height: 100%;">
			<div id = "confirm" style="z-index: 1000;">
	        	<span style="background-color: sky;">안전해요!</span><br>
	        	<span class="message"></span><br>
	        	<span>정품인증 완료!</span><br>
	        	<button class = "yes">확인</button>
	        </div>
		</div>
	</div>
	<form id="frm" method="post">
		<input type="hidden" id="tllat"   name="tllat"  value="">
		<input type="hidden" id="tllng"   name="tllng"  value="">
		<input type="hidden" id="brlat"   name="brlat"  value="">
		<input type="hidden" id="brlng"   name="brlng"  value="">
		<input type="hidden" id="auth"    name="auth"   value="">
		<input type="hidden" id="uniqno"  name="uniqno" value="">
	</form>
	<script>
		var center_lat	= '<%=lat%>';
		var center_lng	= '<%=lng%>';
		var auth		= '<%=auth%>';
		var uniqno		= '<%=uniqno%>';
		
		var tiles = L.tileLayer(
			'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
			{
				maxZoom : 18,
				attribution : '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
				noWrap : true
			}), latlng = L.latLng(center_lat, center_lng);

		var map = L.map('map', {
			center : latlng,
			zoom : 17,
			minZoom : 3,
			zoomControl : false,
			layers: [tiles],
			maxBounds : [
				[-87.71179927260242, -180],
				[89.45016124669523, 180]
			]
		});
		
		var topLeft = map.getBounds().getNorthWest();
		var bottomRight = map.getBounds().getSouthEast();
		
		var markers = L.markerClusterGroup(
				{
					spiderfyOnMaxZoom: false,
					showCoverageOnHover: false,
					zoomToBoundsOnClick: false,
					iconCreateFunction: function (cluster)
					{
						var childCount = cluster.getChildCount();
						var strAuth = (auth == 1 ? 'blue' : 'red');

						var c = '';
						if (childCount < 1000)
						{
							c = 'marker-cluster marker-cluster-'+strAuth+'-small';
						}
						else if (childCount < 1000000)
						{
							c = 'marker-cluster marker-cluster-'+strAuth+'-medium';
							childCount = (childCount/1000).toFixed(1) + 'k';
						}
						else
						{
							c = 'marker-cluster marker-cluster-'+strAuth+'-large';
							childCount = (childCount/1000000).toFixed(1) + 'm';
						}

						return new L.DivIcon({ html: '<div><span>' + childCount + '</span></div>', className: c, iconSize: new L.Point(40, 40) });
					}
				});
		
		var marker = L.marker(latLng = L.latLng(center_lat, center_lng), {
			title : '현재위치',
			icon: new L.icon({
				iconUrl: 'http://cfile225.uf.daum.net/image/2445C43651D6680A1354CA',
				iconSize: [40,40]
			})
		});
		marker.bindPopup('현재위치');
		markers.addLayer(marker);

		var markerList = [];
		
		function mapmove(topLeft, bottomRight)
		{
			$('#tllat').val(topLeft.lat);
			$('#tllng').val(topLeft.lng);
			$('#brlat').val(bottomRight.lat);
			$('#brlng').val(bottomRight.lng);
			$('#auth').val(auth);
			$('#uniqno').val(uniqno);
			
			var form = $("#frm")[0];
			var formData = new FormData(form);
			$.ajax({
				type: 'get',
				url : "/move_square.map?tllat="+$('#tllat').val()+"&tllng="+$('#tllng').val()+
										"&brlat="+$('#brlat').val()+"&brlng="+$('#brlng').val()+
										"&auth="+$('#auth').val()+"&uniqno="+$('#uniqno').val(),
				processData: false,
				contentType: false,
				data : formData,
		        async: true,
				success : function(data) {
					var JSONobj = JSON.parse(data);
					for(var i=0; i<JSONobj.list.length; i++){
						title = JSONobj.list[i].address;
						marker = L.marker(L.latLng(JSONobj.list[i].lat, JSONobj.list[i].lng), {
							title : title
						}).on('click', onClick);
						markers.addLayer(marker);
						markerList.push(marker);
					}
				}
			});
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
					else if(mapZoom >= 10 && mapZoom <= 14)
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
					   arrAddress[arrAddress.length-3] + "," + 
					   arrAddress[arrAddress.length-2] + "," + 
					   arrAddress[arrAddress.length-1];
				}
				else
				{
					if(mapZoom >= 3 && mapZoom <= 4)
					{
						addr = arrAddress[arrAddress.length-1];
					}
					else if(mapZoom >= 5 && mapZoom <= 9)
					{
						addr = arrAddress[arrAddress.length-2] + "," + 
							   arrAddress[arrAddress.length-1];
					}
					else if(mapZoom >= 10 && mapZoom <= 14)
					{
						addr = arrAddress[arrAddress.length-3] + "," + 
							   arrAddress[arrAddress.length-2] + "," + 
							   arrAddress[arrAddress.length-1];
					}
					else
					{
						addr = arrAddress[arrAddress.length-4] + "," + 
							   arrAddress[arrAddress.length-3] + "," + 
							   arrAddress[arrAddress.length-2] + "," + 
							   arrAddress[arrAddress.length-1];
					}
				}
			}
			
			return addr;
		}
		
		function onClick(e)
		{
			var address = getAddress(e.target.options.title, 1);
			
			functionAlert(address, "yes");
		}
		
		mapmove(topLeft, bottomRight);
		map.addLayer(markers);
		
		map.on('moveend', function(e)
		{
			latlng = map.getBounds().getCenter();
			
			markerList.length = 0;
			markers.clearLayers();
			map.removeLayer(markers);
			
			var topLeft = map.getBounds().getNorthWest();
			var bottomRight = map.getBounds().getSouthEast();
			
			var marker = L.marker(latLng = L.latLng(center_lat, center_lng), {
				title : '현재위치',
				icon: new L.icon({
					iconUrl: 'http://cfile225.uf.daum.net/image/2445C43651D6680A1354CA',
					iconSize: [40,40]
				})
			});
			marker.bindPopup('현재위치');
			markers.addLayer(marker);
			
			mapmove(topLeft, bottomRight);
			map.addLayer(markers);
		});
		
		markers.on('clusterclick', function(e){
			var childs = e.layer.getAllChildMarkers();
			var address = getAddress(childs[parseInt(childs.length/2)].options.title, 0);
			functionAlert(address, "yes");
		});
	</script>
</body>
</html>
