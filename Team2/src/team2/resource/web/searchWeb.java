package team2.resource.web;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class searchWeb {

	public List<String> getYoutube(){
		List<String> list = new ArrayList<>();
		URL url;
		try {
			url = new URL("https://www.youtube.com/results?search_query=%ED%8C%8C%EC%B6%A9%EB%A5%98&sp=CAI%253D");
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String temp;
			
			while((temp=br.readLine())!=null){
				if(temp.contains("")){
					
				}
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
}
