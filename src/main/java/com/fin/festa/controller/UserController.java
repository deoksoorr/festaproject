package com.fin.festa.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fin.festa.model.entity.CampVo;
import com.fin.festa.model.entity.GroupCommentVo;
import com.fin.festa.model.entity.GroupPostVo;
import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.model.entity.LoginVo;
import com.fin.festa.model.entity.MyAdminVo;
import com.fin.festa.model.entity.MyCommentVo;
import com.fin.festa.model.entity.MyFollowingVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.MyVentureVo;
import com.fin.festa.model.entity.ProfileVo;
import com.fin.festa.model.entity.ReportListVo;
import com.fin.festa.model.entity.UpdateWaitVo;
import com.fin.festa.service.UserService;

@Controller
@RequestMapping("/user/")
public class UserController {

//////////////////////////////////////////////////////////////////////
///////////////////////////////유저 관련///////////////////////////////
//////////////////////////////////////////////////////////////////////
	
	@Autowired
	private UserService userSerivce;
	
	//내 피드
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String feedSelectOne(HttpServletRequest req, ProfileVo profile) {
		userSerivce.feedSelectOne(req,profile);
		return "user/index";
	}
	
	//게시글 입력
	@RequestMapping(value = "add", method = RequestMethod.POST)
	public String feedInsertOne(HttpServletRequest req, MultipartFile[] files, MyPostVo myPostVo,ProfileVo profile) {
		userSerivce.feedInsertOne(req, files, myPostVo);
		userSerivce.feedSelectOne(req,profile);
		return "redirect:/user/";
	}


	//게시글 수정 (팝업)
	@RequestMapping(value = "maker", method = RequestMethod.GET)
	public String feedDetail(Model model,MyPostVo myPostVo) {
		userSerivce.myFeedDetail(model, myPostVo);
		return "user/maker";
	}

	//게시글 수정 (팝업>팝업 내 기능)
	@RequestMapping(value = "maker", method = RequestMethod.POST)
	public String feedUpdateOne(HttpServletRequest req,MultipartFile[] filess,  MyPostVo myPostVo) {
		userSerivce.feedUpdateOne(req, filess, myPostVo);
		return "user/index";
	}

	//게시글 삭제 (내부팝업 기능)
	@RequestMapping(value = "del", method = RequestMethod.POST)
	public String feedDeleteOne(Model model, MyPostVo myPostVo) {
		userSerivce.feedDeleteOne(model, myPostVo);
		return "user/index";
	}

	//피드 댓글 입력
	@RequestMapping(value = "cmmtadd", method = RequestMethod.POST)
	public String feedCmmtInsertOne(HttpServletRequest req, MyCommentVo myCommentVo) {
		userSerivce.feedCmmtInsertOne(req, myCommentVo);
		return "user/index";
	}

	//피드 댓글 삭제 (내부팝업 생성)
	@RequestMapping(value = "cmmtdel", method = RequestMethod.POST)
	public String feedCmmtDeleteOne(Model model, MyCommentVo myCommentVo) {
		userSerivce.feedCmmtDeleteOne(model, myCommentVo);
		return "user/index";
	}
	
	//피드댓글 더보기 비동기
	@RequestMapping(value = "cmmt", method = RequestMethod.GET)
	public @ResponseBody List<MyCommentVo> GroupDetailCmmt(Model model, MyPostVo mypost){
		return userSerivce.userDetailCmmt(model, mypost);
	}

	//좋아요 체크
	@RequestMapping(value = "likeadd", method = RequestMethod.POST)
	public String likeInsertOne(HttpServletRequest req, MyGoodVo myGoodVo) {
		System.out.println("더하기");
		userSerivce.likeInsertOne(req, myGoodVo);
		return "user/index";
	}

	//좋아요 취소
	@RequestMapping(value = "likedel", method = RequestMethod.POST)
	public String likeDeleteOne(HttpServletRequest req, MyGoodVo myGoodVo) {
		System.out.println("빼기");
		userSerivce.likeDeleteOne(req, myGoodVo);
		return "user/index";
	}

	//팔로워 목록 (팝업)
	@RequestMapping(value = "follower", method = RequestMethod.GET)
	public String followerList(HttpServletRequest req, ProfileVo profile){
		userSerivce.followerList(req, profile);
		return "user/follower";
	}

	//팔로우 목록 (팝업)
	@RequestMapping(value = "following", method = RequestMethod.GET)
	public String followList(HttpServletRequest req, ProfileVo profile){
		userSerivce.followList(req, profile);
		return "user/following";
	}
	
	//팔로우 (팝업>팝업 내 기능)
	@RequestMapping(value = "foll", method = RequestMethod.POST)
	public String followInsertOne(HttpServletRequest req, MyFollowingVo myFollowingVo) {
		//return "user/follower";
		return "user/follow";
	}
	
	//팔로우 취소 (팝업>팝업 내 기능)
	@RequestMapping(value = "unfollow", method = RequestMethod.POST)
	public String followDeleteOne(HttpServletRequest req, MyFollowingVo myFollowingVo) {
		userSerivce.followDeleteOne(req, myFollowingVo);
		//return "user/follower";
		return "user/follow";
	}

	//유저 신고 (팝업)
	@RequestMapping(value = "us_report", method = RequestMethod.GET)
	public String userReport(){
		return "user/us_report";
	}
	
