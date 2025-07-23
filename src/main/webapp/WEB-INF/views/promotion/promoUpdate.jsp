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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj69FH4R/5mcr" crossorigin="anonymous">
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
    <form id="promoUpdateForm" action="${contextPath}/promoBoard/update" method="post" enctype="multipart/form-data">
        <input type="hidden" name="promoId" value="${promo.promoId}" />
        <input type="hidden" name="originalPromoPosterPath" value="${promo.posterPath}"> <%-- 기존 이미지 경로 --%>
        <input type="hidden" id="contextPath" value="${contextPath}"> <%-- JavaScript에서 사용할 contextPath --%>

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
            <label class="form-label"><strong>프로모션 URL</strong></label>
            <input type="url" id="promotionPageUrl" class="form-control" name="promotionPageUrl" value="${promo.promotionPageUrl}" readonly />
        </div>

        <!-- Poster Image Upload -->
        <div class="form-group file-input-group">
            <label for="promoPoster">포스터 이미지</label>
            <div class="file-input-wrapper">
                <input type="file" id="promoPoster" name="promoPoster" accept="image/*" disabled /> <%-- 초기 상태 disabled --%>
                <!-- Custom File Select Button -->
                <label for="promoPoster" class="file-upload-button">파일 선택</label>
                <span id="fileNameDisplay" class="file-name-display">선택된 파일 없음</span>
            </div>
            <!-- Image Preview Area -->
            <div class="image-preview" id="imagePreview">
                <c:choose>
                    <c:when test="${not empty promo.posterPath}">
                        <%-- ⭐⭐ promo.posterPath가 이미 /resources/images/ 를 포함하므로, 여기서는 contextPath만 붙입니다. ⭐⭐ --%>
                        <img src="${contextPath}${promo.posterPath}" alt="Existing Image" onerror="this.onerror=null;this.src='https://placehold.co/600x600/e0e0e0/ffffff?text=No+Image';">
                    </c:when>
                    <c:otherwise>
                        <span class="no-image-text">이미지 미리보기</span>
                    </c:otherwise>
                </c:choose>
            </div>
            <c:if test="${not empty promo.posterPath}">
                <div class="form-check mt-3">
                    <input class="form-check-input" type="checkbox" id="deleteOriginalImage" name="deleteOriginalImage" value="true">
                    <label class="form-check-label" for="deleteOriginalImage">
                        기존 이미지 삭제
                    </label>
                </div>
            </c:if>
        </div>

        <div class="d-flex justify-content-between mt-4 btn-group-bottom">
            <a href="${contextPath}/promoBoard" class="btn btn-outline-secondary">게시판으로 돌아가기</a>

            <div id="adminButtons" class="btn-group-right">
                <button type="button" class="btn btn-primary" onclick="enableEdit()">수정</button>
                <form action="${contextPath}/promoBoard/delete" method="post" style="display:inline-block;">
                    <input type="hidden" name="promoId" value="${promo.promoId}" />
                    <input type="hidden" name="appId" value="${promo.appId}" />
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

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- Custom JS for this page -->
<script src="${contextPath}/resources/js/promoUpdate.js"></script>
<script src="${contextPath}/resources/js/commonModal.js"></script>
</body>
</html>
