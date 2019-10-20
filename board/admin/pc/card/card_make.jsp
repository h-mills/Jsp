<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="/WEB-INF/jsp/include/include.jsp"%>

<html>
<head>
<title>명함관리_생성</title>

<style>
*{text-decoration:none;}
li {list-style:none; text-decoration:none; float:left;}
</style>

<script type="text/javascript" charset="UTF-8">
$(document).ready(function() {
	fn_companylist();
});

// 검색
function fn_search() {
	if($('#st_company').val() == -1) {
		alert("업체명을 선택하세요.");
		return false;
	} else if($('#st_order').val() == -1) {
		alert("발주차수를 선택하세요.");
		return false;
	}

	form.action = "/pc/card/ordersearch";
	form.submit();
}

// 보기페이지로 이동
function fn_viewPage(){

	form.action = "/pc/card/card_view";
	form.submit();
}

function fn_companylist() {
	var url = "/pc/card/companylist";
	$.ajax({
		type: 'post',
		url : url,
		data : {},
        async: true,
		success : function(data) {

			var JSONobj = JSON.parse(data);
			var companylist = JSONobj.companyList;
    		$("#st_company").find("option").remove();
    		$("#st_company").append("<option value='-1'>업체 선택</option>");
   			$("#st_company").append("<option value='0'>전체</option>");

   			if (companylist != null) {
   	       		for(var i=0; i<companylist.length; i++){
   	       			var cd = companylist[i].no;
   	       			var name = companylist[i].name;
   	   				$("#st_company").append("<option value="+cd+">"+name+"</option>");
   	    		}
   	       		if ("${st_company}" != "") {
   	           		$("#st_company option[value='"+"${st_company}"+"']").attr("selected", "selected");
   	       		}
   			}
	       	fn_orderlist();
		}
	});
}

function fn_orderlist() {
	var company_no = $('#st_company').val();
	var url = "/pc/card/orderlist_make";
	$.ajax({
		type: 'post',
		url : url,
		data : {company_no:company_no},
        async: true,
		success : function(data) {

			var JSONobj = JSON.parse(data);
			var orderList = JSONobj.orderList;
			var result = JSONobj.result;

			$("#st_order").find("option").remove();
   			$("#st_order").append("<option value='-1'>발주차수 선택</option>");

   			if (result == "1") {
   	   			for(var i=0; i<orderList.length; i++){
   	   				var no = orderList[i].no;
   	   				var title = orderList[i].title;
   					$("#st_order").append("<option value="+no+">"+title+"</option>");
   	   			}
   	   			if ("${st_order}" != "") {
   	           		$("#st_order option[value='"+"${st_order}"+"']").attr("selected", "selected");
   	       		} else {
   	           		fn_infoClear();
   	       		}
   			}
   			if (company_no == '-1' || result != '1') {
				$("#st_order").find("option").remove();
				$("#st_order").append("<option value='-1'>발주차수 선택</option>");
	       		fn_infoClear();
   			}
		}
	});
}

// 파일, 주문정보, 언어정보 초기화
function fn_infoClear() {
	$("#orderInfo").val("");
	$("#file").val("");
	$("#st_category").val("-1");
	$("#language_ko").prop('checked', false);
	$("#language_en").prop('checked', false);
	$("#language_cn").prop('checked', false);
	$("#language_jp").prop('checked', false);
}

// 주문엑셀 다운로드
function fn_download() {
	form.action = "/pc/card/filedown";
	form.submit();
}

// 명함생성 cvs 다운로드
function fn_cardDown() {
	var category = $("#category").val();
	var card_config_no = $("#card_config_no").val();
	form.action = "/pc/card/carddown?category="+category+"&card_config_no="+card_config_no;
	form.submit();
}

//생성
function fn_create() {
	if($('#st_category').val() < 0 || $('#st_category').val() > 4) {
		alert("타입을 선택하세요.");
		return false;
	} else if($("#file").val() == null || $("#file").val() == "") {
		alert("등록된 파일이 없습니다.!");
		return;
	} else if ($("#createcheck").val() >= 1) {
		alert("생성한 데이터가 있습니다.");
		return;
	}

	if(confirm("생성하시겠습니까?") == false) return;

	var orderdatalist = fn_orderdatalist();

	if (orderdatalist == null || orderdatalist == "") {
		alert("첨부파일이 없습니다.");
		return;
	} else {
		if (orderdatalist.length < 0) {
			alert("첨부파일이 없습니다.");
			return;
		} else {
			$("#loadingModal").modal({backdrop: "static", keyboard: false});

			$("#loadingModal").on('shown.bs.modal', function () {
				$("#totalCount").text(orderdatalist.length);
				fn_ajaxMake(orderdatalist, 0);
	    	});
		}
	}
}

