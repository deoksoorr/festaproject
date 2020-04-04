package com.fin.festa.service;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.math.BigInteger;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.fin.festa.model.MemberDaoImpl;
import com.fin.festa.model.UserDaoImpl;
import com.fin.festa.model.entity.CampVo;
import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.model.entity.JoinGroupVo;
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
import com.fin.festa.util.UploadPhoto;

@Service
public class UserServiceImpl implements UserService {

	// 등록,수정,삭제가 최소2개이상 들어가는 메소드는 꼭 트랜잭션 적용할것!!

	@Autowired
	UserDaoImpl userDao;

	@Autowired
	MemberDaoImpl memberDao;

	// 추가사항
	// 유저 댓글 더보기 비동기

	@Override
	public List<MyCommentVo> userDetailCmmt(Model model, MyPostVo post) {
//		if (post.getPageSearch().getPage4() == 1) {
//			post.getPageSearch().setPage4(2);
//		}
//		model.addAttribute("paging", post.getPageSearch());
		return userDao.FeedDetailCmmt(model, post);
	}

	// 비활성화계정, 정지계정, 추방계정 체크 v
	// 내정보 출력 v
	// 내피드 출력 v
	// 내피드댓글 출력 v
	// 내피드갯수 출력 v
	// 내팔로잉갯수 출력 v
	// 내팔로워갯수 출력 v
	@Override
	public void feedSelectOne(HttpServletRequest req, ProfileVo profile) {
		HttpSession session = req.getSession();
		//ProfileVo profile = (ProfileVo) session.getAttribute("login");
		profile = userDao.myInfo(profile);
		MyAdminVo myAdmin = userDao.adminCheck(profile);
		if (myAdmin.getPropublic() == 1 && myAdmin.getProstop() == 1 && myAdmin.getProkick() == 1) {
			List<MyPostVo> myFeedSelectAll = userDao.myFeedSelectAll(profile); // 피드 리스트
			List<MyCommentVo> myFeedCmmtSelectAll = userDao.myFeedCmmtSelectAll(profile); // 피드 댓글 리스트
			int myFeedCount = userDao.myFeedCount(profile);
			int myFollowerCount = userDao.myFollowerCount(profile);
			int myFollowingCount = userDao.myFollowingCount(profile);
			session.setAttribute("profile", profile);
			session.setAttribute("myFeedCount", myFeedCount);
			session.setAttribute("myFollowerCount", myFollowerCount);
			session.setAttribute("myFollowingCount", myFollowingCount);
			req.setAttribute("myFeedSelectAll", myFeedSelectAll);
			req.setAttribute("myFeedCmmtSelectAll", myFeedCmmtSelectAll);
		}
	}

	// 내피드 등록
	@Override
	public void feedInsertOne(HttpServletRequest req, MultipartFile[] files, MyPostVo myPostVo) {
		UploadPhoto up = new UploadPhoto();
		String mpphoto = up.upload(files, req, myPostVo);

		myPostVo.setMpphoto(mpphoto);
		userDao.myFeedInsertOne(myPostVo);
	}

	// 내피드 디테일
	@Override
	public void myFeedDetail(Model model, MyPostVo myPostVo) {
		myPostVo = userDao.myFeedDetail(myPostVo);
		model.addAttribute("feedDetail", myPostVo);
	}

	// 내피드 수정
	@Override
	public void feedUpdateOne(HttpServletRequest req, MultipartFile[] filess, MyPostVo myPostVo) {
		UploadPhoto up = new UploadPhoto();
		String mpphoto = up.upload(filess, req, myPostVo);
		//System.out.println(mpphoto);
		System.out.println(myPostVo.getMpphoto());
		if (myPostVo.getMpphoto()!=null) {
			if (!mpphoto.isEmpty()) {
				myPostVo.setMpphoto(myPostVo.getMpphoto() + "," + mpphoto);
			}
		}
		else {
			myPostVo.setMpphoto(mpphoto);
		}
		userDao.myFeedUpdateOne(myPostVo);
	}

	// 내피드 삭제
	@Override
	public void feedDeleteOne(Model model, MyPostVo myPostVo) {
		userDao.myFeedDeleteOne(myPostVo);
	}

