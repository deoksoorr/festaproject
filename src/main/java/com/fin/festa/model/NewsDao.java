package com.fin.festa.model;

import java.util.List;

import com.fin.festa.model.entity.FeedVo;
import com.fin.festa.model.entity.GroupCommentVo;
import com.fin.festa.model.entity.GroupPostVo;
import com.fin.festa.model.entity.MyCommentVo;
import com.fin.festa.model.entity.MyFollowingVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.MyPostVo;
import com.fin.festa.model.entity.ReportListVo;

public interface NewsDao {

	List<FeedVo> followFeedSelectAll(MyFollowingVo following);
	
	List<MyCommentVo> followCommentSelectAll(FeedVo feed);
	
	List<FeedVo> joinGroupFeedSelectAll(MyFollowingVo following);
	
	List<GroupCommentVo> joinGroupCommentSelectAll(FeedVo feed);
	
	void myFeedCmmtInsertOne(MyCommentVo cmmt);
	
	void groupFeedCmmtInsertOne(GroupCommentVo groupcmmt);
	
	int myFeedCmmtDeleteOne(MyCommentVo cmmt);
	
	int groupFeedCmmtDeleteOne(GroupCommentVo groupcmmt);
	
	void myFeedLikeInsertOne(MyGoodVo good);
	
	void groupFeedLikeInsertOne(MyGoodVo good);
	
	int myFeedLikeDeleteOne(MyGoodVo good);
	
	int groupFeedLikeDeleteOne(MyGoodVo good);
	
	void myFeedReportInsertOne(ReportListVo report);
	
	void groupFeedReportInsertOne(ReportListVo report);
	
	int myFeedDeleteOne(MyPostVo post);
	
	int groupFeedDeleteOne(GroupPostVo grouppost);
	
	int myFeedUpdateOne(MyPostVo post);
	
	int groupFeedUpdateOne(GroupPostVo grouppost);

	int myFeedLikeOnePlus(MyPostVo post);
	
	int groupFeedLikeOnePlus(GroupPostVo grouppost);
	
	int myFeedLikeOneMinus(MyPostVo post);
	
	int groupFeedLikeOneMinus(GroupPostVo grouppost);
	
	List<MyGoodVo> myGoodRenewal(MyGoodVo good);
	
	int feedReportCountUpdate(ReportListVo report);
}
