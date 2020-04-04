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
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="${root }resources/css/site.css">
<link rel="shortcut icon" href="${root }resources/favicon.ico">
<title>FESTA</title>
<script type="text/javascript">
	$(document).ready(function(){
		var grnum=$('#grnum').val();
		var pronum=$('#pronum').val();
		var ws = new WebSocket('ws://localhost:8080/replyEcho');

		ws.onopen = function () {
		    console.log('Info: connection opened.');
		    setTimeout( function(){ connect(); }, 1000); // retry connection!!
		
		    ws.onmessage = function (event) {
			    console.log('ReceiveMessage:', event.data+'\n');
			};
		};


		ws.onclose = function (event) {
			console.log('Info: connection closed.');
		};
		
		ws.onerror = function(err) {
			console.log(err);
		};

		$('.btnSend').on('click', function(evt) {
			evt.preventDefault();
			if (socket.readyState !== 1) return;
				  let msg = $('input#msg').val();
				  ws.send(msg);
		});
	});

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
					alt="${detail.grname }  그룹 썸네일"></li>
				<li class="ch_gpname">${detail.grname } </li>
				<li><span class="gp_official"></span></li>
			</ul>
		</section>
		<section class="talk_area">
			<div class="chat_content box">
				<div class="scrBar">
					<div class="ch_msg ots">
						<ul class="ch_user">
							<li><a class="pf_picture" href="" target="_blank"> <img
									src="http://placehold.it/24x24" alt="김덕수님의 프로필 썸네일">
							</a> <a class="pf_name" href="" target="_blank">김덕수(user01@email.com)</a>
							</li>
						</ul>
						<p>
							손흥민 대단합니다 ㅠㅠㅠㅠ대한민국의 자랑!! <span>23:50</span>
						</p>
					</div>
					<p class="ch_msg">김덕수(dsx2____@nate.com) 님이 퇴장하셨습니다.</p>
					<div class="ch_msg me">
						<p>
							손흥민 대단합니다 ㅠㅠㅠㅠ대한민국의 자랑!! 손흥민 대단합니다 ㅠㅠㅠㅠ대한민국의 자랑!! 손흥민 대단합니다
							ㅠㅠㅠㅠ대한민국의 자랑!! 손흥민 대단합니다 ㅠㅠㅠㅠ대한민국의 자랑!! 손흥민 대단합니다 ㅠㅠㅠㅠ대한민국의 자랑!!
							손흥민 대단합니다 ㅠㅠㅠㅠ대한민국의 자랑!! <span>23:50</span>
						</p>
					</div>
				</div>
			</div>
			<form class="message_form">
				<a class="pf_picture" href="" target="_blank"> <img
					src="http://placehold.it/30x30" alt="나의 프로필 썸네일">
				</a>
				<p class="msg_input">
					<textarea id="" name="" placeholder="메세지를 입력해주세요"></textarea>
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
						<li><a class="pf_picture" href="" target="_blank"> <img
								src="http://placehold.it/24x24" alt="김덕수님의 프로필 썸네일">
						</a> <a class="pf_name" href="" target="_blank">김덕수(user01@email.com)</a>
						</li>
						<li><a class="pf_picture" href="" target="_blank"> <img
								src="http://placehold.it/24x24" alt="김덕수님의 프로필 썸네일">
						</a> <a class="pf_name" href="" target="_blank">조혜진(m7412@email.com)</a>
						</li>
						<li><a class="pf_picture" href="" target="_blank"> <img
								src="http://placehold.it/24x24" alt="김덕수님의 프로필 썸네일">
						</a> <a class="pf_name" href="" target="_blank">김덕수(user01@email.com)</a>
						</li>
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