	// 내피드댓글 등록
	@Override
	public void feedCmmtInsertOne(HttpServletRequest req, MyCommentVo myCommentVo) {
		userDao.myFeedCmmtInsertOne(myCommentVo);
		/*
		 * HttpSession session = req.getSession(); ProfileVo profile = (ProfileVo)
		 * session.getAttribute("profile"); List<MyCommentVo> myFeedCmmtSelectAll =
		 * userDao.myFeedCmmtSelectAll(profile); req.setAttribute("myFeedCmmtSelectAll",
		 * myFeedCmmtSelectAll);
		 */
	}

	// 내피드댓글 삭제
	@Override
	public void feedCmmtDeleteOne(Model model, MyCommentVo myCommentVo) {
		userDao.myFeedCmmtDeleteOne(myCommentVo);
	}

	// 내피드 좋아요등록
	// 내피드 좋아요등록시 피드좋아요갯수 +1
	// 내 좋아요목록 갱신
	@Override
	public void likeInsertOne(HttpServletRequest req, MyGoodVo myGoodVo) {
		// TODO Auto-generated method stub

	}

	// 내피드 좋아요해제
	// 내피드 좋아요해제시 피드좋아요갯수 -1
	// 내 좋아요목록 갱신
	@Override
	public void likeDeleteOne(HttpServletRequest req, MyGoodVo myGoodVo) {
		// TODO Auto-generated method stub

	}

	// 내팔로잉목록에 등록
	// 상대팔로워목록에 등록
	// 내 팔로잉목록 갱신
	@Override
	public void followInsertOne(HttpServletRequest req, MyFollowingVo myFollowingVo) {
		// TODO Auto-generated method stub

	}

	// 내팔로잉목록에 삭제
	// 상대팔로워목록에 삭제
	// 내 팔로잉목록 갱신
	@Override
	public void followDeleteOne(HttpServletRequest req, MyFollowingVo myFollowingVo) {
		// TODO Auto-generated method stub

	}

	// 유저신고등록
	// 신고당한유저 신고당한횟수 +1
	@Override
	public void userReport(Model model, ReportListVo reportListVo) {
		// TODO Auto-generated method stub

	}

	// 피드신고등록
	// 신고당한유저 신고당한횟수 +1
	@Override
	public void feedReport(Model model, ReportListVo reportListVo) {
		// TODO Auto-generated method stub

	}

	// 그룹 존재유무 체크 v
	// 사업자 존재유무 체크 v
	// 사업자 미존재 시 등록신청 유무 체크 v
	// 사업자 존재시 사업자정보 출력(세션에 값담기) v
	// 캠핑장 존재유무 체크 v
	// 내프로필정보 출력 v
	@Override
	public void myProfile(HttpServletRequest req, ProfileVo profileVo) {
		HttpSession session = req.getSession();
		profileVo = (ProfileVo) session.getAttribute("profile");
		session.setAttribute("profile", userDao.myProfile(profileVo));

		int groupCheck = userDao.groupCheck(profileVo);
		System.out.println("groupCheck : " + groupCheck);
		int ventureCheck = userDao.ventureCheck(profileVo);

		System.out.println(profileVo.getPronum());
		BigInteger myVentureRequestCheck = userDao.myVentureRequestCheck(profileVo);

		MyVentureVo myVenture = userDao.myVentureInfo(profileVo);
		int campCheck = userDao.campCheck(myVenture);

		session.setAttribute("groupCheck", groupCheck);

		// if(myVentureRequestCheck == null && ventureCheck ==1 ) {
		session.setAttribute("myVenture", myVenture);
		session.setAttribute("ventureCheck", ventureCheck);
		session.setAttribute("campCheck", campCheck);
		// }
		// else if(myVentureRequestCheck != null) {
		session.setAttribute("myVentureRequestCheck", myVentureRequestCheck);
		// }
	}

	// 내프로필 수정
	@Override
	public int myProfileUpdateOne(HttpServletRequest req, ProfileVo profileVo) {
		System.out.println(profileVo.getProintro());
		int result = userDao.myProfileUpdate(profileVo);
		req.setAttribute("profile1", profileVo);
		System.out.println(result);
		System.out.println(profileVo.getProintro());
		// req.setAttribute("result", result);

		return result;

	}

