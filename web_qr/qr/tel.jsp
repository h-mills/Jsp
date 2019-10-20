<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function telClear() {
	for (i = 1; i <= 5; i++) {
		$("#telDiv" + i).find("input").val('');
		if(i != 1) $("#telDiv" + i).css("display","none");
	}
}
	function telMix() {
		var data = "";
		for (i = 1; i <= 5; i++) {
			if($("#telDiv" + i).find("input").val().length >0){
				data += $("#telDiv" + i).find("input").val() + ";";
			}
		}
		$("#data").val(data);
	}
	function addtel() {
		var i = 0;
		for (i = 2; i <= 5; i++) {
			var value = "telDiv" + i;
			var teldiv = document.getElementById(value);
			if (teldiv.style.display == "none") {
				teldiv.style.display = "";
				$("#telDiv" + i).find("input").prop("disabled", false);
				$("#telDiv" + i).find("input").val("");
				break;
			}
		}
	}
	function deltel() {
		var i = 0;
		for (i = 5; i >= 2; i--) {
			var value = "telDiv" + i;
			var id = "telvalue" + i;
			var teldiv = document.getElementById(value);
			if (teldiv.style.display == "") {
				teldiv.style.display = "none";
				$("#telDiv" + i).find("input").prop("disabled", true);
				$("#telDiv" + i).find("input").val("");
				//document.getElementById(id).value = "http://";
				break;
			}
		}
	}
	function createTel() {
		var data = "";
		for (i = 1; i <= 5; i++) {
			if($("#tel" + i).find("input").val().length >0){
				data += $("#tel" + i).find("input").val() + ";";
			}
		}
		$("#data").val(data);
	}
	function addtel2() {
		var i = 0;
		for (i = 2; i <= 5; i++) {
			var value = "tel" + i;
			var teldiv = document.getElementById(value);
			if (teldiv.style.display == "none") {
				teldiv.style.display = "";
				$("#tel" + i).find("input").prop("disabled", false);
				$("#tel" + i).find("input").val("");
				break;
			}
		}
	}
	function deltel2() {
		var i = 0;
		for (i = 5; i >= 2; i--) {
			var value = "tel" + i;
			var id = "telvalue" + i;
			var teldiv = document.getElementById(value);
			if (teldiv.style.display == "") {
				teldiv.style.display = "none";
				$("#tel" + i).find("input").prop("disabled", true);
				$("#tel" + i).find("input").val("");
				break;
			}
		}
	}
</script>
</head>
<body>
	<c:if test="${data.data != null }">
	<div id="telDiv1" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: ${data.data[0]==null?'none':''};">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">tel1</span>
		<input type="text" name="data0" class="form-control"
			style="width: 85%;" value="${data.data[0] }">
		<button type="button" class="btn btn-danger" onclick="addtel()"
			style="width: 15%;">추가</button>
	</div>
	<div id="telDiv2" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: ${data.data[1]==null?'none':''};">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">tel2</span>
		<input type="text" name="data1" class="form-control"
			style="width: 85%;" value="${data.data[1] }">
		<button type="button" class="btn btn-danger" onclick="deltel()"
			style="width: 15%;">삭제</button>
	</div>
	<div id="telDiv3" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: ${data.data[2]==null?'none':''};">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">tel3</span>
		<input type="text" name="data2" id="data2" class="form-control"
			style="width: 85%;" value="${data.data[2] }">
		<button type="button" class="btn btn-danger" onclick="deltel()"
			style="width: 15%;">삭제</button>
	</div>
	<div id="telDiv4" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: ${data.data[3]==null?'none':''};">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">tel4</span>
		<input type="text" name="data3" class="form-control"
			style="width: 85%;" value="${data.data[3] }">
		<button type="button" class="btn btn-danger" onclick="deltel()"
			style="width: 15%;">삭제</button>
	</div>
	<div id="telDiv5" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: ${data.data[4]==null?'none':''};">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">tel5</span>
		<input type="text" name="data4" class="form-control"
			style="width: 85%;" value="${data.data[4] }">
		<button type="button" class="btn btn-danger" onclick="deltel()"
			style="width: 15%;">삭제</button>
	</div>
	<div class="input-group input-group pull-right margin-t-10"
		style="width: 100%; text-align: center;">
		<button type="button" class="btn btn-primary btn-m" onclick="update(4)"
			style="width: 15%;">데이터 수정</button>
	</div>
	</c:if>
	<!-- @@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- @@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- @@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- @@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- @@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@ -->
	<c:if test="${data.data == null}">
	<div id="tel1" class="input-group input-group pull-left margin-t-10"
		style="width: 100%;">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">tel</span>
		<input type="text" name="data0" class="form-control"
			style="width: 85%;" value="" placeholder="생성할 tel을 입력하세요">
		<button type="button" class="btn btn-danger" onclick="addtel2()"
			style="width: 15%;">추가</button>
	</div>
	<div id="tel2" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: none">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">tel</span>
		<input type="text" name="data1" class="form-control"
			style="width: 85%;" value="">
		<button type="button" class="btn btn-danger" onclick="deltel2()"
			style="width: 15%;">삭제</button>
	</div>
	<div id="tel3" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: none">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">tel</span>
		<input type="text" name="data2" id="data2" class="form-control"
			style="width: 85%;" value="">
		<button type="button" class="btn btn-danger" onclick="deltel2()"
			style="width: 15%;">삭제</button>
	</div>
	<div id="tel4" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: none">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">tel</span>
		<input type="text" name="data3" class="form-control"
			style="width: 85%;" value="">
		<button type="button" class="btn btn-danger" onclick="deltel2()"
			style="width: 15%;">삭제</button>
	</div>
	<div id="tel5" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: none">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">tel</span>
		<input type="text" name="data4" class="form-control"
			style="width: 85%;" value="">
		<button type="button" class="btn btn-danger" onclick="deltel2()"
			style="width: 15%;">삭제</button>
	</div>
	<div class="input-group input-group pull-right margin-t-10"
		style="width: 100%; text-align: center;">
		<button type="button" class="btn btn-primary btn-m" onclick="create(4)"
			style="width: 15%;">생성</button>
	</div>
	</c:if>
</body>
</html>