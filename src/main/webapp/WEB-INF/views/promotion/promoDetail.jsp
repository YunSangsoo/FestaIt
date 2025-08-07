<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>${promo.promoTitle} - 홍보 게시글</title>

    <c:set var="contextPath" value="${pageContext.request.contextPath}" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="${contextPath}/resources/css/promoDetail.css" />

    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />

    <script>
        var contextPath = "<c:out value='${contextPath}'/>";
    </script>
</head>
<body class="bg-light">

    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div class="top-spacer"></div>

    <div class="container bg-white p-4 shadow-sm rounded">
        <h2 class="mb-4 text-center">${promo.promoTitle}</h2>
        <hr />

        <div class="row mb-3">
            <div class="col-md-6">
                <p><strong>작성자:</strong> ${promo.promoWriter}</p>
                <p><strong>작성일:</strong> <fmt:formatDate value="${promo.createDate}" pattern="yyyy.MM.dd HH:mm" /></p>
            </div>
            <div class="col-md-6 text-md-end">
                <p><strong>조회수:</strong> ${promo.views}</p>
                <p><strong>이벤트 기간:</strong>
                    <c:choose>
                        <c:when test="${not empty promo.startDate and not empty promo.endDate}">
                            <fmt:formatDate value="${promo.startDate}" pattern="yyyy.MM.dd" /> - 
                            <fmt:formatDate value="${promo.endDate}" pattern="yyyy.MM.dd" />
                        </c:when>
                        <c:otherwise>날짜 정보 없음</c:otherwise>
                    </c:choose>
                </p>
            </div>
        </div>

		<div class="mb-4 image-preview-container">
		    <c:choose>
		        <c:when test="${not empty promo.posterImage and not empty promo.posterImage.changeName}">
		            <img src="${contextPath}${promo.posterImage.changeName}" alt="홍보 포스터" class="rounded shadow-sm"
		                 onerror="this.onerror=null;this.src='https://placehold.co/600x600/e0e0e0/ffffff?text=No+Image';" />
		        </c:when>
		        <c:otherwise>
		            <span class="no-image-text">이미지 미리보기</span>
		        </c:otherwise>
		    </c:choose>
		</div>

        <div class="mb-4 promo-detail-content">
            <p>${promo.promoDetail}</p>
        </div>

        <div class="mb-4 text-center">
            <c:choose>
                <c:when test="${not empty promo.promotionPageUrl}">
                    <a href="${promo.promotionPageUrl}" target="_blank" class="homepage-link">홈페이지 바로가기</a>
                </c:when>
                <c:otherwise>
                    <p>정보 없음</p>
                </c:otherwise>
            </c:choose>
        </div>

        <hr />

        <div class="d-flex justify-content-between mt-4">
            <a href="${contextPath}/promoBoard" class="btn btn-outline-secondary">목록 보기</a>

            <%-- 수정/삭제 버튼: 작성자이거나 관리자 --%>
            <c:if test="${loginUser.userNo == promo.writerUserNo}">
                <div class="btn-group">
                    <a href="${contextPath}/promoBoard/promoUpdate?promoId=${promo.promoId}" class="btn btn-primary">수정</a>
                    <button type="button" class="btn btn-danger" id="deleteButton">삭제</button>
                </div>
            </c:if>

            <sec:authorize access="hasRole('ROLE_ADMIN')">
                <c:if test="${loginUser.userNo != promo.writerUserNo}">
                    <div class="btn-group">
                        <a href="${contextPath}/promoBoard/promoUpdate?promoId=${promo.promoId}" class="btn btn-primary">수정</a>
                        <button type="button" class="btn btn-danger" id="deleteButton">삭제</button>
                    </div>
                </c:if>
            </sec:authorize>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/modal.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="${contextPath}/resources/js/commonModal.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const deleteButton = document.getElementById('deleteButton');

            if (deleteButton) {
                deleteButton.addEventListener('click', async function () {
                    const confirmed = await window.showCommonModal(
                        "게시글 삭제 확인",
                        "정말 이 게시글을 삭제하시겠습니까?",
                        true
                    );

                    if (confirmed) {
                        const csrfToken = document.querySelector('meta[name="_csrf"]').content;
                        const csrfHeaderName = document.querySelector('meta[name="_csrf_header"]').content;

                        const params = new URLSearchParams();
                        params.append('promoId', '${promo.promoId}');

                        fetch('${contextPath}/promoBoard/delete', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                                [csrfHeaderName]: csrfToken
                            },
                            body: params.toString()
                        })
                        .then(response => {
                            if (!response.ok) {
                                if (response.status === 403) {
                                    return response.text().then(errorMessage => {
                                        console.error("403 Forbidden 응답 내용:", errorMessage);
                                        throw new Error('권한이 없거나 요청이 위조되었을 수 있습니다.');
                                    });
                                }
                                return response.json().then(errorData => {
                                    throw new Error(errorData.message || `HTTP 오류! 상태: ${response.status}`);
                                }).catch(() => {
                                    return response.text().then(errorMessage => {
                                        console.error(`HTTP 오류 ${response.status} 응답 내용:`, errorMessage);
                                        throw new Error(`알 수 없는 HTTP 오류! 상태: ${response.status}`);
                                    });
                                });
                            }
                            return response.json();
                        })
                        .then(data => {
                            if (data.msg === 'success') {
                                window.showCommonModal("삭제 완료", "게시글이 성공적으로 삭제되었습니다.")
                                    .then(() => {
                                        window.location.href = '${contextPath}/promoBoard';
                                    });
                            } else {
                                window.showCommonModal("삭제 실패", "게시글 삭제에 실패했습니다. " + (data.message || "다시 시도해주세요."));
                            }
                        })
                        .catch(error => {
                            console.error('삭제 요청 중 오류 발생:', error);
                            window.showCommonModal("오류 발생", "삭제 중 오류가 발생했습니다: " + error.message);
                        });
                    }
                });
            }
        });
    </script>
</body>
</html>
