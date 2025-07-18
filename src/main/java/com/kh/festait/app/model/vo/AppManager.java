package com.kh.festait.app.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class AppManager {
	private int appId;
	private String managerName;
	private String email;
	private String tel;
	private String fax;
}
