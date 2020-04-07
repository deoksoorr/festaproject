package com.fin.festa.service;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.math.BigInteger;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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

	// ���,����,������ �ּ�2���̻� ���� �޼ҵ�� �� Ʈ����� �����Ұ�!!

	@Autowired
	UserDaoImpl userDao;

	@Autowired
	MemberDaoImpl memberDao;

	// �߰�����
	// ���� ��� ������ �񵿱�

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
	// 내팔로잉갯수 출력  v
	// 내팔로워갯수 출력 v
	@Override
	public void feedSelectOne(HttpServletRequest req, ProfileVo profile) {
		HttpSession session = req.getSession();
		//ProfileVo profile = (ProfileVo) session.getAttribute("login");
		profile = userDao.myInfo(profile);
		MyAdminVo myAdmin = userDao.adminCheck(profile);
		if (myAdmin.getPropublic() == 1 && myAdmin.getProstop() == 1 && myAdmin.getProkick() == 1) {
			List<MyPostVo> myFeedSelectAll = userDao.myFeedSelectAll(profile); // �ǵ� ����Ʈ
			List<MyCommentVo> myFeedCmmtSelectAll = userDao.myFeedCmmtSelectAll(profile); // �ǵ� ��� ����Ʈ
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

	// ���ǵ� ���
	@Override
	public void feedInsertOne(HttpServletRequest req, MultipartFile[] files, MyPostVo myPostVo) {
		UploadPhoto up = new UploadPhoto();
		String mpphoto = up.upload(files, req, myPostVo);
		myPostVo.setMpphoto(mpphoto);
		userDao.myFeedInsertOne(myPostVo);
	}

	// ���ǵ� ������
	@Override
	public void myFeedDetail(Model model, MyPostVo myPostVo) {
		myPostVo = userDao.myFeedDetail(myPostVo);
		model.addAttribute("feedDetail", myPostVo);
	}

	// ���ǵ� ����
	@Override
	public void feedUpdateOne(HttpServletRequest req, MultipartFile[] filess, MyPostVo myPostVo) {
		UploadPhoto up = new UploadPhoto();
		String mpphoto = up.upload(filess, req, myPostVo);
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

	// ���ǵ� ����
	@Override
	public void feedDeleteOne(Model model, MyPostVo myPostVo) {
		userDao.myFeedDeleteOne(myPostVo);
	}

	// ���ǵ��� ���
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

	// ���ǵ��� ����
	@Override
	public void feedCmmtDeleteOne(Model model, MyCommentVo myCommentVo) {
		userDao.myFeedCmmtDeleteOne(myCommentVo);
	}

	// ���ǵ� ���ƿ���
	// ���ǵ� ���ƿ��Ͻ� �ǵ����ƿ䰹�� +1
	// �� ���ƿ��� ����
	@Transactional
	@Override
	public void likeInsertOne(HttpServletRequest req, MyGoodVo myGoodVo) {
		userDao.myFeedLikeInsertOne(myGoodVo);
		MyPostVo post = new MyPostVo();
		post.setMpnum(myGoodVo.getMpnum());
		
		userDao.myFeedLikeOnePlus(post);
		req.getSession().setAttribute("goodlist", userDao.myGoodRenewal(myGoodVo));
	}

	// ���ǵ� ���ƿ�����
	// ���ǵ� ���ƿ������� �ǵ����ƿ䰹�� -1
	// �� ���ƿ��� ����
	@Transactional
	@Override
	public void likeDeleteOne(HttpServletRequest req, MyGoodVo myGoodVo) {
		userDao.myFeedLikeDeleteOne(myGoodVo);
		MyPostVo post = new MyPostVo();
		post.setMpnum(myGoodVo.getMpnum());
		
		userDao.myFeedLikeOneMinus(post);
		req.getSession().setAttribute("goodlist", userDao.myGoodRenewal(myGoodVo));
		
	}

	// ���ȷ��׸�Ͽ� ���
	// ����ȷο���Ͽ� ���
	// �� �ȷ��׸�� ����
	@Override
	public void followInsertOne(HttpServletRequest req, MyFollowingVo myFollowingVo) {
		
	}

	// ���ȷ��׸�Ͽ� ����
	// ����ȷο���Ͽ� ����
	// �� �ȷ��׸�� ����
	@Override
	public void followDeleteOne(HttpServletRequest req, MyFollowingVo myFollowingVo) {
		userDao.myFollowingDeleteOne(myFollowingVo);
		userDao.yourFollowerDeleteOne(myFollowingVo);
		
		HttpSession session = req.getSession();
		session.setAttribute("followlist", userDao.myFollowingRenewal(myFollowingVo));
	}

	// �����Ű���
	// �Ű�������� �Ű����Ƚ�� +1
	@Override
	public void userReport(Model model, ReportListVo reportListVo) {
		// TODO Auto-generated method stub

	}

	// �ǵ�Ű���
	// �Ű�������� �Ű����Ƚ�� +1
	@Override
	public void feedReport(Model model, ReportListVo reportListVo) {
		// TODO Auto-generated method stub

	}

	// �׷� �������� üũ v
	// ����� �������� üũ v
	// ����� ������ �� ��Ͻ�û ���� üũ v
	// ����� ����� ��������� ���(���ǿ� �����) v
	// ķ���� �������� üũ v
	// ������������ ��� v
	@Override
	public void myProfile(HttpServletRequest req, ProfileVo profileVo) {
		HttpSession session = req.getSession();
		profileVo = (ProfileVo) session.getAttribute("profile");
		session.setAttribute("profile", userDao.myProfile(profileVo));

		int groupCheck = userDao.groupCheck(profileVo);
		int ventureCheck = userDao.ventureCheck(profileVo);

		BigInteger myVentureRequestCheck = userDao.myVentureRequestCheck(profileVo);

		MyVentureVo myVenture = userDao.myVentureInfo(profileVo);
		int campCheck = userDao.campCheck(myVenture);

		session.setAttribute("groupCheck", groupCheck);

		session.setAttribute("myVenture", myVenture);
		session.setAttribute("ventureCheck", ventureCheck);
		session.setAttribute("campCheck", campCheck);
		session.setAttribute("myVentureRequestCheck", myVentureRequestCheck);
	}

	// �������� ����
	@Override
	public int myProfileUpdateOne(HttpServletRequest req,MultipartFile[] files, ProfileVo profileVo) {
		UploadPhoto up = new UploadPhoto();
		if(files != null) {
			String prophoto = up.upload(files, req, profileVo);
			profileVo.setProphoto(prophoto);
		}else if(profileVo.getProphoto().equals("undefined")) {
			profileVo.setProphoto(null);
		}
		int result = userDao.myProfileUpdate(profileVo);
		profileVo = userDao.myInfo(profileVo);
		HttpSession session = req.getSession();
		session.setAttribute("profile", profileVo);

		return result;

	}

	// �Ҽȷα��� üũ
	// ���������� ���
	@Override
	public void myAdmin(Model model, ProfileVo prifileVo) {
		// TODO Auto-generated method stub

	}

	// �������� ����Ȯ��
	@Override
	public int myAdminCheck(Model model, LoginVo loginVo) {
		int result = userDao.identify(loginVo);
		return result;
	}

	// ���������� ����
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
	public int myAdminInactive(HttpServletRequest req, MyAdminVo myAdminVo) {
		HttpSession session = req.getSession();
		ProfileVo profile = (ProfileVo) session.getAttribute("profile");
		int result = userDao.groupCheck(profile);
		int rst = 0;
		if(result ==0) {
			userDao.inactiveUpdate(myAdminVo);
			session.invalidate();
		}
		else {
			GroupVo group = userDao.groupmyGroup(profile);
			System.out.println(group.getGrnum());
			int result2 = userDao.groupUserCount(group);
			if(result2 == 1) {
				userDao.inactiveUpdate(myAdminVo);
				session.invalidate();
			}
			else {
				System.out.println("그룹에 여러명 존재");
				rst = 1;
			}
		}
		return rst;
	}

	// 계정탈퇴 처리
	// 그룹 존재유무 체크
	// 그룹에 가입된 인원수 체크
	@Override
	public int myAdminGoodbye(HttpServletRequest req, ProfileVo profileVo) {
		HttpSession session = req.getSession();
		int result = userDao.groupCheck(profileVo);
		int rst = 0;
		if(result ==0) {
			userDao.userGoodBye(profileVo);
			session.invalidate();
		}
		else {
			GroupVo group = userDao.groupmyGroup(profileVo);
			int result2 = userDao.groupUserCount(group);
			if(result2 == 1) {
				userDao.userGoodBye(profileVo);
				session.invalidate();
			}
			else {
				System.out.println("그룹에 여러명 존재");
				rst = 1;
			}
		}
		return rst;
	}

	// ����� ���� üũ(���ı׷�,����ı׷� �з�)
	// �׷� ���
	// �׷� ���
	@Override
	public GroupVo groupInsertOne(HttpServletRequest req, GroupVo groupVo) {
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

	// ����ڵ�� ��û
	@Override
	public void ventureInsertOne(HttpServletRequest req, UpdateWaitVo updateWaitVo) {
		userDao.ventureRequest(updateWaitVo);

		HttpSession session = req.getSession();
		session.setAttribute("myVentureRequestCheck", 1);
	}

	// ��������� ���(����)
	@Override
	public void ventureAdmin(HttpServletRequest req) {
		HttpSession session = req.getSession();
		ProfileVo profile = (ProfileVo) session.getAttribute("profile");

		MyVentureVo myVenture = userDao.myVentureInfo(profile);
		req.setAttribute("myVenture", myVenture);
		session.setAttribute("myVenture", myVenture);
	}

	// ��������� ����
	// ķ�������� �ڵ�����(��������� ��������)
	@Override
	public void ventureAdminUpdateOne(HttpServletRequest req, MyVentureVo myVenture) {
		userDao.ventureUpdate(myVenture);
		userDao.campInfoUpdate(myVenture);

		HttpSession session = req.getSession();
		session.setAttribute("myVenture", myVenture);
	}

	// ķ���� ���
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
	public void campUpdateOne(HttpServletRequest req,MultipartFile[] files, CampVo campVo) {
		System.out.println(1111);
		UploadPhoto up = new UploadPhoto();
		String caphoto = up.upload(files, req, campVo);
		System.out.println("photo : "+campVo.getCaphoto());
		System.out.println("caphoto : "+caphoto);
		if(campVo.getCaphoto()!=null) {
			if(!caphoto.isEmpty()) {
				campVo.setCaphoto(caphoto+","+campVo.getCaphoto());
			}
		}
		else {
			campVo.setCaphoto(caphoto);
		}
		System.out.println("caphoto : "+campVo.getCaphoto());
		int result = userDao.campUpdate(campVo);
		System.out.println("result : " + result);
		req.setAttribute("myCamp", campVo);
	}

	// �� �ȷο�����Ʈ ���
	@Override
	public void followerList(HttpServletRequest req, ProfileVo profile) {
		req.setAttribute("follower", userDao.myFollowerSelectAll(profile));
	}

	// �� �ȷ��׸���Ʈ ���
	@Override
	public void followList(HttpServletRequest req, ProfileVo profile) {
		req.setAttribute("following", userDao.myFollowingSelectAll(profile));
	}

}
