<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:url value="/" var="root"></c:url>
<c:url value="/resources/upload" var="upload"></c:url>
<!DOCTYPE html>
<html>
<script type="text/javascript">
	var url = window.location.href;
	if(url.indexOf('maker')>0){
		window.location.href='${root}empty';
	}
	$(document).ready(function(){
		$('#edit_btn').on('click',function(){
			var files = new FormData($('#edit_form')[0]);
			$.ajax({
				type: "POST",
				enctype: 'multipart/form-data',
				url: '${root}hot/maker',
				data: files,
				processData: false,
				contentType: false,
				cache: false,
				success: function () {
					$('#close_btn').click();
					openPop('success');
					$('.comm_btn').on('click', function(){
						window.location.reload();		
					});
				},
				error: function (e) { 
					openPop('fail');
				}
			});
			return false;
		});
	});
</script>
<!-- #피드 수정하기 -->
<div class="feed_maker">
	<h3>피드 수정</h3>
	<c:if test="${feedEdit.gpnum ne 0 }">
		<form class="maker_form" id="edit_form" enctype="multipart/form-data">
			<input type="hidden" name="gpnum" value="${feedEdit.gpnum }"/>
			<div class="mk_cont box">
				<p class="pf_picture">
					<img src="${upload }/${feedEdit.profile.prophoto}" alt="${feedEdit.profile.proname }님의 프로필 썸네일" onload="squareTrim($(this), 55)">
				</p>
				<textarea id="" name="gpcontent" placeholder="${feedEdit.profile.proname } 님, 무슨 생각을 하고 계신가요?">${feedEdit.gpcontent }</textarea>
			</div>
			<div class="file_thumbnail mk_thumb box" style="display: block">
				<ul>
					<c:set var="i" value="0"/>
					<c:set var="feedphoto" value="${feedEdit.gpphoto }"/>
					<c:forTokens items="${feedphoto }" delims="," var="item">
						<c:set var="i" value="${i+1 }"/>
						<li class="ft_thumb">
							<input type="hidden" name="gpphoto" value="${item }"/>
							<input type="file" id="file${i }" name="files" accept="video/*, image/*" value="${upload }/${item}">
							<img src="${upload }/${item}" alt="">
							<button class="btn_cancle" type="button">
								<em class="snd_only">업로드 취소하기</em>
							</button>
							<label for="file${i }" class="btn_file"><em class="snd_only">사진/동영상 업로드하기</em></label>
						</li>
					</c:forTokens>
					<c:if test="${i lt 5 }">
						<c:forEach begin="${i }" end="4">
							<c:set var="i" value="${i+1 }"/>
							<li class="ft_btn">
								<input type="file" id="file${i }" name="files" accept="video/*, image/*">
								<img src="" alt="">
								<button class="btn_cancle" type="button">
									<em class="snd_only">업로드 취소하기</em>
								</button>
								<label for="file${i }" class="btn_file"><em class="snd_only">사진/동영상 업로드하기</em></label>
							</li>
						</c:forEach>
					</c:if>
				</ul>
			</div>
			<div class="mk_bottom box">
				<ul class="mk_tags">
					<li><input type="text" id="" name="httitle1" value="${feedEdit.httitle1 }"></li>
					<li><input type="text" id="" name="httitle2" value="${feedEdit.httitle2 }"></li>
					<li><input type="text" id="" name="httitle3" value="${feedEdit.httitle3 }"></li>
				</ul>
				<ul class="mk_btns">
					<li>
						<label for="file1" class="btn_file"><em class="snd_only">사진/동영상 업로드하기</em></label>
					</li>
					<li>
						<button type="button" id="edit_btn" class="btn_send"><em class="snd_only">피드 수정하기</em></button>
					</li>
				</ul>
			</div>
		</form>
	</c:if>
	<c:if test="${feedEdit.gpnum eq 0 }">
		<form class="maker_form" id="edit_form" enctype="multipart/form-data">
			<input type="hidden" name="mpnum" value="${feedEdit.mpnum }"/>
			<div class="mk_cont box">
				<p class="pf_picture">
					<img src="${upload }/${feedEdit.profile.prophoto}" alt="${feedEdit.profile.proname }님의 프로필 썸네일" onload="squareTrim($(this), 55)">
				</p>
				<textarea id="" name="mpcontent" placeholder="${feedEdit.profile.proname } 님, 무슨 생각을 하고 계신가요?">${feedEdit.mpcontent }</textarea>
			</div>
			<div class="file_thumbnail mk_thumb box" style="display: block">
				<ul>
					<c:set var="i" value="0"/>
					<c:set var="feedphoto" value="${feedEdit.mpphoto }"/>
					<c:forTokens items="${feedphoto }" delims="," var="item">
						<c:set var="i" value="${i+1 }"/>
						<li class="ft_thumb">
							<input type="hidden" name="mpphoto" value="${item }"/>
							<input type="file" id="file${i }" name="files" accept="video/*, image/*" value="${upload }/${item}">
							<img src="${upload }/${item}" alt="">
							<button class="btn_cancle" type="button">
								<em class="snd_only">업로드 취소하기</em>
							</button>
							<label for="file${i }" class="btn_file"><em class="snd_only">사진/동영상 업로드하기</em></label>
						</li>
					</c:forTokens>
					<c:if test="${i lt 5 }">
						<c:forEach begin="${i }" end="4">
							<c:set var="i" value="${i+1 }"/>
							<li class="ft_btn">
								<input type="file" id="file${i }" name="files" accept="video/*, image/*">
								<img src="" alt="">
								<button class="btn_cancle" type="button">
									<em class="snd_only">업로드 취소하기</em>
								</button>
								<label for="file${i }" class="btn_file"><em class="snd_only">사진/동영상 업로드하기</em></label>
							</li>
						</c:forEach>
					</c:if>
				</ul>
			</div>
			<div class="mk_bottom box">
				<ul class="mk_tags">
					<li><input type="text" id="" name="httitle1" value="${feedEdit.httitle1 }"></li>
					<li><input type="text" id="" name="httitle2" value="${feedEdit.httitle2 }"></li>
					<li><input type="text" id="" name="httitle3" value="${feedEdit.httitle3 }"></li>
				</ul>
				<ul class="mk_btns">
					<li>
						<label for="file1" class="btn_file"><em class="snd_only">사진/동영상 업로드하기</em></label>
					</li>
					<li>
						<button type="button" id="edit_btn" class="btn_send"><em class="snd_only">피드 수정하기</em></button>
					</li>
				</ul>
			</div>
		</form>
	</c:if>
</div>
<div id="success" class="fstPop pop2">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">수정이 완료되었습니다.</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close comm_btn cfm">확인</button></li>
		</ul>
	</div>
</div>
<div id="fail" class="fstPop pop2">
	<div class="confirm_wrap pop_wrap">
		<p class="pop_tit">수정에 실패하였습니다.</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close comm_btn cfm">확인</button></li>
		</ul>
	</div>
</div>
<button type="button" id="close_btn" class="btn_close"><em class="snd_only">창 닫기</em></button>
<script type="text/javascript">
	btnPop('btn_pop2');
	setFile();
</script>

</html>