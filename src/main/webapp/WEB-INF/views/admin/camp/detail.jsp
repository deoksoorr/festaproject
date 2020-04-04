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
			
			//한줄평삭제버튼 눌렀을때
			$(document).on('click', '.btn_review', function() {
				var value = $(this).data('value');
				 $('#crnum').val(value);
				 console.log($('#crnum').val());
			});
			
			//삭제하기버튼 클릭시
			$(document).on('click', '#delete_btn', function() {
				var crnum = $('#crnum').val();
				$.post('${root}admin/camp/detail/revdel','crnum='+crnum,function(){
					$('#delete').find('.comm_buttons .btn_close').click();
					openPop('success');
					$('.btn_close.ok').click(function(){
						location.reload();
					});
				});
			});
			
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
		var displayRow2=5;	
		var beginPage;		
		var endPage;		
		var prev;				
		var next;	
		var totalPage;
		var startnum;		
		var endnum;			
		var displayPage=5;
		var totalCount;
		
		//페이징함수 
		function paging(page,totalCount1){
			totalCount=totalCount1;		
			startnum=(page-1)*5+1;
			endnum=page*5;
			
			totalPage=Math.floor(totalCount/displayRow2);
			
			if(totalCount%displayRow2!=0){
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
			$('.rate_list li').hide();
			for(var i=startnum; i<=endnum; i++){
				$('.rate_list li').eq(i-1).show();
			}
		}
	</script>
</head>
<body>
<c:if test="${sessionScope.login eq null}">
	<c:redirect url="/empty"/>
</c:if>
<c:if test="${sessionScope.login ne numm }">
	<c:if test="${sessionScope.login.proid ne 'admin@festa.com' }">
		<c:redirect url="/empty"/>
	</c:if>
</c:if>
<div id="wrap" class="adm">
	<section class="banner_area">
		<div class="container">
			<dl>
				<dt><span>관리자페이지 이용 시 주의사항</span></dt>
				<dd>회원 징계 시 다시 한번 확인하고 처리할 것 / 모든 삭제 기능 처리 시 신중하게 처리할 것</dd>
			</dl>
		</div>
	</section>
	<!-- #캠핑정보 (상세) -->
	<!-- 서브페이지 시작 { -->
	<div id="container" class="camp_wrap detail">
		<h2 class="snd_only">캠핑정보</h2>
		<!-- 컨텐츠영역 시작 { -->
		<section class="info_area">
			<div class="container">
				<div class="tit box">
					<div>
						<h3><span>${campdetail.caaddrsel }</span> ${campdetail.caname }</h3>
						<p class="cp_subtit">${campdetail.caintroone }</p>
						<ul class="cp_hashtag">
							<c:choose>
								<c:when
									test="${empty campdetail.httitle1 && empty campdetail.httitle2 && empty campdetail.httitle3}">
								</c:when>
								<c:when
									test="${empty campdetail.httitle1 && empty campdetail.httitle2}">
									<li><a href="">${campdetail.httitle3}</a></li>
								</c:when>
								<c:when
									test="${empty campdetail.httitle2 && empty campdetail.httitle3}">
									<li><a href="">${campdetail.httitle1}</a></li>
								</c:when>
								<c:when
									test="${empty campdetail.httitle1 && empty campdetail.httitle3}">
									<li><a href="">${campdetail.httitle2}</a></li>
								</c:when>
								<c:when test="${empty campdetail.httitle1}">
									<li><a href="">${campdetail.httitle2}</a></li>
									<li><a href="">${campdetail.httitle3}</a></li>
								</c:when>
								<c:when test="${empty campdetail.httitle2}">
									<li><a href="">${campdetail.httitle1}</a></li>
									<li><a href="">${campdetail.httitle3}</a></li>
								</c:when>
								<c:when test="${empty campdetail.httitle3}">
									<li><a href="">${campdetail.httitle1}</a></li>
									<li><a href="">${campdetail.httitle2}</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="">${campdetail.httitle1}</a></li>
									<li><a href="">${campdetail.httitle2}</a></li>
									<li><a href="">${campdetail.httitle3}</a></li>
								</c:otherwise>
							</c:choose>
						</ul>
						<ul class="cp_options">
							<li>
								<b class="cp_liked">${campdetail.cagood }</b>
								<button class="btn_liked act"><em class="snd_only">하트</em></button>
							</li>
							<%-- <li><button class="btn_pop btn_delete btn_camp" data-layer="delete" data-value="${campdetail.canum }"><em class="snd_only">삭제하기</em></button></li> --%>
						</ul>
						<ul class="cp_date">
							<li>정보 등록일 ${campdetail.cadate }</li>
							<li>최근 수정일 ${campdetail.cadateup }</li>
						</ul>
					</div>
				</div>
				<div class="intro box">
					<h4 class="snd_only">캠핑장 사진</h4>
					<c:if test="${campdetail.caphoto ne '' }">
						<div class="thumb_slide">
							<div class="swiper-wrapper">
								<c:set var="caphoto" value="${campdetail.caphoto }" />
								<c:forTokens items="${caphoto }" delims="," var="item">
									<div class="swiper-slide">
										<img src="${upload }/${item }" alt="">
									</div>
								</c:forTokens>
							</div>
							<div class="swiper-pagination"></div>
						</div>
					</c:if>
					<c:if test="${campdetail.caphoto eq '' }">
						<div class="thumb_slide">
							<div class="swiper-wrapper">
								<div class="swiper-slide">
									<img src="${root }resources/images/thumb/no_profile.png" alt="">
								</div>
							</div>
							<div class="swiper-pagination"></div>
						</div>
					</c:if>
					<div class="text_box">
						<h4 class="sub_tit">캠핑장 소개</h4>
						<c:if test="${venturecheck eq 1 }">
							<p class="btn_go"><a href="${root }admin/group/detail?grnum=${venturegroup.grnum}">그룹 바로가기</a></p>
						</c:if>
						<div class="scrBar">
							<pre class="fd_content"><c:out value="${campdetail.caintro }"/></pre>
						</div>
					</div>
				</div>
				<div class="info box">
					<h4 class="sub_tit">캠핑장 시설 안내</h4>
					<ol class="info_list">
					<c:choose>
						<c:when test="${campdetail.caguide1 eq '' and campdetail.caguide2 eq '' and campdetail.caguide3 eq '' and campdetail.caguide4 eq '' and campdetail.caguide5 eq '' and campdetail.caguide6 eq '' and campdetail.caguide7 eq '' }">
							<li class="fstEmpty">등록된 시설 안내 사항이 없습니다</li>
						</c:when>
						<c:otherwise>
							<c:if test="${!empty campdetail.caguide1 }"><li>${campdetail.caguide1 }</li></c:if>
							<c:if test="${!empty campdetail.caguide2 }"><li>${campdetail.caguide2 }</li></c:if>
							<c:if test="${!empty campdetail.caguide3 }"><li>${campdetail.caguide3 }</li></c:if>
							<c:if test="${!empty campdetail.caguide4 }"><li>${campdetail.caguide4 }</li></c:if>
							<c:if test="${!empty campdetail.caguide5 }"><li>${campdetail.caguide5 }</li></c:if>
							<c:if test="${!empty campdetail.caguide6 }"><li>${campdetail.caguide6 }</li></c:if>
							<c:if test="${!empty campdetail.caguide7 }"><li>${campdetail.caguide7 }</li></c:if>
						</c:otherwise>
					</c:choose>
					</ol>
				</div>
			</div>
		</section>
		<section class="location_area">
			<div class="container">
				<h4 class="sub_tit">오시는 길</h4>
				<p id="mapAddress">${campdetail.caaddr }&nbsp;${campdetail.caaddrsuv }</p>
				<div id="map"></div>
			</div>
		</section>
		<section class="rate_area">
			<div class="container">
				<h4 class="sub_tit">
					<p>한줄평 <span>${reviewcount }개</span></p>
					<p>평점 <span>${campdetail.caavg }점</span></p>
				</h4>
				<ul class="rate_list">
				<c:choose>
					<c:when test="${reviewcount ne 0 }">
						<c:forEach items="${campreview }" var="campreview">
							<li>
								<!-- # 프로필 이미지 없음 { -->
								<a class="pf_picture" href="${root }admin/user/detail?pronum=${campreview.pronum}">
									<c:set var="crphoto" value="${campreview.profile.prophoto }" />
									<img src="${upload }/${crphoto}" alt="${campreview.profile.proname }님의 프로필 썸네일">
								</a>
								<!-- } # 프로필 이미지 없음 -->
								<p class="rt_option">
									<button type="button" class="btn_pop btn_delete btn_review" data-layer="delete" data-value="${campreview.crnum }"><em class="snd_only">삭제하기</em></button>
								</p>
								<p class="rt_user">
									<a class="rt_name" href="${root }admin/user/detail?pronum=${campreview.pronum}">
										<b>${campreview.crauthor }</b>
									</a>
									<c:if test="${campreview.crgood eq 0.0 }">
										<span class="rt_star"><img src="${root }resources/images/ico/shp_star.png" alt="별 0개"></span>
									</c:if>
									<c:if test="${campreview.crgood eq 1.0 }">
										<span class="rt_star"><img src="${root }resources/images/ico/shp_star1.png" alt="별 1개"></span>
									</c:if>
									<c:if test="${campreview.crgood eq 2.0 }">
										<span class="rt_star"><img src="${root }resources/images/ico/shp_star2.png" alt="별 2개"></span>
									</c:if>
									<c:if test="${campreview.crgood eq 3.0 }">
										<span class="rt_star"><img src="${root }resources/images/ico/shp_star3.png" alt="별 3개"></span>
									</c:if>
									<c:if test="${campreview.crgood eq 4.0 }">
										<span class="rt_star"><img src="${root }resources/images/ico/shp_star4.png" alt="별 4개"></span>
									</c:if>
									<c:if test="${campreview.crgood eq 5.0 }">
										<span class="rt_star"><img src="${root }resources/images/ico/shp_star5.png" alt="별 5개"></span>
									</c:if>
								</p>
								<p class="rt_cont">${campreview.crcontent }</p>
								<p class="rt_date">${campreview.crdate }</p>
							</li>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<li class="fstEmpty"><i class="xi-error-o"></i>등록된 한줄평이 없습니다</li>
					</c:otherwise>
				</c:choose>
				</ul>
				<div class="fstPage">
					<ul>
					
					</ul>
				</div>
			</div>
		</section>
		<!-- } 컨텐츠영역 끝 -->
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
<!-- #한줄평 삭제하기 { -->
<div id="delete" class="fstPop">
	<div class="del_wrap pop_wrap">
		<h4 class="pop_tit">해당 한줄평을 삭제하시겠습니까?</h4>
		<input type="hidden" id="crnum" value="">
		<form>
			<ul class="comm_buttons">
				<li><button type="button" class="btn_close comm_btn cnc">닫기</button></li>
				<li><button type="button" id="delete_btn" class="comm_btn cfm">삭제하기</button></li>
			</ul>
		</form>
	</div>
	<button type="button" class="btn_close"><em class="snd_only">창 닫기</em></button>
</div>
<!-- } #팝업 삭제하기 -->

<!-- #팝업 처리완료 { -->
<div id="success" class="fstPop">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">처리가 완료되었습니다.</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close ok comm_btn cfm">확인</button></li>
		</ul>
	</div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c1b67c433937cf5e372c63766fb1ccca&libraries=services"></script>
<script type="text/javascript">
	campDetail();
</script>
</body>
</html>