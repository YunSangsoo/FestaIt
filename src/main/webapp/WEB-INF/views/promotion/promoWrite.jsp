<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>홍보 게시글 작성</title>
    <!-- Google Fonts - Noto Sans KR (CSS에서 사용) -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <!-- promoWrite.css 파일 링크 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/promoWrite.css">
    <!-- Font Awesome 아이콘 (검색 버튼 등) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
    <!-- 상단 여백 (헤더가 있을 경우를 대비) -->
    <div class="top-spacer"></div>

    <div class="page-wrapper">
        <h1 class="promo-write-title">홍보 게시글 작성</h1>

        <!-- 게시글 등록 폼 -->
        <form action="${pageContext.request.contextPath}/promo/registerPromo.do" method="post" enctype="multipart/form-data">
            <!-- 제목 입력 필드 -->
            <div class="form-group">
                <label for="promoTitle">제목</label>
                <input type="text" id="promoTitle" name="promoTitle" class="form-control" placeholder="게시글 제목을 입력하세요" required>
            </div>

            <!-- 내용 입력 필드 -->
            <div class="form-group">
                <label for="promoContent">내용</label>
                <textarea id="promoContent" name="promoContent" class="form-control" rows="10" placeholder="게시글 내용을 입력하세요" required></textarea>
            </div>

            <!-- 포스터 이미지 첨부 필드 -->
            <div class="form-group file-input-group">
                <label for="promoPoster">포스터 이미지</label>
					<div class="file-input-wrapper">
					    <!-- 기본 input 숨김 처리 -->
					    <input type="file" id="promoPoster" name="promoPoster" accept="image/*" style="display: none;" />	
					    <!-- 이 라벨이 커스텀 파일 선택 버튼 역할 -->
					    <label for="promoPoster" class="file-upload-button">파일 선택</label>
					
					    <span id="fileNameDisplay" class="file-name-display">선택된 파일 없음</span>
					</div>
                <!-- 이미지 미리보기 영역 -->
                <div class="image-preview" id="imagePreview">
                    <span class="no-image-text">이미지 미리보기</span>
                </div>
            </div>

            <!-- 버튼 그룹 -->
            <div class="button-group">
                <button type="submit" class="submit-btn">등록하기</button>
                <button type="button" class="cancel-btn" onclick="location.href='${pageContext.request.contextPath}/promo/list.do'">취소</button>
            </div>
        </form>
    </div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const promoPosterInput = document.getElementById('promoPoster');
            const fileNameDisplay = document.getElementById('fileNameDisplay');
            const imagePreview = document.getElementById('imagePreview');

            // 파일 선택 시 이벤트 처리
            promoPosterInput.addEventListener('change', function() {
                if (this.files && this.files[0]) {
                    const file = this.files[0];
                    fileNameDisplay.textContent = file.name; // 파일 이름 표시

                    const reader = new FileReader();
                    reader.onload = function(e) {
                        // 이미지 미리보기 업데이트
                        imagePreview.innerHTML = `<img src="${e.target.result}" alt="Image Preview">`;
                    };
                    reader.readAsDataURL(file); // 파일을 Data URL로 읽기
                } else {
                    fileNameDisplay.textContent = '선택된 파일 없음';
                    imagePreview.innerHTML = `<span class="no-image-text">이미지 미리보기</span>`; // 이미지 없을 때 텍스트 표시
                }
            });
        });
    </script>
</body>
</html>
