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

                    // 파일 읽기 성공 시
                    reader.onload = function(e) {
                        const imageUrl = e.target.result;
                        console.log("FileReader result (for assignment):", imageUrl); // 할당 직전 최종 Data URL 확인

                        // 기존의 "이미지 미리보기" 텍스트 제거
                        const noImageTextSpan = imagePreview.querySelector('.no-image-text');
                        if (noImageTextSpan) {
                            noImageTextSpan.remove();
                        }

                        let imgElement = imagePreview.querySelector('img');
                        if (imgElement) {
                            // 이미 <img> 태그가 있다면 src만 업데이트
                            imgElement.src = imageUrl;
                        } else {
                            // <img> 태그가 없다면 새로 생성하여 추가
                            imgElement = document.createElement('img');
                            imgElement.src = imageUrl;
                            imgElement.alt = "Image Preview";
                            imagePreview.appendChild(imgElement);
                        }
                    };

                    // 파일 읽기 실패 시
                    reader.onerror = function() {
                        console.error("파일 읽기 오류:", reader.error);
                        fileNameDisplay.textContent = '파일 읽기 오류';
                        imagePreview.innerHTML = `<span class="no-image-text">이미지 미리보기 (오류)</span>`; // 오류 메시지 표시
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
