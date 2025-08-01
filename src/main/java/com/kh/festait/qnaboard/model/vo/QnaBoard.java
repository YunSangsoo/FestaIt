package com.kh.festait.qnaboard.model.vo;


import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class QnaBoard {
	
	 private int qnaId;             // QNA_ID
	 private int userNo;            // USER_NO
	 private String qnaTitle;       // QNA_TITLE
	 private String qnaDetail;      // QNA_DETAIL
	 private Date createDate;       // CREATE_DATE
	 private Date updateDate;       // UPDATE_DATE
	 private String qnaType;        // QNA_TYPE
	 private String isPrivate;      // IS_PRIVATE (Y/N)
	 private String answerDetail;   // ANSWER_DETAIL
	 private Date answerDate;       // ANSWER_DATE
	 
	 private boolean answered;

}
