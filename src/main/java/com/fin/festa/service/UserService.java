package com.fin.festa.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.fin.festa.model.entity.CampVo;
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

public interface UserService {

		List<MyCommentVo> userDetailCmmt(Model model,MyPostVo post);
	
		void feedInsertOne(HttpServletRequest req, MultipartFile[] files, MyPostVo myPostVo);

		void feedDeleteOne(Model model, MyPostVo myPostVo);

		void feedCmmtDeleteOne(Model model, MyCommentVo myCommentVo);

		void likeInsertOne(HttpServletRequest req, MyGoodVo myGoodVo);

		void likeDeleteOne(HttpServletRequest req, MyGoodVo myGoodVo);

		void followInsertOne(HttpServletRequest req, MyFollowingVo myFollowingVo);
		
		void followDeleteOne(HttpServletRequest req, MyFollowingVo myFollowingVo);
		
		void userReport(Model model, ReportListVo reportListVo);
		
		void feedReport(Model model, ReportListVo reportListVo);
		
		void myProfile(HttpServletRequest req, ProfileVo profileVo);
		
		int myProfileUpdateOne(HttpServletRequest req, ProfileVo profileVo);
		
		void myAdmin(Model model, ProfileVo prifileVo);
		
		int myAdminCheck(Model model, LoginVo loginVo);
		
		void myAdminUpdateOne(HttpServletRequest req, ProfileVo profileVo);
		
		void myAdminInactive(Model model, MyAdminVo myAdminVo);
		
		void myAdminGoodbye(Model model, ProfileVo profileVo);

		GroupVo groupInsertOne(HttpServletRequest req, GroupVo groupVo);
		
		void ventureInsertOne(HttpServletRequest req, UpdateWaitVo updateWaitVo);

		void ventureAdmin(HttpServletRequest req);
		
		void ventureAdminUpdateOne(HttpServletRequest req, MyVentureVo myVenture);
		
		void campInsertOne(Model model, CampVo campVo);
		
		void campAdmin(HttpServletRequest req);
		
		void campUpdateOne(Model model, CampVo campVo);
		
		void followerList(Model model, ProfileVo profile);
		
		void followList(Model model, ProfileVo profile);

		void feedCmmtInsertOne(HttpServletRequest req, MyCommentVo myCommentVo);

		void myFeedDetail(Model model, MyPostVo myPostVo);

		void feedUpdateOne(HttpServletRequest req, MultipartFile[] filess, MyPostVo myPostVo);

		void feedSelectOne(HttpServletRequest req, ProfileVo profile);
}
