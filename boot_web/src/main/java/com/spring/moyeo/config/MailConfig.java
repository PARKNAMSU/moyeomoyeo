package com.spring.moyeo.config;

import java.io.File;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Component
public class MailConfig{
	@Autowired
	private JavaMailSender javaMailSender;

	public void setJavaMailSender(JavaMailSender javaMailSender) {
		this.javaMailSender = javaMailSender;
	}

	public int send(String subject, String text, String from, String to, String filePath) {
		// javax.mail.internet.MimeMessage
		MimeMessage message = javaMailSender.createMimeMessage();
		try {
			// org.springframework.mail.javamail.MimeMessageHelper
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setSubject(subject);
			helper.setText(text, true);
			helper.setFrom(from);
			helper.setTo(to);
			// 첨부 파일 처리
			if (filePath != null) {
				File file = new File(filePath);
				if (file.exists()) {
					helper.addAttachment(file.getName(), new File(filePath));
				}
			}
			javaMailSender.send(message);
			return 1;
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return 0;
	}
}
