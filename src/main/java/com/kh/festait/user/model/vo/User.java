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
import lombok.Data; // ⭐️ @Data 어노테이션으로 통일
import lombok.NoArgsConstructor;

@Data // @Getter, @Setter, @ToString, @EqualsAndHashCode, @RequiredArgsConstructor 포함
@NoArgsConstructor
@AllArgsConstructor
@Builder
// Spring Security의 UserDetails 인터페이스를 구현하여 사용자 인증 및 권한 정보를 제공합니다.
public class User implements UserDetails {

    // USER 테이블의 컬럼에 매핑되는 필드들
    private int userNo;             // USER_NO (사용자 고유 번호)
    private Integer compId;         // COMP_ID (회사 ID, NULL 허용)
    private String userId;          // USER_ID (로그인 ID)
    private String userName;        // USER_NAME (사용자 이름)
    private String userPwd;         // USER_PWD (비밀번호)
    private String email;           // EMAIL
    private String nickname;        // NICKNAME
    private Date birth;             // BIRTH (생년월일)
    private String addr;            // ADDR (주소)
    private String phone;           // PHONE (전화번호)
    private String gender;          // GENDER (성별)
    private String profileImgPath;  // PROFILE_IMG_PATH (프로필 이미지 경로)
    private Date enrollDate;        // ENROLL_DATE (가입일)
    private Date updateDate;        // UPDATE_DATE (수정일)
    private String status;          // STATUS (계정 상태: 'T' - 활성, 'F' - 비활성)
    private Date lastLoginAt;       // LAST_LOGIN_AT (마지막 로그인 시간)

    // Spring Security 권한 정보를 담을 필드
    // 이 필드는 DB의 AUTHORITIES 테이블에서 조회하여 UserDetailsService에서 설정됩니다.
    private List<GrantedAuthority> authorities;

    // --- UserDetails 인터페이스 구현 메소드 ---

    // 사용자의 권한 목록을 반환합니다.
    // AUTHORITIES 테이블에서 조회된 권한들을 GrantedAuthority 객체로 변환하여 리스트로 반환합니다.
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        // 실제 애플리케이션에서는 UserDetailsService 구현체에서
        // DB의 AUTHORITIES 테이블을 조회하여 이 authorities 필드를 채워줍니다.
        // 현재는 빌더를 통해 주입받거나, 필요에 따라 초기화 로직을 추가할 수 있습니다.
        if (this.authorities == null) {
            this.authorities = new ArrayList<>();
        }
        return this.authorities;
    }

    // 사용자의 비밀번호를 반환합니다.
    @Override
    public String getPassword() {
        return userPwd;
    }

    // 사용자의 사용자 이름(ID)을 반환합니다.
    @Override
    public String getUsername() {
        return userId;
    }

    // 계정 만료 여부를 반환합니다. (true: 만료되지 않음)
    // 우리 시스템에서는 계정 만료 개념이 없으므로 항상 true를 반환합니다.
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    // 계정 잠금 여부를 반환합니다. (true: 잠금되지 않음)
    // 우리 시스템에서는 계정 잠금 개념이 없으므로 항상 true를 반환합니다.
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    // 자격 증명(비밀번호) 만료 여부를 반환합니다. (true: 만료되지 않음)
    // 우리 시스템에서는 비밀번호 만료 개념이 없으므로 항상 true를 반환합니다.
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    // 계정 활성화 여부를 반환합니다. (true: 활성화됨)
    // USER 테이블의 STATUS 컬럼 값('T' 또는 'F')을 기반으로 활성화 여부를 판단합니다.
    @Override
    public boolean isEnabled() {
        return "T".equals(status); // 'T'일 경우 true, 그 외(F 등)는 false
    }

    // 편의를 위한 권한 설정 메소드 (UserDetailsService에서 사용될 수 있음)
    public void setAuthorities(List<String> roleNames) {
        this.authorities = new ArrayList<>();
        for (String roleName : roleNames) {
            this.authorities.add(new SimpleGrantedAuthority(roleName));
        }
    }
}
