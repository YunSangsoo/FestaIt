<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>홍보 게시글 작성</title>

    <%-- Bootstrap CSS 추가 --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/promoWrite.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div class="top-spacer"></div>

    <div class="page-wrapper container mt-5">
        <h1 class="promo-write-title text-center mb-4">홍보 게시글 작성</h1>

        <form action="${pageContext.request.contextPath}/promoBoard/promoWrite" method="post" enctype="multipart/form-data">
            
            <input type="hidden" name="appId" value="${selectedEventAppId}">
            <div class="mb-3">
                <label for="promoTitle" class="form-label">제목</label>
                <input type="text" id="promoTitle" name="promoTitle" class="form-control" placeholder="게시글 제목을 입력하세요" required>
            </div>

            <div class="mb-3">
                <label for="promoDetail" class="form-label">내용</label>
                <textarea id="promoDetail" name="promoDetail" class="form-control" rows="10" placeholder="게시글 내용을 입력하세요" required></textarea>
            </div>

            <div class="mb-3">
                <label for="promotionPageUrl" class="form-label">프로모션 웹사이트 (선택 사항)</label>
                <input type="url" id="promotionPageUrl" name="promotionPageUrl" class="form-control" placeholder="http:// 또는 https:// 로 시작하는 URL 입력">
            </div>

            <div class="mb-3 file-input-group">
                <label for="promoPoster" class="form-label">포스터 이미지</label>
                <div class="file-input-wrapper input-group">
                    <input type="file" id="promoPoster" name="promoPoster" accept="image/*" class="form-control" />
                    <label for="promoPoster" class="file-upload-button btn btn-outline-secondary">파일 선택</label>
                    <span id="fileNameDisplay" class.css="file-name-display input-group-text flex-grow-1">선택된 파일 없음</span>
                </div>
                <div class="image-preview border rounded mt-2 p-2 text-center" id="imagePreview">
                    <span class="no-image-text text-muted">이미지 미리보기</span>
                </div>
            </div>

            <div class="button-group d-flex justify-content-end gap-2 mt-4">
                <button type="submit" class="submit-btn btn btn-primary">등록하기</button>
                <button type="button" class="cancel-btn btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/promoBoard'">취소</button>
            </div>
        </form>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <%-- Bootstrap Bundle with Popper 추가 --%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

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
                        console.log("FileReader result (for assignment):", imageUrl);

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
                            imgElement.classList.add('img-fluid', 'rounded'); // Bootstrap 반응형 이미지 클래스 추가
                            imagePreview.appendChild(imgElement);
                        }
                    };

                    // 파일 읽기 실패 시
                    reader.onerror = function() {
                        console.error("파일 읽기 오류:", reader.error);
                        fileNameDisplay.textContent = '파일 읽기 오류';
                        imagePreview.innerHTML = `<span class="no-image-text text-danger">이미지 미리보기 (오류)</span>`; // 오류 메시지 표시
                    };

                    reader.readAsDataURL(file); // 파일을 Data URL로 읽기
                } else {
                    fileNameDisplay.textContent = '선택된 파일 없음';
                    imagePreview.innerHTML = `<span class="no-image-text text-muted">이미지 미리보기</span>`; // 이미지 없을 때 텍스트 표시
                }
            });
        });
    </script>
</body>
</html>