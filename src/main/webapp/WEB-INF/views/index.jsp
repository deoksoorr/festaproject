<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:url value="/" var="root"></c:url>
<c:url value="/resources/upload" var="upload"></c:url>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta property="og:image" content="resources/images/ico/logo.png">
<script type="text/javascript" src="resources/js/jquery-1.12.4.js"></script>
<script type="text/javascript" src="resources/js/util.js"></script>
<script type="text/javascript" src="resources/js/site.js"></script>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="resources/css/site.css">
<link rel="shortcut icon" href="resources/favicon.ico">
<title>FESTA</title>
</head>
<body>
<c:if test="${sessionScope.login ne null }">
	<c:if test="${sessionScope.login.proid eq 'admin@festa.com' }">
		<c:redirect url="/empty"/>
	</c:if>
</c:if>
<!-- 그룹 -->
	<div id="wrap">
		<div id="header">
			<div class="scrX">
				<div class="container">
					<h1>
						<a href="${root }"><em class="snd_only">FESTA</em></a>
					</h1>
					<form class="search_box" action="${root }search/">
						<input type="text" name="keyword" placeholder="캠핑장 또는 그룹을 검색해보세요!" required="required">
						<button type="submit">
							<img src="${root }resources/images/ico/btn_search.png" alt="검색">
						</button>
					</form>
					<ul id="gnb">
						<li><a href="${root}camp/">캠핑정보</a></li>
						<li><a href="${root}hot/">인기피드</a></li>
						<li><a href="${root}news/">뉴스피드</a></li>
						<c:if test="${login eq null }">
							<li><a href="${root}member/login" class="btn_pop">로그인</a></li>
						</c:if>
						<c:if test="${login ne null }">
							<li><a href="${root}user/">마이페이지</a></li>
						</c:if>
					</ul>
					<c:if test="${login ne null }">
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
					<button type="button" id="btnTop">
						<em class="snd_only">맨 위로</em>
					</button>
				</div>
			</div>
		</div>
		<div id="main">
			<section class="visual_area">
				<div class="container">
					<div>
						<div class="text_box">
							<img src="resources/images/main/bg_copy.png"
								alt="솔직한 리뷰, 믿을 수 있는 캠핑! FESTA">
						</div>
						<form class="search_box" action="${root }search/">
							<input type="text" name="keyword" placeholder="캠핑장 또는 그룹" required="required">
							<button type="submit">검색</button>
						</form>
					</div>
				</div>
			</section>
			<section class="group_area">
				<div class="container">
					<h2 class="main_tit">
						<em class="snd_only">추천 그룹</em>이런 그룹은 어때요?
					</h2>
					<ul class="group_list">
						<c:forEach items="${grouplist }" var="grouplist">
							<c:if test="${login ne null }">
								<li><a class="gp_thumb" href="${root }group/?grnum=${grouplist.grnum}&pronum=${login.pronum}"> 
								<img src="${upload }/${grouplist.grphoto}" alt="${grouplist.grname } 그룹 썸네일">
								</a> <a class="gp_text" href="${root }group/?grnum=${grouplist.grnum}&pronum=${login.pronum}"> <strong>${grouplist.grname }</strong> <span>${grouplist.grintro }</span>
								</a></li>
							</c:if>
							<c:if test="${login eq null }">
								<li><a class="gp_thumb" href="${root }group/?grnum=${grouplist.grnum}"> 
								<img src="${upload }/${grouplist.grphoto}" alt="${grouplist.grname } 그룹 썸네일">
								</a> <a class="gp_text" href="${root }group/?grnum=${grouplist.grnum}"> <strong>${grouplist.grname }</strong> <span>${grouplist.grintro }</span>
								</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</section>
			<section class="camp_area">
				<div class="container">
					<h2 class="main_tit">
						<em class="snd_only">추천 캠핑장</em>믿고 가는 캠핑장 베스트
					</h2>
					<div class="slide_box">
						<div class="swiper-wrapper">
						<c:forEach items="${camplist }" var="camplist">
							<dl class="swiper-slide">
								<dt>
									 <c:set var="image" value="${fn:substringBefore(camplist.caphoto,',') }"/>
									<span><img src="${upload }/${image}"
										alt="${camplist.caname } 썸네일"></span>
								</dt>
								<dd>
									<a href="${root }camp/detail?canum=${camplist.canum}" class="txtbox"> <strong>${camplist.caname }</strong> <span>${camplist.caaddrsel }</span> 
									<b class="cp_liked">${camplist.cagood }</b>
									</a>
								</dd>
							</dl>
						</c:forEach>
						</div>
						<div class="swiper-pagination"></div>
					</div>
				</div>
			</section>
		</div>
		<div id="footer">
			<div class="container">
				<div class="img_box">
					<img src="resources/images/ico/logo_w.png" alt="FESTA">
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
		main();
	</script>
</body>
</html>