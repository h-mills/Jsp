<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function smsClear() {
	for (i = 1; i <= 2; i++) {
		if($("#faxDiv" + i).find("input").val().length >0){
			$("#faxDiv" + i).find("input").val('');
		}
	}
}
	function faxMix() {
		var data = "";
		if($("#faxDiv1").find("input").val().length >0){
			data += $("#faxDiv1").find("input").val() + ";";
		}else{
			alert("번호를 입력하세요.");
			return;
		}
		if($("#faxDiv2").find("input").val().length >0){
			data += $("#faxDiv2").find("input").val() + ";";
		}else{
			alert("내용을 입력하세요.");
			return;
		}
		$("#data").val(data);
	}
	function createFax() {
		var data = "";
		if($("#fax1").find("input").val().length >0){
			data += $("#fax1").find("input").val() + ";";
		}else{
			alert("번호를 입력하세요.");
		}
		if($("#fax2").find("input").val().length >0){
			data += $("#fax2").find("input").val() + ";";
		}else{
			alert("내용을 입력하세요.");
			return ;
		}
		$("#data").val(data);
	}
</script>
</head>
<body>
	<c:if test="${data.data != null }">
	<div id="faxDiv1" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: ${data.data[0]==null?'none':''};">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">번호</span>
		<input type="text" name="data0" class="form-control" style="width: 100%;" value="${data.data[0] }">
	</div>
	<div id="faxDiv2" class="input-group input-group pull-left margin-t-10"
		style="width: 100%;">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">내용</span>
		<input type="text" name="data1" class="form-control" style="width: 100%;" value="${data.data[1] }">
	</div>
	<div class="input-group input-group pull-right margin-t-10"
		style="width: 100%; text-align: center;">
		<button type="button" class="btn btn-primary btn-m" onclick="update(5)"
			style="width: 15%;">데이터 수정</button>
	</div>
	</c:if>
	<!-- @@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- @@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- @@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- @@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- @@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@ -->
	<c:if test="${data.data == null}">
	<div id="fax1" class="input-group input-group pull-left margin-t-10"
		style="width: 100%;">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">번호</span>
		<input type="text" name="data0" class="form-control" style="width: 100%;" value="" placeholder="번호를 입력하세요">
	</div>
	<div id="fax2" class="input-group input-group pull-left margin-t-10"
		style="width: 100%;">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">내용</span>
		<input type="text" name="data1" class="form-control" style="width: 100%;" value=""placeholder="전송할 메시지를 입력하세요">
	</div>
	<div class="input-group input-group pull-right margin-t-10"
		style="width: 100%; text-align: center;">
		<button type="button" class="btn btn-primary btn-m" onclick="create(5)"
			style="width: 15%;">생성</button>
	</div>
	</c:if>
</body>
</html>