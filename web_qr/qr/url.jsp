<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function urlClear() {
	for (i = 1; i <= 5; i++) {
		$("#urlDiv" + i).find("input").val('');
		if(i != 1) $("#urlDiv" + i).css("display","none");
	}
}
	function urlMix() {
		var data = "";
		for (i = 1; i <= 5; i++) {
			if($("#urlDiv" + i).find("input").val().length >0){
				data += $("#urlDiv" + i).find("input").val() + ";";
			}
		}
		$("#data").val(data);
	}
	function addurl() {
		var i = 0;
		for (i = 2; i <= 5; i++) {
			var value = "urlDiv" + i;
			var urldiv = document.getElementById(value);
			if (urldiv.style.display == "none") {
				urldiv.style.display = "";
				$("#urlDiv" + i).find("input").prop("disabled", false);
				$("#urlDiv" + i).find("input").val("");
				break;
			}
		}
	}
	function delurl() {
		var i = 0;
		for (i = 5; i >= 2; i--) {
			var value = "urlDiv" + i;
			var id = "urlvalue" + i;
			var urldiv = document.getElementById(value);
			if (urldiv.style.display == "") {
				urldiv.style.display = "none";
				$("#urlDiv" + i).find("input").prop("disabled", true);
				$("#urlDiv" + i).find("input").val("");
				//document.getElementById(id).value = "http://";
				break;
			}
		}
	}
	function createUrl() {
		var data = "";
		for (i = 1; i <= 5; i++) {
			if($("#url" + i).find("input").val().length >0){
				data += $("#url" + i).find("input").val() + ";";
			}
		}
		$("#data").val(data);
	}
	function addurl2() {
		var i = 0;
		for (i = 2; i <= 5; i++) {
			var value = "url" + i;
			var urldiv = document.getElementById(value);
			if (urldiv.style.display == "none") {
				urldiv.style.display = "";
				$("#url" + i).find("input").prop("disabled", false);
				$("#url" + i).find("input").val("");
				break;
			}
		}
	}
	function delurl2() {
		var i = 0;
		for (i = 5; i >= 2; i--) {
			var value = "url" + i;
			var id = "urlvalue" + i;
			var urldiv = document.getElementById(value);
			if (urldiv.style.display == "") {
				urldiv.style.display = "none";
				$("#url" + i).find("input").prop("disabled", true);
				$("#url" + i).find("input").val("");
				break;
			}
		}
	}
</script>
<title>Insert title here</title>
</head>
<body>
	<c:if test="${data.data != null}">
	<div id="urlDiv1" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: ${data.data[0]==null?'none':''};">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">url1</span>
		<input type="text" name="data0" class="form-control"
			style="width: 85%;" value="${data.data[0]}">
		<button type="button" class="btn btn-danger" onclick="addurl()"
			style="width: 15%;">추가</button>
	</div>
	<div id="urlDiv2" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: ${data.data[1]==null?'none':''};">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">url2</span>
		<input type="text" name="data1" class="form-control"
			style="width: 85%;" value="${data.data[1]}">
		<button type="button" class="btn btn-danger" onclick="delurl()"
			style="width: 15%;">삭제</button>
	</div>
	<div id="urlDiv3" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: ${data.data[2]==null?'none':''};">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">url3</span>
		<input type="text" name="data2" id="data2" class="form-control"
			style="width: 85%;" value="${data.data[2]}">
		<button type="button" class="btn btn-danger" onclick="delurl()"
			style="width: 15%;">삭제</button>
	</div>
	<div id="urlDiv4" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: ${data.data[3]==null?'none':''};">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">url4</span>
		<input type="text" name="data3" class="form-control"
			style="width: 85%;" value="${data.data[3]}">
		<button type="button" class="btn btn-danger" onclick="delurl()"
			style="width: 15%;">삭제</button>
	</div>
	<div id="urlDiv5" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: ${data.data[4]==null?'none':''};">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">url5</span>
		<input type="text" name="data4" class="form-control"
			style="width: 85%;" value="${data.data[4]}">
		<button type="button" class="btn btn-danger" onclick="delurl()"
			style="width: 15%;">삭제</button>
	</div>
	<div class="input-group input-group pull-right margin-t-10"
		style="width: 100%; text-align: center;">
		<button type="button" class="btn btn-primary btn-m" onclick="update(1)" style="width: 15%;">데이터 수정</button>
	</div>
	</c:if>
	<!-- @@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- @@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- @@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- @@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- @@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@ -->
	<c:if test="${data.data == null}">
	<div id="url1" class="input-group input-group pull-left margin-t-10"
		style="width: 100%;">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">url</span>
		<input type="text" name="data0" class="form-control"
			style="width: 85%;" value="" placeholder="생성할 URL을 입력하세요">
		<button type="button" class="btn btn-danger" onclick="addurl2()"
			style="width: 15%;">추가</button>
	</div>
	<div id="url2" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: none">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">url</span>
		<input type="text" name="data1" class="form-control"
			style="width: 85%;" value="">
		<button type="button" class="btn btn-danger" onclick="delurl2()"
			style="width: 15%;">삭제</button>
	</div>
	<div id="url3" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: none">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">url</span>
		<input type="text" name="data2" id="data2" class="form-control"
			style="width: 85%;" value="">
		<button type="button" class="btn btn-danger" onclick="delurl2()"
			style="width: 15%;">삭제</button>
	</div>
	<div id="url4" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: none">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">url</span>
		<input type="text" name="data3" class="form-control"
			style="width: 85%;" value="">
		<button type="button" class="btn btn-danger" onclick="delurl2()"
			style="width: 15%;">삭제</button>
	</div>
	<div id="url5" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: none">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">url</span>
		<input type="text" name="data4" class="form-control"
			style="width: 85%;" value="">
		<button type="button" class="btn btn-danger" onclick="delurl2()"
			style="width: 15%;">삭제</button>
	</div>
	<div class="input-group input-group pull-right margin-t-10"
		style="width: 100%; text-align: center;">
		<button type="button" class="btn btn-primary btn-m" onclick="create(1)"
			style="width: 15%;">생성</button>
	</div>
	</c:if>
</body>
</html>