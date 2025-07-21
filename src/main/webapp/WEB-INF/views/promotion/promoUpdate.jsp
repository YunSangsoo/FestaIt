<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>홍보 게시글 수정/삭제</title>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <!-- Custom CSS for this page -->
    <link rel="stylesheet" href="${contextPath}/resources/css/promoUpdate.css">
</head>
<body class="bg-light">

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- Header Spacer -->
<div class="top-spacer"></div>

<div class="container bg-white p-4 shadow-sm rounded">
    <h4 class="border-bottom pb-2">홍보 게시글 수정/삭제</h4>

    <!-- Flash Message Output -->
    <c:if test="${not empty alertMsg}">
        <div class="alert alert-info">${alertMsg}</div>
    </c:if>

    <!-- Update Form -->
    <!-- ⭐ enctype="multipart/form-data"를 추가하여 파일 업로드를 가능하게 합니다. ⭐ -->
    <form id="promoUpdateForm" action="${contextPath}/promoBoard/update" method="post" enctype="multipart/form-data">
        <input type="hidden" name="promoId" value="${promo.promoId}" />

        <div class="mb-3">
            <label class="form-label"><strong>제목</strong></label>
            <input type="text" id="promoTitle" class="form-control" name="promoTitle" value="${promo.promoTitle}" readonly />
        </div>

        <div class="mb-3">
            <label class="form-label"><strong>작성일</strong></label>
            <div>
                <fmt:formatDate value="${promo.createDate}" pattern="yyyy.MM.dd HH:mm" />
            </div>
        </div>
        
        <div class="mb-3">
            <label class="form-label"><strong>내용</strong></label>
            <textarea id="promoDetail" class="form-control" name="promoDetail" rows="10" readonly><c:out value="${promo.promoDetail}" /></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label"><strong>조회수</strong></label>
            <input type="text" class="form-control" value="${promo.views}" readonly />
        </div>

        <div class="mb-3">
            <label class="form-label"><strong>프로모션 URL</strong></label>
            <input type="url" id="promotionPageUrl" class="form-control" name="promotionPageUrl" value="${promo.promotionPageUrl}" readonly />
        </div>

        <!-- ⭐ 포스터 이미지 첨부 필드 및 미리보기 추가 ⭐ -->
        <div class="mb-3 file-input-group">
            <label for="promoPoster" class="form-label"><strong>포스터 이미지</strong></label>
            <div class="file-input-wrapper">
                <input type="file" id="promoPoster" name="reUploadFile" accept="image/*" /> <!-- ⭐ name을 reUploadFile로 변경 ⭐ -->
                <label for="promoPoster" class="file-upload-button">파일 선택</label>
                <span id="fileNameDisplay" class="file-name-display">
                    <c:choose>
                        <c:when test="${not empty promo.posterPath}">
                            현재 파일: ${promo.posterPath.substring(promo.posterPath.lastIndexOf('/') + 1)}
                            <input type="hidden" name="originalFileName" value="${promo.posterPath.substring(promo.posterPath.lastIndexOf('/') + 1)}">
                        </c:when>
                        <c:otherwise>
                            선택된 파일 없음
                        </c:otherwise>
                    </c:choose>
                </span>
            </div>
            <!-- 이미지 미리보기 영역 -->
            <div class="image-preview" id="imagePreview">
                <c:choose>
                    <c:when test="${not empty promo.posterPath}">
                        <img src="${contextPath}/resources/uploadFiles/${promo.posterPath}" alt="현재 포스터 이미지">
                    </c:when>
                    <c:otherwise>
                        <span class="no-image-text">이미지 미리보기</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <!-- ⭐ 이미지 관련 필드 끝 ⭐ -->

        <div class="d-flex justify-content-between mt-4 btn-group-bottom">
            <a href="${contextPath}/promoBoard" class="btn btn-outline-secondary">게시판으로 돌아가기</a>

            <div id="adminButtons" class="btn-group-right">
                <button type="button" class="btn btn-primary" onclick="enableEdit()">수정</button>
                
                <!-- Delete Form (inline-block handled by CSS) -->
                <form action="${contextPath}/promoBoard/delete" method="post">
                    <input type="hidden" name="promoId" value="${promo.promoId}" />
                    <button type="button" class="btn btn-danger" id="deleteButton">삭제</button> 
                </form>
            </div>

            <div id="editButtons" class="btn-group-right" style="display:none;">
                <button type="submit" class="btn btn-success" id="saveBtn">저장</button>
                <button type="button" class="btn btn-secondary" onclick="cancelEdit()" id="cancelBtn">취소</button>
            </div>
        </div>
    </form>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<jsp:include page="/WEB-INF/views/common/modal.jsp" /> <!-- 공통 모달 포함 -->

