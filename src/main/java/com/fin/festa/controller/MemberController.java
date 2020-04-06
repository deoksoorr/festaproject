package com.fin.festa.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fin.festa.model.entity.LoginVo;
import com.fin.festa.model.entity.ProfileVo;
import com.fin.festa.service.MemberService;

@Controller
@RequestMapping("/member/")
public class MemberController {

//////////////////////////////////////////////////////////////////////
//////////////////////////////로그인 관련//////////////////////////////
//////////////////////////////////////////////////////////////////////

	@Autowired
	private MemberService memberService;

	// 로그인 화면 (팝업)
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login() {
		return "member/login";
	}

	// 로그인 처리
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public @ResponseBody ProfileVo login(HttpServletRequest req, LoginVo loginVo) {
		ProfileVo profile = memberService.login(req, loginVo);

		return profile;
	}
	
	//정지
	@RequestMapping(value = "stop", method = RequestMethod.GET)
	public String stop() {
		return "member/stop";
	}
	
	//추방
	@RequestMapping(value = "kick", method = RequestMethod.GET)
	public String kick() {
		return "member/kick";
	}

	// 로그아웃 (팝업)
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout() {
		return "member/logout";
	}

	// 로그아웃 (팝업>팝업 내 기능)
	@RequestMapping(value = "logout", method = RequestMethod.POST)
	public String logout(HttpServletRequest req) {
		System.out.println("로그아웃 팝업");
		memberService.logout(req);
		
		return "index";
	}

	// 회원가입 화면
	@RequestMapping(value = "join", method = RequestMethod.GET)
	public String memberInsertOne() {
		return "member/join";
	}

	// ID중복체크
	@RequestMapping(value = "join/idcheck", method = RequestMethod.POST)
	@ResponseBody
	public int idCheck(Model model, LoginVo loginVo) {
		int result = memberService.idCheck(model, loginVo);
		return result;
	}

	// 회원가입 성공
	@RequestMapping(value = "join", method = RequestMethod.POST)
	public String memberInsertOne(Model model, ProfileVo profileVo) {
		memberService.memberInsertOne(model, profileVo);
		return "member/success";
	}

	/*
	 * // 회원가입 성공
	 * 
	 * @RequestMapping(value = "success", method = RequestMethod.POST) public String
	 * memberInsertSuccess() { return "member/success"; }
	 */

	// ID찾기 화면 (팝업)
	@RequestMapping(value = "find_id", method = RequestMethod.GET)
	public String findId() {
		return "member/find_id";
	}

	// ID찾기 처리 (팝업>팝업 내 기능)
	@RequestMapping(value = "find_id", method = RequestMethod.POST)
	@ResponseBody
	public ProfileVo findId(Model model, LoginVo loginVo) {
		ProfileVo profile =  memberService.findId(model, loginVo);
		
		return profile;
	}

	// PW찾기 화면 (팝업)
	@RequestMapping(value = "find_pw", method = RequestMethod.GET)
	public String findPw() {
		return "member/find_pw";
	}

	// PW찾기 처리 (팝업>팝업 내 기능)
	@RequestMapping(value = "find_pw", method = RequestMethod.POST)
	@ResponseBody
	public ProfileVo findPw(Model model, LoginVo loginVo) {
		ProfileVo profile =  memberService.findPw(model, loginVo);
		return profile;
	}
	
	// PW 업데이트
	@RequestMapping(value="update_pw", method= RequestMethod.POST)
	public String updatePw(Model model,ProfileVo profile) {
		System.out.println("접속");
		memberService.updatePw(model, profile);
		return "index";
	}

}
