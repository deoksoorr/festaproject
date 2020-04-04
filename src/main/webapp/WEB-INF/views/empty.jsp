<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:url value="/" var="root"></c:url>
<c:url value="/resources/upload" var="upload"></c:url>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta property="og:image" content="${root }resources/images/ico/logo.png">
	<script type="text/javascript" src="${root }resources/js/jquery-1.12.4.js"></script>
	<script type="text/javascript" src="${root }resources/js/util.js"></script>
	<script type="text/javascript" src="${root }resources/js/site.js"></script>
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
	<link rel="stylesheet" href="${root }resources/css/site.css">
	<link rel="shortcut icon" href="${root }resources/favicon.ico">
	<title>FESTA</title>
	<script type="text/javascript">
		$(document).ready(function(){
			$('#gnb li a').eq(2).on('click',function(e){
				var loginCheck = '${login.logincheck}';
				if(loginCheck==''){
					openLayer(e,'${root}member/login');
					return false;
				}
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
					<c:choose>
						<c:when test="${login.proid eq 'admin@festa.com' }">
							<a href="${root }admin/"><em class="snd_only">FESTA</em></a>
						</c:when>
						<c:otherwise>
							<a href="${root }"><em class="snd_only">FESTA</em></a>
						</c:otherwise>
					</c:choose>
				</h1>
				<c:if test="${login.proid ne 'admin@festa.com' }">
					<form class="search_box" action="${root }search/">
						<input type="text" name="keyword" placeholder="캠핑장 또는 그룹을 검색해보세요!" required="required">
						<button type="submit"><img src="${root }resources/images/ico/btn_search.png" alt="검색"></button>
					</form>
					</c:if>
				<ul id="gnb">
				<c:if test="${login.proid ne 'admin@festa.com' }">
					<li><a href="${root }camp/">캠핑정보</a></li>
					<li><a href="${root }hot/">인기피드</a></li>
					<li><a href="${root }news/">뉴스피드</a></li>
				</c:if>
					<c:if test="${login eq null }">
						<li><a href="${root }member/login" class="btn_pop">로그인</a></li>
					</c:if>
					<c:if test="${login ne null }">
						<c:if test="${login.proid ne 'admin@festa.com' }">
							<li><a href="${root}user/">마이페이지</a></li>
						</c:if>
						<c:if test="${login.proid eq 'admin@festa.com' }">
							<li><a href="${root}admin/">관리자</a></li>
							<li><a href="${root }member/logout" class="btn_pop">로그아웃</a></li>
						</c:if>
					</c:if>
				</ul>
					<c:if test="${login ne null and login.proid ne 'admin@festa.com' }">
						<div id="userMenu" class="fstLyr">
							<button class="btn_menu">
								<em class="snd_only">나의 메뉴 더보기</em>
							</button>
							<dl class="menu_box" tabindex="0">
								<dt>
									<b>${login.proname }님 환영합니다.</b>
								</dt>
								<dd>
		                           <span class="btn_mylist">나의 그룹</span>
		                           <div class="my_list">
		                              <ul>
		                                 <c:forEach items="${joinGroup }" var="joinGroup">
		                                    <li><a
		                                       href="${root }group/?grnum=${joinGroup.grnum}&pronum=${login.pronum}">
		                                          <span><img src="${upload }/${joinGroup.group.grphoto}"
		                                             alt="${joinGroup.group.grname } 그룹 썸네일"></span> <b>${joinGroup.group.grname }</b>
		                                    </a></li>
		                                 </c:forEach>
		                              </ul>
		                           </div>
		                        </dd>
		                        <dd>
		                           <span class="btn_mylist">나의 채팅</span>
		                           <div class="my_list">
		                              <ul>
		                                 <c:forEach items="${joinGroup }" var="joinGroup">
		                                    <li><a href=""> <span><img
		                                             src="${upload }/${joinGroup.group.grphoto}" alt="${joinGroup.group.grname } 그룹 썸네일"></span>
		                                          <b>${joinGroup.group.grname }</b>
		                                    </a></li>
		                                 </c:forEach>
		                              </ul>
		                           </div>
		                        </dd>
		                        <dd>
		                           <span class="btn_mylist">나의 캠핑장</span>
		                           <div class="my_list">
		                              <ul>
		                                 <c:forEach items="${bookMark }" var="bookMark">
		                                 <c:set var="image" value="${fn:substringBefore(bookMark.camp.caphoto,',') }"/>
		                                    <li><a href="${root }camp/detail?canum=${bookMark.camp.canum}">
		                                          <span><img src="${upload }/${image}"
		                                             alt="${bookMark.camp.caname } 캠핑장 썸네일"></span> <b>${bookMark.camp.caname }</b>
		                                    </a></li>
		                                 </c:forEach>
		                              </ul>
		                           </div>
		                        </dd>
								<dd class="btn_logout">
									<form>
										<a href="${root}member/logout" class="btn_pop">로그아웃</a>
									</form>
								</dd>
							</dl>
						</div>
					</c:if>
				<button type="button" id="btnTop"><em class="snd_only">맨 위로</em></button>
			</div>
		</div>
	</div>
	<!-- # -->
	<!-- 서브페이지 시작 { -->
	<div id="container" class="offer_wrap">
		<div class="container">
			<h2><span>안내</span></h2>
			<div class="info_box">
				<p><b>요청하신 페이지를 찾을 수 없습니다.</b></p>
			</div>
			<p class="comm_buttons">
				<button class="btn_back comm_btn cfm" onclick="history.back();">뒤로 돌아가기</button>
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
					<span>경기도 성남시 분당구 느티로 2, AK와이즈플레이스</span>
					<span>김채찍과노예들</span>
					<span>사업자등록번호 : 123-45-67890</span>
				</p>
				<p>
					<span>통신판매신고번호 : 제 2020-서울강남-0000</span>
					<span>대표번호 : 010-3332-8616</span>
					<span>담당자 : 김덕수</span>
					<span>문의 : 010-3332-8616</span>
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
</html>
