<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ include file="/WEB-INF/jsp/include/include.jsp"%>

<html>
<head>
<link rel="stylesheet" href="/common/bootstrap-select-1.12.4/css/bootstrap-select.min.css">
<script src="/common/bootstrap-select-1.12.4/js/bootstrap-select.min.js"></script>
<title>명함관리</title>
<style>
*{text-decoration:none;}
#cardTable td {vertical-align: middle;}
#cardTable th {padding-left: 0px; padding-right: 0px; font-size: 12px;}
</style>
<script type="text/javascript" charset="UTF-8">
$(document).ready(function() {
	if ("${rd_isdelete}" == "") {
		$(":radio[value='all']").attr("checked", "checked");
	} else {
		$(":radio[value='${rd_isdelete}']").attr("checked", "checked");
	}

	fn_companylist();
});

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

//체크박스 전체체크
function fn_checkAll() {
	if ($("#checkall").is(":checked") == true) {
		$("input:checkbox[name='box']").prop('checked', true);
	} else {
		$("input:checkbox[name='box']").prop('checked', false);
	}
}

function fn_makePage(){
	form.action = "/pc/card/card_make";
	form.submit();
}
function pageMove(pageNum) {
	var url = "/pc/card/card_view";
	if ("${search}" == "2") {
		url = "/pc/card/card_view2";
	} else if ("${search}" == "3") {
		url = "/pc/card/card_view3";
	}
	$("#pageNum").val(pageNum);
	form.action = url;
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

       		for(var i=0; i<companylist.length; i++){
       			var cd = companylist[i].no;
       			var name = companylist[i].name;
   				$("#st_company").append("<option value="+cd+">"+name+"</option>");
    		}
       		if ("${st_company}" != "") {
           		$("#st_company option[value='"+"${st_company}"+"']").attr("selected", "selected");
       		}
       		fn_orderlist();
		}
	});
}

function fn_orderlist() {
	var company_no = $('#st_company').val();
	var url = "/pc/card/orderlist";
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
			$("#st_order").append("<option value='0'>전체</option>");

			if (result == "1") {
	   			for(var i=0; i<orderList.length; i++){
	   				var no = orderList[i].no;
	   				var title = orderList[i].title;
					$("#st_order").append("<option value="+no+">"+title+"</option>");
	   			}
	   			if ("${st_order}" != "") {
	           		$("#st_order option[value='"+"${st_order}"+"']").attr("selected", "selected");
	       		}
			}
   			if(company_no == '-1' || result != '1'){
   				$("#st_order").find("option").remove();
   				$("#st_order").append("<option value='-1'>발주차수 선택</option>");
   			}
		}
	});
}

function fn_search() {
	if($('#st_company').val() == -1) {
		alert("업체명을 선택하세요.");
		return false;
	} else if($('#st_order').val() == -1) {
		alert("발주차수를 선택하세요.");
		return false;
	}
	$("#keyword").val("");
	
	form.action = "/pc/card/card_view";
	form.submit();
}

function fn_search2() {
	if($('#st_dept').val() < -1) {
		alert("직종을 선택하세요.");
		return false;
	}
	$("#keyword").val("");

	form.action = "/pc/card/card_view2";
	form.submit();
}

function fn_search3() {
	$("#keyword").val($("#keyword").val().trim());
	form.action = "/pc/card/card_view3";
	form.submit();
}

function fn_normal() {
	var count = 0;
	count = $("input:checkbox[name='box']:checked").size();
	if (count == 0) {
		alert('항목을 선택해 주세요.');
		return;
	}

	if (confirm('정상 처리 하시겠습니까?') != true) return;

	form.action = "/pc/card/normal";
	form.submit();
}

function fn_del() {
	var count = 0;
	count = $("input:checkbox[name='box']:checked").size();
	if (count == 0) {
		alert('항목을 선택해 주세요.');
		return;
	}

	if (confirm('삭제 하시겠습니까?') != true) return;

	form.action = "/pc/card/del";
	form.submit();
}

// 통계
function fn_stats(category, carddata_master_no, order_no) {
	window.open("/pc/card/card_stats_scan?order_no="+order_no+"&category="+category+"&carddata_master_no="+carddata_master_no,"통계",
			"width=1000,height=700,scrollbars=yes,resizeable=yes,left=200,top=50");
}

// 랜딩페이지
function fn_landing(landingurl, category, carddata_master_no, lang) {
	//gubun:normal, wide, micro, microwide
	var gubun = "";
	if (category == 0) {
		gubun = "normal";
	}else if (category == 1) {
		gubun = "wide";
	}else if (category == 2) {
		gubun = "micro";
	}else if (category == 3) {
		gubun = "microwide";
	}
	window.open(landingurl+"?gubun="+gubun+"&card_data_no="+carddata_master_no+"&lang="+lang,"LANDING",
			"width=1000,height=700,scrollbars=yes,resizeable=yes,left=200,top=50");
}

