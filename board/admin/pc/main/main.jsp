<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="/WEB-INF/jsp/include/include.jsp" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>MAIN</title>
<script src="/inc/js/jQuery-2.1.4.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.min.js"></script>
<script src="/common/js/jquery.smartPop3.js"></script>
<link rel="stylesheet" href="/common/css/jquery.smartPop3.css"/>
<script language="javascript">
function fileupload()
{
	if(document.getElementById("file").value.length <= 0)
	{
		alert("파일을 선택해 주세요!");
		return;
	}
	frm.action = "/pc/main/upload";
	frm.submit();
}

function genLargefn()
{
	if(document.getElementById("file").value.length <= 0)
	{
		alert("파일을 선택해 주세요!");
		return;
	}

	if(confirm("생성하시겠습니까?") == false) return;

	loadXMLDoc();
}

function loadXMLDoc()
{
	var xmlhttp;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
    	xmlhttp=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
    	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }

    var file = document.getElementById("file");
    var currRow = $("#currRow").val();
    var totalCnt = $("#totalCnt").val();
    var formData = new FormData();
    formData.append("file", file.files[0]);
    formData.append("currRow", currRow);
    formData.append("totalCnt", totalCnt);
    formData.append("reFileName", $("#reFileName").val());

    var url = "/pc/main/loading?currRow="+currRow+"&totalCnt="+totalCnt;
    $.smartPop.open({bodyClose: false, width:400, height: 200, url: url });

	xmlhttp.open("POST", "/pc/main/upload", true);
    xmlhttp.send(formData);
    xmlhttp.onreadystatechange=function()
    {
    	if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
    		var htmlcode='';
    		var JSONobj = JSON.parse(xmlhttp.responseText);
    		var list = JSONobj.list;
    		var currRow = JSONobj.currRow;
    		var totalCnt = JSONobj.totalCnt;
    		var reFileName = JSONobj.reFileName;
    		var htmlcode = "";

    		for (var i in list) {
    			var info = list[i];
        		var name = info.name;
        		var dept = info.dept;
        		var pos = info.pos;
        		var tel = info.tel;
        		var fax = info.fax;
        		var phone = info.phone;
        		var email = info.email;
        		var image = info.image;

        		htmlcode+= '<tr style="border-bottom:solid 1px #efefef;">';
    			htmlcode+= '<td style="text-align:right;">'+name+'</td>';
    			htmlcode+= '<td style="text-align:right;">'+dept+'</td>';
    			htmlcode+= '<td style="text-align:right;">'+pos+'</td>';
    			htmlcode+= '<td style="text-align:right;">'+tel+'</td>';
    			htmlcode+= '<td style="text-align:right;">'+fax+'</td>';
    			htmlcode+= '<td style="text-align:right;">'+phone+'</td>';
    			htmlcode+= '<td style="text-align:right;">'+email+'</td>';
    			htmlcode+= '<td><img src=\"'+image+'\" style=\"border:1px solid red;\"></td>';
    			htmlcode+= '</tr>';
    		}
    		$("#file").val(null);
			$(htmlcode).appendTo(".table > tbody");
    		$("#currRow").val(currRow);
    		$("#totalCnt").val(totalCnt);
    		$("#reFileName").val(reFileName);

    		if (($("#currRow").val() == $("#totalCnt").val()) && $("#currRow").val() != 0) {
        		$.smartPop.close();
    			alert("완료되었습니다.");
    	    } else {
    	    	$("#currRow").val((parseInt($("#currRow").val()) + 1));
    	    	loadXMLDoc();
    	    }
       	}
	};
};
</script>

</head>
<body>
	<form name="frm" method="post" enctype="multipart/form-data">
		<div style="width:50%; margin-top:10px;">
			파일 첨부 : <input type="file" name="file" id="file" style="width:80%; border:1px solid red;"/>
			<input type="button" id="imageBt" value="ImageUpload" onclick="fileupload();"/>
			<input type="button" id="excelBt" value="ExcelUpload" onclick="genLargefn();"/>
		</div>
	</form>
	<c:if test="${!empty imagepath}">
		<div style="margin-top:10px;">
			<img src=${imagepath } style="border:1px solid red;">
		</div>
	</c:if>
	<div class="panel panel-default pull-right margin-t-10" style="width:100%;">
		<div>
			<div class="panel-heading" style="padding:5px 10px">
				<h4>생성 개수
					<input type="hidden" id="currRow" value="0"/>
					<input type="hidden" id="reFileName" value=""/>
					<input type="text" name="totalCnt" id="totalCnt" value="0" style="width:300px; text-align: right;" readOnly>
					<span class="label label-success">개</span>
				</h4>
			</div>
		</div>
		<div class="panel-body">
			<table class="table text-center">
				<thead>
              		<tr>
                		<th class="text-center" style="width:90px;">name</th>
						<th class="text-center" style="width:100px;">dept</th>
						<th class="text-center" style="width:100px;">pos</th>
						<th class="text-center" style="width:100px;">tel</th>
						<th class="text-center" style="width:100px;">fax</th>
						<th class="text-center" style="width:100px;">phone</th>
						<th class="text-center" style="width:150px;">email</th>
						<th class="text-center" style="width:150px;">image</th>
             		</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>
 