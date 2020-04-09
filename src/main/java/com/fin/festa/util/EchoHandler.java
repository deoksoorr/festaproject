package com.fin.festa.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fin.festa.model.entity.ChatVo;
import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.model.entity.ProfileVo;

//에코서버
public class EchoHandler extends TextWebSocketHandler{

	List<WebSocketSession> sessions=new ArrayList<>();
	Map<String, WebSocketSession> userSessions = new HashMap<>();
	String roomnum;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("Connect");

		//group뽑기 
		String url=session.getUri()+"a";
        String path[]=url.split("grnum");
        path[1]=path[1].replace("=", "");
        path[1]=path[1].replace("a", "");
        roomnum=path[1];

        //전체 세션에 기존 로그인 세션 가져와서 넣기
		Map<String, Object> httpSession = session.getAttributes();
		System.out.println(session);
		ProfileVo login = (ProfileVo) httpSession.get("login");
		login.setChatgrnum(roomnum);
		
				
		ArrayList<ChatVo> list = new ArrayList<>();
		ChatVo chatVo=new ChatVo();
		chatVo.setChatId(login.getProid());
		chatVo.setChatName(login.getProname());
		chatVo.setChatGrnum(roomnum);
		list.add(chatVo);
		
		String senderName=login.getProname();
		String senderId=login.getProid();
		userSessions.put(senderId, session);

		System.out.println(senderName+"님이 "+roomnum+"번 방 입장!!");
		for(int i=0; i<list.size(); i++) {
			System.out.println(list.get(i).getChatGrnum());
			for(WebSocketSession sess : userSessions.values()) {
				if(list.get(i).getChatGrnum()==roomnum) {
					sess.sendMessage(new TextMessage(senderName+"("+senderId+")님이 입장하였습니다.*"+roomnum));
				}
			}
		}
		/*
		for(WebSocketSession sess : userSessions.values()) {
			for(int i=0; i<list.size(); i++) {
				if(senderId!=list.get(i).getProid()) {
					sess.sendMessage(new TextMessage("+"+list.get(i).getProid()+"+"+list.get(i).getProname()+"+"+list.get(i).getProphoto()));
				}
			}
		}*/
		
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println(session+":"+message);
		String msg=message.getPayload();
		System.out.println(msg);
        String path[]=msg.split("=");
        System.out.println(path[1]);
		
		
		Map<String, Object> httpSession = session.getAttributes();
		ProfileVo login = (ProfileVo) httpSession.get("login");
		
		String senderId=login.getProid();
		String senderName=login.getProname();
		String senderPhoto=login.getProphoto();
		
		SimpleDateFormat format = new SimpleDateFormat("HH:mm");
		Date today = new Date();
		String time=format.format(today);
		System.out.println (senderId+"|"+senderName+"|"+senderPhoto+"|"+path[1]+"|"+time);

		for(WebSocketSession sess : userSessions.values()) {
			sess.sendMessage(new TextMessage(senderId+"|"+senderName+"|"+senderPhoto+"|"+path[1]+"|"+time));
		}
	}
	

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("Closed");
		
		Map<String, Object> httpSession = session.getAttributes();
		ProfileVo login = (ProfileVo) httpSession.get("login");
		String senderName=login.getProname();
		String senderId=login.getProid();

		userSessions.remove(senderId, session);
		for(WebSocketSession sess : userSessions.values()) {
			sess.sendMessage(new TextMessage(senderName+"("+senderId+")님이 퇴장하였습니다."));
		}
		session.close();
		
		if(session.isOpen()){
			System.out.println("real Closed");
			session.close();
		}
	}
	
	
	
}
