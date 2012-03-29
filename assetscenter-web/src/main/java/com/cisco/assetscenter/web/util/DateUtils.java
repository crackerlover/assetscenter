package com.cisco.assetscenter.web.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang.StringUtils;

/**
 * provide date convertion tools.
 * @author shuaizha
 * @date 2011-9-1
 */
public final class DateUtils {

	
	public static final String DATABASE_ASSET_FORMAT = "yyyy-MM-dd";
	public static final String EASYUI_FORMAT = "MM/dd/yyyy";
	/**
	 * convert the time to the special date.
	 * @param time
	 * @param source
	 * @param target
	 * @return
	 */
	public static String convertStr2Str(String time, String source, String target) {
		if(StringUtils.isEmpty(time) || StringUtils.isEmpty(source)) {
			return "";
		}
		SimpleDateFormat sdf = new SimpleDateFormat(source);
		Date date = null;
		try {
			date = sdf.parse(time);
		} catch (ParseException e) {
		}
		return new SimpleDateFormat(target).format(date);
	}
	
	/**
	 * convert the time to the special date.
	 * format type to the special format.
	 * @param date
	 * @return
	 */
	public static String convertDate2Str(Date date, String format) {
		return new SimpleDateFormat(format).format(date);
	}
	
	public static void main(String[] args) {
		System.out.println(DateUtils.convertStr2Str("8/29/2011", "MM/dd/yyyy", DATABASE_ASSET_FORMAT));
	}
}
