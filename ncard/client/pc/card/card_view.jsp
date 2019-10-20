<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ include file="/WEB-INF/jsp/include/include.jsp"%>

<html>
<head>
<link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
<link href="/common/bootstrap-treeselect/css/jquery.bootstrap.treeselect.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-1.12.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<script src="/common/bootstrap-treeselect/js/jquery.bootstrap.treeselect.js"></script>
<title>명함관리</title>
<style>
*{text-decoration:none;}
.deptSelectBtn{width: 100%;padding-top: 5px;padding-bottom: 5px;padding-left: 10px;padding-right: 10px;font-size: 12px;border-radius: 0;}
</style>
<script type="text/javascript" charset="UTF-8">
$(document).ready(function() {
	if ("${rd_isdelete}" == null) {
		$(":radio[value='all']").attr("checked", "checked");
	} else {
		$(":radio[value='${rd_isdelete}']").attr("checked", "checked");
	}
	if("${st_dept}" == null || "${st_dept}" == '-1'){
		$('#st_dept').val("-1");
	}else{
		$('#st_dept').val("${st_dept}");
	}
	if("${param.s_name}" != null && "${param.s_name}" != ''){
		var name = "${param.s_name}";
		$('#s_name').val(name.trim());
	}else{
		$('#s_name').val("");
	}
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


function fn_makePage(){
	form.action = "/pc/card/card_make";
	form.submit();
}
function pageMove(pageNum) {
	var url = "/pc/card/card_view";
	if ("${search}" == "2") {
		url = "/pc/card/card_view";
	}
	$("#pageNum").val(pageNum);
	form.action = url;
	form.submit();
}
// 부서명으로 검색
function fn_search() {
	$('#s_name').val('');
	form.action = "/pc/card/card_view";
	form.submit();
}
// 이름으로 검색
function fn_search2() {
	if($('#s_name').val().trim().length <= 0){
		alert("이름을 입력해 주세요."); return;
	}
	$('#st_dept').val('');
	form.action = "/pc/card/card_view";
	form.submit();
}

// 통계
function fn_stats(name, category, carddata_master_no, order_no) {
	window.open("/pc/card/card_stats_scan?order_no="+order_no+"&name="+encodeURI(encodeURIComponent(name))+"&category="+category+"&carddata_master_no="+carddata_master_no,"통계",
			"width=1000,height=700,scrollbars=yes,resizeable=yes,left=200,top=50");
}

// 랜딩페이지
function fn_landing(landingurl, category, carddata_master_no, lang, status) {
	if(status==4){
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
	}else{
		alert("랜딩페이지가 아직 준비되지 않았습니다");
		return false;
	}
	
}
</script>

</head>
<body>
	<form id="form" method="post">
	  	<input type="hidden" id="order_no" name="order_no" value="${card.order_no }">
		<input type="hidden" id="pageNum" name="pageNum" size="10" value="0">
		<input type="hidden" id="pagingURL" name="pagingURL" size="100" value="0">
		<div class="container subnav subnav-top" style="margin-top:20px; border-radius:10px 10px 10px 10px; ">
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
					<div class="pull-left" style="margin-left: 30px;">
						<p class="pull-left font-w"><span id="totalCount" style="vertical-align: middle;">총 ${listcount==null?0:listcount}개</span></p>
					</div>
				</div>
				<div class="pull-right width-100" style="margin-left: -10px;">
					<button class="btn btn-info wd50 btn-sm" type="button"onclick="fn_search2()">검색</button>
				</div>
				<div class="font-w pull-right" style="margin: 0 auto;">
					<div class="pull-right margin-r-10" style="width: 200px;">
						<input type="text" id="s_name" name="s_name" value="" onkeyPress="if (event.keyCode==13) fn_search2();" placeholder="이름으로 검색" class="form-control input-sm">
					</div>
				</div>
				<div class="font-w pull-right" style="margin-left: -10px; margin-right: 10px;">
					<button class="btn btn-info wd50 btn-sm" type="button"onclick="fn_search()">검색</button>
				</div>
				<div class="pull-right width-100" style="margin: 0 auto;">
					<div class="pull-left margin-r-10" style="width: 200px;">
						<select class="form-control input-sm" multiple="multiple" id="st_dept" name="st_dept">
							<c:forEach items="${deptList }" var="dept">
								<c:set var="parent" value="data-parent=${dept.parent_cd}"></c:set>
					            <option value="${dept.dept_no}" ${dept.level == 0 ? "" : parent} ${dept.isselect=="1"?"selected":""}>${dept.name }</option>
				            </c:forEach>
				        </select>
						<script type="text/javascript">
							$(document).ready(function() {
								$('#st_dept').treeselect();
								if("${st_dept}" == "-1"){
									fn_delcheckall();
								}
							});
							function fn_delcheckall(){
								var nodes = $(".bts_dropdown").find(":checkbox");
								for (var i=0; i<nodes.length; i++) {
									if ($(nodes[i]).is(":checked") == true) {
										$(nodes[i]).prop('checked', false);
									}
								}
								$(".deptSelectBtn").children('span').text('부서선택');
							}
							function fn_checkClick(obj) {
								var childrensNode = $(obj).closest("li").find(":checkbox");

								for (var i=1; i<childrensNode.length; i++) {
									if ($(obj).is(":checked") == true) {
										$(childrensNode[i]).prop('checked', true);
									} else {
										$(childrensNode[i]).prop('checked', false);
									}
								}

								var pNode = $(obj).closest("ul").siblings(".parentNode");
								while (true) {
									if (pNode.length > 0) {
										$(pNode).children(":checkbox").prop('checked', false);
										pNode = $(pNode).closest("ul").siblings(".parentNode");
									} else {
										return;
									}
								}
							}
						</script>
					</div>
				</div>
			</div>
		</div>
		<div class="container margin-t-10 cntbox radiall" style="padding:20px 20px 0 20px;">
			<div>
		 		<div class="pull-left">
				<h4 class="pull-left" style="margin-bottom:30px;">
		        <strong>명함관리</strong>
		        </h4>
		    	</div>
			</div>
			<table class="table text-center">
				<thead>
					<tr>
						<th class="text-center client-n" style="width: 50px;">번호</th>
						<th class="text-center client-num" style="width:80px;">이미지</th>
						<th class="text-center client-num" style="width:100px;">이름</th>
						<th class="text-center client-num" style="width:100px;">부서</th>
						<th class="text-center client-num" style="width:80px;">직급</th>
						<th class="text-center client-num" style="width:100px;">전화번호</th>
						<th class="text-center client-num" style="width:100px;">메일주소</th>
						<th class="text-center client-num" style="width:110px;">등록일</th>
						<th class="text-center client-num" style="width:80px;">상태</th>
						<th class="text-center client-num" style="width:70px;">통계</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${cardList }" var="card" varStatus="i">
						<c:if test="${card.ko_lang == '1' }">
							<tr class="${card.rownum%2 == 0?'':'active'}" style="cursor: pointer;">
								<c:if test="${card.first_lang == 'ko' }">
									<td rowspan="${card.lang_count }" align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'ko','${card.status}');">
										<fmt:parseNumber integerOnly="true" value="${card.rownum }" />
									</td>
									<td rowspan="${card.lang_count }" align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'ko','${card.status}');">
						           		<img src="${card.imageViewPath }" onload="resize(this)">
									</td>						
								</c:if>
								<td align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'ko','${card.status}');">${card.ko_name }</td>
								<td align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'ko','${card.status}');">${card.ko_part }</td>
								<td align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'ko','${card.status}');">${card.ko_position }</td>
								<td align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'ko','${card.status}');">${card.ko_tel }</td>
								<td align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'ko','${card.status}');">${card.ko_email }</td>
								<c:if test="${card.first_lang == 'ko' }">
									<td align="center" style="vertical-align: middle;" rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'ko','${card.status}');">
										<fmt:formatDate value="${card.date }" pattern="yyyy-MM-dd" />
									</td>
									<td align="center" style="vertical-align: middle;" rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'ko','${card.status}');">${card.isdelete==0?'정상':'삭제' }</td>
									<td align="center" style="vertical-align: middle;" rowspan="${card.lang_count }">
										<button type="button" class="btn btn-primary btn-sm wd50" onclick="fn_stats('${card.ko_name }', '${card.category}', '${card.master_no}', '${card.order_no }');">통계</button>
									</td>
								</c:if>
							</tr>
						</c:if>
						<c:if test="${card.en_lang == '1' }">
							<tr class="${card.rownum%2 == 0?'':'active'}" style="cursor: pointer;">
								<c:if test="${card.first_lang == 'en' }">
									<td rowspan="${card.lang_count }" align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'en','${card.status }');">
										<fmt:parseNumber integerOnly="true" value="${card.rownum }" />
									</td>
									<td rowspan="${card.lang_count }" align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'en','${card.status }');">
						           		<img src="${card.imageViewPath }" onload="resize(this)">
									</td>						
								</c:if>
								<td align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'en','${card.status }');">${card.en_name }</td>
								<td align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'en','${card.status }');">${card.en_part }</td>
								<td align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'en','${card.status }');">${card.en_position }</td>
								<td align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'en','${card.status }');">${card.en_tel }</td>
								<td align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'en','${card.status }');">${card.en_email }</td>
								<c:if test="${card.first_lang == 'en' }">
									<td align="center" style="vertical-align: middle;" rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'en','${card.status }');">
										<fmt:formatDate value="${card.date }" pattern="yyyy-MM-dd" />
									</td>
									<td align="center" style="vertical-align: middle;" rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'en','${card.status }');">${card.isdelete==0?'정상':'삭제' }</td>
									<td align="center" style="vertical-align: middle;" rowspan="${card.lang_count }">
										<button type="button" class="btn btn-primary btn-sm wd50" onclick="fn_stats('${card.en_name }','${card.category}', '${card.master_no}', '${card.order_no }');">통계</button>
									</td>
								</c:if>
							</tr>
						</c:if>
						<c:if test="${card.cn_lang == '1' }">
							<tr class="${card.rownum%2 == 0?'':'active'}" style="cursor: pointer;">
								<c:if test="${card.first_lang == 'cn' }">
									<td rowspan="${card.lang_count }" align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'cn','${card.status }');">
										<fmt:parseNumber integerOnly="true" value="${card.rownum }" />
									</td>
									<td rowspan="${card.lang_count }" align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'cn','${card.status }');">
						           		<img src="${card.imageViewPath }" onload="resize(this)">
									</td>						
								</c:if>
								<td align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'cn','${card.status }');">${card.cn_name }</td>
								<td align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'cn','${card.status }');">${card.cn_part }</td>
								<td align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'cn','${card.status }');">${card.cn_position }</td>
								<td align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'cn','${card.status }');">${card.cn_tel }</td>
								<td align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'cn','${card.status }');">${card.cn_email }</td>
								<c:if test="${card.first_lang == 'cn' }">
									<td align="center" style="vertical-align: middle;" rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'cn','${card.status }');">
										<fmt:formatDate value="${card.date }" pattern="yyyy-MM-dd" />
									</td>
									<td align="center" style="vertical-align: middle;" rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'cn','${card.status }');">${card.isdelete==0?'정상':'삭제' }</td>
									<td align="center" style="vertical-align: middle;" rowspan="${card.lang_count }">
										<button type="button" class="btn btn-primary btn-sm wd50" onclick="fn_stats('${card.cn_name }','${card.category}', '${card.master_no}', '${card.order_no }');">통계</button>
									</td>
								</c:if>
							</tr>
						</c:if>
						<c:if test="${card.jp_lang == '1' }">
							<tr class="${card.rownum%2 == 0?'':'active'}" style="cursor: pointer;">
								<c:if test="${card.first_lang == 'jp' }">
									<td rowspan="${card.lang_count }" align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'jp','${card.status }');">
										<fmt:parseNumber integerOnly="true" value="${card.rownum }" />
									</td>
									<td rowspan="${card.lang_count }" align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'jp','${card.status }');">
						           		<img src="${card.imageViewPath }" onload="resize(this)">
									</td>						
								</c:if>
								<td align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'jp','${card.status }');">${card.jp_name }</td>
								<td align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'jp','${card.status }');">${card.jp_part }</td>
								<td align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'jp','${card.status }');">${card.jp_position }</td>
								<td align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'jp','${card.status }');">${card.jp_tel }</td>
								<td align="center" style="vertical-align: middle;" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'jp','${card.status }');">${card.jp_email }</td>
								<c:if test="${card.first_lang == 'jp' }">
									<td align="center" style="vertical-align: middle;" rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'jp','${card.status }');">
										<fmt:formatDate value="${card.date }" pattern="yyyy-MM-dd" />
									</td>
									<td align="center" style="vertical-align: middle;" rowspan="${card.lang_count }" onClick="fn_landing('${card.landinginfo}', '${card.category}', '${card.master_no}', 'jp','${card.status }');">${card.isdelete==0?'정상':'삭제' }</td>
									<td align="center" style="vertical-align: middle;" rowspan="${card.lang_count }">
										<button type="button" class="btn btn-primary btn-sm wd50" onclick="fn_stats(''${card.jp_name }',${card.category}', '${card.master_no}', '${card.order_no }');">통계</button>
									</td>
								</c:if>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
				<tfoot>
					 <tr>
	               		<td colspan="10" class="text-center">
	               			<ul class="pagination">
	                 			<%@ include file="/WEB-INF/jsp/include/cardpaging.jsp"%>
							</ul>              
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</form>
</body>
</html>