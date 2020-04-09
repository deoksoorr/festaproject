package com.fin.festa.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.fin.festa.model.NewsDaoImpl;
import com.fin.festa.model.entity.FeedVo;
import com.fin.festa.model.entity.GroupCommentVo;
import com.fin.festa.model.entity.GroupPostVo;
import com.fin.festa.model.entity.MyCommentVo;
import com.fin.festa.model.entity.MyFollowingVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.PageSearchVo;
import com.fin.festa.model.entity.ReportListVo;
import com.fin.festa.util.DateCalculate;

@Service
public class NewsServiceImpl implements NewsService{

	//등록,수정,삭제가 최소2개이상 들어가는 메소드는 꼭 트랜잭션 적용할것!!
	
	@Autowired
	NewsDaoImpl newsDao;
	
	//뉴스피드 출력(그룹피드,개인피드 합쳐서)
	@Override
	public void newsFeedSelectAll(HttpServletRequest req, MyFollowingVo myFollowingVo) {
		PageSearchVo page = new PageSearchVo();
		page.setPage5(1);
		
		FeedVo feed = new FeedVo();
		List<FeedVo> followFeed = newsDao.followFeedSelectAll(myFollowingVo);
		List<FeedVo> groupFeed = newsDao.joinGroupFeedSelectAll(myFollowingVo);
		
		// 그룹/개인피드 (날짜순 정렬)
		DateCalculate cal = new DateCalculate();
		List<FeedVo> sortList = cal.VoDateGoodReturn(followFeed, groupFeed);
		req.setAttribute("feedList", sortList);
		
		// 팔로우피드 댓글
		feed.setFeedList(followFeed);
		req.setAttribute("followComment", newsDao.followFeedSelectAll(myFollowingVo));
		
		// 그룹피드 댓글
		feed.setFeedList(groupFeed);
		req.setAttribute("groupComment", newsDao.joinGroupFeedSelectAll(myFollowingVo));
	}

	//뉴스피드 댓글등록(그룹피드,개인피드 구별해서 등록)
	@Override
	public void newsFeedCmmtInsertOne(Model model, GroupCommentVo groupCommentVo, MyCommentVo myCommentVo) {
		// TODO Auto-generated method stub
		
	}

	//뉴스피드 댓글삭제(그룹피드,개인피드 구별해서 삭제)
	@Override
	public void newsFeedCmmtDeleteOne(Model model, GroupCommentVo groupCommentVo, MyCommentVo myCommentVo) {
		// TODO Auto-generated method stub
		
	}

	//뉴스피드 좋아요등록(그룹피드,개인피드 구별해서 좋아요등록)
	//뉴스피드 좋아요갯수 +1
	//내 좋아요목록 갱신
	@Override
	public void newsLikeInsertOne(HttpServletRequest req, MyGoodVo myGoodVo) {
		// TODO Auto-generated method stub
		
	}

	//뉴스피드 좋아요해제(그룹피드,개인피드 구별해서 좋아요해제)
	//뉴스피드 좋아요갯수 -1
	//내 좋아요목록 갱신
	@Override
	public void newsLikeDeleteOne(HttpServletRequest req, MyGoodVo myGoodVo) {
		// TODO Auto-generated method stub
		
	}

	//뉴스피드 신고등록(그룹피드,개인피드 구별해서 신고등록)
	//신고당한유저 신고당한횟수 +1
	@Override
	public void newsFeedReport(HttpServletRequest req, ReportListVo reportListVo, MultipartFile[] files) {
		// TODO Auto-generated method stub
		
	}

	//뉴스피드 수정(그룹피드,개인피드 구별해서 수정)
	@Override
	public void newsFeedUpdateOne(HttpServletRequest req, GroupPostVo groupPostVo, MyPostVo myPostVo, MultipartFile[] files) {
		// TODO Auto-generated method stub
		
	}

	//뉴스피드 삭제(그룹피드,개인피드 구별해서 삭제)
	@Override
	public void newsFeedDeleteOne(Model model, GroupPostVo groupPostVo, MyPostVo myPostVo) {
		// TODO Auto-generated method stub
		
	}

}
