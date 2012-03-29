package com.cisco.assetscenter.service.asset.util;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import org.apache.commons.lang.StringUtils;

/**
 * provide read/write function of excel.
 * @author shuaizha
 *
 */
public final class ExcelUtils {

	public final static String ELTMS = "eITMS#";
	public final static String SN = "SN";
	public final static String TYPE = "Product Name";
	public final static String DESCRIPTION = "Product Model";
	public final static String OWNER = "Requestor id";
	public final static String LOCATION = "Bin location";
	public final static String WAREHOUSE_TIME = "Inbound Date";
	public final static String PRICE_RMB = "Total Asstes(RMB)";
	
	/**
	 * read data from the excel file.
	 * @param file
	 * @return
	 */
	public static Map<String, List<String>> readExcel(String file) {
		Map<String, List<String>> data = new HashMap<String, List<String>>();
		if(StringUtils.isEmpty(file)) {
			return data;
		}
		Workbook wb = null;
		try {
			wb = Workbook.getWorkbook(new File(file));
		} catch (BiffException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if(null == wb) {
			return data;
		}
		Sheet[] sheets = wb.getSheets();
		if(null != sheets && sheets.length > 0) {
			for(Sheet sheet : sheets) {
				int column = sheet.getColumns();
				for(int i = 0; i < column; i ++) {
					Cell[] cells = sheet.getColumn(i);
					if(null != cells && cells.length > 0) {
						String title = cells[0].getContents();
						//ELTMS
						if(title.equalsIgnoreCase(ELTMS)) {
							if(cells.length > 1) {
								List<String> ELTMS_LIST = new ArrayList<String>();
								for(int j = 1; j < cells.length; j ++) {
									ELTMS_LIST.add(cells[j].getContents());
								}
								data.put(title, ELTMS_LIST);
							}
						}
						//SN
						if(title.equalsIgnoreCase(SN)) {
							if(cells.length > 1) {
								List<String> SN_LIST = new ArrayList<String>();
								for(int j = 1; j < cells.length; j ++) {
									SN_LIST.add(cells[j].getContents());
								}
								data.put(title, SN_LIST);
							}
						}
						//TYPE
						if(title.equalsIgnoreCase(TYPE)) {
							if(cells.length > 1) {
								List<String> TYPE_LIST = new ArrayList<String>();
								for(int j = 1; j < cells.length; j ++) {
									TYPE_LIST.add(cells[j].getContents());
								}
								data.put(title, TYPE_LIST);
							}
						}
						//DESCRIPTION
						if(title.equalsIgnoreCase(DESCRIPTION)) {
							if(cells.length > 1) {
								List<String> DESCRIPTION_LIST = new ArrayList<String>();
								for(int j = 1; j < cells.length; j ++) {
									DESCRIPTION_LIST.add(cells[j].getContents());
								}
								data.put(title, DESCRIPTION_LIST);
							}
						}
						//OWNER
						if(title.equalsIgnoreCase(OWNER)) {
							if(cells.length > 1) {
								List<String> OWNER_LIST = new ArrayList<String>();
								for(int j = 1; j < cells.length; j ++) {
									OWNER_LIST.add(cells[j].getContents());
								}
								data.put(title, OWNER_LIST);
							}
						}
						//LOCATION
						if(title.equalsIgnoreCase(PRICE_RMB)) {
							if(cells.length > 1) {
								List<String> PRICE_RMB_LIST = new ArrayList<String>();
								for(int j = 1; j < cells.length; j ++) {
									PRICE_RMB_LIST.add(cells[j].getContents());
								}
								data.put(title, PRICE_RMB_LIST);
							}
						}
						//WAREHOUSE_TIME
						if(title.equalsIgnoreCase(WAREHOUSE_TIME)) {
							if(cells.length > 1) {
								List<String> WAREHOUSE_TIME_LIST = new ArrayList<String>();
								for(int j = 1; j < cells.length; j ++) {
									WAREHOUSE_TIME_LIST.add(cells[j].getContents());
								}
								data.put(title, WAREHOUSE_TIME_LIST);
							}
						}
					}
				}
			}
		}
		wb.close();
		return data;
	}
	
	
	public static void main(String[] args) {
		ExcelUtils.readExcel("c:/test.xls");
	}
}
