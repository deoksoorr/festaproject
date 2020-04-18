<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/" var="root" />
<c:url value="/resources/upload" var="upload" />
<!DOCTYPE html>
<html lang="ko">
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
function btn_close(){
    document.cookie = 'loginCookie' + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT;path=/';
    var url = window.location.href;
	if(url.indexOf('group')>0||url.indexOf('news')>0||url.indexOf('user')>0||url.indexOf('admin')>0||url.indexOf('empty')>0){
		window.location.href='${root}';
	}
}
	$(document).ready(function(){
		var cookie = '${cookie.loginCookie.value}';
		var login = '${login ne null}';

		if(cookie!=''&&login=='false'){
			openPop('loginCookie',none,btn_close);
		}

		$('#btnCookie').on('click',function(){
			$.post('${root}member/loginCookie','id='+cookie,function(data){
				if (data.prorn == '0') {
					location.reload();
				} else if (data.prorn == '1') {
					location.href = "${root}member/stop";
				} else if (data.prorn == '2') {
					location.href = "${root}member/kick";
				} else if (data.prorn == '3') {
					location.reload();
				} else if (data.prorn == '4') {
					location.href = "${root}";
				}
			});
		});
	      
	      $('.btn_logout').on('click',function(){
	    	 location.href="${root}"; 
	      });
	});
</script>
</head>
<body>
	<div id="wrap">
		<div id="header">
			<div class="scrX">
				<div class="container">
					<h1>
						<a href="${root }"><em class="snd_only">FESTA</em></a>
					</h1>
					<form class="search_box">
						<input type="text" placeholder="캠핑장 또는 그룹을 검색해보세요!" required="required">
						<button type="submit">
							<img src="${root }resources/images/ico/btn_search.png" alt="검색">
						</button>
					</form>
					<ul id="gnb">
						<li><a href="${root }camp/">캠핑정보</a></li>
						<li><a href="${root }hot/">인기피드</a></li>
						<li><a href="${root}news/?pronum=${login.pronum}">뉴스피드</a></li>
						<li><a href="${root }member/login" class="btn_pop">로그인</a></li>
					</ul>
					<button type="button" id="btnTop">
						<em class="snd_only">맨 위로</em>
					</button>
				</div>
			</div>
		</div>
		<!-- # -->
		<!-- 서브페이지 시작 { -->
		<div id="container" class="offer_wrap">
			<div class="container">
				<h2>
					<span>서비스 이용제한 안내</span>
				</h2>
				<p>해당 계정은 아래와 같은 이유로 페스타를 이용할 수 없습니다.</p>
				<div class="info_box">
					<p>
						${kick.stopresult }
					</p>
				</div>
				<p class="comm_buttons">
					<button class="btn_logout comm_btn cfm">메인으로 돌아가기</button>
				</p>
			</div>
		</div>
		<!-- } 서브페이지 -->
		<div id="footer">
			<div class="container">
				<div class="img_box">
					<img src="${root }resources/images/ico/logo_w.png" alt="FESTA">
				</div>
				<div class="text_box">
					<p>
						<span>경기도 성남시 분당구 느티로 2, AK와이즈플레이스</span> <span>김채찍과노예들</span> <span>사업자등록번호
							: 123-45-67890</span>
					</p>
					<p>
						<span>통신판매신고번호 : 제 2020-서울강남-0000</span> <span>대표번호 :
							010-3332-8616</span> <span>담당자 : 김덕수</span> <span>문의 :
							010-3332-8616</span>
					</p>
					<p>&copy; DEOKSOORR. All RIGHTS RESERVED.</p>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
	feedType('feed_viewer');
	fileThumbnail();
</script>
</body>
<!-- #팝업 처리완료 { -->
<div id="loginCookie" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">기존 정보로 로그인 하시겠습니까?</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close btnCookieClose comm_btn cnc">로그아웃</button></li>
			<li><button type="button" id="btnCookie" class="ok comm_btn cfm">로그인</button></li>
		</ul>
	</div>
</div>
</html>