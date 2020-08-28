package test;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import com.jayway.jsonpath.Configuration;
import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;

public class challenge3 {

	
	public static void main(String[] args) {
		System.out.println("Challenge-3 to retrieve json data");
		String json = getJson();
		accessJson(json);		
	}

	private static void accessJson(String json) {

	 DocumentContext docContext = JsonPath.using(Configuration.defaultConfiguration()).parse(json);
		String nest3 = docContext.read("$.main.nest-1.nest-2.nest-3.value");
		System.out.println(nest3);

	}
	private static String getJson() {
		String json = "";
		try {
			json = new String(Files.readAllBytes(Paths.get("./data/challenge3-data.json")));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return json;
	}
}
