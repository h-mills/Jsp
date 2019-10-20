
//입력여부 체크
//obj_nm : 체크할 Text 박스명
//msg    : 에러시 뿌려질 메시지
function box_check(obj_nm, msg) 
{ 
  var obj = document.getElementById(obj_nm);

  if (obj.value.split(" ").join("") == "") {  	      
      
      if (obj.type.indexOf("select") > -1) {
          alert(msg + "을(를) 선택해 주세요.");
      } else {
          alert(msg + "을(를) 입력해 주세요.");
      }
      obj.focus();
      return false;
  }
  
  return true;	
}

//입력길이 체크
//obj_nm : 체크할 Text 박스명
//width  : 제한할 글자수
//msg    : 에러시 뿌려질 메시지
function box_length(obj_nm, width, msg) 
{  	  
  var obj = document.getElementById(obj_nm);
    
  if (obj.value.length > eval(width)) {	  
      alert(msg + "는(은) 최대 " + width + "자까지 입력 가능합니다.");
      obj.focus();
      return false;
  }
  
  return true;	
}

//숫자만 입력 체크(KeyPress Event)
function only_num()
{
   var key = event.keyCode;
         
   if ((key < 48 || 57 < key)) {
       event.keyCode = "";
       return;
   }      	
}

//숫자 입력여부 체크(Blur Event)
//obj : 객체
function num_check(obj)
{	
   var value = obj.value;	
  	
   if (value.split(" ").join("") == "")
       return;
   
   var chr = "";		
   for (var i=0; i < value.length; i++) {   	   	
        chr = value.charCodeAt(i);
        
        if ((chr < 48 || 57 < chr)) {
            alert("숫자만 입력 할수 있습니다.");
            obj.focus();
            break;           
        }	              	
   }	
}

//숫자/특수기호 "." 만 입력 체크(KeyPress Event)
//value : 현재 저장된 값
//num : 제한 갯수
function only_num_f(value, num)
{
   var key = event.keyCode;
   
   if ((key < 48 || 57 < key) && key != '46') {
       event.keyCode = "";
       return;
   } else if (key == '46') {
	   if (search_mask(".", value) >= num || value.substring(value.length-1) == "." || value == "") {		   
		   event.keyCode = "";
	       return;   
	   }
   }
}

//숫자/특수기호 "." 만 입력 체크(KeyUp Event)
//value : 현재 저장된 값
function only_num_f_up(obj)
{
   var value = obj.value;
   var chr = "";
   var t_value = "";
   var p_chr = "";
   
   var key = event.keyCode;
   
   if (key == 32 || key == 8 || (key > 36 && key < 41) || key == 46)
	   return;
   
   for(var i=0; i < value.length; i++) {
	   chr = value.charCodeAt(i);
	   
	   if (i == 0 && chr == '46') {
	   } else if(chr == '46' && p_chr == chr) {
       } else if(chr == '46') {
		   p_chr = "46";
		   t_value = t_value + "" + value.charAt(i);
       } else {
    	   p_chr = "";
    	   t_value = t_value + "" + value.charAt(i);
       }		  		       
   }
   obj.value = t_value;   
}

//숫자/특수기호 "." 입력여부 체크(Blur Event)
//obj : 객체
//num : 제한 갯수
function num_f_check(obj, num)
{	
   var value = obj.value;	
	
   if (value.split(" ").join("") == "")
       return;
 
   var chr = "";		
   for (var i=0; i < value.length; i++) {   	   	
        chr = value.charCodeAt(i);
      
        if ((chr < 48 || 57 < chr) && chr != '46') {
            alert("숫자와 '.' 기호만 입력 할수 있습니다.");
            obj.focus();
            break;           
        } else if (chr == '46') {
        	if (search_mask(".", value) > num) {
        		alert("'.' 기호는 " + num + "개만 입력 할수 있습니다.");
                obj.focus();    	       
     		    break;
     	    }
        }
   }	
}

//숫자/특수기호 "-" 만 입력 체크(KeyPress Event)
function only_num_b(value)
{
   var key = event.keyCode;
   
   if ((key < 48 || 57 < key) && key != '45') {
       event.keyCode = "";
       return;
   } else if (key == '45') {
	   if (value.substring(value.length-1) == "-" || value == "") {
		   event.keyCode = "";
	       return;   
	   }
   }
}

