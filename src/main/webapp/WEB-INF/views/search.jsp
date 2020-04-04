<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:url value="/" var="root"></c:url>
<c:url value="/resources/upload" var="upload"></c:url>
<c:if test="${sessionScope.login ne null }">
	<c:if test="${sessionScope.login.proid eq 'admin@festa.com' }">
		<c:redirect url="/empty"/>
	</c:if>
</c:if>
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
			/* 
			//첫화면때 2개만 피드출력
			$('.feed_list li').each(function(index){
				if(index>1){
					$('.feed_list li').eq(index).hide();
				}
			}); 
			 */
			
			//스크롤 내렸을때 피드 2개씩 출력
			$(window).scroll(function(){
			    var scrolltop = parseInt ( $(window).scrollTop() );
			    if( scrolltop >= $(document).height() - $(window).height() - 0.5 ){
					var scrollTag=$('#footer').siblings('span');
					var scroll=scrollTag.text();
					var keyword = $('.search_box>input').val();
					scroll++;
					scrollTag.text(scroll);
					console.log(scroll);
					$.get('${root}search/','keyword='+keyword+'&page5='+scroll,function(){
						
					}).done(function(html){
						$('#wrap').replaceWith(html);
					});
			    }
			});
			
			//그룹 비동기페이지네이션
			//첫화면 로딩시 백에서 가져온 페이징값저장
			var totalCount1='${paging.totalCount}';
			//첫화면시 페이징기능 호출,페이지뷰,로우뷰 출력
			paging(page,totalCount1);
			pageView(pageText);
			rowView();
			
			//페이지버튼 눌렀을때 이벤트
			$(document).on('click','.fstPage a',function(e){
				pageText=$(this).text();
				//다음버튼 눌렀을경우
				if(pageText=='다음 페이지'){
					if(page==totalPage){
						return false;						
					}else{
						page+=1;
					}
				//이전버튼 눌렀을경우
				}else if(pageText=='이전 페이지'){
					if(page==1){
						return false;						
					}else{
						page-=1;
					}
				//맨끝버튼 눌렀을경우
				}else if(pageText=='맨 끝으로'){
					if(totalPage==endPage){
						page=endPage;
					}else if(totalPage!=endPage){
						page=endPage+1;
					}
				//맨앞버튼 눌렀을경우
				}else if(pageText=='맨 앞으로'){
					if(beginPage==1){
						page=beginPage;
					}else if(beginPage!=1){
						page=beginPage-1;
					}
				//그외 숫자버튼 눌렀을경우
				}else{
					page=Number(pageText);
				}
				paging(page,totalCount1);
				pageView(pageText);
				rowView();
				e.preventDefault();
			});
			
		});
		
		//페이징에 필요한 필드선언
		var pageText=1;
		var page=1;
		var displayRow3=6;	
		var beginPage;		
		var endPage;		
		var prev;				
		var next;	
		var totalPage;
		var startnum;		
		var endnum;			
		var displayPage=6;
		var totalCount;
		
		//페이징함수 
		function paging(page,totalCount1){
			totalCount=totalCount1;		
			startnum=(page-1)*6+1;
			endnum=page*6;
			
			totalPage=Math.floor(totalCount/displayRow3);
			
			if(totalCount%displayRow3!=0){
				totalPage+=1;
			}
			
			endPage = Math.floor((page+(displayPage-1))/displayPage)*displayPage;
			beginPage = endPage - (displayPage-1);
			
			if(totalPage<endPage&&totalPage==page){
				endPage=totalPage;
				next=false;
			}else if(totalPage<endPage&&totalPage>page) {
				endPage=totalPage;
				next=true;
			}else if(totalPage==endPage&&totalPage==page){
				next=false;
			}else {
				next=true;
			}
			if(beginPage==1){
				prev=false;
			}else{
				prev=true;
			}
		}
		
		//페이지뷰 함수
		function pageView(pageText){
			if(totalCount!=0){
				if(page==1){
					$('.fstPage ul').html('<li><a class="pg_start off"><em class="snd_only">맨 앞으로</em></a></li>'+
					'<li><a class="pg_prev off"><em class="snd_only">이전 페이지</em></a></li>');
				}else{
					$('.fstPage ul').html('<li><a class="pg_start" href=""><em class="snd_only">맨 앞으로</em></a></li>'+
					'<li><a class="pg_prev" href=""><em class="snd_only">이전 페이지</em></a></li>');
				}
				for(var i=beginPage; i<=endPage; i++){
					if(i==page){
						$('.fstPage ul').append('<li><b>'+i+'</b></li>');
					}else{
						$('.fstPage ul').append('<li><a href="">'+i+'</a></li>');
					}
				}
				if(next==true){
					$('.fstPage ul').append('<li><a class="pg_next" href=""><em class="snd_only">다음 페이지</em></a></li>'+
					'<li><a class="pg_end" href=""><em class="snd_only">맨 끝으로</em></a></li>');
				}else{
					$('.fstPage ul').append('<li><a class="pg_next off"><em class="snd_only">다음 페이지</em></a></li>'+
					'<li><a class="pg_end off"><em class="snd_only">맨 끝으로</em></a></li>');
				}
			}
		}

		//로우뷰 함수
		function rowView(){
			$('.group_list li').hide();
			for(var i=startnum; i<=endnum; i++){
				$('.group_list li').eq(i-1).show();
			}
		}
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
						<input type="text" name="keyword" value="${paging.keyword }" placeholder="캠핑장 또는 그룹을 검색해보세요!" required="required">
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
							<li><a href="${root}user/?pronum=${login.pronum}">마이페이지</a></li>
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
                                    <c:choose>
                                       <c:when test="${joinGroup.group.grphoto eq null }">
                                          <li><a
                                             href="${root }group/?grnum=${joinGroup.grnum}&pronum=${login.pronum}">
                                                <span><img src="${root }resources/upload/thumb/no_profile.png"
                                                   alt="${joinGroup.group.grname } 그룹 썸네일"></span> <b>${joinGroup.group.grname }</b>
                                          </a></li>
                                       </c:when>
                                       <c:otherwise>
                                          <li><a
                                             href="${root }group/?grnum=${joinGroup.grnum}&pronum=${login.pronum}">
                                                <span><img src="${upload }/${joinGroup.group.grphoto}"
                                                   alt="${joinGroup.group.grname } 그룹 썸네일"></span> <b>${joinGroup.group.grname }</b>
                                          </a></li>
                                       </c:otherwise>
                                    </c:choose>
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
	<!-- #캠핑정보 (리스트) -->
	<!-- 서브페이지 시작 { -->
	<div id="container" class="search_wrap">
		<!-- 컨텐츠영역 시작 { -->
		<section class="title_area container">
			<h2 class="comm_tit"><b>${paging.keyword }</b>(으)로 검색한 결과입니다.</h2>
		</section>
		<section class="camp_area">
			<div class="container">
				<h3 class="sub_tit">캠핑장</h3>
				<c:if test="${!empty searchCamp }">
				<div class="camp_slide">
					<div>
						<ul class="camp_list swiper-wrapper">
							<c:forEach items="${searchCamp }" var="searchCamp">
								<li class="swiper-slide">
									<a class="cp_thumb" href="${root }camp/detail?canum=${searchCamp.canum}">
									<c:set var="image" value="${fn:substringBefore(searchCamp.caphoto,',') }"/>
										<img src="${upload }/${image}" alt="${searchCamp.caname } 캠핑장 썸네일">
										<b class="cp_liked">${searchCamp.cagood }</b>
									</a>
									<a class="cp_text" href="${root }camp/detail?canum=${searchCamp.canum}">
										<b class="cp_name">${searchCamp.caname }</b>
										<span>
											<b class="cp_loc">${searchCamp.caaddrsel }</b>
											<c:choose>
												<c:when
													test="${empty searchCamp.httitle1 && empty searchCamp.httitle2 && empty searchCamp.httitle3}">
												</c:when>
												<c:when
													test="${empty searchCamp.httitle1 && empty searchCamp.httitle2}">
													#${searchCamp.httitle3}
												</c:when>
												<c:when
													test="${empty searchCamp.httitle2 && empty searchCamp.httitle3}">
													#${searchCamp.httitle1}
												</c:when>
												<c:when
													test="${empty searchCamp.httitle1 && empty searchCamp.httitle3}">
													#${searchCamp.httitle2}
												</c:when>
												<c:when test="${empty searchCamp.httitle1}">
													#${searchCamp.httitle2}
													#${searchCamp.httitle3}
												</c:when>
												<c:when test="${empty searchCamp.httitle2}">
													#${searchCamp.httitle1}
													#${searchCamp.httitle3}
												</c:when>
												<c:when test="${empty searchCamp.httitle3}">
													#${searchCamp.httitle1}
													#${searchCamp.httitle2}
												</c:when>
												<c:otherwise>
													#${searchCamp.httitle1}
													#${searchCamp.httitle2}
													#${searchCamp.httitle3}
												</c:otherwise>
											</c:choose>
										</span>
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>
					<button type="button" class="swiper-prev"><em class="snd_only">이전</em></button>
					<button type="button" class="swiper-next"><em class="snd_only">다음</em></button>
				</div>
				</c:if>
				<c:if test="${empty searchCamp }">
					<p class="fstEmpty"><i class="xi-error-o"></i>검색한 결과가 없습니다.</p>
				</c:if>
			</div>
		</section>
		<section class="group_area">
			<div class="container">
				<h3 class="sub_tit">그룹</h3>
				<c:if test="${!empty searchGroup }">
					<ul class="group_list">
						<c:forEach items="${searchGroup }" var="searchGroup">
							<li>
								<c:if test="${login ne null }">
									<a class="gp_thumb" href="${root }group/?grnum=${searchGroup.grnum}&pronum=${login.pronum}">
										<img src="${upload }/${searchGroup.grphoto}" alt="${searchGroup.grname } 그룹 썸네일">
									</a>
									<a class="gp_text" href="${root }group/?grnum=${searchGroup.grnum}&pronum=${login.pronum}">
										<strong>${searchGroup.grname }</strong>
										<span>${searchGroup.grintro }</span>
										<b>${searchGroup.graddr }</b>
									</a>
								</c:if>
								<c:if test="${login eq null }">
									<a class="gp_thumb" href="${root }group/?grnum=${searchGroup.grnum}">
										<img src="${upload }/${searchGroup.grphoto}" alt="${searchGroup.grname } 그룹 썸네일">
									</a>
									<a class="gp_text" href="${root }group/?grnum=${searchGroup.grnum}">
										<strong>${searchGroup.grname }</strong>
										<span>${searchGroup.grintro }</span>
										<b>${searchGroup.graddr }</b>
									</a>
								</c:if>
							</li>
						</c:forEach>
					</ul>
				</c:if>
				<c:if test="${empty searchGroup }">
					<p class="fstEmpty"><i class="xi-error-o"></i>검색한 결과가 없습니다.</p>
				</c:if>
				<div class="fstPage">
					<ul>
					
					</ul>
				</div>
			</div>
		</section>
		<section class="feed_area">
			<div class="container">
				<h3 class="sub_tit">피드</h3>
				<ul class="feed_list">
				<c:if test="${!empty searchFeed }">
					<c:forEach items="${searchFeed }" var="searchFeed">
						<c:choose>
							<c:when test="${searchFeed.gpnum eq 0 }">
								<li>
									<a class="text box btn_pop" href="${root }search/feed?mpnum=${searchFeed.mpnum}">
										<c:choose>
												<c:when
													test="${empty searchFeed.httitle1 && empty searchFeed.httitle2 && empty searchFeed.httitle3}">
												</c:when>
												<c:when
													test="${empty searchFeed.httitle1 && empty searchFeed.httitle2}">
													<span class="fd_hashtag">${searchFeed.httitle3}</span>
												</c:when>
												<c:when
													test="${empty searchFeed.httitle2 && empty searchFeed.httitle3}">
													<span class="fd_hashtag">${searchFeed.httitle1}</span>
												</c:when>
												<c:when
													test="${empty searchFeed.httitle1 && empty searchFeed.httitle3}">
													<span class="fd_hashtag">${searchFeed.httitle2}</span>
												</c:when>
												<c:when test="${empty searchFeed.httitle1}">
													<span class="fd_hashtag">${searchFeed.httitle2}&nbsp;#${searchFeed.httitle3}</span>
												</c:when>
												<c:when test="${empty searchFeed.httitle2}">
													<span class="fd_hashtag">${searchFeed.httitle1}&nbsp;#${searchFeed.httitle3}</span>
												</c:when>
												<c:when test="${empty searchFeed.httitle3}">
													<span class="fd_hashtag">${searchFeed.httitle1}&nbsp;#${searchFeed.httitle2}</span>
												</c:when>
												<c:otherwise>
													<span class="fd_hashtag">${searchFeed.httitle1}&nbsp;#${searchFeed.httitle2}&nbsp;#${searchFeed.httitle3}</span>
												</c:otherwise>
											</c:choose>
										<span class="fd_content">${searchFeed.mpcontent }</span>
									</a>
									<c:if test="${searchFeed.mpphoto ne '' }">
										<a class="thumb box btn_pop" href="${root }search/feed?mpnum=${searchFeed.mpnum}">
										 <c:set var="mpphoto" value="${fn:substringBefore(searchFeed.mpphoto,',') }"/>
											<span class="fd_thumb"><img src="${upload }/${mpphoto}" alt="피드 썸네일"></span>
										</a>
									</c:if>
									<p class="info box btn_pop">
										<a class="pf_picture" href="${root }user/?pronum=${searchFeed.pronum}">
											<img src="${upload }/${searchFeed.profile.prophoto}" alt="피드 썸네일" onload="squareTrim($(this), 30)">
										</a>
										<a class="fd_name" href="${root }user/?pronum=${searchFeed.pronum}">${searchFeed.profile.proname }</a>
										<span class="fd_liked">${searchFeed.good }</span>
										<span class="fd_comment">${searchFeed.mptotal }</span>
										<span class="fd_date">${searchFeed.date1 }</span>
									</p>
								</li>
							</c:when>
							<c:otherwise>
								<li>
									<a class="text box btn_pop" href="${root }search/feed?gpnum=${searchFeed.gpnum}">
										<c:choose>
												<c:when
													test="${empty searchFeed.httitle1 && empty searchFeed.httitle2 && empty searchFeed.httitle3}">
												</c:when>
												<c:when
													test="${empty searchFeed.httitle1 && empty searchFeed.httitle2}">
													<span class="fd_hashtag">${searchFeed.httitle3}</span>
												</c:when>
												<c:when
													test="${empty searchFeed.httitle2 && empty searchFeed.httitle3}">
													<span class="fd_hashtag">${searchFeed.httitle1}</span>
												</c:when>
												<c:when
													test="${empty searchFeed.httitle1 && empty searchFeed.httitle3}">
													<span class="fd_hashtag">${searchFeed.httitle2}</span>
												</c:when>
												<c:when test="${empty searchFeed.httitle1}">
													<span class="fd_hashtag">${searchFeed.httitle2}&nbsp;#${searchFeed.httitle3}</span>
												</c:when>
												<c:when test="${empty searchFeed.httitle2}">
													<span class="fd_hashtag">${searchFeed.httitle1}&nbsp;#${searchFeed.httitle3}</span>
												</c:when>
												<c:when test="${empty searchFeed.httitle3}">
													<span class="fd_hashtag">${searchFeed.httitle1}&nbsp;#${searchFeed.httitle2}</span>
												</c:when>
												<c:otherwise>
													<span class="fd_hashtag">${searchFeed.httitle1}&nbsp;#${searchFeed.httitle2}&nbsp;#${searchFeed.httitle3}</span>
												</c:otherwise>
											</c:choose>
										<span class="fd_content">${searchFeed.gpcontent }</span>
									</a>
									<c:if test="${searchFeed.gpphoto ne '' }">
										<a class="thumb box btn_pop" href="${root }search/feed?gpnum=${searchFeed.gpnum}">
										 <c:set var="gpphoto" value="${fn:substringBefore(searchFeed.gpphoto,',') }"/>
											<span class="fd_thumb"><img src="${upload }/${gpphoto}" alt="피드 썸네일"></span>
										</a>
									</c:if>
									<p class="info box btn_pop">
										<a class="pf_picture" href="${root }user/?pronum=${searchFeed.pronum}">
											<img src="${upload }/${searchFeed.profile.prophoto}" alt="피드 썸네일" onload="squareTrim($(this), 30)">
										</a>
										<a class="fd_name" href="${root }user/?pronum=${searchFeed.pronum}">${searchFeed.profile.proname }</a>
										<span class="fd_liked">${searchFeed.good }</span>
										<c:if test="${login ne null }">
											<a class="fd_group" href="${root }group/?grnum=${searchFeed.grnum}&pronum=${login.pronum}">${searchFeed.group.grname }</a>
										</c:if>
										<c:if test="${login eq null }">
											<a class="fd_group" href="${root }group/?grnum=${searchFeed.grnum}">${searchFeed.group.grname }</a>
										</c:if>
										<span class="fd_comment">${searchFeed.gptotal }</span>
										<span class="fd_date">${searchFeed.date1 }</span>
									</p>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:if>
				<c:if test="${empty searchFeed }">
					<p class="fstEmpty"><i class="xi-error-o"></i>검색한 결과가 없습니다.</p>
				</c:if>
				</ul>
			</div>
		</section>
		<!-- } 컨텐츠영역 끝 -->
	</div>
	<span class="snd_only">${paging.page5-1 }</span>
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
	campSlider();
	feedType('feed_list li');
</script>
</body>
</html>