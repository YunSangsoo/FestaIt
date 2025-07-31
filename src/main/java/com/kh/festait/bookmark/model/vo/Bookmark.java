package com.kh.festait.bookmark.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class Bookmark {
	private int userNo;
	private int appId;
	private Date createDate;
}
