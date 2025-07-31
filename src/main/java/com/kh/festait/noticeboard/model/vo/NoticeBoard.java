package com.kh.festait.noticeboard.model.vo;

import java.util.Date;

import com.kh.festait.common.model.vo.Image;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class NoticeBoard {
	private int noticeId;
    private String noticeTitle;
    private String noticeDetail;
    private Date createDate;
    private Date updateDate;
    private String highlight;

    private Image posterImage;
}
