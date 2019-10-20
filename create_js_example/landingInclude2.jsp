<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
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

	//데이터 영역, 주소록 저장 활성,비활성
	function dataDisplay(lang) {

		$("[id^='dataDiv']").attr("style", "display:none");
		$("[id^='saveDiv']").attr("style", "display:none");

		if (lang == 'en') {
			$("#dataDivEn").attr("style", "display:block");
			$("#saveDivEn").attr("style", "display:block");
		} else if (lang == 'cn') {
			$("#dataDivCn").attr("style", "display:block");
			$("#saveDivCn").attr("style", "display:block");
		} else if (lang == 'jp') {
			$("#dataDivJp").attr("style", "display:block");
			$("#saveDivJp").attr("style", "display:block");
		} else {
			$("#dataDivKo").attr("style", "display:block");
			$("#saveDivKo").attr("style", "display:block");
		}

		data(lang);
	}

	//데이터, 라벨 바인딩
	function data(lang) {

		if (lang == 'en') {
			$("#t_enname").text("Name");
			$("#t_enpart").text("Division");
			$("#t_enposition").text("Position");
			$("#t_enduty").text("Duty");
			$("#t_enaddress").text("Address");
			$("#t_enemail").text("E-mail");
			$("#t_entel").text("Tel.");
			$("#t_enfax").text("Fax");
			$("#t_enmobile").text("Mobile");

			$("#enname").val("${info.enname}");
			$("#enpart").val("${info.enpart}");
			$("#enposition").val("${info.enposition}");
			$("#enduty").val("${info.enduty}");
			$("#enaddress").val("${info.enaddress}");
			$("#enemail").html("<a href=\"mailto:${info.enemail }\">${info.enemail}</a>");
			$("#entel").html("<a href=\"tel:${info.entel}\">${info.entel}</a>");
			$("#enfax").val("${info.enfax}");
			$("#enmobile").html("<a href=\"tel:${info.enmobile }\">${info.enmobile}");
			var vcard = "vcard:{\"no\":\"${info.no}\",\"company\":\"${info.company}\",\"name\":\"${info.enname}\",\"part\":\"${info.enpart}\",\"position\":\"${info.enposition}\",\"duty\":\"${info.enduty}\",\"address\":\"${info.enaddress}\",\"email\":\"${info.enemail}\",\"tel\":\"${info.entel}\",\"fax\":\"${info.enfax}\",\"mobile\":\"${info.enmobile}\"}";
			$("#saveDivEn a").attr("href", vcard);
		} else if (lang == 'cn') {
			$("#t_cnname").text("名字");
			$("#t_cnpart").text("部署");
			$("#t_cnposition").text("職級");
			$("#t_cnduty").text("職責");
			$("#t_cnaddress").text("地址");
			$("#t_cnemail").text("邮件");
			$("#t_cntel").text("电话");
			$("#t_cnfax").text("传真");
			$("#t_cnmobile").text("手机");

			$("#cnname").val("${info.cnname}");
			$("#cnpart").val("${info.cnpart}");
			$("#cnposition").val("${info.cnposition}");
			$("#cnduty").val("${info.cnduty}");
			$("#cnaddress").val("${info.cnaddress}");
			$("#cnemail").html("<a href=\"mailto:${info.cnemail }\">${info.cnemail}</a>");
			$("#cntel").html("<a href=\"tel:${info.cntel}\">${info.cntel}</a>");
			$("#cnfax").val("${info.cnfax}");
			$("#cnmobile").html("<a href=\"tel:${info.cnmobile }\">${info.cnmobile}");
			var vcard = "vcard:{\"no\":\"${info.no}\",\"company\":\"${info.company}\",\"name\":\"${info.cnname}\",\"part\":\"${info.cnpart}\",\"position\":\"${info.cnposition}\",\"duty\":\"${info.cnduty}\",\"address\":\"${info.cnaddress}\",\"email\":\"${info.cnemail}\",\"tel\":\"${info.cntel}\",\"fax\":\"${info.cnfax}\",\"mobile\":\"${info.cnmobile}\"}";
			$("#saveDivCn a").attr("href", vcard);
		} else if (lang == 'jp') {
			$("#t_jpname").text("名前");
			$("#t_jppart").text("部署");
			$("#t_jpposition").text("職級");
			$("#t_jpduty").text("職責");
			$("#t_jpaddress").text("住所");
			$("#t_jpemail").text("E-mail");
			$("#t_jptel").text("電話");
			$("#t_jpfax").text("传真");
			$("#t_jpmobile").text("ケータイ");

			$("#jpname").val("${info.jpname}");
			$("#jppart").val("${info.jppart}");
			$("#jpposition").val("${info.jpposition}");
			$("#jpduty").val("${info.jpduty}");
			$("#jpaddress").val("${info.jpaddress}");
			$("#jpemail").html("<a href=\"mailto:${info.jpemail }\">${info.jpemail}</a>");
			$("#jptel").html("<a href=\"tel:${info.jptel}\">${info.jptel}</a>");
			$("#jpfax").val("${info.jpfax}");
			$("#jpmobile").html("<a href=\"tel:${info.jpmobile }\">${info.jpmobile}");
			var vcard = "vcard:{\"no\":\"${info.no}\",\"company\":\"${info.company}\",\"name\":\"${info.jpname}\",\"part\":\"${info.jppart}\",\"position\":\"${info.jpposition}\",\"duty\":\"${info.jpduty}\",\"address\":\"${info.jpaddress}\",\"email\":\"${info.jpemail}\",\"tel\":\"${info.jptel}\",\"fax\":\"${info.jpfax}\",\"mobile\":\"${info.jpmobile}\"}";
			$("#saveDivJp a").attr("href", vcard);
		} else {
			$("#t_koname").text("이름");
			$("#t_kopart").text("부서");
			$("#t_koposition").text("직급");
			$("#t_koduty").text("직책");
			$("#t_koaddress").text("주소");
			$("#t_koemail").text("메일");
			$("#t_kotel").text("전화");
			$("#t_kofax").text("팩스");
			$("#t_komobile").text("모바일");

			$("#koname").val("${info.koname}");
			$("#kopart").val("${info.kopart}");
			$("#koposition").val("${info.koposition}");
			$("#koduty").val("${info.koduty}");
			$("#koaddress").val("${info.koaddress}");
			$("#koemail").html("<a href=\"mailto:${info.koemail }\">${info.koemail}</a>");
			$("#kotel").html("<a href=\"tel:${info.kotel}\">${info.kotel}</a>");
			$("#kofax").val("${info.kofax}");
			$("#komobile").html("<a href=\"tel:${info.komobile }\">${info.komobile}");
			var vcard = "vcard:{\"no\":\"${info.no}\",\"company\":\"${info.company}\",\"name\":\"${info.koname}\",\"part\":\"${info.kopart}\",\"position\":\"${info.koposition}\",\"duty\":\"${info.koduty}\",\"address\":\"${info.koaddress}\",\"email\":\"${info.koemail}\",\"tel\":\"${info.kotel}\",\"fax\":\"${info.kofax}\",\"mobile\":\"${info.komobile}\"}";
			$("#saveDivKo a").attr("href", vcard);
		}
	}

	function resize(img)
	{
		// 원본 이미지 사이즈 저장
	   	var width = img.width;
	   	var height = img.height;

		var divWidth = $(img).parent().width();

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
<body>
</body>
</head>
</html>