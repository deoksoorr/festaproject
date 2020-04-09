<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url value="/" var="root" />
<c:url value="/resources/upload" var="upload" />
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta property="og:image" content="${root }resources/images/ico/logo.png">
<script type="text/javascript" src="${root }resources/js/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${root }resources/js/util.js"></script>
<script type="text/javascript" src="${root }resources/js/site.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.js"></script>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="${root }resources/css/site.css">
<link rel="shortcut icon" href="${root }resources/favicon.ico">
<title>FESTA</title>
<script type="text/javascript">
	$(document).ready(function(){
		
		connect();
		
		$('#chstmsg').keydown(function(key) {
            if (key.keyCode == 13) {
            	if (!event.shiftKey){
            		if(socket.readyState !== 1){
        				return;
        			}
        			let msg=$('#chstmsg').val();
        			socket.send(msg);
        			$('#chstmsg').val('');
            	}
            }
		});
		
		$('.btn_send').on('click', function(){
			if(socket.readyState !== 1){
				return;
			}
			let msg=$('#chstmsg').val();
			socket.send(msg);
			$('#chstmsg').val('');
		});
	});

</script>
<script type="text/javascript">
	var socket = null;
	function connect(){
		var ws=new WebSocket("ws://localhost:8080/festa/chat/echo?grnum=${detail.grnum}")
		socket=ws;
		ws.onopen=function(event){
			console.log('connection open');
		};
		
		ws.onmessage=function(event){
			
			var myid=$('#proid').val();
			var chat=event.data.split('|');		// 아이디 + 이름 + 사진 + 메세지 + 시간 
			
			if(chat[1]==null){
				var chat=event.data.split('+');
				console.log(chat[1]);
				$('.chatarea').append(
					'<li>'+
						'<p class="ch_msg">'+chat[0]+'</p>'+
					'</li>'
				);
				$('.ch_user').append(
					'<li>'+
						'<a class="pf_picture" href="" target="_blank">'+
							'<img src="${upload}/'+chat[3]+'" alt="'+chat[2]+'님의 프로필 썸네일" onload="squareTrim($(this), 30)">'+
						'</a>'+
						'<a class="pf_name" href="" target="_blank">'+chat[2]+'('+chat[1]+')</a>'+
					'</li>'
				);
			}else{
				var chatid=chat[0];
				if(myid==chatid){
					$('.chatarea').append(
						'<li>'+
							'<div class="ch_msg me">'+
							'<p>'+ chat[3] +
							'<span>'+chat[4]+'</span>'+
							'</p>'+
							'</div>'+
						'</li>'
					);
				}else{
					$('.chatarea').append(
						'<li>'+
							'<div class="ch_msg ots">'+
								'<ul class="ch_user">'+
									'<li>'+
										'<a class="pf_picture" href="" target="_blank">'+
											'<img src="${upload }/'+chat[2]+'" alt="'+chat[1]+'님의 프로필 썸네일" onload="squareTrim($(this), 30)">'+
										'</a>'+
										'<a class="pf_name" href="" target="_blank">'+chat[1]+'('+chat[0]+')</a>'+
									'</li>'+
								'</ul>'+
								'<p>'+chat[3]+'<span>'+chat[4]+'</span></p>'+
							'</div>'+
						'</li>'
					);
				}
			}
		}
		ws.onclose=function(event){
			console.log('closed');
			setTimeout(function(){connect();}, 1000);
		}
		ws.onerror=function(err){
			console.log('error:', err)
		}
	}
</script>
</head>
<body>
	<div id="wrap" class="chat_wrap">
		<h1 class="snd_only">FESTA</h1>
		<h2 class="snd_only">${detail.grname } 그룹 단체 채팅</h2>
		<input type="hidden" id="grnum" value="${detail.grnum }" />
		<input type="hidden" id="pronum" value="${login.pronum }" />
		<section class="title_area">
			<ul class="chat_info box">
				<li class="pf_picture"><img src="${upload }/${detail.grphoto }"
					alt="${detail.grname }  그룹 썸네일" onload="squareTrim($(this), 30)"></li>
				<li class="ch_gpname">${detail.grname } </li>
				<li><span class="gp_official"></span></li>
			</ul>
		</section>
		
		<section class="talk_area">
			<div class="chat_content box">
				<div class="scrBar">
					<ul class="chatarea">
					</ul>
				</div>
			</div>
			<form class="message_form">
				<input type="hidden" id="proid" value="${login.proid }" />
				<a class="pf_picture" href="" target="_blank"> 
					<img src="${upload }/${login.prophoto }" alt="나의 프로필 썸네일" onload="squareTrim($(this), 30)"> 
				</a>
				<p class="msg_input">
					<textarea id="chstmsg" name="" placeholder="메세지를 입력해주세요"></textarea>
					<button type="button" class="btn_send">
						<em class="snd_only">전송</em>
					</button>
				</p>
			</form>
		</section>
		<section class="users_area">
			<div class="chat_user box">
				<p class="ch_number">현재 접속자 (999명)</p>
				<div class="scrBar">
					<ul class="ch_user">
					</ul>
				</div>
			</div>
		</section>
		<p class="pf_label"></p>
	</div>

	<script type="text/javascript">
		userInform();
		//shortMessage();
	</script>
</body>
</html>