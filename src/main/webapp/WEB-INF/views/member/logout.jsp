<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/" var="root" />
<c:url value="/resources/upload" var="upload" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
 	$('#btn_submit').on('click',function(){
		$.post('${root}member/logout','',function(){
			location.href='${root}';
		});
		return false;
	});
</script>
</head>
<body>
<!-- #1단계팝업 로그아웃 { -->
<div class="confirm_wrap pop_wrap">
	<form action="${root }member/logout" method="post">
		<p class="pop_tit">로그아웃 하시겠습니까?</p>
		<ul class="comm_buttons">
			<li><button type="button" class="btn_close comm_btn cnc">취소</button></li>
			<li><button type="submit" id="btn_submit" name="btn_submit" class="btn_close comm_btn sbm">확인</button></li>
		</ul>
	</form>
</div>
<button type="button" class="btn_close"><em class="snd_only">창 닫기</em></button>
<!-- } #1단계팝업 로그아웃 -->
</body>
</html>