package com.fin.festa.model.entity;

import java.sql.Date;

public class ChatVo {

	String chatName;
	String chatContent;
	Date chatTime;
	
	public ChatVo() {
		// TODO Auto-generated constructor stub
	}

	public ChatVo(String chatName, String chatContent, Date chatTime) {
		super();
		this.chatName = chatName;
		this.chatContent = chatContent;
		this.chatTime = chatTime;
	}

	public String getChatName() {
		return chatName;
	}

	public void setChatName(String chatName) {
		this.chatName = chatName;
	}

	public String getChatContent() {
		return chatContent;
	}

	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}

	public Date getChatTime() {
		return chatTime;
	}

	public void setChatTime(Date chatTime) {
		this.chatTime = chatTime;
	}

	
	
}