function fn_orderdatalist() {
	var order_no = $("#order_no").val();
	var orderdatalist;

	$.ajax({
		type: 'post',
		url : "/pc/card/orderdata",
		data : {
			order_no:order_no
		},
        async: false,
		success : function(data) {
			var JSONobj = JSON.parse(data);
			orderdatalist = JSONobj.orderdatalist;
		}
	});
	return orderdatalist;
}

function fn_ajaxMake(orderdatalist, idx) {
	var langdingurl = $("#langdingurl").val();
	var order_no = $("#order_no").val();
	var language = $("#language").val();
	var company_no = $("#company_no").val();
	var category = $("#st_category").val();
	var orderth = $("#orderth").val();
	var config_no = $("#card_config_no").val();
	config_no = (config_no == null || config_no == "" ? 0 : config_no); 
	var cd = orderdatalist[idx].cd;
	var jobclass = orderdatalist[idx].dept_no;
	var file = orderdatalist[idx].file;

	$.ajax({
		type: 'post',
		url : "/pc/card/create",
		data : {
			company_no:company_no, 
			language:language,
			langdingurl:langdingurl, 
			order_no:order_no,
			category:category,
			orderth:orderth,
			cd:cd,
			jobclass:jobclass,
			file:file,
			config_no:config_no
		},
        async: true,
		success : function(data) {
			var JSONobj = JSON.parse(data);
			var result = JSONobj.result;

			if (result == 1) {
				var cardList = JSONobj.cardList;
				var card_config_no = JSONobj.card_config_no;
				var htmlcode = "";
				var rn = $("#rownum").val();

				if (cardList != null) {
	    			if (cardList.length > 0) {
	            		for (var i=0; i<cardList.length; i++) {
	            			var master = cardList[i].master;
	            			var data_ko = cardList[i].data_ko;
	            			var data_en = cardList[i].data_en;
	            			var data_cn = cardList[i].data_cn;
	            			var data_jp = cardList[i].data_jp;
	            			var image = master.image;
	            			var langCnt = master.langCnt;
	            			var firstLang = master.firstLang;

	           				htmlcode += "<tr>";
	           				htmlcode += "<td rowspan=\"" + langCnt + "\" style=\"vertical-align: middle;\">" + (++rn) + "</td>";
	           				htmlcode += "<td rowspan=\"" + langCnt + "\" style=\"vertical-align: middle;\">";
	           				htmlcode += "<div style=\"width: 100px;\">"
	           				htmlcode += "<img src=\"" + master.imageViewPath + "\" onload=\"resize(this)\">";
	           				htmlcode += "</div>"
	           				htmlcode += "</td>";
	           				if (data_ko != null) {
	           					if (firstLang != "ko") {htmlcode += "<tr>";}
		           				htmlcode += "<td>"+(data_ko==null?"-":data_ko.name)+"</td>";
		           				htmlcode += "<td>"+(data_ko==null?"-":data_ko.part)+"</td>";
		           				htmlcode += "<td>"+(data_ko==null?"-":data_ko.position)+"</td>";
		           				htmlcode += "<td>"+(data_ko==null?"-":data_ko.tel)+"</td>";
		           				htmlcode += "<td>"+(data_ko==null?"-":data_ko.email)+"</td>";
		           				htmlcode += "</tr>";					       				
	           				}
	           				if (data_en != null) {
	           					if (firstLang != "en") {htmlcode += "<tr>";}
		           				htmlcode += "<td>"+(data_en==null?"-":data_en.name)+"</td>";
		           				htmlcode += "<td>"+(data_en==null?"-":data_en.part)+"</td>";
		           				htmlcode += "<td>"+(data_en==null?"-":data_en.position)+"</td>";
		           				htmlcode += "<td>"+(data_en==null?"-":data_en.tel)+"</td>";
		           				htmlcode += "<td>"+(data_en==null?"-":data_en.email)+"</td>";
		           				htmlcode += "</tr>";
	           				}
	           				if (data_cn != null) {
	           					if (firstLang != "cn") {htmlcode += "<tr>";}
		           				htmlcode += "<td>"+(data_cn==null?"-":data_cn.name)+"</td>";
		           				htmlcode += "<td>"+(data_cn==null?"-":data_cn.part)+"</td>";
		           				htmlcode += "<td>"+(data_cn==null?"-":data_cn.position)+"</td>";
		           				htmlcode += "<td>"+(data_cn==null?"-":data_cn.tel)+"</td>";
		           				htmlcode += "<td>"+(data_cn==null?"-":data_cn.email)+"</td>";
		           				htmlcode += "</tr>";
	           				}
	           				if (data_jp != null) {
	           					if (firstLang != "jp") {htmlcode += "<tr>";}
		           				htmlcode += "<td>"+(data_jp==null?"-":data_jp.name)+"</td>";
		           				htmlcode += "<td>"+(data_jp==null?"-":data_jp.part)+"</td>";
		           				htmlcode += "<td>"+(data_jp==null?"-":data_jp.position)+"</td>";
		           				htmlcode += "<td>"+(data_jp==null?"-":data_jp.tel)+"</td>";
		           				htmlcode += "<td>"+(data_jp==null?"-":data_jp.email)+"</td>";
		           				htmlcode += "</tr>";
	           				}
	            		}
	    			}
	    		}
				if (orderdatalist.length > ++idx) {
					$(htmlcode).appendTo("#cardList > tbody");
					$("#card_config_no").val(card_config_no);
					$("#rownum").val(rn);
					$("#currCount").text(idx);
					fn_ajaxMake(orderdatalist, idx);
				} else {
					$(htmlcode).appendTo("#cardList > tbody");
					$("#currCount").text(idx);
					$(".btnCreate").addClass("hidden");
					$(".btnDown").removeClass("hidden");
					$("#category").val(category);
					fn_ajaxUpdateCount(category, card_config_no, company_no);
				}
			} else {
				alert("엑셀 데이터를 확인해 주세요.");
				$("#loadingModal").modal("hide");
			}
		}
	});
}