//숫자/특수기호 "-" 만 입력 체크(KeyUp Event)
//value : 현재 저장된 값
function only_num_b_up(obj)
{
 var value = obj.value;
 var chr = "";
 var t_value = "";
 var p_chr = "";
 
 var key = event.keyCode;
 
 if (key == 32 || key == 8 || (key > 36 && key < 41) || key == 46)
	   return;
 
 for(var i=0; i < value.length; i++) {
	   chr = value.charCodeAt(i);
	   
	   if (i == 0 && chr == '45') {
	   } else if(chr == '45' && p_chr == chr) {
     } else if(chr == '45') {
		   p_chr = "45";
		   t_value = t_value + "" + value.charAt(i);
     } else {
  	   p_chr = "";
  	   t_value = t_value + "" + value.charAt(i);
     }		  		       
 }
 obj.value = t_value;   
}

//숫자/특수기호 "-" 입력여부 체크(Blur Event)
//obj : 객체
function num_b_check(obj)
{	
   var value = obj.value;	
	
   if (value.split(" ").join("") == "")
       return;

   var chr = "";		
   for (var i=0; i < value.length; i++) {   	   	
        chr = value.charCodeAt(i);
    
        if ((chr < 48 || 57 < chr) && chr != '45') {
            alert("숫자와 '-' 기호만 입력 할수 있습니다.");
            obj.focus();
            break;           
        }
   }	
}

//특수기호 갯수  체크(KeyPress Event)
//mask : 체크할 특수 기호
//value : 현재 저장된 값
//num : 제한 갯수
function mask_chk(mask, value, num)
{
   var key = event.keyCode;   
   var chr = mask.charCodeAt(0);
   
   if (chr == key) {
       if (search_mask(mask, value) >= num || value.substring(value.length-1) == mask || value == "") {		   
	       event.keyCode = "";
           return;   
       }
   }
}

//특수기호 입력여부 체크(Blur Event)
//mask : 체크할 특수 기호
//obj : 객체
//num : 제한 갯수
function mask_chk_b(mask, obj, num)
{	
   var value = obj.value;	
	
   if (value.split(" ").join("") == "")
       return;
 		   
   if (search_mask(mask, value) > num) {
       alert("'" + mask + "' 기호는 " + num + "개만 입력 할수 있습니다.");
       obj.focus();
   }   
}

//숫자/영문만 입력 체크(KeyPress Event)
function only_chr_num()
{
   var key = event.keyCode;   
      
   if ((key < 48 || 57 < key) && (key < 97 || key > 122) && (key < 65 || key > 90) && key != 32) {
       event.keyCode = "";
       return;
   }      	
}

//숫자/영문 입력여부 체크(Blur Event)
//obj : 객체
function chr_num_check(obj)
{	
   var value = obj.value;	
  	
   if (value.split(" ").join("") == "")
       return;
   
   var chr = "";		
   for (var i=0; i < value.length; i++) {   	   	
        chr = value.charCodeAt(i);
        
        if ((chr < 48 || 57 < chr) && (chr < 97 || chr > 122) && (chr < 65 || chr > 90) && chr != 32) {
            alert("숫자/영문만 입력 할수 있습니다.");
            obj.focus();
            break;           
        }	              	
   }	
}

//모든 문자 치환
//contents : 원문
//before   : 변경전 값
//after    : 변경후 값 
function replace_all(source, before, after) 
{
   if (source.split(" ").join("") == "")
       return "";
   
   source = source.replace(before, after);
      
   if (source.indexOf(before) > -1) {
	   return replace_all(source, before, after);
   } else {           
       return source;
   }    
}

//파일의 확장자를 리턴
//file_nm : 파일명 
function search_ext(file_nm) 
{
   if (file_nm.split(" ").join("") == "")
       return "";
  
   file_nm = file_nm.substring(file_nm.indexOf(".")+1);
   
   if (file_nm.indexOf(".") > -1) {
	   return search_ext(file_nm);
   } else {               
       return file_nm;
   }    
}

//지정 글자의 갯수 조회 
//mask : 지정 글자
//value : 값  
function search_mask(mask, value) 
{
   var num = 0;
   
   if (value != null && value.split(" ").join("") != "") {
	   for(var i=0; i < value.length; i++) {
		   if (value.charAt(i) == mask) {
		       num++;
		   }
	   }
   }    
   return num;
}