// 데이터 수정
function fn_updateCardData(category, card_master_no, firstLang) {
	window.open("/pc/card/getcarddata?category="+category+"&card_master_no="+card_master_no+"&lang="+firstLang,"명함정보수정",
	"width=1000,height=550,scrollbars=yes,resizeable=yes,left=200,top=50");
}

</script>

</head>
<body>
	<form id="form" method="post">
	  	<input type="hidden" id="order_no" name="order_no" value="${card.order_no }">
		<input type="hidden" id="pageNum" name="pageNum" size="10" value="0">
		<input type="hidden" id="pagingURL" name="pagingURL" size="100" value="0">
		<div class="container subnav subnav-top" style="margin-top:20px;">
			<div class="subnavcontainer">
				<div class="font-w pull-left" style="margin: 0 auto;">
					<div class="pull-left margin-r-10" style="width: 300px;">
						<select class="form-control input-sm"name="st_company" id="st_company" onchange="fn_orderlist();">
							  <option value="-1">업체 선택</option>
						</select>
					</div>
				</div>
				<div class="font-w pull-left" style="margin: 0 auto;">
					<div class="pull-left margin-r-10" style="width: 200px;">
						<select class="form-control input-sm"name="st_order" id="st_order">
							  <option value="-1">발주차수 선택</option>
						</select>
					</div>
				</div>
				<div class="pull-left width-100" style="margin-left: -10px;">
					<button class="btn btn-info wd50 btn-sm" type="button"onclick="fn_search()">검색</button>
				</div>
			</div>
		</div>

		<div class="container subnav subnav-bottom">
			<div class="subnavcontainer">
				<div class="font-w pull-left" style="margin: 0 auto;">
					<div class="pull-left margin-r-10" style="width: 200px;">
						<select class="form-control selectpicker" name="st_industry" id="st_industry" multiple title="업종 선택" data-selected-text-format="count > 2" data-size="15" data-live-search="true" data-live-search-placeholder="검색" data-actions-box="true">
							<c:forEach var="list" items="${industryList }">
								<c:choose>
									<c:when test="${list.level == '1' }">
										<optgroup label="${list.name }">
									</c:when>
									<c:when test="${list.level == '2' }">
										<option value="${list.cd }" disabled>${list.name }</option>
									</c:when>
									<c:otherwise>
										<option value="${list.cd }" title="${list.name }" ${list.select=="1"?"selected":""}>&nbsp;&nbsp;&nbsp;${list.name }</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="font-w pull-left" style="margin: 0 auto;">
					<div class="pull-left margin-r-10" style="width: 150px;">
						<select class="form-control input-sm"name="st_dept" id="st_dept">
							<option value="-2" ${(st_dept == -2 || search != 2) ? "selected" : ""}>직종 선택</option>
							<option value="-1" ${(st_dept == -1 && search == 2) ? "selected" : ""}>전체</option>
							<c:forEach var="list" items="${deptList }">
								<option value="${list.no }" ${(st_dept == list.no && search == 2) ? "selected" : ""}>${list.name }</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="pull-left width-100" style="margin-left: -10px;">
					<button class="btn btn-info wd50 btn-sm" type="button" onclick="fn_search2()">검색</button>
				</div>
				<div class="pull-left width-200">
					<div class="input-group input-group-sm" style="margin-left: 10px;">
						<input type="text" class="form-control" style="width: 150px;" id="keyword" name="keyword" value="${param.keyword}" maxlength="20" placeholder="이름"> 
						<span class="input-group-btn">
							<button class="btn btn-info wd50" type="button" onclick="fn_search3();">검색</button>
						</span>
					</div>
				</div>
				<div class="font-w pull-right" style="margin: 0 auto;">
					<div class="pull-left">
						<label class="radio-inline"> 
							<input type="radio" name="rd_isdelete" value="all">모두
						</label> 
						<label class="radio-inline"> 
							<input type="radio" name="rd_isdelete" value="0">정상
						</label> 
						<label class="radio-inline"> 
							<input type="radio" name="rd_isdelete" value="1">삭제
						</label>
					</div>
					<div class="pull-left" style="margin-left: 50px;">
						<p class="pull-left font-w"><span id="totalCount">총 ${listcount==null?0:listcount}개</span></p>
					</div>
				</div>
			</div>
		</div>

		<div class="container margin-t-10 cntbox radiall" style="padding:20px 20px 0 20px;">
			<div class="pull-left center-block" style="width:100%;">
		    	<div class="btn-group center-block center-block text-center" style="width:200px;">
		        	<button type="button" class="btn btn-primary navbar-btn wd100 active">보기</button>
		            <button type="button" class="btn btn-default navbar-btn wd100" onclick="fn_makePage();">생성</button>  
		        </div>
			</div>
			<div>
		 		<div class="pull-left">
				<h4 class="pull-left" style="margin-bottom:30px;">
		        <strong>명함관리<small>&nbsp;이미지 클릭 시 데이터를 수정할 수 있습니다.</small></strong>
		        </h4>
		    	</div>
			</div>
			<table class="table text-center" id="cardTable">
				<thead>
					<tr>
						<th class="text-center client-n" style="width: 30px;"><label><input type="checkbox" id="checkall" onClick="fn_checkAll();"></label></th>
						<th class="text-center client-n" style="width: 50px;">번호</th>
						<th class="text-center client-num" style="width:70px;">타입</th>
						<th class="text-center client-num" style="width:80px;">이미지</th>
						<th class="text-center client-num" style="width:100px;">이름</th>
						<th class="text-center client-num" style="width:100px;">부서</th>
						<th class="text-center client-num" style="width:80px;">직급</th>
						<th class="text-center client-num" style="width:100px;">전화번호</th>
						<th class="text-center client-num" style="width:100px;">메일주소</th>
						<th class="text-center client-num" style="width:110px;">등록일</th>
						<th class="text-center client-num" style="width:70px;">상태</th>
						<th class="text-center client-num" style="width:50px;">통계</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${cardList }" var="card" varStatus="i">
						<c:if test="${card.ko_lang == '1' }">
							<tr class="${card.ROWNUM%2 == 0?'':'active'}" style="cursor: pointer;">
								<c:if test="${card.first_lang == 'ko' }">
									<td rowspan="${card.lang_count }">
										<label><input type="checkbox" id="box" name="box" value="${card.master_no}:${card.category}"></label>
									</td>
									<td rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'ko');">
										<fmt:parseNumber integerOnly="true" value="${card.ROWNUM }" />
									</td>
									<td rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'ko');">
										<c:choose>
											<c:when test="${card.category == 1}">와이드</c:when>
											<c:when test="${card.category == 2}">마이크로</c:when>
											<c:when test="${card.category == 3}">마이크로와이드</c:when>
											<c:otherwise>일반</c:otherwise>
										</c:choose>
									</td>
									<td rowspan="${card.lang_count }" onClick="fn_updateCardData('${card.category}', '${card.master_no}', '${card.first_lang}');">
						           		<img src="${card.imageViewPath }" onload="resize(this)">
									</td>						
								</c:if>
								<td onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'ko');">${card.ko_name }</td>
								<td onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'ko');">${card.ko_part }</td>
								<td onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'ko');">${card.ko_position }</td>
								<td onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'ko');">${card.ko_tel }</td>
								<td onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'ko');">${card.ko_email }</td>
								<c:if test="${card.first_lang == 'ko' }">
									<td rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'ko');">
										<fmt:formatDate value="${card.date }" pattern="yyyy-MM-dd" />
									</td>
									<td rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'ko');">${card.isdelete==0?'정상':'삭제' }</td>
									<td rowspan="${card.lang_count }">
										<button type="button" class="btn btn-primary btn-sm wd50" onclick="fn_stats('${card.category}', '${card.master_no}', '${card.order_no }');">통계</button>
									</td>
								</c:if>
							</tr>
						</c:if>
						<c:if test="${card.en_lang == '1' }">
							<tr class="${card.ROWNUM%2 == 0?'':'active'}" style="cursor: pointer;">
								<c:if test="${card.first_lang == 'en' }">
									<td rowspan="${card.lang_count }">
										<label><input type="checkbox" id="box" name="box" value="${card.master_no }"></label>
									</td>
									<td rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'en');">
										<fmt:parseNumber integerOnly="true" value="${card.ROWNUM }" />
									</td>
									<td rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'en');">
										<c:choose>
											<c:when test="${card.category == 1}">와이드</c:when>
											<c:when test="${card.category == 2}">마이크로</c:when>
											<c:when test="${card.category == 3}">마이크로와이드</c:when>
											<c:otherwise>일반</c:otherwise>
										</c:choose>
									</td>
									<td rowspan="${card.lang_count }" onClick="fn_updateCardData('${card.category}', '${card.master_no}', '${card.first_lang}');">
						           		<img src="${card.imageViewPath }" onload="resize(this)">
									</td>						
								</c:if>
								<td onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'en');">${card.en_name }</td>
								<td onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'en');">${card.en_part }</td>
								<td onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'en');">${card.en_position }</td>
								<td onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'en');">${card.en_tel }</td>
								<td onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'en');">${card.en_email }</td>
								<c:if test="${card.first_lang == 'en' }">
									<td rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'en');">
										<fmt:formatDate value="${card.date }" pattern="yyyy-MM-dd" />
									</td>
									<td rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'en');">${card.isdelete==0?'정상':'삭제' }</td>
									<td rowspan="${card.lang_count }">
										<button type="button" class="btn btn-primary btn-sm wd50" onclick="fn_stats('${card.category}', '${card.master_no}', '${card.order_no }');">통계</button>
									</td>
								</c:if>
							</tr>
						</c:if>
						<c:if test="${card.cn_lang == '1' }">
							<tr class="${card.ROWNUM%2 == 0?'':'active'}" style="cursor: pointer;">
								<c:if test="${card.first_lang == 'cn' }">
									<td rowspan="${card.lang_count }">
										<label><input type="checkbox" id="box" name="box" value="${card.master_no }"></label>
									</td>
									<td rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'cn');">
										<fmt:parseNumber integerOnly="true" value="${card.ROWNUM }" />
									</td>
									<td rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'cn');">
										<c:choose>
											<c:when test="${card.category == 1}">와이드</c:when>
											<c:when test="${card.category == 2}">마이크로</c:when>
											<c:when test="${card.category == 3}">마이크로와이드</c:when>
											<c:otherwise>일반</c:otherwise>
										</c:choose>
									</td>
									<td rowspan="${card.lang_count }" onClick="fn_updateCardData('${card.category}', '${card.master_no}', '${card.first_lang}');">
						           		<img src="${card.imageViewPath }" onload="resize(this)">
									</td>						
								</c:if>
								<td onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'cn');">${card.cn_name }</td>
								<td onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'cn');">${card.cn_part }</td>
								<td onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'cn');">${card.cn_position }</td>
								<td onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'cn');">${card.cn_tel }</td>
								<td onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'cn');">${card.cn_email }</td>
								<c:if test="${card.first_lang == 'cn' }">
									<td rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'cn');">
										<fmt:formatDate value="${card.date }" pattern="yyyy-MM-dd" />
									</td>
									<td rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'cn');">${card.isdelete==0?'정상':'삭제' }</td>
									<td rowspan="${card.lang_count }">
										<button type="button" class="btn btn-primary btn-sm wd50" onclick="fn_stats('${card.category}', '${card.master_no}', '${card.order_no }');">통계</button>
									</td>
								</c:if>
							</tr>
						</c:if>
						<c:if test="${card.jp_lang == '1' }">
							<tr class="${card.ROWNUM%2 == 0?'':'active'}" style="cursor: pointer;">
								<c:if test="${card.first_lang == 'jp' }">
									<td rowspan="${card.lang_count }">
										<label><input type="checkbox" id="box" name="box" value="${card.master_no }"></label>
									</td>
									<td rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'jp');">
										<fmt:parseNumber integerOnly="true" value="${card.ROWNUM }" />
									</td>
									<td rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'jp');">
										<c:choose>
											<c:when test="${card.category == 1}">와이드</c:when>
											<c:when test="${card.category == 2}">마이크로</c:when>
											<c:when test="${card.category == 3}">마이크로와이드</c:when>
											<c:otherwise>일반</c:otherwise>
										</c:choose>
									</td>
									<td rowspan="${card.lang_count }" onClick="fn_updateCardData('${card.category}', '${card.master_no}', '${card.first_lang}');">
						           		<img src="${card.imageViewPath }" onload="resize(this)">
									</td>						
								</c:if>
								<td onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'jp');">${card.jp_name }</td>
								<td onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'jp');">${card.jp_part }</td>
								<td onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'jp');">${card.jp_position }</td>
								<td onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'jp');">${card.jp_tel }</td>
								<td onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'jp');">${card.jp_email }</td>
								<c:if test="${card.first_lang == 'jp' }">
									<td rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'jp');">
										<fmt:formatDate value="${card.date }" pattern="yyyy-MM-dd" />
									</td>
									<td rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'jp');">${card.isdelete==0?'정상':'삭제' }</td>
									<td rowspan="${card.lang_count }">
										<button type="button" class="btn btn-primary btn-sm wd50" onclick="fn_stats('${card.category}', '${card.master_no}', '${card.order_no }');">통계</button>
									</td>
								</c:if>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
				<tfoot>
					 <tr>
	               		<td colspan="12" class="text-center">
	               			<ul class="pagination">
	                 			<%@ include file="/WEB-INF/jsp/include/paging.jsp"%>
							</ul>              
						</td>
					</tr>
				</tfoot>
			</table>
			<c:if test="${cardList.size() != 0 && listcount != null}">
			<div class="input-group input-group pull-left" style="width:100%; margin-bottom:20px;">
				<button type="button" class="btn btn-danger btn-m wd100 pull-right" style="margin-left:20px;" onClick="fn_del()">삭제</button>
				<button type="button" class="btn btn-primary btn-m wd100 pull-right" onClick="fn_normal()">정상</button>
			</div>
			</c:if>
		</div>
	</form>
</body>
</html>