	// 소셜로그인 체크
	// 내가입정보 출력
	@Override
	public void myAdmin(Model model, ProfileVo prifileVo) {
		// TODO Auto-generated method stub

	}

	// 가입정보 본인확인
	@Override
	public int myAdminCheck(Model model, LoginVo loginVo) {
		int result = userDao.identify(loginVo);
		return result;
	}

	// 내가입정보 수정
	@Override
	public void myAdminUpdateOne(HttpServletRequest req, ProfileVo profileVo) {
		userDao.joinInfoUpdate(profileVo);
		HttpSession session = req.getSession();
		session.setAttribute("profile", profileVo);
		System.out.println(profileVo.getPronum());
	}

	// 비활성화계정 처리
	// 그룹 존재유무 체크
	// 그룹에 가입된 인원수 체크
	@Override
	public void myAdminInactive(Model model, MyAdminVo myAdminVo) {
		// TODO Auto-generated method stub

	}

	// 계정탈퇴 처리
	// 그룹 존재유무 체크
	// 그룹에 가입된 인원수 체크
	@Override
	public void myAdminGoodbye(Model model, ProfileVo profileVo) {
		// TODO Auto-generated method stub

	}

	// 사업자 유무 체크(공식그룹,비공식그룹 분류)
	// 그룹 등록
	// 그룹 등록
	@Override
	public GroupVo groupInsertOne(HttpServletRequest req, GroupVo groupVo) {
		;
		HttpSession session = req.getSession();
		ProfileVo profile = (ProfileVo) session.getAttribute("profile");

		userDao.groupInsert(groupVo);
		groupVo = userDao.groupmyGroup(profile);
		userDao.myGroupJoin(groupVo);

		List<JoinGroupVo> joinGroup = memberDao.myJoinGroupSelectAll(profile);

		session.setAttribute("joinGroup", joinGroup);
		session.setAttribute("group", groupVo);
		session.setAttribute("groupCheck", 1);
		req.setAttribute("detail", groupVo);

		return groupVo;
	}

	// 사업자등록 신청
	@Override
	public void ventureInsertOne(HttpServletRequest req, UpdateWaitVo updateWaitVo) {
		userDao.ventureRequest(updateWaitVo);

		HttpSession session = req.getSession();
		session.setAttribute("myVentureRequestCheck", 1);
	}

	// 사업자정보 출력(세션)
	@Override
	public void ventureAdmin(HttpServletRequest req) {
		HttpSession session = req.getSession();
		ProfileVo profile = (ProfileVo) session.getAttribute("profile");

		MyVentureVo myVenture = userDao.myVentureInfo(profile);
		req.setAttribute("myVenture", myVenture);
		session.setAttribute("myVenture", myVenture);
	}

	// 사업자정보 수정
	// 캠핑장정보 자동수정(사업자정보 수정값만)
	@Override
	public void ventureAdminUpdateOne(HttpServletRequest req, MyVentureVo myVenture) {
		userDao.ventureUpdate(myVenture);
		userDao.campInfoUpdate(myVenture);

		HttpSession session = req.getSession();
		session.setAttribute("myVenture", myVenture);
	}

	// 캠핑장 등록
	@Override
	public void campInsertOne(Model model, CampVo campVo) {

	}

	// 세션에 담긴 사업자정보로 캠핑장정보 출력
	@Override
	public void campAdmin(HttpServletRequest req) {
		HttpSession session = req.getSession();
		MyVentureVo myVenture = (MyVentureVo) session.getAttribute("myVenture");

		CampVo camp = userDao.myCampSelectOne(myVenture);
		System.out.println(camp.getCanum());
		session.setAttribute("myCamp", camp);
	}

	// 캠핑장정보 수정
	@Override
	public void campUpdateOne(Model model, CampVo campVo) {
		int result = userDao.campUpdate(campVo);
		model.addAttribute("myCamp", campVo);
	}

	// 내 팔로워리스트 출력
	@Override
	public void followerList(Model model, ProfileVo profile) {
		// TODO Auto-generated method stub

	}

	// 내 팔로잉리스트 출력
	@Override
	public void followList(Model model, ProfileVo profile) {
		// TODO Auto-generated method stub

	}

}