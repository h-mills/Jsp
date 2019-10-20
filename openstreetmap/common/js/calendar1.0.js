  // 요일 색깔
  var _day_color_ = new Array('red', 'black', 'black', 'black', 'black', 'black', 'blue');
  // 요일 표시
  var _dayName_ = new Array('일','월','화','수','목','금','토');

  var _current_date_ = new Date();

  var _month_ = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  var _show_gubun_ = "false";
  
  var _t_back_color = "";

  //iframe create     
  var iframe_ = "<iframe id=\"if_date_\" name=\"if_date_\" marginwidth=\"0\" marginheight=\"0\" frameborder=\"0\" scrolling=\"no\" allowtransparency=\"true\" style=\"border:1px solid black;display:none;position:absolute;top:0;left:0;background-color:white;z-index:10\" height=\"156px\" width=\"180px\" src=\"about:blank\" onMouseOut=\"javascript:time_close()\"></iframe>";
  document.write(iframe_);  	
     
  //위치 지정
  function cal_location_(init_left, init_top)
  {
	  
	  
	  document.getElementById("if_date_").style.left = init_left + "px";
	  document.getElementById("if_date_").style.top = init_top + "px";    
  }

  //Show gubun
  //init_left  : left 위치 
  //init_top   : top 위치
  //function명 : date_method
  //year       : 년도
  //month      : 월
  function cal_show_(obj, date_method, year, month)
  {      	 
  	 if (year == null || year == "")
         year = _current_date_.getFullYear() + "";
     
     if (month == null ||  month == "")
         month = _current_date_.getMonth()+1 + "";    
          
  	 //달력 초기화
     if (if_date_.s_year_ == null) {
         init_date_();
     }
     
     if (_show_gubun_ == "false") {
     	            	            	  
     	  if (obj == null)
            return;
     	  
     	  cal_location_(obj.getBoundingClientRect().left, obj.getBoundingClientRect().top + obj.clientHeight + 5);
     	  
         document.getElementById("if_date_").style.display = "";         
         
         data_set_ = function(value) {
	        	 		if(value != "" && value != null) {
	                          var year  = if_date_.s_year_.innerHTML;
	                          var month = if_date_.s_month_.innerHTML;
	                          var day = value + "";
	                          
	                          if (month.length < 2) {
	                              month = "0" + month;	
	                          }
	                                                                                                                                                     
	                          if (day.length < 2) {
	                              day = "0" + day;	
	                          }
	                          
	                          var t_date_ = year + "-" + month + "-" + day;
	                                                                                                                                             
	                          eval(date_method + "('" + t_date_ + "');");                                                                              
	                                                                                                                                  
	                          document.getElementById("if_date_").style.display = "none";                               
	                          _show_gubun_ = "false";      
	        	 		}
             	     }
             	     
         month_set_ = function(year, month) {
         	          
                          if_date_.s_year_.innerHTML = year;
                          if_date_.s_month_.innerHTML = month;   
         	                          
        	                setContent(year, month);
         	          
         	                if_date_.document.getElementById("sp_date_d_").style.display = "";
                          if_date_.document.getElementById("sp_date_m_").style.display = "none";           	                   	          
         	          }
         
         if (year != null && month != null && year.split(" ").join("") != "" && month.split(" ").join("") != "") {         	            	   
         	                	  
         	   if_date_.s_year_.innerHTML = year;
         	  
         	   if (month.substring(0, 1) == "0") {
         	  	   month = month.substring(1);
         	   }	              	                	                	  
             if_date_.s_month_.innerHTML = month;
             
             setContent(year, month);
         }         
         _show_gubun_ = "true";
     } else {
     	        	   
     	   if (if_date_.document.getElementById("sp_date_d_").style.display == "none") {
             if_date_.document.getElementById("sp_date_d_").style.display = "";
             if_date_.document.getElementById("sp_date_m_").style.display = "none";
             
             year = if_date_.s_year_m_.innerHTML;
             
             for (i=1; i < 13; i++) {
                  if (eval("if_date_.tf_m" + i + ".style.backgroundColor") == "yellow") {
                      month = eval("if_date_.tf_m" + i + ".value");
                      break;   	
                  }
             }             
             setContent(year, month);
          }                         	         
          document.getElementById("if_date_").style.display = "none";
          _show_gubun_ = "false";
     }
  }
  
  //월
  function show_month_(year_id, month_id)
  {
     var year_value  = if_date_.document.getElementById(year_id).innerHTML;
     var month_value = if_date_.document.getElementById(month_id).innerHTML;    
      	        
     document.getElementById("if_date_").style.height = "170px";
     
     if_date_.document.getElementById("s_year_m_").innerHTML = year_value;
               
     setMonthStyle(month_value);
     
     if_date_.document.getElementById("sp_date_d_").style.display = "none";
     if_date_.document.getElementById("sp_date_m_").style.display = "";     
  }
  
  //일자   
  function init_date_(year, month)
  {     
          
     if (year == null || year == "") {     	
         year = _current_date_.getFullYear();
     }
     
     if (month == null || month == "") {     	
         month = _current_date_.getMonth()+1;
     }
                    
     var _style_  = print_style();
     var _header_ = print_table(0, '180', '27', 0, 0, 0, 'background-color:#FFFFFF')
                  + print_tr(0)
                  + print_td(0, '', '', 7)
//                + print_year_prev()
                  + print_month_prev()                  
                  + print_date("s_year_", year, "s_month_", month)
//                  + " <font style=\"font-size:12px\">년</font> "
//                  + print_year_next()
//                  + print_date("s_month_", _current_date_.getMonth()+1)
//                  + " <font style=\"font-size:12px\">월</font> "
                  + print_month_next()
                  + print_td()
                  + print_td(0, '', '', 7)
                  //+ print_exit()
                  + print_td()
                  + print_tr()
                  + print_table();
     
     var _header_day_ = print_table(0, '180', '20', 0, 1, 0, 'border-top:silver 1px dotted; border-bottom:silver 1px dotted; background-color:#FFFFFF; cursor:hand; line-height:18px')
                      + print_tr(0, 'center', 'background-color:#FFFFFF');
          
     //요일 헤더 셋팅
     for (var i=0; i < 7; i++) {
          _header_day_ += print_td(0);
          _header_day_ += print_day(_dayName_, i)
          _header_day_ += print_td();
                        
     }
     _header_day_ += print_tr()
                   + print_table();


     //일자 셋팅
     var _body_ = print_table(0, '180', '', 0, 1, 0, 'background:url(/rknf/orm/image/back_ground.gif); filter:alpha(opacity=70); cursor:hand; line-height:18px');

     for (var i = 0; i < 42; i++) {     
          _body_ += print_tr(0, 'center', '');

          for (var j=0; j < 7; j++) {
               _body_ += print_text_field( i, 'color:' + _day_color_[j] + '; cursor:hand; border-width:1px; font-size:9pt; border-color:#FFFFFF; border-style:solid; text-align:center', "parent.date_set_(this.value);", "#FFFFFF", "#F0EDF0");
               i++;
               if (i == 42) break;
          }
          i--;
          _body_ += print_tr();
     }                
         
     _body_ += print_table();


     //월 span 작성          	
     var _header_m_ = print_table(0, '180', '27', 0, 0, 0, 'border-bottom:silver 1px dotted;background-color:#FFFFFF')
                    + print_tr(0)
                    + print_td(0, '', '', 4)
                    + print_year_prev()                  
                    + print_month("s_year_m_", year)
                    + print_year_next()
                    + print_td()
                    + print_td(0, '', '', 4)
                    //+ print_exit()
                    + print_td()
                    + print_tr()
                    + print_table();
                                    
     //월 셋팅
     var _body_m_ = print_table(0, '180', '', 0, 1, 0, 'background:url(/rknf/orm/image/back_ground.gif); filter:alpha(opacity=70); cursor:hand; line-height:18px');
     
     var num=0;
     for (var j = 0; j < 4; j++) {     	               
          _body_m_ += print_tr();
          for(var i=0; i < 3; i++) {
              _body_m_ += print_month_field( ++num, ' cursor:hand; border-width:1px; font-size:9pt; border-color:#FFFFFF; border-style:solid; text-align:center; height:33px', "parent.month_set_(s_year_m_.innerHTML, this.value);", "#FFFFFF", "#F0EDF0");
              
          }          
          _body_m_ += print_tr(0, 'center', '');   
                        
     }                
     _body_m_ += print_tr();         
     _body_m_ += print_table();

     var _contents_ = _style_ + "<body bgcolor=\"transparent\"><span id='sp_date_d_'>" + _header_ + "" + _header_day_ + "" + _body_ + "</span><span id='sp_date_m_' style='display:none'>" + _header_m_ + "" + _body_m_ + "</span></body>";
  
     if_date_.document.open();
     if_date_.document.write(_contents_);
     if_date_.document.close();               
     
     setContent(year, month);    
  }        
 
  function print_style()
  {	  
     return "<style type=\"text/css\">"
            + "a:hover {position:relative; top:2; left:2}"
            + "</style>";        
  }
  
  //Table Tag
  function print_table(gb, width, height, border, cellspacing, cellpadding, style)
  {
     if (width == null)
         width = "";
     if (height == null)
         height = "";
     if (border == null)
         border = "";
     if (cellspacing == null)
         cellspacing = "";
     if (cellpadding == null)
         cellpadding = "";
     if (style == null)
         style = "";    
                           
     if (gb == null) {
         return "</table>";
     } else if(gb == 0) {
         return "<table width='" + width + "' height='" + height + "' border='" + border + "' cellspacing='" + cellspacing + "' cellpadding='" + cellpadding + "' style='" + style + "'>";
     }
  }

  //Tr Tag
  function print_tr(gb, align, style)
  {
     if (align == null)
         align = "";
     if (style == null)
         style = "";
        	
     if (gb == null) {
         return "</tr>";
     } else if(gb == 0) {
         return "<tr align='"+ align +"' style='"+ style +"'>";
     }
  }

  //Td Tag
  function print_td(gb, width, height, colspan, id)
  {
     if (width == null)
         width = "";
     if (height == null)
         height = "";
     if (colspan == null)
         colspan = "";
     if (id == null)
         id = "";                 
     	  
     if (gb == null) {
         return "</td>";
     } else if(gb == 0) {
         return "<td width='"+ width +"' height='"+ height +"' colspan='"+ colspan +"' id='"+ id +"' align='center'>";
     }
  }

  //이전해 링크
  function print_year_prev()
  {
     return "&nbsp;<a href='javascript:parent.year_prev_();'><img src='../../common/images/common/icon_back.gif' border='0' align='absmiddle'></a>&nbsp;";
  }

  //다음해 링크
  function print_year_next()
  {
     return "&nbsp;<a href='javascript:parent.year_next_();'><img src='../../common/images/common/icon_next.gif' border='0' align='absmiddle'></a>&nbsp;";
  }

  function print_exit()
  {
     return "<a href='javascript:parent.exit_();'><img src='/rknf/orm/img/exit1.gif' border='0' align='absmiddle'></a>";
  }

  //월 필드
  function print_month(year_id, year_value)
  {  	                  
     return "<span id='" + year_id + "' style='font-size:9pt'>" + year_value + "</span> <font style=\"font-size:12px\">년</font>";
  }
  
  //날짜 필드
  function print_date(year_id, year_value, month_id, month_value)
  {  	                  
     return "<span onClick=\"javascript:parent.show_month_('" + year_id + "', '" + month_id + "')\" style='cursor:hand'><span id='" + year_id + "' style='font-size:9pt'>" + year_value + "</span> <font style=\"font-size:12px\">년</font> <span id='" + month_id + "' style='font-size:9pt'>" + month_value + "</span> <font style=\"font-size:12px\">월</font></span>";
  }

  //이전달 링크
  function print_month_prev()
  {
     return "&nbsp;<a href='javascript:parent.month_prev_();'><img src='../../common/images/common/icon_back.gif' border='0' align='absmiddle'></a>&nbsp;";
  }

  //다음달 링크
  function print_month_next()
  {
     return "&nbsp;<a href='javascript:parent.month_next_();'><img src='../../common/images/common/icon_next.gif' border='0' align='absmiddle'></a>&nbsp;";
  }

  //요일 (gb: 0 ~ 6) ===> 일 ~ 토
  function print_day(dayName, gb)
  {
     var day_color_ = "";	
     
     if (gb == "0") {
         day_color_ = "red";
     } else if (gb == "6") {
     	 day_color_ = "blue";
     }
      	  	
     return "<font style='font-size:9pt' color='" + day_color_ + "'>" + dayName[gb] + "</font>";
  }

  //일자 필드(gb: 0 ~ 41)
  function print_text_field(gb, style, event, tfCol, focusCol)
  {                
     return "<td id=\"tf" + gb + "\" style=\"" + style + "\" onmouseover=\"javascript:parent.change_color_(this.style.backgroundColor);this.style.backgroundColor='#82F933';this.style.borderColor='" + focusCol + "';\" onMouseOut=\"javascript:parent.restore_color_(this);this.style.borderColor='" + tfCol + "'\"  onClick=\"parent.data_set_(this.value);\"></td>";
  }
  
  //월 필드(gb: 1 ~ 12)
  function print_month_field(gb, style, event, tfCol, focusCol)
  {                
     return "<td id=\"tf_m" + gb + "\" value='"+ gb + "' style=\"" + style + "\" onmouseover=\"javascript:parent.change_color_(this.style.backgroundColor);this.style.backgroundColor='#82F933';this.style.borderColor='" + focusCol + "';\" onMouseOut=\"javascript:parent.restore_color_(this);this.style.borderColor='" + tfCol + "'\"  onClick=\"" + event + "\">" + gb + " 월</td>";
  }
  
  // html의 필드값 세팅
  function setContent(year, month)
  {     
     var dates = this.setDates(year, month);          
          
     for (var i = 0; i < 42; i++) {
          for (var j = 0; j < 7; j++) {
               setTextField("tf" + i, dates[i] );
                                                                               
               if (dates[i] == _current_date_.getDate() && year == _current_date_.getFullYear() && (parseInt(month)-1) == _current_date_.getMonth()) {               	   
                   setTodayStyle(i);
               } else {               	
                   eval("if_date_.tf" + i + ".style.fontWeight = 'normal';");
                   eval("if_date_.tf" + i + ".style.backgroundColor = '';");                   
               }
               i++;

               if (i == 42) break;
          }
          i--;
     }
          
     //resize     
     if (dates.length <= 28) {
         document.getElementById("if_date_").style.height = "138px";
     } else if (dates.length >= 42) {
         document.getElementById("if_date_").style.height = "176px";    
     } else {       
         document.getElementById("if_date_").style.height = "156px";                  
     }    
  }

  // 오늘 날짜 스타일
  function setTodayStyle(gb)
  {
     eval("if_date_.tf" + gb + ".style.fontWeight = 'bold';");
     eval("if_date_.tf" + gb + ".style.backgroundColor = 'yellow';");
  }
  
  // 선택월 스타일
  function setMonthStyle(gb)
  {     	 
     for (i=1; i < 13; i++) {
          
          if (gb == i) {              	
              eval("if_date_.tf_m" + gb + ".style.fontWeight = 'bold';");
              eval("if_date_.tf_m" + gb + ".style.backgroundColor = 'yellow';");    	
          } else {
              eval("if_date_.tf_m" + i + ".style.fontWeight = '';");
              eval("if_date_.tf_m" + i + ".style.backgroundColor = '';");
     	  }
     }     		  	     
  }

  // 일자 세팅
  function setTextField(name, value)
  {  
   
     if (value == "" || value == null) {
         if_date_.document.getElementById(name).disabled = true;
         if_date_.document.getElementById(name).value = "";
         if_date_.document.getElementById(name).innerHTML = "";
     } else {
        if_date_.document.getElementById(name).disabled = "";                
        
        if (value < 10) {
            if_date_.document.getElementById(name).value = value;
            if_date_.document.getElementById(name).innerHTML = value;
        } else {
            if_date_.document.getElementById(name).value = value;
            if_date_.document.getElementById(name).innerHTML = value;
        }       
     }
     
  }

  //해당월의 데이터 배열 생성
  function setDates(year, month)
  {
     var dates_     = new Array();
     var first_day  = get_first_day(year, month);
     var last_day   = get_last_day(year, month);
     var last_date  = get_day_month(year, month);
     var first_date = 1;
               
     //초기화
     for (var i = 0; i < first_day; i++) dates_[i] = '';

     //날짜를 입력한다.
     for (var i = first_day; i < parseInt(last_date) + parseInt(first_day) ; i++) {
          dates_[i] = first_date;
          first_date ++;
     }
     
     var len = dates_.length;
     for (var i = 0; i < (6-last_day); i++) {
          dates_[len + i] = '';
     }

     return dates_;
  }

  //첫일자에 요일 구하기
  function get_first_day(year, month)
  {
     var tmp_date_ = new Date();
     tmp_date_.setDate(1);
     tmp_date_.setMonth(month-1);
     tmp_date_.setFullYear(year);
              
     return tmp_date_.getDay();
  }

  //마지막 요일 구하기
  function get_last_day(year, month)
  {
     var tmp_date_ = new Date();
     tmp_date_.setDate(get_day_month(year, month));
     tmp_date_.setMonth(month-1);
     tmp_date_.setFullYear(year);

     return tmp_date_.getDay();
  }

  //조회 년월의 일수 구하기
  function get_day_month(year, month)
  {
     var last_day_ = "";

     if (month == "2") {
         if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
             last_day_ = "29";
         } else {
             last_day_ = _month_[month-1];
         }
     } else {
         last_day_ = _month_[month-1];
     }
     return last_day_;
  }
  
  //이전 년으로 세팅
  function year_prev_()
  {
     var tmp = parseInt(if_date_.s_year_m_.innerHTML) - 1;

     if_date_.s_year_m_.innerHTML = tmp;
     //this.setContent(tmp, if_date_.s_month_.innerHTML);
  }

  //다음 년으로 세팅
  function year_next_()
  {
     var tmp = parseInt(if_date_.s_year_m_.innerHTML) + 1;
   
     if_date_.s_year_m_.innerHTML = tmp;
     //this.setContent(tmp, if_date_.s_month_.innerHTML);
  }

  //닫기
  function exit_()
  {
     //초기화
     //init_date_(); 	 
     cal_show_();
  }

  //이전 년월로 세팅
  function month_prev_() 
  {
     var year = if_date_.s_year_.innerHTML;
     var month = if_date_.s_month_.innerHTML;
          
     if (month == "1") {
       	 year = parseInt(year) - 1;
         month = "12";   	
     } else {
         month = parseInt(month) - 1;	
     }

     if_date_.s_year_.innerHTML = year;
     if_date_.s_month_.innerHTML = month;
     
     setContent(year, month);
  }
  
  // 다음 년월로 세팅   
  function month_next_() 
  {
     var year = if_date_.s_year_.innerHTML;
     var month = if_date_.s_month_.innerHTML;
          
     if (month == "12") {
     	   year = parseInt(year) + 1;
         month = "1";   	
     } else {
         month = parseInt(month) + 1;	
     }
     
     if_date_.s_year_.innerHTML = year;
     if_date_.s_month_.innerHTML = month;
     
     setContent(year, month);
  }
  
  function change_color_(color)
  {
     _t_back_color = color;
  }
  
  function restore_color_(obj)
  {
     obj.style.backgroundColor = _t_back_color;  
  }
  
  function time_close()
  {  
     setTimeout("cal_show_()", 1000);
  }
      