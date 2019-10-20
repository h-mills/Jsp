<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ include file="/WEB-INF/jsp/include/include.jsp"%>
<jsp:useBean id="sysdate" class="java.util.Date"/>
<fmt:formatDate value="${sysdate }" pattern="HH:mm:ss" var="sysdate"/>
<jsp:useBean id="now" class="java.util.Date" />
<html>
<head>
<title>QR관리</title>
<style>
*{text-decoration:none;}
.table tbody tr td{vertical-align: middle;}
</style>
<script type="text/javascript" charset="UTF-8">
$(document).ready(function() {
	if("${data.category}" == null || "${data.category}" == 0) {
		$('#qr_category').val(0);
		$('#rd_isdelete').val('all');
	} else {
		$('#qr_category').val("${data.category}");
		$('#rd_isdelete').val("${data.isdelete}");
	}
	if ("${data.isdelete}" == null) {
		$(":radio[value='all']").attr("checked", "checked");
	} else {
		$(":radio[value='${data.isdelete}']").attr("checked", "checked");
	}
});
//체크박스 전체체크
function fn_checkAll() {
	if ($("#checkall").is(":checked") == true) {
		$("input:checkbox[name='box']").prop('checked', true);
	} else {
		$("input:checkbox[name='box']").prop('checked', false);
	}
}
//이미지 리사이즈
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
//랜딩 페이지
function fn_landing(url,masterno) {
	window.open(url+"?idx="+masterno,"LANDING", "width=600,height=500,scrollbars=yes,resizeable=yes,left=200,top=50");
}
// 보기 페이지로 이동
function fn_makePage(){
	form.action = "/qr/qr_make";
	form.submit();
}
// 대량생성 페이지로 이동
function fn_largeMake(){
	form.action = "/qr/largemake";
	form.submit();
}
// 페이징
function pageMove(pageNum) {
	document.getElementById('pageNum').value = pageNum;
	form.action = "/qr/qr_view";
	form.submit();
}
// 검색
function fn_search() {
	if($('#startDate').val() == "" || $('#endDate').val() == "") {
		alert("날짜를 지정하세요.");
		return false;
	}
	form.action = "/qr/qr_view";
	form.submit();
}
// 정상화 처리
function fn_normal() {
	var count = 0;
	count = $("input:checkbox[name='box']:checked").size();
	if (count == 0) {
		alert('항목을 선택해 주세요.');
		return;
	}

	if (confirm('정상 처리 하시겠습니까?') != true) return;

	form.action = "/qr/normal";
	form.submit();
}
// 삭제 처리
function fn_del() {
	var count = 0;
	count = $("input:checkbox[name='box']:checked").size();
	if (count == 0) {
		alert('항목을 선택해 주세요.');
		return;
	}

	if (confirm('삭제 하시겠습니까?') != true) return;

	form.action = "/qr/del";
	form.submit();
}
// 다운로드
function fn_download() {
	var count = 0;
	count = $("input:checkbox[name='box']:checked").size();
	if (count == 0) {
		alert('항목을 선택해 주세요.');
		return;
	}

	if (confirm('선택한 항목을 다운로드 하시겠습니까?') != true) return;
	form.action = "/qr/download";
	form.submit();
}
// 통계
function fn_stats(category, qr_config_no, qr_master_no) {
	window.open("/stats/qr_stats_scan?no="+qr_master_no+"&category="+category+"&qr_config_no="+qr_config_no,"통계",
			"width=1000,height=700,scrollbars=yes,resizeable=yes,left=200,top=50");
}
// 상세페이지
function fn_detail(masterno) {
	var pagenum = document.getElementById('pageNum').value;
	document.getElementById('masterno').value = masterno;
	form.action = "/qr/detail";
	form.submit();
}

</script>

