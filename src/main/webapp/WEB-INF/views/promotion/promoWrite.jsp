<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>홍보 게시글 작성</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/promoWrite.css">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <!-- Header Spacer -->
    <div class="top-spacer"></div>

    <div class="page-wrapper">
        <h1 class="promo-write-title">홍보 게시글 작성</h1>

        <!-- Post Registration Form -->
        <!-- ⭐ 이 부분의 action 속성을 수정해야 합니다. ⭐ -->
        <form action="${pageContext.request.contextPath}/promoBoard/promoWrite" method="post" enctype="multipart/form-data">
            <!-- Title Input -->
            <div class="form-group">
                <label for="promoTitle">제목</label>
                <input type="text" id="promoTitle" name="promoTitle" class="form-control" placeholder="게시글 제목을 입력하세요" required>
            </div>

            <!-- Content Input -->
            <div class="form-group">
                <label for="promoContent">내용</label>
                <textarea id="promoContent" name="promoContent" class="form-control" rows="10" placeholder="게시글 내용을 입력하세요" required></textarea>
            </div>

            <!-- Poster Image Upload -->
            <div class="form-group file-input-group">
                <label for="promoPoster">포스터 이미지</label>
                <div class="file-input-wrapper">
                    <input type="file" id="promoPoster" name="promoPoster" accept="image/*" />
                    <!-- Custom File Select Button -->
                    <label for="promoPoster" class="file-upload-button">파일 선택</label>
                    <span id="fileNameDisplay" class="file-name-display">선택된 파일 없음</span>
                </div>
                <!-- Image Preview Area -->
                <div class="image-preview" id="imagePreview">
                    <span class="no-image-text">이미지 미리보기</span>
                </div>
            </div>

            <!-- Button Group -->
            <div class="button-group">
                <button type="submit" class="submit-btn">등록하기</button>
                <!-- ⭐ 이 부분의 onclick 속성도 수정해야 합니다. ⭐ -->
                <button type="button" class="cancel-btn" onclick="location.href='${pageContext.request.contextPath}/promoBoard'">취소</button>
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
