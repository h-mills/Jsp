
	String url = "https://dapi.kakao.com/v2/search/web?query="+keyWord+"&size="+maxsearch;
	List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

	try{
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();

		// optional default is GET
		con.setRequestMethod("GET");

		//add request header
		con.setRequestProperty("User-Agent", "Mozilla/5.0");
		con.setRequestProperty("Authorization", DaumApiKey);

		int responseCode = con.getResponseCode();
		System.out.println("\nSending 'GET' request to URL : " + url);
		System.out.println("Response Code : " + responseCode);
		
		BufferedReader in = new BufferedReader(
		        new InputStreamReader(con.getInputStream(), "UTF-8"));
		String ret = in.readLine();
		ret = ret.substring(ret.indexOf("},")+2, ret.lastIndexOf(","));
		ret = "{"+ret+"}";
		//System.out.println("ret = " + ret);
		
		JSONParser parser = new JSONParser();
		JSONObject json = (JSONObject)parser.parse(ret);
		//JSONObject documents = (JSONObject)json.get("documents");
		
		JSONArray item = (JSONArray)json.get("documents");
		
		for(int i=0; i<item.size(); i++){
			JSONObject temp = (JSONObject)item.get(i);
			HashMap<String, Object> urlMap = new HashMap<String, Object>();
			urlMap.put("url", temp.get("url"));
			list.add(urlMap);
		}
		
		String inputLine;
		StringBuffer response = new StringBuffer();

		in.close();

	}catch (Exception e){
		e.printStackTrace();
	}
    return list;
}