package com.cisco.assetscenter.service.asset.impl;


import java.io.IOException;
import java.util.Properties;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.apache.commons.lang.StringUtils;

import com.cisco.assetscenter.dao.dataobject.Constants;
import com.cisco.assetscenter.dao.dataobject.mail.MailDO;
import com.cisco.assetscenter.service.asset.MailService;

public class DefaultMailService implements MailService {

	private static Properties props;
	private static final String EMAIL_HOST = "xmb-hkg-412.apac.cisco.com";
	static {
		props = new Properties();
		try {
			props.load(DefaultMailService.class.getClassLoader().getResourceAsStream("config.properties"));
			props.put("mail.smtp.host", props.getProperty("EMAIL_HOST", EMAIL_HOST));
		} catch (IOException e) {
			props.put("mail.smtp.host", EMAIL_HOST);
		}
		//props.put("mail.smtp.host", EMAIL_HOST);
		
	}
	
	@Override
	public boolean sendMail(MailDO mail) {
		boolean success = false;
		if(null == mail) {
			return success;
		}
		Session session = Session.getInstance(props);
		session.setDebug(false);
		Message msg = new MimeMessage(session);
		try {
			msg.setFrom(new InternetAddress(mail.getSender()));
			msg.setRecipients(Message.RecipientType.TO, new InternetAddress[]{new InternetAddress(mail.getRecipient())});
			if(StringUtils.isNotBlank(mail.getCcRecipient())) {
				msg.setRecipients(Message.RecipientType.CC, new InternetAddress[]{new InternetAddress(mail.getCcRecipient())});
			}
			msg.setSubject(mail.getSubject());
			msg.setSentDate(mail.getSendDate());
			Multipart multipart = new MimeMultipart("related");
			BodyPart htmlPart = new MimeBodyPart();
			htmlPart.setContent(mail.getContent(), "text/html");
			multipart.addBodyPart(htmlPart);
			msg.setContent(multipart);
			Transport.send(msg);
			success = true;
		} catch (AddressException e) {
		} catch (MessagingException e) {
		}
		return success;
	}
	
	public static void main(String[] args) throws IOException {
		MailService mailService = new DefaultMailService();
		MailDO mail = new MailDO();
		mail.setSender("shuaizha@cisco.com");
		mail.setCcRecipient("shuaizha@cisco.com");
		mail.setRecipient("shuaizha@cisco.com");
		mail.setSubject("Hello shuaizha");
		mail.setContent(Constants.MAIL_TEAM_TEMPLATE);
		mailService.sendMail(mail);
//		Properties pros = new Properties();
//		pros.load(DefaultMailService.class.getClassLoader().getResourceAsStream("config.properties"));
//		System.out.println(pros.getProperty("EMAIL_HOST"));
	}
	
}
