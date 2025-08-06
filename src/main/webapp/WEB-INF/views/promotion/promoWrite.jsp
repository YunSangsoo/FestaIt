<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>홍보 게시글 작성</title>

    <c:set var="contextPath" value="${pageContext.request.contextPath}" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />

    <link rel="stylesheet" href="${contextPath}/resources/css/promoForm.css" />

    <style>
        .file-input-wrapper #promoPoster {
            display: none;
        }
    </style>

</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div class="top-spacer"></div>

    <sec:authorize access="isAuthenticated()">
        <div class="page-wrapper container mt-5">
			<h1 class="promo-form-title border-bottom pb-2">홍보 게시글 작성</h1>

            <c:if test="${not empty alertMsg}">
                <div class="alert alert-info">${alertMsg}</div>
            </c:if>
            <c:if test="${not empty errorMsg}">
                <div class="alert alert-danger">${errorMsg}</div>
            </c:if>
            <c:if test="${not empty infoMsg}">
                <div class="alert alert-warning">${infoMsg}</div>
            </c:if>

            <form:form action="${contextPath}/promoBoard/promoWrite" method="post" modelAttribute="promo" enctype="multipart/form-data">
                
                <div class="mb-3 form-group">
                    <label for="appId" class="form-label">홍보할 행사 선택</label>
                    <form:select path="appId" cssClass="form-select form-control" id="appId" required="true">
                        <form:option value="" label="-- 행사 선택 --" />
                        <form:options items="${eventApplications}" itemValue="appId" itemLabel="eventAppName" />
                    </form:select>
                    <form:errors path="appId" cssClass="text-danger mt-1" />
                    <c:if test="${empty eventApplications}">
                        <p class="text-danger mt-2">※ 작성 가능한 행사가 없습니다. 먼저 행사를 신청하고 승인 받아야 합니다.</p>
                    </c:if>
                </div>

                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                <div class="mb-3 form-group">
                    <label for="promoTitle" class="form-label">제목</label>
                    <form:input path="promoTitle" id="promoTitle" cssClass="form-control" placeholder="게시글 제목을 입력하세요" required="true" />
                    <form:errors path="promoTitle" cssClass="text-danger mt-1" />
                </div>

                <div class="mb-3 form-group">
                    <label for="promoDetail" class="form-label">내용</label>
                    <form:textarea path="promoDetail" id="promoDetail" cssClass="form-control" rows="10" placeholder="게시글 내용을 입력하세요" required="true" />
                    <form:errors path="promoDetail" cssClass="text-danger mt-1" />
                </div>

                <div class="mb-3 form-group">
                    <label for="promotionPageUrl" class="form-label">홍보 URL (선택 사항)</label>
                    <form:input path="promotionPageUrl" id="promotionPageUrl" cssClass="form-control" placeholder="http:// 또는 https:// 로 시작하는 URL 입력" type="url" />
                    <form:errors path="promotionPageUrl" cssClass="text-danger mt-1" />
                </div>

                <div class="mb-3 file-input-group form-group">
                    <label for="promoPoster" class="form-label">포스터 이미지</label>
                    <div class="file-input-wrapper">
                        <input type="file" id="promoPoster" name="promoPoster" accept="image/*" />
                        <label for="promoPoster" class="file-upload-button">파일 선택</label>
                        <span id="fileNameDisplay" class="file-name-display">선택된 파일 없음</span>
                    </div>
                    <div class="image-preview" id="imagePreview">
                        <span class="no-image-text">이미지 미리보기</span>
                    </div>
                </div>

				<div class="d-flex justify-content-end mt-4 align-items-center gap-2">
				    <button type="submit" class="btn btn-primary">등록</button>
				    <button type="button" class="btn btn-danger" onclick="location.href='${contextPath}/promoBoard'">취소</button>
				</div>
                
            </form:form>
        </div>
    </sec:authorize>

    <sec:authorize access="!isAuthenticated()">
        <div class="container mt-5">
            <div class="alert alert-warning text-center">
                글 작성 권한이 없습니다. 로그인을 먼저 해주세요.
            </div>
            <div class="text-center mt-3">
                <a href="${contextPath}/login" class="btn btn-primary">로그인 페이지로 이동</a>
            </div>
        </div>
    </sec:authorize>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const promoPosterInput = document.getElementById('promoPoster');
            const fileNameDisplay = document.getElementById('fileNameDisplay');
            const imagePreview = document.getElementById('imagePreview');

            promoPosterInput.addEventListener('change', function() {
                if (this.files && this.files[0]) {
                    const file = this.files[0];
                    fileNameDisplay.textContent = file.name;

                    const reader = new FileReader();
                    reader.onload = function(e) {
                        const imageUrl = e.target.result;
                        const noImageTextSpan = imagePreview.querySelector('.no-image-text');
                        if (noImageTextSpan) {
                            noImageTextSpan.remove();
                        }
                        let imgElement = imagePreview.querySelector('img');
                        if (imgElement) {
                            imgElement.src = imageUrl;
                        } else {
                            imgElement = document.createElement('img');
                            imgElement.src = imageUrl;
                            imgElement.alt = "Image Preview";
                            imgElement.classList.add('img-fluid', 'rounded');
                            imagePreview.appendChild(imgElement);
                        }
                    };
                    reader.onerror = function() {
                        console.error("파일 읽기 오류:", reader.error);
                        fileNameDisplay.textContent = '파일 읽기 오류';
                        imagePreview.innerHTML = `<span class="no-image-text text-danger">이미지 미리보기 (오류)</span>`;
                    };
                    reader.readAsDataURL(file);
                } else {
                    fileNameDisplay.textContent = '선택된 파일 없음';
                    imagePreview.innerHTML = `<span class="no-image-text text-muted">이미지 미리보기</span>`;
                }
            });
        });
    </script>
</body>
</html>