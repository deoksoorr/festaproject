package com.fin.festa.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.fin.festa.model.entity.GroupCommentVo;
import com.fin.festa.model.entity.GroupPostVo;
import com.fin.festa.model.entity.MyCommentVo;
import com.fin.festa.model.entity.MyFollowingVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.ReportListVo;

public interface NewsService {

		void  newsFeedSelectAll(Model model, MyFollowingVo myFollowingVo);
		
		void  newsFeedCmmtInsertOne(Model model, GroupCommentVo groupCommentVo, MyCommentVo myCommentVo);
		
		void  newsFeedCmmtDeleteOne(Model model, GroupCommentVo groupCommentVo, MyCommentVo myCommentVo);
		
		void  newsLikeInsertOne(HttpServletRequest req, MyGoodVo myGoodVo);
		
		void  newsLikeDeleteOne(HttpServletRequest req, MyGoodVo myGoodVo);
		
		void  newsFeedReport(Model model, ReportListVo reportListVo);
		
		void newsFeedUpdateOne(Model model, GroupPostVo groupPostVo, MyPostVo myPostVo);
		
		void newsFeedDeleteOne(Model model, GroupPostVo groupPostVo, MyPostVo myPostVo);
}
