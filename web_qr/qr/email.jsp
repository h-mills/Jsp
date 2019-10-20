<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function emailClear() {
		for (i = 1; i <= 5; i++) {
			$("#emailDiv" + i).find("input").val('');
			if(i != 1) $("#emailDiv" + i).css("display","none");
		}
	}
	function emailMix() {
		var data = "";
		for (i = 1; i <= 5; i++) {
			if($("#emailDiv" + i).find("input").val().length >0){
				data += $("#emailDiv" + i).find("input").val() + ";";
			}
		}
		$("#data").val(data);
	}
	function addemail() {
		var i = 0;
		for (i = 2; i <= 5; i++) {
			var value = "emailDiv" + i;
			var emaildiv = document.getElementById(value);
			if (emaildiv.style.display == "none") {
				emaildiv.style.display = "";
				$("#emailDiv" + i).find("input").prop("disabled", false);
				$("#emailDiv" + i).find("input").val("");
				break;
			}
		}
	}
	function delemail() {
		var i = 0;
		for (i = 5; i >= 2; i--) {
			var value = "emailDiv" + i;
			var id = "emailvalue" + i;
			var emaildiv = document.getElementById(value);
			if (emaildiv.style.display == "") {
				emaildiv.style.display = "none";
				$("#emailDiv" + i).find("input").prop("disabled", true);
				$("#emailDiv" + i).find("input").val("");
				break;
			}
		}
	}
	function createEmail() {
		var data = "";
		for (i = 1; i <= 5; i++) {
			if($("#email" + i).find("input").val().length >0){
				data += $("#email" + i).find("input").val() + ";";
			}
		}
		$("#data").val(data);
	}
	function addemail2() {
		var i = 0;
		for (i = 2; i <= 5; i++) {
			var value = "email" + i;
			var emaildiv = document.getElementById(value);
			if (emaildiv.style.display == "none") {
				emaildiv.style.display = "";
				$("#email" + i).find("input").prop("disabled", false);
				$("#email" + i).find("input").val("");
				break;
			}
		}
	}
	function delemail2() {
		var i = 0;
		for (i = 5; i >= 2; i--) {
			var value = "email" + i;
			var id = "emailvalue" + i;
			var emaildiv = document.getElementById(value);
			if (emaildiv.style.display == "") {
				emaildiv.style.display = "none";
				$("#email" + i).find("input").prop("disabled", true);
				$("#email" + i).find("input").val("");
				break;
			}
		}
	}
</script>
</head>
<body>
	<c:if test="${data.data != null }">
	<div id="emailDiv1" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: ${data.data[0]==null?'none':''};">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">email1</span>
		<input type="text" name="data0" class="form-control"
			style="width: 85%;" value="${data.data[0]}">
		<button type="button" class="btn btn-danger" onclick="addemail()"
			style="width: 15%;">추가</button>
	</div>
	<div id="emailDiv2" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: ${data.data[1]==null?'none':''};">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">email2</span>
		<input type="text" name="data1" class="form-control"
			style="width: 85%;" value="${data.data[1]}">
		<button type="button" class="btn btn-danger" onclick="delemail()"
			style="width: 15%;">삭제</button>
	</div>
	<div id="emailDiv3" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: ${data.data[2]==null?'none':''};">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">email3</span>
		<input type="text" name="data2" id="data2" class="form-control"
			style="width: 85%;" value="${data.data[2]}">
		<button type="button" class="btn btn-danger" onclick="delemail()"
			style="width: 15%;">삭제</button>
	</div>
	<div id="emailDiv4" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: ${data.data[3]==null?'none':''};">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">email4</span>
		<input type="text" name="data3" class="form-control"
			style="width: 85%;" value="${data.data[3]}">
		<button type="button" class="btn btn-danger" onclick="delemail()"
			style="width: 15%;">삭제</button>
	</div>
	<div id="emailDiv5" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: ${data.data[4]==null?'none':''};">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">email5</span>
		<input type="text" name="data4" class="form-control"
			style="width: 85%;" value="${data.data[4]}">
		<button type="button" class="btn btn-danger" onclick="delemail()"
			style="width: 15%;">삭제</button>
	</div>
	<div class="input-group input-group pull-right margin-t-10"
		style="width: 100%; text-align: center;">
		<button type="button" class="btn btn-primary btn-m" onclick="update(2)"
			style="width: 15%;">데이터 수정</button>
	</div>
	</c:if>
	<!-- @@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- @@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- @@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- @@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- @@@@@@@@@@@@@@@생성@@@@@@@@@@@@@@@@@@@@@@ -->
	<c:if test="${data.data == null}">
	<div id="email1" class="input-group input-group pull-left margin-t-10"
		style="width: 100%;">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">email</span>
		<input type="text" name="data0" class="form-control"
			style="width: 85%;" value="" placeholder="생성할 email을 입력하세요">
		<button type="button" class="btn btn-danger" onclick="addemail2()"
			style="width: 15%;">추가</button>
	</div>
	<div id="email2" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: none">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">email</span>
		<input type="text" name="data1" class="form-control"
			style="width: 85%;" value=""placeholder="생성할 email을 입력하세요">
		<button type="button" class="btn btn-danger" onclick="delemail2()"
			style="width: 15%;">삭제</button>
	</div>
	<div id="email3" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: none">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">email</span>
		<input type="text" name="data2" id="data2" class="form-control"
			style="width: 85%;" value=""placeholder="생성할 email을 입력하세요">
		<button type="button" class="btn btn-danger" onclick="delemail2()"
			style="width: 15%;">삭제</button>
	</div>
	<div id="email4" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: none">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">email</span>
		<input type="text" name="data3" class="form-control"
			style="width: 85%;" value=""placeholder="생성할 email을 입력하세요">
		<button type="button" class="btn btn-danger" onclick="delemail2()"
			style="width: 15%;">삭제</button>
	</div>
	<div id="email5" class="input-group input-group pull-left margin-t-10"
		style="width: 100%; display: none">
		<span class="input-group-addon" id="basic-addon1" style="width: 80px;">email</span>
		<input type="text" name="data4" class="form-control"
			style="width: 85%;" value=""placeholder="생성할 email을 입력하세요">
		<button type="button" class="btn btn-danger" onclick="delemail2()"
			style="width: 15%;">삭제</button>
	</div>
	<div class="input-group input-group pull-right margin-t-10"
		style="width: 100%; text-align: center;">
		<button type="button" class="btn btn-primary btn-m" onclick="create(2)"
			style="width: 15%;">생성</button>
	</div>
	</c:if>
</body>
</html>