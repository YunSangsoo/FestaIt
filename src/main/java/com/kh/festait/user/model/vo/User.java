package com.kh.festait.user.model.vo;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data; // @Data 어노테이션 사용
import lombok.NoArgsConstructor;

@Data // Getter, Setter, ToString, EqualsAndHashCode, RequiredArgsConstructor 포함
@NoArgsConstructor
@AllArgsConstructor
@Builder
// Spring Security의 UserDetails 인터페이스 구현. 사용자 인증 및 권한 정보 제공.
public class User implements UserDetails {

    // --- USER 테이블 컬럼 매핑 필드 ---
    private int userNo;             // 사용자 고유 번호
    private Integer compId;         // 회사 ID (NULL 허용)
    private String userId;          // 로그인 ID
    private String userName;        // 사용자 이름
    private String userPwd;         // 비밀번호
    private String email;           // 이메일
    private String nickname;        // 닉네임
    private Date birth;             // 생년월일
    private String addr;            // 주소
    private String phone;           // 전화번호
    private String gender;          // 성별
    private String profileImgPath;  // 프로필 이미지 경로
    private Date enrollDate;        // 가입일
    private Date updateDate;        // 수정일
    private String status;          // 계정 상태 ('T' - 활성, 'F' - 비활성)
    private Date lastLoginAt;       // 마지막 로그인 시간

    // Spring Security 권한 정보 필드
    // DB의 AUTHORITIES 테이블에서 조회하여 UserDetailsService에서 설정.
    private List<GrantedAuthority> authorities;

    // --- UserDetails 인터페이스 구현 메소드 ---

    // 사용자의 권한 목록 반환.
    // UserDetailsService 구현체에서 DB 조회 후 이 authorities 필드를 채움.
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        if (this.authorities == null) {
            this.authorities = new ArrayList<>();
        }
        return this.authorities;
    }

    // 사용자의 비밀번호 반환.
    @Override
    public String getPassword() {
        return userPwd;
    }

    // 사용자의 사용자 이름(ID) 반환.
    @Override
    public String getUsername() {
        return userId;
    }

    // 계정 만료 여부 반환 (true: 만료되지 않음).
    // 시스템에 계정 만료 개념이 없으므로 항상 true 반환.
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    // 계정 잠금 여부 반환 (true: 잠금되지 않음).
    // 시스템에 계정 잠금 개념이 없으므로 항상 true 반환.
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    // 자격 증명(비밀번호) 만료 여부 반환 (true: 만료되지 않음).
    // 시스템에 비밀번호 만료 개념이 없으므로 항상 true 반환.
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    // 계정 활성화 여부 반환 (true: 활성화됨).
    // USER 테이블의 STATUS 컬럼 값('T' 또는 'F') 기반으로 판단.
    @Override
    public boolean isEnabled() {
        return "T".equals(status); // 'T'일 경우 true, 그 외는 false
    }

    // 편의를 위한 권한 설정 메소드 (UserDetailsService에서 사용될 수 있음).
    public void setAuthorities(List<String> roleNames) {
        this.authorities = new ArrayList<>();
        for (String roleName : roleNames) {
            this.authorities.add(new SimpleGrantedAuthority(roleName));
        }
    }
}
