package com.cisco.assetscenter.dao.dataobject.mail;

import java.util.Date;

import com.cisco.assetscenter.dao.dataobject.BaseDO;

public class MailDO extends BaseDO {

	private static final long serialVersionUID = 201602441461365889L;

	private String sender;
	private String recipient;
	private String ccRecipient;
	private String subject;
	private Date sendDate = new Date();
	private String content;
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getRecipient() {
		return recipient == null ? "" : recipient;
	}
	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}
	public String getSubject() {
		return subject == null ? "" : subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public Date getSendDate() {
		return sendDate;
	}
	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}
	public String getContent() {
		return content == null ? "" : content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCcRecipient() {
		return ccRecipient == null ? "" : ccRecipient;
	}
	public void setCcRecipient(String ccRecipient) {
		this.ccRecipient = ccRecipient;
	}
}
