package com.cisco.assetscenter.web.asset;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.cisco.assetscenter.service.asset.ReportService;

public class BatchImportController implements Controller {

	protected final Logger logger = Logger.getLogger(BatchImportController.class);
	private ReportService reportService;
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String file = upload(request);
		if(StringUtils.isNotBlank(file)) {
			reportService.batchImport(file);
		}
		String queryString = "?selectKey=&selectValue=&owner=&type=&status=&startTime=&endTime=";
		return new ModelAndView("asset/asset_ajax", "queryString", queryString);
	}
	public void setReportService(ReportService reportService) {
		this.reportService = reportService;
	}
	
	@SuppressWarnings("unchecked")
	private String upload(HttpServletRequest request) throws Exception {
		String filepath = "";
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		if(isMultipart) {
			final String USER_HOME = System.getProperty("user.home");
			final String SEPARATOR = File.separator;
			File temp = new File(USER_HOME + SEPARATOR + "upload_files_temp" + SEPARATOR);
			File dir = new File(USER_HOME + SEPARATOR + "upload_files" + SEPARATOR);
			if(!temp.exists()) {
				temp.mkdir();
			}
			if(!dir.exists()) {
				dir.mkdir();
			}
			DiskFileItemFactory factory = new DiskFileItemFactory(4096, temp);
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setHeaderEncoding("UTF-8"); 
			upload.setSizeMax(1024 * 1024 * 100);
			List<FileItem> fileItems = upload.parseRequest(request);
			if(null != fileItems && fileItems.size() > 0) {
				for(FileItem fileItem : fileItems) {
					if(!fileItem.isFormField()) {
						String fileName = fileItem.getName();
						int index = fileName.lastIndexOf(SEPARATOR);
						if(-1 != index) {
							fileName = fileName.substring(index);
						}
						if(StringUtils.isNotBlank(fileName)) {
							File fileOnServer = new File(dir + SEPARATOR + fileName);
							fileItem.write(fileOnServer);
							filepath = fileOnServer.getPath();
						}
					}
				}
			}
		}
		return filepath;
	}
	
	
	public static void main(String[] args) {
		System.out.println(System.getProperty("user.home"));
		System.out.println(File.separator);
	}

}
