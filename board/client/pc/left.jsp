<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
<link rel="shortcut icon" href="http://cdn.nitrome.com/favicon.ico" />
<title>Left메뉴</title>
<link rel="stylesheet" type="text/css" href="/common/css/poi.css">
<script language="javascript" src="/common/js/util.js"></script>
<script language="javascript">
	
function changeLeft(value)
{
	 document.getElementById("tbl_1").style.display = "none";
	 
	 if (value == "1") 
	 {
	    document.getElementById("tbl_1").style.display = "";
	 }
}

function move(value)
{  	 
	 parent.frame_move(value);  	   	 
}
		
</script>	
</head>
<body style="padding:15px;">
<table width="210" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" id="tbl_1">
  <tr>
    <td><B>MAIN1</B></td>
  </tr>
  <tr>
    <td height="5"></td>
  </tr>
  <tr>
    <td style="cursor:pointer;" onclick="move(1);">MAIN1 SUB</td>
  </tr>
</table>
</body>
</html>
