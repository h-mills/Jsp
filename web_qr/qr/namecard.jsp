<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function namecardClear() {
	for (i = 1; i <= 9; i++) {
		if(document.getElementById("namedata"+i).value.length > 0){
			document.getElementById("namedata"+i).value = '';
		}
	}
}
	function nameCardMix() {
		var data = "";
		for (i = 1; i <= 9; i++) {
			data += document.getElementById("namedata"+i).value + ";";
		}
		$("#data").val(data);
	}
	function createNamecard() {
		var data = "";
		for (i = 1; i <= 9; i++) {
			data += document.getElementById("ndata"+i).value + ";";
		}
		$("#data").val(data);
	}
</script>
<title>Insert title here</title>
</head>
<body>
	<c:if test="${data.data != null }">
	<div id="nameCard1" class="input-group input-group pull-left margin-t-10"
		style="width: 100%;">
		<span class="input-group-addon" id="basic-addon1" style="width: 5%;">이름</span>
		<input type="text" id="namedata1" class="form-control" style="width: 100%;" value="${data.data[0] }">
		<span class="input-group-addon" id="basic-addon1" style="width: 5%;">메일</span>
		<input type="text" id="namedata2" class="form-control" style="width: 100%;" value="${data.data[1] }">
		<span class="input-group-addon" id="basic-addon1" style="width: 5%;">회사</span>
		<input type="text" id="namedata3" class="form-control" style="width: 100%;" value="${data.data[2] }">
	</div>
	<div id="nameCard2" class="input-group input-group pull-left margin-t-10"
		style="width: 100%;">
		<span class="input-group-addon" id="basic-addon1" style="width: 5%;">전화</span>
		<input type="text" id="namedata4" class="form-control" style="width: 100%;" value="${data.data[3] }">
		<span class="input-group-addon" id="basic-addon1" style="width: 5%;">팩스</span>
		<input type="text" id="namedata5" class="form-control" style="width: 100%;" value="${data.data[4] }">
		<span class="input-group-addon" id="basic-addon1" style="width: 5%;">모바일</span>
		<input type="text" id="namedata6" class="form-control" style="width: 100%;" value="${data.data[5] }">
	</div>
	<div id="nameCard3" class="input-group input-group pull-left margin-t-10"
		style="width: 100%;">
		<span class="input-group-addon" id="basic-addon1" style="width: 5%;">주소</span>
		<input type="text" id="namedata7" class="form-control" style="width: 100%;" value="${data.data[6] }">
	</div>
	<div id="nameCard4" class="input-group input-group pull-left margin-t-10"
		style="width: 100%;">
		<span class="input-group-addon" id="basic-addon1" style="width: 5%;">홈페이지</span>
		<input type="text" id="namedata8" class="form-control" style="width: 100%;" value="${data.data[7] }">
	</div>
	<div id="nameCard5" class="input-group input-group pull-left margin-t-10"
		style="width: 100%;">
		<span class="input-group-addon" id="basic-addon1" style="width: 5%;">메모</span>
		<input type="text" id="namedata9" class="form-control" style="width: 100%;" value="${data.data[8] }">
	</div>
	<div class="input-group input-group pull-right margin-t-10"
		style="width: 100%; text-align: center;">
		<button type="button" class="btn btn-primary btn-m" onclick="update(6)"
			style="width: 15%;">데이터 수정</button>
	</div>
	</c:if>
	<!-- @@@@@@@@@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- @@@@@@@@@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- @@@@@@@@@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- @@@@@@@@@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- @@@@@@@@@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- @@@@@@@@@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@@ -->
	<c:if test="${data.data == null }">
		<div id="nameCard1" class="input-group input-group pull-left margin-t-10"
		style="width: 100%;">
		<span class="input-group-addon" id="basic-addon1" style="width: 5%;">이름</span>
		<input type="text" id="ndata1" class="form-control" style="width: 100%;" value="" placeholder="이름을 입력하세요">
		<span class="input-group-addon" id="basic-addon1" style="width: 5%;">메일</span>
		<input type="text" id="ndata2" class="form-control" style="width: 100%;" value="" placeholder="메일주소 입력하세요">
		<span class="input-group-addon" id="basic-addon1" style="width: 5%;">회사</span>
		<input type="text" id="ndata3" class="form-control" style="width: 100%;" value="" placeholder="회사명을 입력하세요">
	</div>
	<div id="nameCard2" class="input-group input-group pull-left margin-t-10"
		style="width: 100%;">
		<span class="input-group-addon" id="basic-addon1" style="width: 5%;">전화</span>
		<input type="text" id="ndata4" class="form-control" style="width: 100%;" value="" placeholder="전화번호를 입력하세요">
		<span class="input-group-addon" id="basic-addon1" style="width: 5%;">팩스</span>
		<input type="text" id="ndata5" class="form-control" style="width: 100%;" value="" placeholder="팩스번호를 입력하세요">
		<span class="input-group-addon" id="basic-addon1" style="width: 5%;">모바일</span>
		<input type="text" id="ndata6" class="form-control" style="width: 100%;" value="" placeholder="핸드폰 번호를 입력하세요">
	</div>
	<div id="nameCard3" class="input-group input-group pull-left margin-t-10"
		style="width: 100%;">
		<span class="input-group-addon" id="basic-addon1" style="width: 5%;">주소</span>
		<input type="text" id="ndata7" class="form-control" style="width: 100%;" value="" placeholder="주소 입력하세요">
	</div>
	<div id="nameCard4" class="input-group input-group pull-left margin-t-10"
		style="width: 100%;">
		<span class="input-group-addon" id="basic-addon1" style="width: 5%;">홈페이지</span>
		<input type="text" id="ndata8" class="form-control" style="width: 100%;" value="" placeholder="홈페이지 주소를 입력하세요">
	</div>
	<div id="nameCard5" class="input-group input-group pull-left margin-t-10"
		style="width: 100%;">
		<span class="input-group-addon" id="basic-addon1" style="width: 5%;">메모</span>
		<input type="text" id="ndata9" class="form-control" style="width: 100%;" value="" placeholder="메모를 입력하세요">
	</div>
	<div class="input-group input-group pull-right margin-t-10"
		style="width: 100%; text-align: center;">
		<button type="button" class="btn btn-primary btn-m" onclick="create(6)"
			style="width: 15%;">생성</button>
	</div>
	</c:if>
</body>
</html>