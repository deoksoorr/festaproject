package com.fin.festa.model;

import java.util.List;

import com.fin.festa.model.entity.CampReviewVo;
import com.fin.festa.model.entity.CampVo;
import com.fin.festa.model.entity.GroupVo;
import com.fin.festa.model.entity.MyBookMarkVo;
import com.fin.festa.model.entity.MyGoodVo;
import com.fin.festa.model.entity.PageSearchVo;
import com.fin.festa.model.entity.ReportListVo;

public interface CampDao {
	
	List<CampVo> newCampSelectAll();
	
	List<CampVo> allLocationCamp();
	
	List<CampVo> locationCamp(CampVo campVo);
	
	CampVo campInfoSelectOne(CampVo campVo);
	
	int ventureGroupCheck(CampVo campVo);
	
	GroupVo campVentureGroup(CampVo campVo);
	
	List<CampReviewVo> campReview(CampVo campVo);
	
	List<CampVo> sameLocationCamp(CampVo campVo);
	
	int campReviewCount(CampVo campVo);
	
	void campReviewInsert(CampReviewVo campReviewVo);
	
	int campAvgUpdate(CampReviewVo campReviewVo);
	
	int campReviewDelete(CampReviewVo campReviewVo);
	
	void campLikeInsert(MyGoodVo good);
	
	int campLikeDelete(MyGoodVo good);
	
	int campLikeOnePlus(CampVo camp);
	
	int campLikeOneMinus(CampVo camp);
	
	void campReport(ReportListVo reportListVo);
	
	void campBookMarkInsert(MyBookMarkVo bookMark);
	
	int campBookMarkDelete(MyBookMarkVo bookMark);
	
	List<MyGoodVo> myGoodRenewal(MyGoodVo good);
	
	List<MyBookMarkVo> myboodRenewal(MyBookMarkVo bookMark);
	
	int campReportCountUpdate(ReportListVo reportListVo);
}