  //style sheet value
  var _style_data_    = "";
  //write and string kind
  var _write_kind_    = "";
  //add term value
  var _add_value_     = "";
  //default option kind
  var _option_kind_   = "";

  //combo clear method
  function combo_clear_()
  {
     _style_data_    = "";
     _write_gubun_   = "";
     _add_value_     = "";
     _option_kind_   = "";
  }
    
  //set style sheet 
  function setStyleData(value)
  {
     _style_data_ = value;
  }
  
  //set write and string
  //value S -> String value return
  function setWriteKind(value)
  {
     _write_kind_ = value;
  }
    
  //set add term value
  function setAddValue(value)
  {
     _add_value_ = value;
  }
  
  //set default option kind
  //value A -> All  
  //value B -> Select
  function setOptionKind(value)
  {
     _option_kind_ = value;
  }
  
  //get style sheet 
  function getStyleData(value)
  {
     return _style_data_;
  }
  
  //get write and string 
  function getWriteKind(value)
  {
     return _write_kind_;
  }
  
  //get add term value
  function getAddValue(value)
  {
     return _add_value_;
  }
  
  //get default option kind
  function getOptionKind(value)
  {
     return _option_kind_;
  }
      
  //combo create method
  //sel_name     -> combo box name
  //data_kind    -> combo box data kind
  //event_method -> add event method name
  //c_sel_name   -> control combo box name(slave name)
  //c_sel_option -> control combo box name(slave data kind)
  function combo_init(sel_name, data_kind, event_method, c_sel_name, c_sel_option)
  {  
     var sel_contents_ = "";
     var event_contents = "";
     var sel_data = "";
            
    //style sheet default setting
    if (_style_data_ == null || _style_data_.split(" ").join("") == "") {
        _style_data_ = "width:100%";
    }
    
    //add event init
    if (event_method == null) {
    	event_method = "";    	
    }        
           
    //onchange event setting
    if (c_sel_name != null && c_sel_name.split(" ").join("") != "") {
    	event_contents = "onchange=\"combo_sel_slave(this);" + event_method+ "\"";
    } else {
    	event_contents = "onchange=\"" + event_method+ "\"";
    	c_sel_name = "";
    	c_sel_option = "";
    } 
        
    //combo box data process    
    if (data_kind != "" && _add_value_ == "") {
        sel_data = send_ajax(data_kind);
    } else if (data_kind != "" && _add_value_ != "") {
        sel_data = send_ajax(data_kind, _add_value_);
    }             
    
    //combo box container create                                                                
    sel_contents_ = "<select id=\"" + sel_name + "\" name=\"" + sel_name + "\" style=\"" + _style_data_ + "\" " + event_contents + " slave=\"" + c_sel_name + "\" slave_kind=\"" + c_sel_option + "\" option_kind=\"" + _option_kind_ + "\">";
        
    if (_option_kind_.toUpperCase() == "A") {
    	sel_contents_ += "<option value=\"\">전체</option>";
    } else if (_option_kind_.toUpperCase() == "B") {
        sel_contents_ += "<option value=\"\">선택해주세요</option>";
    } else if (_option_kind_.toUpperCase() == "C") {
        sel_contents_ += "<option value=\"\">선택</option>";    
    }
       
    //combo box option setting       
    if (sel_data != null && sel_data.split(" ").join("") == ""  && sel_contents_.indexOf("option") < 0) {
 	      sel_contents_ += "<option value=\"\">선택해주세요</option>";
    } else if (sel_data != null) {
    	  sel_contents_ += sel_data;
    }                
    sel_contents_ += "</select>";       
    
    //write and string kind process
    if (_write_kind_.toUpperCase() == "S") {
    	  return sel_contents_;
    } else {
        document.write(sel_contents_);           
    }    
 }  
 
 //slave depts combo box
 //parent_obj : parent Combo object
 function combo_sel_slave(parent_obj)
 {    
    var sel_contents_ = "";
    
    var value = parent_obj.value;
    var idx_ = 0;
    var tmp_ = "";
    
    var obj = "";
    var data_kind = "";
    var option_kind = "";
           
    //depts check
    if (parent_obj.slave != "" && parent_obj.slave != null && parent_obj.slave != "undefined") {
                    
        data_kind = parent_obj.slave_kind;
        obj = document.getElementById(parent_obj.slave);
        
        tmp_ = obj.outerHTML;            
        option_kind = obj.option_kind;
                          
        //Combo init info setting
        if (obj.innerHTML.split(" ").join("").length <= 0) {            
            idx_ = tmp_.indexOf("</" + obj.tagName + ">");
        } else {
            idx_ = tmp_.indexOf(obj.innerHTML);
        }                    
        tmp_ = tmp_.substring(0, idx_);            
                                   
        var sel_data = send_ajax(data_kind, value);    
        
        if (option_kind.toUpperCase() == "A") {
            sel_contents_ += "<option value=\"\">전체</option>";
        } else if (option_kind.toUpperCase() == "B") {
            sel_contents_ += "<option value=\"\">선택해주세요</option>";
        } else if (option_kind.toUpperCase() == "C") {
            sel_contents_ += "<option value=\"\">선택</option>";    
        }
        
        if (sel_data.split(" ").join("") == ""  && sel_contents_.indexOf("option") < 0) {
 	        sel_contents_ += "<option value=\"\">선택해주세요</option>";
        } else {
        	sel_contents_ += sel_data;
        } 
           
        tmp_ += sel_contents_;
        tmp_ += "</" + obj.tagName + ">";
        
        obj.outerHTML = tmp_; 
                
        //Slave Check
        combo_sel_slave(obj);
    }                   	        
 }
    
 /*data_kind -> A : 메뉴분류 선택 Combo Data
                B : 메뉴기능 Combo data
 */                
 //combo box option data process method
 //data_kind : combo box data kind
 //value     : value
 function send_ajax(data_kind, value)
 {  
    //init
    if (value == null)
        value = "";
                    
    var result_ = "";
                        
    if (data_kind.toUpperCase() == "A") {
        result_ = "<option value='D'>매일</option>"
                + "<option value='W'>매주</option>"
                + "<option value='M'>매월</option>";
    } else if (data_kind.toUpperCase() == "B") {    	
    	if (value == "W") {
    		result_ = "<option value='MON'>월</option>"
                    + "<option value='TUE'>화</option>"
                    + "<option value='WED'>수</option>"
                    + "<option value='THU'>목</option>"
                    + "<option value='FRI'>금</option>"
                    + "<option value='SAT'>토</option>"
                    + "<option value='SUN'>일</option>";    		    	
    	} else if (value == "M") {
    	   for(var i=1; i <= 12; i++) {    		   
    		   if (i < 10) {
    			   result_ += "<option value='0" + "" + i + "'>0" + "" + i + "</option>";
    		   } else {
    		       result_ += "<option value='" + i + "'>" + i + "</option>";
    		   }	   
    	   }
    	}
    } else if (data_kind.toUpperCase() == "C") {
    	for(var i=0; i < 24; i++) {    		   
 		   if (i < 10) {
 			   result_ += "<option value='" + i + "'>0" + "" + i + "</option>";
 		   } else {
 		       result_ += "<option value='" + i + "'>" + i + "</option>";
 		   }	   
 	    }
    } else if (data_kind.toUpperCase() == "D") {
    	result_ = "<option value='00'>00</option>"
                + "<option value='10'>10</option>"
                + "<option value='20'>20</option>"
                + "<option value='30'>30</option>"
                + "<option value='40'>40</option>"
                + "<option value='50'>50</option>";                
    	/*
    	for(var i=0; i <= 59; i++) {    		   
 		   if (i < 10) {
 			   result_ += "<option value='0" + "" + i + "'>0" + "" + i + "</option>";
 		   } else {
 		       result_ += "<option value='" + i + "'>" + i + "</option>";
 		   }	   
 	    }
 	    */
    } else if (data_kind.toUpperCase() == "E") {
    			// 인물
    	result_ = "<option value='D'>DAUM</option>"
                + "<option value='N'>NAVER</option>"
		    	+ "<option value='G'>GOOGLE</option>";

    } else if (data_kind.toUpperCase() == "P") {
    	if (value == "0") {
    	    result_ = "<option value='0'>480x272</option>"
    		        + "<option value='1'>500x400</option>"
           		    + "<option value='2'>400x300</option>"
                    + "<option value='3'>300x200</option>"
                    + "<option value='4'>768x128</option>"
                    + "<option value='5'>640x128</option>"
                    + "<option value='6'>512x128</option>"
                    + "<option value='7'>384x128</option>"
                    + "<option value='8'>256x128</option>"
                    + "<option value='9'>256x256</option>";
    	} else if(value == "1") {
    		result_ = "<option value='0'>128x256</option>"
    		        + "<option value='1'>128x384</option>"    		    
                    + "<option value='2'>128x512</option>";	
    	} else if(value == "2") {
    		result_ = "<option value='0'>128x128</option>"
    		        + "<option value='1'>128x256</option>"    		    
                    + "<option value='2'>128x512</option>";
    	}
    } else if (data_kind != "") {    	
        var url_ = "/combo.cknb?gubun=" + data_kind + "&value=" + value;
        result_ = ajax_process(url_);
    }                
    return result_;
 }