	//유저 신고 (팝업>팝업 내 기능)
	@RequestMapping(value = "us_report", method = RequestMethod.POST)
	public String userReport(Model model, ReportListVo reportListVo){
		return "user/index";
	}

	//피드 신고 (팝업)
	@RequestMapping(value = "report", method = RequestMethod.GET)
	public String feedReport(){
		return "user/report";
	}
	
	//피드 신고 (팝업>팝업 내 기능)
	@RequestMapping(value = "report", method = RequestMethod.POST)
	public String feedReport(Model model, ReportListVo reportListVo){
		return "user/index";
	}
	
//////////////////////////////////////////////////////////////////////
///////////////////////////////유저 세팅///////////////////////////////
//////////////////////////////////////////////////////////////////////	
	
	//내 프로필 관리
	@RequestMapping(value = "profile", method = RequestMethod.GET)
	public String myProfile(HttpServletRequest req, ProfileVo profileVo) {
		userSerivce.myProfile(req, profileVo);
		return "user/profile";
	}
	
	//내 프로필 수정
	@RequestMapping(value = "profile", method = RequestMethod.POST)
	public String myProfileUpdateOne(HttpServletRequest req, ProfileVo profileVo) {
		int result = userSerivce.myProfileUpdateOne(req, profileVo);
		return "user/profile";
	}
	
	//내 계정 관리
	@RequestMapping(value = "adm", method = RequestMethod.GET)
	public String myAdmin(Model model, ProfileVo prifileVo) {
		return "user/adm";
	}
	
	//내 계정 관리(비밀번호 확인)
	@RequestMapping(value = "check", method = RequestMethod.GET)
	public String myAdminCheck() {
		return "user/check";
	}
	
	//내 계정 관리(비밀번호 확인)
	@RequestMapping(value = "check", method = RequestMethod.POST)
	public String myAdminCheck(Model model, LoginVo loginVo) {
		int result = userSerivce.myAdminCheck(model, loginVo);
		if(result == 1) {
		return "user/adm";
		}
		else {
			return "user/check";
		}
	}
	
	//내 계정 정보 수정
	@RequestMapping(value = "adm", method = RequestMethod.POST)
	public String myAdminUpdateOne(HttpServletRequest req, ProfileVo profileVo) {
		userSerivce.myAdminUpdateOne(req, profileVo);
		return "user/check";
	}
	
	//내 계정 비활성화 (팝업 기능)
	@RequestMapping(value = "out", method = RequestMethod.POST)
	public String myAdminInactive(Model model, MyAdminVo myAdminVo) {
		return "index";
	}
	
	//내 계정 탈퇴 (팝업 기능)
	@RequestMapping(value = "inactive", method = RequestMethod.POST)
	public String myAdminGoodbye(Model model, ProfileVo profileVo) {
		return "index";
	}

	//그룹 생성
	@RequestMapping(value = "group", method = RequestMethod.GET)
	public String groupInsertOne() {
		return "user/group";
	}
	
	//그룹 생성 완료
	@RequestMapping(value = "group", method = RequestMethod.POST)
	public String groupInsertOne(HttpServletRequest req, GroupVo groupVo) {
		groupVo = userSerivce.groupInsertOne(req, groupVo);
		return "redirect:../group/?grnum=" + groupVo.getGrnum() + "&pronum=" + groupVo.getPronum();
	}
	   
	//사업자 계정 신청
	@RequestMapping(value = "venture/add", method = RequestMethod.GET)
	public String ventureInsertOne(Model model) {
		return "user/venture/add";
	}
	
	//사업자 계정 신청 완료
	@RequestMapping(value = "venture/add", method = RequestMethod.POST)
	public String ventureInsertOne(HttpServletRequest req, UpdateWaitVo updateWaitVo) {
		userSerivce.ventureInsertOne(req, updateWaitVo);
		return "user/venture/standby";
	}

	//사업자 계정 신청 승인 대기
	@RequestMapping(value = "venture/standby", method = RequestMethod.GET)
	public String ventureInsertOne() {
		return "user/venture/standby";
	}

	//사업자 계정 관리
	@RequestMapping(value = "venture", method = RequestMethod.GET)
	public String ventureAdmin(HttpServletRequest req) {
		userSerivce.ventureAdmin(req);
		return "user/venture/index";
	}
	
	//사업자 계정 수정
	@RequestMapping(value = "venture/edit", method = RequestMethod.POST)
	public String ventureAdminUpdateOne(HttpServletRequest req, MyVentureVo myVenture) {
		userSerivce.ventureAdminUpdateOne(req, myVenture);
		return "user/venture/index";
	}
	
	//캠핑장 정보 등록
	@RequestMapping(value = "camp/add", method = RequestMethod.GET)
	public String campInsertOne() {
		return "user/camp/add";
	}

	//캠핑장 정보 등록 완료
	@RequestMapping(value = "camp/add", method = RequestMethod.POST)
	public String campInsertOne(Model model, CampVo campVo) {
		return "camp/detail";
	}
	
	//캠핑장 정보 관리
	@RequestMapping(value = "camp", method = RequestMethod.GET)
	public String campAdmin(HttpServletRequest req) {
		userSerivce.campAdmin(req);
		return "user/camp/index";
	}
	
	//캠핑장 정보 수정
	@RequestMapping(value = "camp/edit", method = RequestMethod.POST)
	public String campUpdateOne(Model model, CampVo campVo) {
		userSerivce.campUpdateOne(model, campVo);
		return "user/camp/index";
	}
}
