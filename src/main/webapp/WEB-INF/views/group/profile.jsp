<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:if test="${sessionScope.login ne null }">
	<c:if test="${sessionScope.login.proid eq 'admin@festa.com' }">
		<c:redirect url="/empty" />
	</c:if>
</c:if>
<c:url value="/" var="root"></c:url>
<c:url value="/resources/upload" var="upload"></c:url>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta property="og:image"
	content="${root }resources/images/ico/logo.png">
<script type="text/javascript"
	src="${root }resources/js/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${root }resources/js/util.js"></script>
<script type="text/javascript" src="${root }resources/js/site.js"></script>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="${root }resources/css/site.css">
<link rel="shortcut icon" href="${root }resources/favicon.ico">
<title>FESTA</title>
<script type="text/javascript">
	
	$(document).ready(function(){
		var login = '${login}';
		var cookie = '${cookie.loginCookie.value}';
		if(cookie!=''&&login==''&&loginValue==true){
		   openPop('loginCookie');
		}
		
		$('#btnCookie').on('click',function(){
		   $.post('${root}member/loginCookie','id='+cookie,function(data){
		      if (data.prorn == '0') {
		         location.href = "${root}user/?pronum="+data.pronum;
		      } else if (data.prorn == '1') {
		         location.href = "${root}member/stop";
		      } else if (data.prorn == '2') {
		         location.href = "${root}member/kick";
		      } else if (data.prorn == '3') {
		         location.href = "${root}admin/";
		      } else if (data.prorn == '4') {
		         location.href = "${root}";
		      }
		   });
		});
		$('#festa4').val('${detail.graddr}').prop('selected', 'selected');
		$('select').each(function() {
			   var label = $(this).siblings('.comm_sel_label');
			   var value = $('#graddr').val();
			   label.text(value);
			});
		
		$('#editok').on('click', function(){
			var files = new FormData($('#update_group')[0]);
			$.ajax({
				type: "POST",
				enctype: 'multipart/form-data',
				url: '${root}group/profile/edit',
				data: files,
				processData: false,
				contentType: false,
				cache: false,
				success: function (data) {
					openPop('ok');
					$('#editsuccess').on('click', function() {
						location.reload();
					});
				},
				error: function (e) { 
					openPop('fail');
					e.preventDefault();
				}
			});
		});
		
	 	
	 	$('#festa8').on('click', function(){
	 		var grnum=$('#postgrnum').val();
	 		$('#grnum').val(grnum);
	 		var grtotal=$('#postgrtotal').val();
	 		$('#grtotal').val(grtotal);
	 		var pronum=$('#postpronum').val();
	 		$('#pronum').val(pronum);
	 		var pronum2=$('#pronum').val();
	 		console.log(pronum2);
	 		
	 		//그룹삭제 키값검사
		 	$('#keymsg').on('propertychange change keyup paste input', function(){
		 		var keymsg=$('#keymsg').val();
		 		var sucmsg='여행하는 과정에서 행복을 느낀다'
		 		var grtotal=$('#grtotal')
		 		if(keymsg == sucmsg){
		 			$('#delcheck').removeAttr("disabled");
		 			$('#delcheck').removeClass('cnc');
		 			$('#delcheck').addClass('cfm');

		 			var grnum=$('#grnum').val();
		 			var grtotal=$('#grtotal').val();
		 			var pronum=$('#pronum').val();
		 			
	 				console.log(grtotal);
	 				
		 			$('#delcheck').on('click', function(){
		 				//그룹인원 1인 넘을경우 실패
		 				if(grtotal > 1){
	 						openPop("groupfail");
	 		 				$('#keymsg').val('');
		 				} else{
			 				$.post('${root}/group/profile/del', 'grnum='+grnum+'&pronum='+pronum, function(data){
		 						openPop("deleteok");
		 						$('#deletesuccess').on('click', function(){
		 							window.location.href='http://localhost:8080/festa/user/';
		 						});
			 				})	 					
		 				}
		 			});
		 		}else{
		 			$('#delcheck').attr("disabled", "disabled");
		 			$('#delcheck').removeClass('cfm');
		 			$('#delcheck').addClass('cnc');
		 		}
		 	});
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
						<input type="text" placeholder="캠핑장 또는 그룹을 검색해보세요!">
						<button type="button" id="search">
							<img src="${root }resources/images/ico/btn_search.png" alt="검색">
						</button>
					</form>
					<ul id="gnb">
						<li><a href="${root}camp/">캠핑정보</a></li>
						<li><a href="${root}hot/">인기피드</a></li>
						<li><a href="${root}news/">뉴스피드</a></li>
						<c:if test="${login eq null }">
							<%
								out.println("<script>alert('로그인 후 이용이 가능합니다.')</script>");
							%>
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
										<c:forEach items="${bookMark}" var="bookMark">
											<li>
												<a href="${root}camp/detail?canum=${bookMark.camp.canum}&caaddrsel=${bookMark.camp.caaddrsel}">
													<span>
														<c:set var="image" value="${fn:substringBefore(bookMark.camp.caphoto,',')}"></c:set>
														<c:if test="${!empty bookMark.camp.caphoto && empty image}"><img src="${upload}/${bookMark.camp.caphoto}" alt="${bookMark.camp.caname}"></c:if>
														<c:if test="${!empty bookMark.camp.caphoto && !empty image}"><img src="${upload}/${image}" alt="${bookMark.camp.caname}"></c:if>
														<c:if test="${empty bookMark.camp.caphoto && empty image}"><img src="${root}resources/images/thumb/no_profile.png" alt="${bookMark.camp.caname}"></c:if>
													</span>
													<b>${bookMark.camp.caname}</b>
												</a>
											</li>
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
		<!-- #그룹 관리 -->
		<!-- 서브페이지 시작 { -->
		<div id="container" class="setting_wrap">
			<!-- 프로필영역 시작 { -->
			<section class="profile_area">
				<div class="container">
					<div class="info_box">
						<dl>
							<dt class="pf_tit">
								<a class="pf_name"
									href="${root }group/?grnum=${detail.grnum}&pronum=${detail.pronum}">
									<b>${detail.grname }</b>
								</a>
								<c:if test="${detail.grventure eq 2 }">
									<span class="gp_official"></span>
								</c:if>
								<c:if test="${login.pronum eq detail.pronum }">
									<a class="pf_opt go_settings"
										href="${root }group/profile/?grnum=${detail.grnum}"> <em
										class="snd_only">설정</em>
									</a>
								</c:if>
								<c:if test="${login.pronum ne detail.pronum }">
									<a href="${root }group/gp_report"
										class="pf_opt btn_pop btn_report"> <em class="snd_only">신고하기</em>
									</a>
								</c:if>
							</dt>
							<dd class="pf_intro">${detail.grintro }
							<dd class="pf_hashtag">
								<c:choose>
									<c:when
										test="${empty detail.httitle1 && empty detail.httitle2 && empty detail.httitle3}">
									</c:when>
									<c:when
										test="${empty detail.httitle1 && empty detail.httitle2}">
										<a href="">${detail.httitle3}</a>
									</c:when>
									<c:when test="${empty detail.httitle1}">
										<a href="">${detail.httitle2}</a>
										<a href="">${detail.httitle3}</a>
									</c:when>
									<c:otherwise>
										<a href="">${detail.httitle1}</a>
										<a href="">${detail.httitle2}</a>
										<a href="">${detail.httitle3}</a>
									</c:otherwise>
								</c:choose>
							</dd>
							<dd class="gp_list">
								<span>그룹장 : ${detail.profile.proname}</span> <a
									class="btn_pop btn_member"
									href="${root }group/member?grnum=${detail.grnum}">멤버 :
									${detail.grtotal }명</a> <span>개설일 : ${detail.grdate }</span>
								<c:if test="${login.pronum ne detail.pronum }">
									<a class="btn_pop btn_out" href="${root }group/out">탈퇴</a>
								</c:if>
							</dd>
							<c:choose>
								<c:when test="${detail.grphoto eq null }">
									<dd class="pf_picture">
										<img src="${root }resources/upload/thumb/no_profile.png" alt="${detail.grname } 그룹 썸네일">
									</dd>
								</c:when>
								<c:otherwise>
									<dd class="pf_picture">
										<img src="${upload }/${detail.grphoto }" alt="${detail.grname } 그룹 썸네일">
									</dd>
								</c:otherwise>
							</c:choose>
						</dl>
					</div>
					<p class="social_btns">
						<button type="button" class="btn_chat"
							onclick="window.open('${root}group/chat','Festa chat','width=721,height=521,location=no,status=no,scrollbars=no');">그룹채팅</button>
					</p>
				</div>
			</section>
			<!-- } 프로필영역 끝 -->
			<div class="container">
				<!-- 좌측 사이드메뉴 시작 { -->
				<section class="side_area">
					<ul class="lnb_list">
						<li><a href="${root }group/profile?grnum=${detail.grnum}" class="act">그룹 관리</a></li>
						<li><a href="${root }group/user?grnum=${detail.grnum}">그룹원 관리</a></li>
						<li><a href="${root }group/req?grnum=${detail.grnum}">가입신청 조회</a></li>
					</ul>
				</section>
				<!-- } 좌측 사이드메뉴 시작 -->
				<!-- 컨텐츠영역 시작 { -->
				<section class="content_area">
					<h2 class="set_tit">그룹 관리</h2>
					<input type="hidden" id="postgrnum" value="${detail.grnum }" />
					<input type="hidden" id="postgrtotal" value="${detail.grtotal }" />
					<input type="hidden" id="postpronum" value="${login.pronum }" />
					<form action="${root }group/profile/edit" method="post" class="set_form" id="update_group" enctype="multipart/form-data">
						<ul class="input_list">
							<li class="set_file1 box">
								<p>그룹 대표사진</p>
								<div>
									<p class="pf_picture">
										<input type="file" id="festa2" name="files" accept="image/*">
										<c:choose>
											<c:when test="${detail.grphoto eq null }">
												<input type="hidden" id="grphoto" name="grphoto" value="" />
												<img src="${root}resources/images/thumb/no_profile.png" alt="그룹의 프로필 썸네일">	
											</c:when>
											<c:otherwise>
												<input type="hidden" id="grphoto" name="grphoto" value="${detail.grphoto }" />
												<img src="${upload }/${detail.grphoto }" alt="그룹의 프로필 썸네일">											
											</c:otherwise>
										</c:choose>
									</p>
									<ul class="comm_buttons_s">
										<li><label for="festa2" class="comm_btn cfm">등록</label></li>
										<li>
											<button type="button" id="grphotoDel" class="comm_btn btn_cancle">삭제</button>
										</li>
									</ul>
								</div>
							</li>
							<li class="box">
								<p>
									<label for="festa1">그룹 이름</label>
								</p>
								<div>
									<input type="text" style="background-color: #eef0f3" id="festa1" name="grname" value="${detail.grname }" required="required" readonly="readonly">
								</div>
							</li>
							<li class="box">
								<p>
									<label for="festa3">그룹 소개</label>
								</p>
								<div>
									<textarea id="festa3" name="grintro" placeholder="??자 이내로 작성해주세요">${detail.grintro }</textarea>
								</div>
							</li>
						</ul>
						<ul class="input_list">
							<li class="box">
								<p>
									<label for="festa4">그룹 관심지역</label>
								</p>
								<div>
									<input type="hidden" id="graddr" value="${detail.graddr }" />
									<select class="comm_sel" id="festa4" name="graddr">
										<option value="서울">서울</option>
										<option value="경기도">경기도</option>
										<option value="강원도">강원도</option>
										<option value="충청도">충청도</option>
										<option value="전라도">전라도</option>
										<option value="경상도">경상도</option>
										<option value="제주도">제주도</option>
										<option value="인천">인천</option>
										<option value="세종">세종</option>
										<option value="대구">대구</option>
										<option value="울산">울산</option>
										<option value="광주">광주</option>
										<option value="대전">대전</option>
									</select>
									<p class="comm_sel_label">서울</p>
								</div>
							</li>
							<li class="set_tags box">
								<p>해시태그 등록</p>
								<div>
									<ul>
										<li><input type="text" id="festa5" name="httitle1" value="${detail.httitle1 }"></li>
										<li><input type="text" id="festa6" name="httitle2" value="${detail.httitle2 }"></li>
										<li><input type="text" id="festa7" name="httitle3" value="${detail.httitle3 }"></li>
									</ul>
								</div>
							</li>
						</ul>
						<ul class="input_list">
							<li class="set_chk box">
								<p>그룹 설정</p>
								<div>
									<input type="checkbox" class="comm_rdo rdo_pop btn_pop" id="festa8" name="festa8" data-layer="del">
									<label for="festa8">그룹 삭제</label>
									<p class="txt_explan">
										그룹 삭제 시 프로필 및 공유한 피드가 모두 삭제되며, 복구가 불가능합니다.<br>
									</p>
									<p class="txt_explan">
										※ 그룹 삭제는 그룹 멤버가 없는 상태에서만 가능하므로 <span class="err">가입한
											멤버가 있을 경우</span><br> <span class="err">그룹원 관리에서 모두 추방</span> 후
										진행해주세요.<br>
									</p>
								</div>
							</li>
						</ul>
						<input type="hidden" name="pronum" value="${detail.pronum }" />
						<input type="hidden" name="grnum" value="${detail.grnum}"/>
						<ul class="comm_buttons">
							<li><button type="reset" class="btn_close comm_btn cnc">취소</button></li>
							<li><button type="button" id="save" class="comm_btn cfm btn_pop" data-layer="edit">저장</button></li>
						</ul>
					</form>
				</section>
				<!-- } 컨텐츠영역 끝 -->
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
	
	
	<div class="fstPop">
		<div class="out_wrap pop_wrap" id="del">
			<h3 class="pop_tit">그룹을 삭제하시겠습니까?</h3>
			<div class="info_box">
				<ul>
					<li>삭제한 그룹의 데이터는 복구할 수 없습니다.</li>
					<li>확인 버튼을 누르시면 그룹 삭제가 완료됩니다.</li>
				</ul>
			</div>
			<p>[다음 문구를 똑같이 입력해주세요.]</p>
			<p class="out_words">여행하는 과정에서 행복을 느낀다</p>
			<form class="comm_form">
				<div class="ip_box">
					<input type="text" id="keymsg" name="" required="required">
					<p class="f_message"></p>
				</div>
				<div class="btn_box">
					<input type="hidden" id="grnum" value="" />
					<input type="hidden" id="grtotal" value="" />
					<input type="hidden" id="pronum" value="" />
					<ul class="comm_buttons">
						<li><button type="button" class="btn_close comm_btn cnc">취소</button></li>
						<li><button type="button" id="delcheck" class="btn_close comm_btn cnc" disabled="disabled">확인</button></li>
					</ul>
				</div>
			</form>
		</div>
		<button type="button" class="btn_close"><em class="snd_only">창 닫기</em></button>
	</div>
	
	<div id="groupfail" class="fstPop">
		<div class="confirm_wrap pop_wrap">
			<p class="pop_tit">그룹을 삭제할 수 없습니다.</p>
			<p class="pop_txt">아직 탈퇴하지 않은 그룹 멤버가 있습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" class="btn_close comm_btn cfm">확인</button></li>
			</ul>
		</div>
	</div>
	
	<!-- #삭제 처리완료 { -->
	<div id="deleteok" class="fstPop">
		<div class="confirm_wrap pop_wrap">
			<p class="pop_tit">그룹 삭제가 완료되었습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" id="deletesuccess" class="btn_close comm_btn cfm">확인</button></li>
			</ul>
		</div>
	</div>
	
	<div id="edit" class="fstPop">
		<div class="out_wrap pop_wrap">
			<h3 class="pop_tit">정보를 수정하시겠습니까?</h3>
			<input type="hidden" id="num" value="">
			<div class="btn_box">
				<ul class="comm_buttons">
					<li><button type="button" class="btn_close comm_btn cnc">취소</button></li>
					<li><button type="button" id="editok" class="btn_close comm_btn cfm">확인</button></li>
				</ul>
			</div>
		</div>
		<button type="button" class="btn_close">
			<em class="snd_only">창 닫기</em>
		</button>
	</div>
	
	<!-- #팝업 처리완료 { -->
	<div id="ok" class="fstPop">
		<div class="confirm_wrap pop_wrap">
			<p class="pop_tit">처리가 완료되었습니다.</p>
			<ul class="comm_buttons">
				<li><button type="button" id="editsuccess" class="btn_close comm_btn cfm">확인</button></li>
			</ul>
		</div>
	</div>
		
	<!-- #팝업 처리완료 { -->
	<div id="loginCookie" class="fstPop">
		<div class="confirm_wrap pop_wrap">
			<p class="pop_tit">로그인을 유지 시키겠습니까?</p>
			<ul class="comm_buttons">
				<li><button type="button" class="btn_close comm_btn cnc">닫기</button></li>
				<li><button type="button" id="btnCookie"
						class="ok comm_btn cfm">로그인</button></li>
			</ul>
		</div>
	</div>
	<!-- } #팝업 처리완료 -->
	<script type="text/javascript">
		rdoPop();
		setOneFile();
		btnPop('btn_pop2');
	</script>
</body>
</html>