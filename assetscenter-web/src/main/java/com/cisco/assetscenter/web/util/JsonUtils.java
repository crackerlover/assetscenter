package com.cisco.assetscenter.web.util;

/**
 * provide the tools of json.
 * @author shuaizha
 * @date 2011-8-30
 */
public final class JsonUtils {

	/**
	 * convert the json character to html character.
	 * @param source
	 * @return
	 */
	public static final String convertJsonChar(String source) {
		source = source.replaceAll("&#038;", "&");
		source = source.replaceAll("&#034;", "\"");
		source = source.replaceAll("&#060;", "<");
		source = source.replaceAll("&#062;", ">"); 
		source = source.replaceAll("&#039;", "'"); 
		return source;
	}
	
	/**
	 * convert the html special character.
	 * @param source
	 * @return
	 */
	public static final String convertHtmlChar(String source) {
		source = source.replaceAll("&", "&amp;");
		source = source.replaceAll("\"", "&quot;");
		source = source.replaceAll("<", "&lt;");
		source = source.replaceAll(">", "&gt;"); 
		source = source.replaceAll(" ", "&nbsp;"); 
		return source;
	}
	
	/**
	 * skip the special char, such as \r\n, if it exists, the json will not work.
	 * @param source
	 * @return
	 */
	public static String skipChar(String source) {
		source = source.replaceAll("\n\r", "<br/>");
		source = source.replaceAll("\r\n", "<br/>");
		source = source.replaceAll("\n", " ");
		source = source.replaceAll("\r", " ");
		return source;
	}
	
	public static void main(String[] args) {
		String source = "?name=&status=-1&startTime=&endTime=";
		System.out.println(JsonUtils.convertHtmlChar((source)));
	}
}
