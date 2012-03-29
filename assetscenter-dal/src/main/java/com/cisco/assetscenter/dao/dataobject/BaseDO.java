package com.cisco.assetscenter.dao.dataobject;

import java.io.Serializable;


/**
 * The base dataobject.
 * @author shuaizha
 * @date 2011-8-22
 */
public class BaseDO implements Serializable {

	private static final long serialVersionUID = -5518018437201324320L;

	private int id;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Override
	public int hashCode() {
		return id;
	}

	@Override
	public boolean equals(Object obj) {
		if(obj instanceof BaseDO) {
			BaseDO base = (BaseDO)obj;
			if(base.getId() == this.getId()) {
				return true;
			}
		}
		return false;
	}
}
