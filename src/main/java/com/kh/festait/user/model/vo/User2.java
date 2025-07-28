package com.kh.festait.user.model.vo;


import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@Data
@ToString
// 사업자 정보 저장 필드
public class User2 {
	
	private int compId; // 사업자 아이디
    
    private String bsGrgiNum; // 사업자번호
    
    private String compAddr; // 사업자 주소
    
    private String AddrDetail; // 사업자 상세주소
    
    private String compName; // 사업자상호명
}
