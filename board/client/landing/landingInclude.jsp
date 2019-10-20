<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/common/js/jquery-1.8.2.js"></script>
<title>HiddentagBiz</title>

<script type="text/javascript">
<c:set value="${data.info }" var="info"></c:set>

	$(document).ready(function() {
		//언어 메뉴 설정
		if ("${info.ko}" != "1") {
			$("#menu_ko").attr("style", "display:none");
		}
		if ("${info.en}" != "1") {
			$("#menu_en").attr("style", "display:none");
		}
		if ("${info.cn}" != "1") {
			$("#menu_cn").attr("style", "display:none");
		}
		if ("${info.jp}" != "1") {
			$("#menu_jp").attr("style", "display:none");
		}

		var chk = "";
		if ("${info.lang}" == "ko") {
			chk = "${info.ko}";
		} else if ("${info.lang}" == "en") {
			chk = "${info.en}";
		} else if ("${info.lang}" == "cn") {
			chk = "${info.cn}";
		} else if ("${info.lang}" == "jp") {
			chk = "${info.jp}";
		}

		var first_lang = "";

		if (chk == "1") {
			first_lang = "${info.lang}";
		} else {
			if ("${info.en}" == "1") {
				first_lang = "en";
			} else if ("${info.ko}" == "1") {
				first_lang = "ko";
			} else if ("${info.cn}" == "1") {
				first_lang = "cn";
			} else if ("${info.jp}" == "1") {
				first_lang = "jp";
			}
		}

		$("#menu_" + first_lang).addClass("active");

		//언어 메뉴 클릭
		$("#menu_ko").click(function() {
			$("#menu_en").removeClass("active");
			$("#menu_cn").removeClass("active");
			$("#menu_jp").removeClass("active");
			$("#menu_ko").addClass("active");
			dataDisplay("ko");
		});
		$("#menu_en").click(function() {
			$("#menu_ko").removeClass("active");
			$("#menu_cn").removeClass("active");
			$("#menu_jp").removeClass("active");
			$("#menu_en").addClass("active");
			dataDisplay("en");
		});
		$("#menu_cn").click(function() {
			$("#menu_ko").removeClass("active");
			$("#menu_en").removeClass("active");
			$("#menu_jp").removeClass("active");
			$("#menu_cn").addClass("active");
			dataDisplay("cn");
		});
		$("#menu_jp").click(function() {
			$("#menu_ko").removeClass("active");
			$("#menu_en").removeClass("active");
			$("#menu_cn").removeClass("active");
			$("#menu_jp").addClass("active");
			dataDisplay("jp");
		});

		//로딩 최초 데이터 바인딩
		dataDisplay(first_lang);

		var url = "/img/face_pic.png";
		if ("${info.image}" != '' && "${info.image}" != null) {
			url = "${info.imagepath}";
		}

		$("#image").attr("src", url);
		$("#image").attr("onload", "resize(this)");
		$("#logo").attr("onload", "resize(this)");

		//카카오, 라인
		if ('${info.kakaoid}' == '' || '${info.kakaoid}' == '-') {
			$("#kakaoDiv").attr("style", "display:none");
		}
		if ('${info.lineid}' == '' || '${info.lineid}' == '-') {
			$("#lineDiv").attr("style", "display:none");
		}
		
		//댓글
		//fn_getReply(0, 0);
		
		//댓글입력html
		//fn_replyInputDiv();

		//youtube
		fn_youtube("${info.youtube}");
		
		//모바일 히스토리
		var agent = navigator.userAgent;

		if(agent.match('Android')){
			Mobile.saveMobileDB('${info}');
		} else if(agent.match('iPhone') || agent.match('iPad')) {
			var url = "jscall:*saveMobileDB*";
			url += JSON.stringify(${info});
			document.location=url;
		}
	});

	//카카오, 라인
	function fn_sns(id, option) {
		var agent = navigator.userAgent;

		if(agent.match('Android')){
			if (option == '1') {
				Mobile.gotoKakaoTalk(id);
			} else if (option == '2') {
				Mobile.gotoLine(id);
			}
		} else if(agent.match('iPhone') || agent.match('iPad')) {
			if (option == '1') {
				document.location="jscall:*gotoKakaoTalk*" + id;
			} else if (option == '2') {
				document.location="jscall:*gotoLine*" + id;
			}
		}
	}

	//유투브
	function fn_youtube(url) {
		if (url != null && url != "") {
			$("#youtubuDiv").html("<iframe src=\"//www.youtube.com/embed/" + url +"?rel=0&enablejsapi=1\" style=\"margin: 0 auto;\" width=\"90%;\" height=\"500\" id=\"youtubeIframe\" frameborder=\"0\" allowfullscreen></iframe>");		
		} else {
			$("#youtubuDiv").attr("style", "display:none");
		}
	}
	
	//주소록 저장
	function dataDisplay(lang) {
		var txt = "";

		if (lang == 'en') {
			txt = "Save Contact";
		} else if (lang == 'cn') {
			txt = "保存号码";
		} else if (lang == 'jp') {
			txt = "連絡先に保存";
		} else {
			txt = "주소록 저장하기";
		}
		$("#saveDiv button").text(txt);

		data(lang);
	}

	//데이터, 라벨 바인딩
	function data(lang) {

		if (lang == 'en') {
			$("#t_name").text("Name");
			$("#t_company").text("Company");
			$("#t_part").text("Division");
			$("#t_position").text("Position");
			$("#t_duty").text("Duty");
			$("#t_address").text("Address");
			$("#t_email").text("E-mail");
			$("#t_tel").text("Tel.");
			$("#t_fax").text("Fax");
			$("#t_mobile").text("Mobile");

			$("#show_name").text("${info.enname}");
			$("#show_part").text("${info.show_part_en}");
			$("#show_mobile").text("${info.enmobile}");
			$("#kakao").html("<a href=\"javascript:void(0)\" onclick=\"fn_sns('${info.kakaoid}', '1')\">${info.kakaoid}</a>");
			$("#line").html("<a href=\"javascript:void(0)\" onclick=\"fn_sns('${info.lineid}', '2')\">${info.lineid}</a>");
			$("#name").text("${info.enname}");
			$("#company").text("${info.company}");
			$("#part").text("${info.enpart}");
			$("#position").text("${info.enposition}");
			$("#duty").text("${info.enduty}");
			$("#address").text("${info.enaddress}");
			$("#email").html("<a href=\"mailto:${info.enemail }\">${info.enemail}</a>");
			$("#tel").html("<a href=\"tel:${info.entel}\">${info.entel}</a>");
			$("#fax").text("${info.enfax}");
			$("#mobile").html("<a href=\"tel:${info.enmobile }\">${info.enmobile}");
			var vcard = "vcard:{\"no\":\"${info.no}\",\"company\":\"${info.company}\",\"name\":\"${info.enname}\",\"part\":\"${info.enpart}\",\"position\":\"${info.enposition}\",\"duty\":\"${info.enduty}\",\"address\":\"${info.enaddress}\",\"email\":\"${info.enemail}\",\"tel\":\"${info.entel}\",\"fax\":\"${info.enfax}\",\"mobile\":\"${info.enmobile}\"}";
			$("#saveDiv a").attr("href", vcard);
		} else if (lang == 'cn') {
			$("#t_name").text("名字");
			$("#t_company").text("公司");
			$("#t_part").text("部署");
			$("#t_position").text("職級");
			$("#t_duty").text("職責");
			$("#t_address").text("地址");
			$("#t_email").text("邮件");
			$("#t_tel").text("电话");
			$("#t_fax").text("传真");
			$("#t_mobile").text("手机");

			$("#show_name").text("${info.cnname}");
			$("#show_part").text("${info.show_part_cn}");
			$("#show_mobile").text("${info.cnmobile}");
			$("#kakao").html("<a href=\"javascript:void(0)\" onclick=\"fn_sns('${info.kakaoid}', '1')\">${info.kakaoid}</a>");
			$("#line").html("<a href=\"javascript:void(0)\" onclick=\"fn_sns('${info.lineid}', '2')\">${info.lineid}</a>");
			$("#name").text("${info.cnname}");
			$("#company").text("${info.company}");
			$("#part").text("${info.cnpart}");
			$("#position").text("${info.cnposition}");
			$("#duty").text("${info.cnduty}");
			$("#address").text("${info.cnaddress}");
			$("#email").html("<a href=\"mailto:${info.cnemail }\">${info.cnemail}</a>");
			$("#tel").html("<a href=\"tel:${info.cntel}\">${info.cntel}</a>");
			$("#fax").text("${info.cnfax}");
			$("#mobile").html("<a href=\"tel:${info.cnmobile }\">${info.cnmobile}");
			var vcard = "vcard:{\"no\":\"${info.no}\",\"company\":\"${info.company}\",\"name\":\"${info.cnname}\",\"part\":\"${info.cnpart}\",\"position\":\"${info.cnposition}\",\"duty\":\"${info.cnduty}\",\"address\":\"${info.cnaddress}\",\"email\":\"${info.cnemail}\",\"tel\":\"${info.cntel}\",\"fax\":\"${info.cnfax}\",\"mobile\":\"${info.cnmobile}\"}";
			$("#saveDiv a").attr("href", vcard);
		} else if (lang == 'jp') {
			$("#t_name").text("名前");
			$("#t_company").text("会社");
			$("#t_part").text("部署");
			$("#t_position").text("職級");
			$("#t_duty").text("職責");
			$("#t_address").text("住所");
			$("#t_email").text("E-mail");
			$("#t_tel").text("電話");
			$("#t_fax").text("传真");
			$("#t_mobile").text("ケータイ");

			$("#show_name").text("${info.jpname}");
			$("#show_part").text("${info.show_part_jp}");
			$("#show_mobile").text("${info.jpmobile}");
			$("#kakao").html("<a href=\"javascript:void(0)\" onclick=\"fn_sns('${info.kakaoid}', '1')\">${info.kakaoid}</a>");
			$("#line").html("<a href=\"javascript:void(0)\" onclick=\"fn_sns('${info.lineid}', '2')\">${info.lineid}</a>");
			$("#name").text("${info.jpname}");
			$("#company").text("${info.company}");
			$("#part").text("${info.jppart}");
			$("#position").text("${info.jpposition}");
			$("#duty").text("${info.jpduty}");
			$("#address").text("${info.jpaddress}");
			$("#email").html("<a href=\"mailto:${info.jpemail }\">${info.jpemail}</a>");
			$("#tel").html("<a href=\"tel:${info.jptel}\">${info.jptel}</a>");
			$("#fax").text("${info.jpfax}");
			$("#mobile").html("<a href=\"tel:${info.jpmobile }\">${info.jpmobile}");
			var vcard = "vcard:{\"no\":\"${info.no}\",\"company\":\"${info.company}\",\"name\":\"${info.jpname}\",\"part\":\"${info.jppart}\",\"position\":\"${info.jpposition}\",\"duty\":\"${info.jpduty}\",\"address\":\"${info.jpaddress}\",\"email\":\"${info.jpemail}\",\"tel\":\"${info.jptel}\",\"fax\":\"${info.jpfax}\",\"mobile\":\"${info.jpmobile}\"}";
			$("#saveDiv a").attr("href", vcard);
		} else {
			$("#t_name").text("이름");
			$("#t_company").text("회사");
			$("#t_part").text("부서");
			$("#t_position").text("직급");
			$("#t_duty").text("직책");
			$("#t_address").text("주소");
			$("#t_email").text("메일");
			$("#t_tel").text("전화");
			$("#t_fax").text("팩스");
			$("#t_mobile").text("모바일");

			$("#show_name").text("${info.koname}");
			$("#show_part").text("${info.show_part_ko}");
			$("#show_mobile").text("${info.komobile}");
			$("#kakao").html("<a href=\"javascript:void(0)\" onclick=\"fn_sns('${info.kakaoid}', '1')\">${info.kakaoid}</a>");
			$("#line").html("<a href=\"javascript:void(0)\" onclick=\"fn_sns('${info.lineid}', '2')\">${info.lineid}</a>");
			$("#name").text("${info.koname}");
			$("#company").text("${info.company}");
			$("#part").text("${info.kopart}");
			$("#position").text("${info.koposition}");
			$("#duty").text("${info.koduty}");
			$("#address").text("${info.koaddress}");
			$("#email").html("<a href=\"mailto:${info.koemail }\">${info.koemail}</a>");
			$("#tel").html("<a href=\"tel:${info.kotel}\">${info.kotel}</a>");
			$("#fax").text("${info.kofax}");
			$("#mobile").html("<a href=\"tel:${info.komobile }\">${info.komobile}");
			var vcard = "vcard:{\"no\":\"${info.no}\",\"company\":\"${info.company}\",\"name\":\"${info.koname}\",\"part\":\"${info.kopart}\",\"position\":\"${info.koposition}\",\"duty\":\"${info.koduty}\",\"address\":\"${info.koaddress}\",\"email\":\"${info.koemail}\",\"tel\":\"${info.kotel}\",\"fax\":\"${info.kofax}\",\"mobile\":\"${info.komobile}\"}";
			$("#saveDiv a").attr("href", vcard);
		}
	}

	//댓글
	function fn_replyInputDiv() {
		var htmlcode = "";
		htmlcode += "<p class=\"c_title\">댓글쓰기</p>";
		htmlcode += "<table>";
		htmlcode += "<tbody>";
		htmlcode += "<tr>";
		htmlcode += "<td>";
		htmlcode += "<input type=\"text\" id=\"replyname\" placeholder=\"이름 입력해 주세요\">";
		htmlcode += "</td>";
		htmlcode += "<td>";
		htmlcode += "<input type=\"password\" id=\"replypasswd\" placeholder=\"비밀번호 입력해 주세요\">";
		htmlcode += "</td>";
		htmlcode += "<td>";
		htmlcode += "<button type=\"button\" onclick=\"fn_replysave();\">등록</button>";
		htmlcode += "</td>";
		htmlcode += "</tr>";
		htmlcode += "<tr>";
		htmlcode += "<td colspan=\"3\">";
		htmlcode += "<input type=\"text\" id=\"replycontent\" placeholder=\"내용 입력해 주세요\">";
		htmlcode += "</td>";
		htmlcode += "</tr>";
		htmlcode += "</tbody>";
		htmlcode += "</table>";
		$("#replyInputDiv").html(htmlcode);
	}
	
	//댓글 조회
	function fn_getReply(pageNum, isMore) {
		var carddata_master_no = "${info.no}";

		$.ajax({
			type: 'post',
			url : '/mobile/reply',
			data : {carddata_master_no:carddata_master_no,pageNum:pageNum},
	        async: true,
			success : function(data) {
				var JSONobj = JSON.parse(data);
				var replyList = JSONobj.replyList;
				var pagingValues = JSONobj.pagingValues;
				var htmlCode = "";
				var htmlCode2 = "";

				if (pagingValues.totalListCount > 0) {
					if (replyList != null && replyList.length > 0) {
						var name = $("#replyname").val("");
						var content = $("#replycontent").val("");
						var passwd = $("#replypasswd").val("");
	
						for (var i in replyList) {
							htmlCode += "<li class=\"u_cbox_comment\">";
							htmlCode += "<div class=\"u_cbox_comment_box\">";
							htmlCode += "<div class=\"u_cbox_area\">";
							htmlCode += "<span class=\"u_cbox_nick\">" + replyList[i].name + "</span>";
							htmlCode += "<span class=\"u_cbox_contents\">" + replyList[i].content + "</span>";
							htmlCode += "<span class=\"u_cbox_date\">" + replyList[i].date + "</span>";
							htmlCode += "<span class=\"u_cbox_del\" onclick=\"fn_replydel(" + replyList[i].no + ")\">삭제</span>";
							htmlCode += "</div>";
							htmlCode += "</div>";
							htmlCode += "</li>";
						}
						htmlCode2 += "<div class=\"c_more_box\">";
						htmlCode2 += "<span class=\"c_more\" onclick=\"fn_getReply(" + (pageNum + 1) + ", 1)\" id=\"replyMore\">댓글 더보기</span>";
						htmlCode2 += "</div>";

						if (isMore == 1) {
							$("#replyList").append(htmlCode);	
						} else {
							$("#replyList").html(htmlCode);
						}
						
						$("#replyMoreDiv").html(htmlCode2);
					}
					$("#replyDiv").attr("style", "display:block");
					$("#replyMoreDiv").attr("style", "display:block");
				} else {
					$("#replyDiv").attr("style", "display:none");
					$("#replyMoreDiv").attr("style", "display:none");
				}
			}
		});
	}

	//댓글 저장
	function fn_replysave() {
		var carddata_master_no = "${info.no}";
		var name = $("#replyname").val();
		var content = $("#replycontent").val();
		var passwd = $("#replypasswd").val();

		if (name == null || name == "") {
			alert("이름을 입력해 주세요.");
			return;
		} else if (content == null || content == "") {
			alert("내용을 입력해 주세요.");
			return;
		} else if (passwd == null || passwd == "") {
			alert("비밀번호를 입력해 주세요.");
			return;
		}

		$.ajax({
			type: 'post',
			url : '/mobile/replysave',
			data : {carddata_master_no:carddata_master_no,name:name,content:content,passwd:passwd},
	        async: true,
			success : function(data) {
				var JSONobj = JSON.parse(data);
				var result = JSONobj.result;
				var replyList = JSONobj.replyList;
				var htmlCode = "";

				if (result == 1) {
					fn_getReply(0, 0);
				} else {
					alert("등록에 실패하였습니다.");
				}
			}
		});
	}

	//댓글삭제 창
	function fn_replydel(no) {
		window.open("/mobile/replydelmain?no="+no,"댓글삭제",
		"width=500,height=200,scrollbars=no,resizeable=yes,left=450,top=150");
	}

	function resize(img)
	{
		// 원본 이미지 사이즈 저장
	   	var width = img.width;
	   	var height = img.height;

		var divWidth = $(img).parents("div").width();

	   	// 가로, 세로 최대 사이즈 설정
	   	var maxWidth = divWidth;   // 원하는대로 설정. 픽셀로 하려면 maxWidth = 100  이런 식으로 입력
	   	var maxHeight = divWidth;   // 원래 사이즈 * 0.5 = 50%

	   	// 가로가 세로보다 크면 가로는 최대사이즈로, 세로는 비율 맞춰 리사이즈
	   	if(width > height)
	   	{
	 	  	resizeWidth = maxWidth;
	 	  	resizeHeight = (height * resizeWidth) / width;
	   		// 세로가 가로보다 크면 세로는 최대사이즈로, 가로는 비율 맞춰 리사이즈
	   	}
	   	else
	   	{
	      	resizeHeight = maxHeight;
	      	resizeWidth = (width * resizeHeight) / height;
	    }
	   	// 리사이즈한 크기로 이미지 크기 다시 지정
	   	img.width = resizeWidth;
	   	img.height = resizeHeight;
	}

</script>
<script type="text/javascript">
var tag = document.createElement('script');
tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

var player;
function onYouTubeIframeAPIReady() {
    player = new YT.Player('youtubeIframe', {
        events: {
            'onReady': onPlayerReady,               // 플레이어 로드가 완료되고 API 호출을 받을 준비가 될 때마다 실행
            'onStateChange': onPlayerStateChange    // 플레이어의 상태가 변경될 때마다 실행
        }
    });
}

function onPlayerReady(event) {
    // 플레이어 자동실행 (주의: 모바일에서는 자동실행되지 않음)
    //event.target.playVideo();
}

var done = false;
var agent = navigator.userAgent;

function onPlayerStateChange(event) {
	if (agent.match('Android') || agent.match('iPhone') || agent.match('iPad')){
		if (event.data == 3 && !done) {
			if (confirm("3G/LTE 등으로 재생 시 데이터 사용료가 발생할 수 있습니다.")) {
				player.playVideo();
				done = true;
			} else {
				player.stopVideo();
			}
		}
	}
}

</script>
</head>
</html>