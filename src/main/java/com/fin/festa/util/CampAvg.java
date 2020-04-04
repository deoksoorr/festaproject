package com.fin.festa.util;

import com.fin.festa.model.entity.CampReviewVo;

//캠핑장 별점계산
public class CampAvg {

	public CampReviewVo avgCalculate(CampReviewVo campReviewVo) {
		
		double crgood=campReviewVo.getCrgood();
		double caavg=campReviewVo.getCamp().getCaavg();
		
		caavg=(Math.round(((caavg+crgood)*10)/2))/10.0;
		campReviewVo.getCamp().setCaavg(caavg);
		
		return campReviewVo;
	}
}