</head>
<body>
<fmt:formatDate value="${now }" pattern="yyyy-MM-dd" var="today" />
	<form id="form" method="post">
		<input type="hidden" id="masterno" name="masterno" value="0">
		<input type="hidden" id="pageNum" name="pageNum" size="10" value="${data.pagingValues.pageNum==null?0:data.pagingValues.pageNum }">
		<input type="hidden" id="pagingURL" name="pagingURL" size="100" value="0">
		<div class="container subnav subnav-top">
			<div class="subnavcontainer">
				<div class="font-w pull-left" style="margin: 0 auto;">
					<div class="pull-left margin-r-10" style="width: 200px;">
						<select class="form-control input" name="qr_category" id="qr_category">
							<option value="0" selected=${data.category ==0?'selected':'' }>전체</option>
							<option value="1" selected=${data.category ==1?'selected':'' }>URL</option>
							<option value="2" selected=${data.category ==2?'selected':'' }>EMAIL</option>
							<option value="3" selected=${data.category ==3?'selected':'' }>GPS</option>
							<option value="4" selected=${data.category ==4?'selected':'' }>전화번호</option>
							<option value="5" selected=${data.category ==5?'selected':'' }>SMS</option>
							<option value="6" selected=${data.category ==6?'selected':'' }>명함</option>
							<option value="7" selected=${data.category ==7?'selected':'' }>메시지</option>
						</select>
					</div>
				</div>
				<div class="font-w pull-left" style="margin: 0 auto;">
					<div class="pull-left margin-r-10" style="width: 150px;">
						<input id="startDate" name="startDate" class="form-control input-text"  type="text" placeholder="생성일자" value=${data.startDate==null?'2017-06-07':data.startDate }>
					</div>
				</div>
				<div class="font-w pull-left" style="margin: 0 auto;">
					<div class="pull-left margin-r-10" style="width: 150px;">
						<input id="endDate" name="endDate" class="form-control input-text"  type="text" placeholder="생성일자" value=${data.endDate==null?today:data.endDate }>
					</div>
				</div>
				<div class="font-w pull-left" style="margin: 0 auto;">
					<div class="pull-left margin-r-10" style="width: 200px;">
						<input id="title" name="title" class="form-control input-text" type="text" placeholder="제목을 입력해주세요" value=${data.title==null?'':data.title }>
					</div>
				</div>
				<div class="pull-left width-100" style="margin-left: 5px;">
					<button class="btn btn-info wd50 btn-sm" type="button"onclick="fn_search()" style="width: 50px; height: 33px;">검색</button>
				</div>
			</div>
		</div>

		<div class="container subnav subnav-bottom">
			<div class="subnavcontainer">
				<div class="font-w pull-left" style="margin: 0 auto;">
					<div class="pull-left">
						<label class="radio-inline"> 
							<input type="radio" name="rd_isdelete" value="all" checked="checked">모두
						</label> 
						<label class="radio-inline"> 
							<input type="radio" name="rd_isdelete" value="0">정상
						</label> 
						<label class="radio-inline"> 
							<input type="radio" name="rd_isdelete" value="1">삭제
						</label>
					</div>
					<div class="pull-left" style="margin-left: 50px;">
						<p class="pull-left font-w"><span id="totalCount">총&nbsp;${data.listcount==null?0:data.listcount}개</span></p>
					</div>
				</div>
			</div>
		</div>

		<div class="container margin-t-10 cntbox radiall" style="padding:20px 20px 0 20px;">
			<div class="pull-left center-block" style="width:100%;">
		    	<div class="btn-group center-block center-block text-center" style="width:100%;">
		        	<button type="button" class="btn btn-primary navbar-btn wd100 " style="width: 33%; position: relative;">보기</button>
		            <button type="button" class="btn btn-default navbar-btn wd100" onclick="fn_makePage();" style="width: 33%;">생성</button>
		            <button type="button" class="btn btn-default navbar-btn wd100" style="width: 33%;" onclick="fn_largeMake()">대량생성</button>  
		        </div>
			</div>
			<div>
		 		<div class="pull-left">
				<h4 class="pull-left" style="margin-bottom:30px;">
		        <strong>QR보기</strong>
		        </h4>
		    	</div>
			</div>
			<table class="table table-hover text-center">
				<thead>
					<tr>
						<th class="text-center client-n" style="width: 3%;;"><label><input type="checkbox" id="checkall" onClick="fn_checkAll();"></label></th>
						<th class="text-center client-n" style="width: 5%;">번호</th>
						<th class="text-center client-num" style="width:10%;">QR 이미지</th>
						<th class="text-center client-num" style="width:10%;">카테고리</th>
						<th class="text-center client-num" style="width:40%;">제목</th>
						<th class="text-center client-num" style="width:7%;">담당자</th>
						<th class="text-center client-num" style="width:10%;">생성일자</th>
						<th class="text-center client-num" style="width:5%;">상태</th>
						<th class="text-center client-num" style="width:5%;">통계</th>
						<th class="text-center client-num" style="width:5%;">랜딩</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${data.list }" var="list" varStatus="i">
						<tr class="${list.ROWNUM%2==0?'':'active'}" >
							<td><label><input type="checkbox" id="box" name="box" value="${list.no }"></label></td>
							<td onclick="fn_detail(${list.no})"><fmt:formatNumber value="${list.ROWNUM }" type="number"/></td>
							<td onclick="fn_detail(${list.no})"><img src="/${list.image }?${sysdate}" onload="resize(this)"></td>
							<c:if test="${list.category==1 }"><td onclick="fn_detail(${list.no})">url</td></c:if>
							<c:if test="${list.category==2 }"><td onclick="fn_detail(${list.no})">email</td></c:if>
							<c:if test="${list.category==3 }"><td onclick="fn_detail(${list.no})">gps</td></c:if>
							<c:if test="${list.category==4 }"><td onclick="fn_detail(${list.no})">전화번호</td></c:if>
							<c:if test="${list.category==5 }"><td onclick="fn_detail(${list.no})">sms</td></c:if>
							<c:if test="${list.category==6 }"><td onclick="fn_detail(${list.no})">명함</td></c:if>
							<c:if test="${list.category==7 }"><td onclick="fn_detail(${list.no})">메시지</td></c:if>
							<td onclick="fn_detail(${list.no})">${list.title }</td>
							<td onclick="fn_detail(${list.no})">${list.gen_name }</td>
							<td onclick="fn_detail(${list.no})">${list.date }</td>
							<td onclick="fn_detail(${list.no})">${list.isdelete==0?'정상':'삭제' }</td>
							<td><button type="button"  class="btn btn-primary btn-sm wd50" onclick="fn_stats('${list.category}', '${list.qr_config_no}', '${list.no }');">통계</button></td>
							<td><button type="button"  class="btn btn-primary btn-sm" onclick="fn_landing('${data.landing}','${list.no }')" >보기</button></td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					 <tr>
	               		<td colspan="10" class="text-center">
	               			<ul class="pagination">
	                 			<%@ include file="/WEB-INF/jsp/include/paging.jsp"%>
							</ul>              
						</td>
					</tr>
				</tfoot>
			</table>
			<c:if test="${data.list.size() != 0 && data.listcount != null}">
			<div class="input-group input-group pull-left" style="width:100%; margin-bottom:20px;">
				<button type="button" class="btn btn-danger btn-m wd100 pull-right" style="margin-left:20px;" onClick="fn_del()">삭제</button>
				<button type="button" class="btn btn-danger btn-m wd100 pull-right" style="margin-left:20px;" onClick="fn_normal()">정상</button>
				<button type="button" class="btn btn-primary btn-m wd100 pull-right" onClick="fn_download()" style="width: 15%;">QR이미지 다운로드</button>
			</div>
			</c:if>
		</div>
	</form>
</body>
</html>