//생성후 iqr번호, 카드생성수, 주문상태 변경
function fn_ajaxUpdateCount(category, card_config_no, company_no) {
	$.ajax({
		type: 'post',
		url : "/pc/card/updateOrderInfo",
		data : {
			category : category, 
			card_config_no : card_config_no,
			company_no : company_no
		},
        async: true,
		success : function(data) {
    		alert("완료되었습니다.");
    		$("#loadingModal").modal("hide");
		}
	});
}

function resize(img)
{
	// 원본 이미지 사이즈 저장
   	var width = img.width;
   	var height = img.height;
 
   	// 가로, 세로 최대 사이즈 설정
   	var maxWidth = 100;   // 원하는대로 설정. 픽셀로 하려면 maxWidth = 100  이런 식으로 입력
   	var maxHeight = 100;   // 원래 사이즈 * 0.5 = 50%
 
   	// 가로가 세로보다 크면 가로는 최대사이즈로, 세로는 비율 맞춰 리사이즈
   	if(width > height)
   	{
 	  	resizeWidth = maxWidth;
 	  	resizeHeight = (height * resizeWidth) / width;
   		// 세로가 가로보다 크면 세로는 최대사이즈로, 가로는 비율 맞춰 리사이즈
   	}
   	else
   	{
      	resizeHeight = maxHeight;
      	resizeWidth = (width * resizeHeight) / height;
    }
   	// 리사이즈한 크기로 이미지 크기 다시 지정
   	img.width = resizeWidth;
   	img.height = resizeHeight;
}
</script>

