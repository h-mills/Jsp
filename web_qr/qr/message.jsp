<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function messageClear(){
		document.getElementById("message").value = '';
	}
	function updateMessage() {
		var data = "";
		if (document.getElementById("message").value.length > 0)
			data += document.getElementById("message").value;
		$("#data").val(data);
	}
	function createMessage() {
		var data = "";
		if (document.getElementById("message2").value.length > 0)
			data += document.getElementById("message2").value;
		$("#data").val(data);
	}
</script>
</head>
<body>
	<c:if test="${data.data != null }">
		<div id="msgDiv" class="input-group input-group pull-left margin-t-10"
			style="width: 100%; display: ${data.data[0]==null?'none':''};">
			<span class="input-group-addon" id="basic-addon1"
				style="width: 80px;">메시지</span>
			<textarea class="form-control"  id="message"  rows="10" cols="100">${data.data[0]}</textarea>
		</div>
		<div class="input-group input-group pull-right margin-t-10"
			style="width: 100%; text-align: center;">
			<button type="button" class="btn btn-primary btn-m"
				onclick="update(7)" style="width: 15%;">데이터 수정</button>
		</div>
	</c:if>
	<c:if test="${data.data == null }">
		<div id="msgDiv" class="input-group input-group pull-left margin-t-10"
			style="width: 100%;">
			<span class="input-group-addon" id="basic-addon1"
				style="width: 80px;">메시지</span>
			<textarea class="form-control"  id="message2" rows="10" cols="100"></textarea>
		</div>
		<div class="input-group input-group pull-right margin-t-10"
			style="width: 100%; text-align: center;">
			<button type="button" class="btn btn-primary btn-m"
				onclick="create(7)" style="width: 15%;">생성</button>
		</div>
	</c:if>
</body>
</html>