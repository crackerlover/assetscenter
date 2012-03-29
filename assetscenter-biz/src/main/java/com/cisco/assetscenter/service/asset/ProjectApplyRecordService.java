package com.cisco.assetscenter.service.asset;

import java.util.List;

import com.cisco.assetscenter.dao.dataobject.project.ProjectApplyRecordDO;
import com.cisco.assetscenter.dao.dataobject.query.ProjectApplyRecordQuery;

public interface ProjectApplyRecordService {

	public int insert(ProjectApplyRecordDO projectApplyRecord);
	
	public boolean updateStatus(int status, int id);
	
	public List<ProjectApplyRecordDO> loadProjectApplyRecordByQuery(ProjectApplyRecordQuery query);
	
	public int getProjectApplyRecordTotalNums(ProjectApplyRecordQuery query);
	
	public ProjectApplyRecordDO findProjectApplyRecordById(int id);
	public List<ProjectApplyRecordDO> findProjectApplyRecordByIdRole(int id, int role);
	public ProjectApplyRecordDO findProjectApplyRecordByIdUserRole(String project, String username, int role);
}