</head>
<body>
	<input type="hidden" id="company_no" value="${orderMap.company_no}">
	<input type="hidden" id="langdingurl" value="${orderMap.url}">
	<input type="hidden" id="language" value="${orderMap.language}">
	<input type="hidden" id="orderth" value="${orderMap.orderth}">
	<input type="hidden" id="category" value="${orderMap.category}">
	<input type="hidden" id="createcheck" value="${orderMap.createcheck}">
	<input type="hidden" id="rownum" value="0">
	<input type="hidden" id="card_config_no" value="${orderMap.card_config_no}">
	<form id="form" method="post" action="/pc/card/card_make">
		<input type="hidden" id="order_no" name="order_no" value="${orderMap.no}">
		<div class="container subnav subnav-top" style="margin-top:20px;">
			<div class="container">
				<div class="font-w pull-left" style="margin: 0 auto;">
					<div class="pull-left margin-r-10" style="width: 300px;">
						<select class="form-control input-sm" name="st_company" id="st_company" onchange="fn_orderlist();">
							<option value="-1">업체선택</option>
						</select>
					</div>
				</div>
				<div class="font-w pull-left" style="margin: 0 auto;">
					<div class="pull-left margin-r-10" style="width: 200px;">
						<select class="form-control input-sm" name="st_order" id="st_order" onchange="fn_infoClear();">
							<option value="-1">발주차수 선택</option>
						</select>
					</div>
				</div>
				<div class="pull-left width-100" style="margin-left: -10px;">
					<button class="btn btn-info wd50 btn-sm" type="button" onclick="fn_search()">검색</button>
				</div>
				<div class="font-w pull-left" style="margin: 0 auto;">
					<div class="pull-left margin-r-10" style="width: 100px; margin-left: 10px;">
						<input type="text" class="form-control input-sm" style="border-radius: 3px;" id="file" name="file" value="총 ${orderMap.filecount}개" readonly="readonly">
					</div>
				</div>
				<div class="pull-left width-100" style="margin-left: -10px;">
					<button class="btn btn-info wd100 btn-sm " type="button" onclick="fn_download()">다운로드</button>
				</div>
			</div>
		</div>

		<div class="container subnav subnav-bottom">
			<div class="subnavcontainer">
				<div class="pull-left margin-r-10" style="width: 500px; margin-left: -15px;">
					<div class="pull-left input-group input-group-sm" style="width: 500px;">
						<c:choose>
							<c:when test="${orderMap.id == null}">
								<input type="text" class="form-control" id="orderInfo" placeholder="진행 상태 url" readonly="readonly" style="border-radius: 3px;">
							</c:when>
							<c:otherwise>
								<input type="text" class="form-control" id="orderInfo" value="주문자:${orderMap.name}, 등록일:${orderMap.orderdate}, 진행상태:${orderMap.status_view}, 랜딩URL:${orderMap.url}" readonly="readonly" style="border-radius: 3px;">
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="pull-left margin-r-10" style="width: 250px; color: #fff;">
					<label class="checkbox-inline"> 
						<input type="checkbox" id="language_ko" type="checkbox" disabled="disabled" ${orderMap.ko=="1"?"checked":""} value="${orderMap.ko=='1'?'1':'0'}"> 한국
					</label> 
					<label class="checkbox-inline"> 
						<input type="checkbox" id="language_en" type="checkbox" disabled="disabled" ${orderMap.en=="1"?"checked":""} value="${orderMap.en=='1'?'1':'0'}"> 영어
					</label> 
					<label class="checkbox-inline"> 
						<input type="checkbox" id="language_cn" type="checkbox" disabled="disabled" ${orderMap.cn=="1"?"checked":""} value="${orderMap.cn=='1'?'1':'0'}"> 중국어
					</label> 
					<label class="checkbox-inline"> 
						<input type="checkbox" id="language_jp" type="checkbox" disabled="disabled" ${orderMap.jp=="1"?"checked":""} value="${orderMap.jp=='1'?'1':'0'}"> 일어
					</label>
				</div>
				<div class="font-w pull-left" style="margin: 0 auto;">
					<div class="pull-left" style="width: 100px;">
						<select class="form-control input-sm" name="st_category" id="st_category" style="color: red;">
							<option value="-1" ${orderMap.category == -1 ? "selected" : ""}>타입 선택</option>
							<option value="0" ${orderMap.category == 0 ? "selected" : ""}>일반</option>
							<option value="1" ${orderMap.category == 1 ? "selected" : ""}>와이드</option>
							<option value="2" ${orderMap.category == 2 ? "selected" : ""}>마이크로</option>
							<option value="3" ${orderMap.category == 3 ? "selected" : ""}>마이크로와이드</option>
						</select>
					</div>
				</div>
				<div class="pull-right" style="margin-right: -15px;">
					<button class="btn btn-info wd50 btn-sm btn-danger btnCreate ${orderMap.createcheck>0?'hidden':''}" type="button" onclick="fn_create()">생성</button>
					<button class="btn btn-info wd50 btn-sm btn-primary btnDown ${orderMap.createcheck>0?'':'hidden'}" type="button" onclick="fn_cardDown();">CSV</button>
				</div>
			</div>
		</div>
	</form>

	<div class="container margin-t-10 cntbox radiall" style="padding: 20px 20px 0 20px;">
		<div class="pull-left center-block" style="width: 100%;">
			<div class="pull-right">
				<p><strong id="total"></strong></p>
			</div>
			<div class="btn-group center-block center-block text-center"
				style="width: 200px;">
				<button type="button" class="btn btn-default navbar-btn wd100" onclick="fn_viewPage();">보기</button>
				<button type="button" class="btn btn-primary navbar-btn wd100 active">생성</button>
			</div>
		</div>
		<div>
			<div class="pull-left">
				<h4 class="pull-left" style="margin-bottom: 30px;">
					<strong>명함관리</strong>
				</h4>
			</div>
		</div>
		<table class="table table-hover text-center table-striped" id="cardList">
			<thead>
				<tr>
					<th class="text-center client-n" style="width: 40px;">번호</th>
					<th class="text-center client-num" style="width: 80px;">사진</th>
					<th class="text-center client-num" style="width: 150px;">이름</th>
					<th class="text-center client-num" style="width: 150px;">부서</th>
					<th class="text-center client-num" style="width: 150px;">직급</th>
					<th class="text-center client-num" style="width: 80px;">전화번호</th>
					<th class="text-center client-num" style="width: 100px;">메일주소</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>

	<!-- MODAL -->
	<div id="loadingModal" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h2 class="modal-title" align="center">등록중</h2>
				</div>
				<div class="modal-body" align="center">
					<div><h3>현재:<span id="currCount">0</span> / 총:<span id="totalCount">0</span></h3></div>
		  			<div><h3 style="color: red;">※ 대량의 데이터는 시간이 다소 소요 됩니다.</h3></div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>