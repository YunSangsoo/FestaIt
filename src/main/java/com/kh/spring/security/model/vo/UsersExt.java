package com.kh.spring.security.model.vo;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.kh.spring.users.model.vo.UsersVo; // ⭐ 추가: UsersVo 임포트 ⭐

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // getter/setter 등을 자동 생성
@NoArgsConstructor // 기본 생성자
public class UsersExt implements UserDetails { // ⭐ UserDetails 인터페이스 구현 ⭐

    private int userNo;
    private String userId;
    private String userPwd;
    private String status; // 'T' 또는 'F' (활성화 여부)
    private String userName; // 사용자 이름도 필요할 수 있음
    private String email; // 필요시 추가
    private String nickname; // 필요시 추가
    private String birth; // 필요시 추가
    private String addr; // 필요시 추가
    private String phone; // 필요시 추가
    private String gender; // 필요시 추가

    private List<GrantedAuthority> authorities; // ⭐ GrantedAuthority 리스트로 변경 ⭐

    // ⭐ 중요: UsersVo 객체와 권한 리스트(String)를 받아 UsersExt를 생성하는 생성자 ⭐
    public UsersExt(UsersVo userVo, List<String> roles) {
        this.userNo = userVo.getUserNo();
        this.userId = userVo.getUserId();
        this.userPwd = userVo.getUserPwd();
        this.status = userVo.getStatus();
        this.userName = userVo.getUserName();
        this.email = userVo.getEmail();
        this.nickname = userVo.getNickname();
        this.birth = userVo.getBirth();
        this.addr = userVo.getAddr();
        this.phone = userVo.getPhone();
        this.gender = userVo.getGender();

        this.authorities = new ArrayList<>();
        if (roles != null) {
            for (String role : roles) {
                this.authorities.add(new SimpleGrantedAuthority(role));
            }
        }
    }
    
    // ⭐ UserDetails 인터페이스 구현 메서드들 ⭐
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return this.authorities;
    }

    @Override
    public String getPassword() {
        return this.userPwd;
    }

    @Override
    public String getUsername() {
        return this.userId; // userId 필드를 Spring Security의 username으로 사용
    }

    @Override
    public boolean isAccountNonExpired() {
        return true; // 계정 만료 여부 (true면 만료되지 않음)
    }

    @Override
    public boolean isAccountNonLocked() {
        return true; // 계정 잠금 여부 (true면 잠겨있지 않음)
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true; // 비밀번호 만료 여부 (true면 만료되지 않음)
    }

    @Override
    public boolean isEnabled() {
        // ⭐ 'T' 상태일 때만 활성화된 것으로 간주 ⭐
        return "T".equalsIgnoreCase(this.status); // 상태 필드를 기반으로 활성화 여부 반환
    }
}