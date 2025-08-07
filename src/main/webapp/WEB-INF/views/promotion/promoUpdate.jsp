<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>홍보 게시글 수정/삭제</title>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${contextPath}/resources/css/promoForm.css" />

    <style>
        .page-wrapper {
            background-color: #e0ffe0 !important;
        }
    </style>
</head>
<body class="bg-light">

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<div class="top-spacer"></div>

<div class="page-wrapper container bg-white p-4 shadow-sm rounded">
    <h4 class="promo-form-title border-bottom pb-2">홍보 게시글 수정/삭제</h4>

    <c:if test="${not empty alertMsg}">
        <div class="alert alert-info">${alertMsg}</div>
    </c:if>
    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger">${errorMsg}</div>
    </c:if>

    <form:form
        id="promoUpdateForm"
        modelAttribute="promo"
        action="${contextPath}/promoBoard/promoUpdate"
        method="post"
        enctype="multipart/form-data">
        
        <form:hidden path="promoId" />
        <form:hidden path="appId" />
        <form:hidden path="posterImage.originName" />
        <form:hidden path="posterImage.changeName" id="originalPromoPosterPath" />
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

        <div class="mb-3">
            <label class="form-label"><strong>제목</strong></label>
            <form:input path="promoTitle" cssClass="form-control" readonly="true" id="promoTitle" />
        </div>

        <div class="mb-3">
            <label class="form-label"><strong>작성일</strong></label>
            <div>
                <fmt:formatDate value="${promo.createDate}" pattern="yyyy.MM.dd HH:mm" />
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label"><strong>내용</strong></label>
            <%-- ⭐ 핵심 수정: <form:textarea> 태그 내부를 비우고 단일 태그로 사용 ⭐ --%>
            <form:textarea path="promoDetail" cssClass="form-control" rows="10" readonly="true" id="promoDetail" />
        </div>

        <div class="form-group mb-3">
            <label class="form-label">홍보 URL (선택 사항)</label>
            <form:input path="promotionPageUrl" id="promotionPageUrl" cssClass="form-control" placeholder="http:// 또는 https:// 로 시작하는 URL 입력" type="url" />
            <form:errors path="promotionPageUrl" cssClass="text-danger mt-1" />
        </div>
        
        <div class="form-group file-input-group mb-3">
            <label class="form-label">포스터 이미지</label>
            <div class="file-input-wrapper">
                <input type="file" id="promoPoster" name="promoPoster" accept="image/*" class="form-control-file" disabled />
                <label for="promoPoster" class="file-upload-button">파일 선택</label>
                <span id="fileNameDisplay" class="file-name-display">선택된 파일 없음</span>
            </div>
        </div>

        <div class="image-preview" id="imagePreview">
            <c:choose>
                <c:when test="${not empty promo.posterImage.changeName}">
                    <img src="${contextPath}${promo.posterImage.changeName}" alt="포스터 이미지"
                        onerror="this.onerror=null;this.src='https://placehold.co/600x600/e0e0e0/ffffff?text=No+Image';" />
                </c:when>
                <c:otherwise>
                    <span class="no-image-text">이미지 미리보기</span>
                </c:otherwise>
            </c:choose>
        </div>


        <div class="d-flex justify-content-end mt-4 align-items-center gap-2">
            <sec:authorize access="isAuthenticated()">
                <sec:authentication property="principal.userNo" var="loginUserNo" />

                <c:choose>
                    <c:when test="${loginUserNo == promo.writerUserNo}">
                        <div class="btn-group" role="group" aria-label="user-controls">
                            <button type="button" class="btn btn-primary" onclick="enableEdit()">수정</button>
                            <div id="editButtons" style="display:none;">
                                <button type="submit" class="btn btn-success">저장</button>
                                <button type="button" class="btn btn-secondary" onclick="cancelEdit()">취소</button>
                            </div>
                            <form id="deleteForm" action="${contextPath}/promoBoard/delete" method="post" style="display:inline;">
                                <input type="hidden" name="promoId" value="${promo.promoId}" />
                                <input type="hidden" name="appId" value="${promo.appId}" />
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <button type="button" class="btn btn-danger deleteButton">삭제</button>
                            </form>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <sec:authorize access="hasRole('ROLE_ADMIN')">
                            <div class="btn-group" role="group" aria-label="admin-controls">
                                <button type="button" class="btn btn-primary" onclick="enableEdit()">수정</button>
                                <div id="editButtons" style="display:none;">
                                    <button type="submit" class="btn btn-success">저장</button>
                                    <button type="button" class="btn btn-secondary" onclick="cancelEdit()">취소</button>
                                </div>
                                <form id="deleteForm" action="${contextPath}/promoBoard/delete" method="post" style="display:inline;">
                                    <input type="hidden" name="promoId" value="${promo.promoId}" />
                                    <input type="hidden" name="appId" value="${promo.appId}" />
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button type="button" class="btn btn-danger deleteButton">취소</button>
                                </form>
                            </div>
                        </sec:authorize>
                    </c:otherwise>
                </c:choose>
            </sec:authorize>
        </div>

    </form:form>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<jsp:include page="/WEB-INF/views/common/modal.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/js/promoUpdate.js"></script>
<script src="${contextPath}/resources/js/commonModal.js"></script>

</body>
</html>