//스트링 길이 Byte길이로 제한 표시
//contents : 스트링 값
//limit    : 제한 길이
//box_yn   : 박스모양 여부
function string_limit(contents, limit, box_yn)
{
   var str_byte = 0;
   var t_str = "";
   var header_ = "";
   var tail_ = "";
   
   var obj_ = document.getElementById("div_");
   
   if (obj_ == null) {
	   document.write("<div id='div_' style='display:none;border:1px solid silver;background-color:#FFFFFF;position:absolute'></div>");
   }     
         
   if (contents != null && !contents.split(" ").join("") == "") {	   	  
       for(var i=0;i < contents.length; i++) {	 
           if (escape(contents.charAt(i)).length > 3) {
		       str_byte += 2;
	       } else {
		       str_byte += 1;
	       }
	                 
	       if (str_byte >= limit) {
	    	   header_ = "<span onMouseOver='javascript:div_view(\"" + contents + "\", this, \"" + box_yn + "\")' onMouseOut='javascript:div_.style.display=\"none\"' style='cursor:hand'>";
	    	   tail_ = "</span>";
		       t_str += "...";
		       break;
	       } else {
		       t_str += "" + contents.charAt(i);
	       }
       }
       document.write(header_ + "" + replace_all(t_str, "&lt;br&gt;", "") + "" + tail_);
   }   
}

//Event
function div_view(contents, obj_, box_yn)
{		
	//div_.style.top = event.y - event.offsetY + document.body.scrollTop - obj_.style.posTop - 4;
	//div_.style.left = event.x - event.offsetX + document.body.scrollLeft - obj_.style.posLeft + 70;
	div_.style.top = event.clientY + document.body.scrollTop;
			
	if (box_yn != null && box_yn == "Y") {
		div_.style.left = event.clientX + document.body.scrollLeft - 250;
		div_.style.width = "28px";
		div_.style.height = "30px";
	} else {
		div_.style.left = event.clientX + document.body.scrollLeft;
	    div_.style.width = contents.length * 3 + "px";
	}    

	div_.innerHTML = contents;
	div_.style.display = "";	
}

//윈도우(Pop-up)
//url    : Url
//width  : 윈도우의 넓이
//height : 윈도우의 높이
function window_pop(url, width, height)
{    
   var winx = (screen.width - width) / 2;
   var winy = (screen.height- height) / 2;
    
   var settings = "height=" + height + ", "
                + "width=" + width + ", "
	            + "top=" + winy  + ", "
	            + "left=" + winx  + ", "
	            + "scrollbars=no, "
	            + "resizable =yes";
 
   var win = window.open(url, "pop", settings);
   win.focus();
}

//Flash 처리
function flash_view(url, width, height) 
{
   document.write("<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0' width='"+width+"' height='"+height+"'>");
   document.write("<param name='allowScriptAccess' value='always'>");   
   document.write("<param name='movie' value='"+url+"'>");
   document.write("<param name='quality' value='high'>");
   document.write("<param name='wmode' value='transparent'>");
   document.write("<param name='menu' value='false'>");
   //document.write("<object src='"+url+"' quality='high' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' width='"+width+"' height='"+height+"'></object>");
   document.write("<embed src='"+url+"' wmode='transparent' menu='false' scale='noscale' quality='high' width='"+width+"' height='"+height+"' align='middle' allowScriptAccess='always' type='application/x-shockwave-flash' pluginspage='https://www.macromedia.com/go/getflashplayer'>");
   document.write("</object>");        
}

//Ajax 통신 처리 
function ajax_process(url_)
{	
    var xmlhttp = null;
    var result_ = "";

    if (window.XMLHttpRequest) {
        xmlhttp = new XMLHttpRequest();
    } else {
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }                    

    xmlhttp.open("POST", url_, false);
    
    //Cache 초기화
    //xmlhttp.setRequestHeader("Content-type:", "application/text/xml;charset=utf-8"); 
    //xmlhttp.setRequestHeader("Cache-Control:", "no-cache"); 
    //xmlhttp.setRequestHeader("Pragma:", "no-cache"); 
                                   
    xmlhttp.onreadystatechange = function() { 
                                      
                                      if (xmlhttp.readyState == 4) {                                              	                                                	  
                                          if (xmlhttp.status == 200) {
                                              result_ = xmlhttp.responseText;
                                              
                                              result_ = replace_all(result_, "\n", "");                                              
                                              result_ = replace_all(result_, "\r", "");
                                              result_ = replace_all(result_, "\r\n", "");   
                                          }
                                      }                                                                                                                  
                                 }
    xmlhttp.send(null);
        
    return result_;	
    
    
    
}