<!-- Custom JS for this page -->
<script src="${contextPath}/resources/js/promoUpdate.js"></script>
<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="${contextPath}/resources/js/commonModal.js"></script> 
</body>
</html>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const promoTitleInput = document.getElementById('promoTitle');
        const promoDetailTextarea = document.getElementById('promoDetail');
        const promotionPageUrlInput = document.getElementById('promotionPageUrl');
        const promoPosterInput = document.getElementById('promoPoster'); // 새로 추가된 파일 입력
        const fileNameDisplay = document.getElementById('fileNameDisplay');
        const imagePreview = document.getElementById('imagePreview');
        const adminButtons = document.getElementById('adminButtons');
        const editButtons = document.getElementById('editButtons');
        const saveBtn = document.getElementById('saveBtn');
        const cancelBtn = document.getElementById('cancelBtn');

        // 원본 값 저장 (취소 시 복원용)
        const originalValues = {
            promoTitle: promoTitleInput.value,
            promoDetail: promoDetailTextarea.value,
            promotionPageUrl: promotionPageUrlInput.value,
            posterPath: imagePreview.innerHTML // 초기 이미지 미리보기 상태 저장
        };

        // 수정 모드 활성화 함수
        window.enableEdit = function() {
            promoTitleInput.removeAttribute('readonly');
            promoDetailTextarea.removeAttribute('readonly');
            promotionPageUrlInput.removeAttribute('readonly');
            promoPosterInput.removeAttribute('disabled'); // 파일 입력 활성화

            adminButtons.style.display = 'none';
            editButtons.style.display = 'flex';
        };

        // 수정 모드 비활성화 및 원본 값 복원 함수
        window.cancelEdit = function() {
            promoTitleInput.setAttribute('readonly', true);
            promoDetailTextarea.setAttribute('readonly', true);
            promotionPageUrlInput.setAttribute('readonly', true);
            promoPosterInput.setAttribute('disabled', true); // 파일 입력 비활성화

            // 원본 값 복원
            promoTitleInput.value = originalValues.promoTitle;
            promoDetailTextarea.value = originalValues.promoDetail;
            promotionPageUrlInput.value = originalValues.promotionPageUrl;
            imagePreview.innerHTML = originalValues.posterPath; // 이미지 미리보기 복원
            fileNameDisplay.textContent = originalValues.posterPath.includes('현재 파일:') ? originalValues.posterPath.substring(originalValues.posterPath.indexOf('현재 파일:') + 6) : '선택된 파일 없음';
            promoPosterInput.value = ''; // 파일 입력 초기화

            adminButtons.style.display = 'flex';
            editButtons.style.display = 'none';
        };

        // 파일 선택 시 미리보기 처리
        promoPosterInput.addEventListener('change', function() {
            if (this.files && this.files[0]) {
                const file = this.files[0];
                fileNameDisplay.textContent = `새 파일: ${file.name}`; // 파일 이름 표시

                const reader = new FileReader();
                reader.onload = function(e) {
                    imagePreview.innerHTML = `<img src="${e.target.result}" alt="새 이미지 미리보기">`;
                };
                reader.readAsDataURL(file);
            } else {
                // 파일 선택 취소 시 기존 이미지 또는 "이미지 미리보기" 텍스트로 복원
                imagePreview.innerHTML = originalValues.posterPath;
                fileNameDisplay.textContent = originalValues.posterPath.includes('현재 파일:') ? originalValues.posterPath.substring(originalValues.posterPath.indexOf('현재 파일:') + 6) : '선택된 파일 없음';
            }
        });

        // 삭제 버튼 이벤트는 promoUpdate.js로 이동 (중복 방지)
        // 이 스크립트 블록은 JSP 파일 하단에 위치하여 DOM 로드 후 실행됩니다.
    });
</script>
