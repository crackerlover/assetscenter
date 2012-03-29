package com.cisco.assetscenter.service.asset;

public interface ReportService {

	/**
	 * batch import data from the file.
	 * @param file the real path.
	 * @return
	 */
	public boolean batchImport(String file);
}
