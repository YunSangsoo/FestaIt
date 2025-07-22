package com.kh.festait.common.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class Image {
	private int imgNo;
	private String imgType;
	private String originName;
	private String changeName;
	private int imgOrder;
	private Date createDate;
	private int refNo;
}