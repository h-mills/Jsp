<%@page import="org.xml.sax.SAXException"%>
<%@page import="javax.xml.parsers.ParserConfigurationException"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="java.io.StringReader"%>
<%@page import="org.xml.sax.InputSource"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="java.nio.ByteBuffer"%>
<%@page import="java.nio.charset.Charset"%>
<%@page import="java.sql.DriverManager"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String win_number = request.getParameter("win_number").trim();
	String name = request.getParameter("name").trim();
	String jumin = request.getParameter("jumin").trim();
	String tel = request.getParameter("tel").trim();
	String market = request.getParameter("market").trim(); 
	System.out.println("==========당첨자 정보==========");
	System.out.println("이름 : " + name);
	System.out.println("전화번호 : " + tel);
	System.out.println("구매처 : " + market);
	int grade = 0;
	if (win_number != null) {
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;

		URL url;
		URLConnection connection;

		String URL = "jdbc:mysql://ip/event?useUnicode=true&characterEncoding=UTF-8&characterSetResults=UTF-8";
		String USER = user_id;
		String PASS = pw;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(URL, USER, PASS);
			if (conn != null) {
				stmt = conn.createStatement();
				if (stmt != null) {
					String query = "update fitz set name=" + "'" + name + "'" + ",jumin=" + "'" + jumin + "'"
							+ ",market=" + "'" + market + "'" + ",tel=" + "'" + tel + "'" + " where win_number="
							+ "'" + win_number + "'";
					stmt.executeUpdate(query);

					query = "select grade from fitz where win_number = " + "'" + win_number + "'";
					rs = stmt.executeQuery(query);
					if (rs.next()) {
						grade = rs.getInt(1);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
	int result = 0;
	String reason = "";
	String goods_id = "";
	// 1등은 mms 안보냄.
	if (grade == 1) {
		result = 1;
	} else {
		if (grade == 2) { // 30000원
			if (market.equals("롯데마트") || market.equals("기타매장"))
				goods_id = "G00000161155";
			else if (market.equals("이마트"))
				goods_id = "G00000182158";
			else if (market.equals("홈플러스"))
				goods_id = "G00000230987";
		} else if (grade == 3) { // 10000원
			if (market.equals("롯데마트") || market.equals("기타매장"))
				goods_id = "G00000161153";
			else if (market.equals("이마트"))
				goods_id = "G00000165763";
			else if (market.equals("홈플러스"))
				goods_id = "G00000230986";
		} else if (grade == 4) { // 5000원
			if (market.equals("롯데마트") || market.equals("기타매장"))
				goods_id = "G00000162427";
			else if (market.equals("이마트"))
				goods_id = "G00000182156";
			else if (market.equals("홈플러스"))
				goods_id = "G00000230985";
		}

		// kt mhows API 호출 URL 파라미터 매핑
		String phone_no = request.getParameter("phone_no");
		String title = "피츠 1억병 판매돌파";
		String msg = "피츠 수퍼클리어 1억병 판매돌파 기념 이벤트 당첨을 축하드립니다!!! " + "아래 내용을 참고하여 경품을 수령하세요. "
				+ "문의 02-554-6401 운영시간 평일 오전 10시부터 오후 6시까지";
		String url = "https://giftishowgw.giftishow.co.kr/media/request.asp?MDCODE=M000102766";
		url += "&MSG=" + URLEncoder.encode(msg, "EUC-KR");
		url += "&TITLE=" + URLEncoder.encode(title, "EUC-KR");
		url += "&CALLBACK=025446401";
		url += "&goods_id=" + goods_id;
		url += "&phone_no=" + phone_no;
		url += "&tr_id=fitz_" + win_number;

		// kt mhows 테스트서버용 url&parameter 매핑
		/* String testurl = "http://tgiftishowgw.giftishow.co.kr/media/request.asp?MDCODE=M000201931";
		testurl += "&MSG=" + URLEncoder.encode(msg, "EUC-KR");
		testurl += "&TITLE=" + URLEncoder.encode(title, "EUC-KR");
		testurl += "&CALLBACK=025446401";
		testurl += "&goods_id=" + goods_id;
		testurl += "&phone_no=" + phone_no;
		testurl += "&tr_id=fitz_t" + win_number; */

		URL obj = new URL(url);
		HttpURLConnection con = null;
		int TIMEOUT_VALUE = 3000;
		try {
			con = (HttpURLConnection) obj.openConnection();
			// timeout 3초 설정
			con.setConnectTimeout(TIMEOUT_VALUE);
			con.setReadTimeout(TIMEOUT_VALUE);
			con.setRequestMethod("GET");
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=euc-kr");
			//add request header
			con.setRequestProperty("User-Agent",
					"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36");

			int responseCode = con.getResponseCode();
			if (responseCode == 200) {
				BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(),"utf-8"));
				String inputLine;
				StringBuffer res = new StringBuffer();
				while ((inputLine = in.readLine()) != null) {
					res.append(inputLine);
				}
				DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
				DocumentBuilder builder;
				InputSource is;

				builder = factory.newDocumentBuilder();
				is = new InputSource(new StringReader(res.toString()));
				Document doc = builder.parse(is);
				NodeList list = doc.getElementsByTagName("code");
				NodeList rlist = doc.getElementsByTagName("reason");
				//System.out.println(res.toString());
				result = Integer.parseInt(list.item(0).getTextContent());
				reason = rlist.item(0).getTextContent().toString();
				reason = URLEncoder.encode(reason, "UTF-8");
				if (result == 1000) {
					result = 1;
				} else {
					System.out.println("error code : " + result);
				}
				in.close();
			} else {
				System.out.println("Response Code : " + responseCode);
				result = responseCode;
				reason = "요청이 많습니다. 잠시후에 다시 시도해 주세요.";
			}
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (con != null)
				con.disconnect();
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codecheck</title>

</head>
<body>
	<%
		if (result == 1 && grade == 1) {
	%>
	<jsp:forward page="./finish_1st.jsp"></jsp:forward>
	<%
		} else if (result == 1 && (grade == 2 || grade == 3 || grade == 4)) {
	%>
	<jsp:forward page="./finish_2to4.jsp"></jsp:forward>
	<%
		} else {
	%>
	<jsp:forward page="./mmsfail.jsp">
		<jsp:param value="<%=result%>" name="error_code" />
		<jsp:param value="<%=reason%>" name="error_reason" />
	</jsp:forward>
	<%
		}
	%>
</body>
</html>