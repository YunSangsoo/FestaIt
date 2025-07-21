<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${promo.promoTitle} - 홍보 게시글</title>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <!-- Google Fonts: Noto Sans KR -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <!-- Custom CSS for promoDetail -->
    <link rel="stylesheet" href="${contextPath}/resources/css/promoDetail.css">

    <!-- contextPath for JavaScript -->
    <script>
        var contextPath = "<c:out value='${contextPath}'/>";
    </script>
</head>
<body class="bg-light">

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <!-- Header Spacer -->
    <div class="top-spacer"></div>

    <div class="container bg-white p-4 shadow-sm rounded">
        <h2 class="mb-4 text-center">${promo.promoTitle}</h2>
        <hr>

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
                            <fmt:formatDate value="${promo.startDate}" pattern="yyyy.MM.dd" /> - <fmt:formatDate value="${promo.endDate}" pattern="yyyy.MM.dd" />
                        </c:when>
                        <c:otherwise>
                            날짜 정보 없음
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
        </div>

        <!-- 이미지 미리보기 컨테이너 -->
        <div class="mb-4 image-preview-container">
            <c:choose>
                <c:when test="${not empty promo.posterPath}">
                    <img src="${contextPath}/resources/uploadFiles/${promo.posterPath}" 
                         alt="홍보 포스터" 
                         class="rounded shadow-sm"
                         onerror="this.onerror=null;this.src='https://placehold.co/600x600/e0e0e0/ffffff?text=No+Image';">
                </c:when>
                <c:otherwise>
                    <span class="no-image-text">이미지 미리보기</span>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="mb-4 promo-detail-content">
            <p>${promo.promoDetail}</p>
        </div>

        <div class="mb-4">
            <p><strong>프로모션 웹사이트:</strong> 
                <c:if test="${not empty promo.promotionPageUrl}">
                    <a href="${promo.promotionPageUrl}" target="_blank">${promo.promotionPageUrl}</a>
                </c:if>
                <c:if test="${empty promo.promotionPageUrl}">
                    정보 없음
                </c:if>
            </p>
        </div>

        <hr>

        <div class="d-flex justify-content-between mt-4">
            <a href="${contextPath}/promoBoard" class="btn btn-outline-secondary">목록으로 돌아가기</a>

            <div class="btn-group">
                <a href="${contextPath}/promoBoard/promoUpdate?promoId=${promo.promoId}" class="btn btn-primary">수정</a>
                <button type="button" class="btn btn-danger" id="deleteButton">삭제</button>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <jsp:include page="/WEB-INF/views/common/modal.jsp" /> <!-- 공통 모달 포함 -->

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <!-- Custom JS for common modal -->
    <script src="${contextPath}/resources/js/commonModal.js"></script> 
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const deleteButton = document.getElementById('deleteButton');

            if (deleteButton) {
                deleteButton.addEventListener('click', async function() {
                    const confirmed = await window.showCommonModal(
                        "게시글 삭제 확인",
                        "정말 이 게시글을 삭제하시겠습니까?"
                    );

                    if (confirmed) {
                        // AJAX를 사용하여 삭제 요청 전송
                        fetch('${contextPath}/promoBoard/delete', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded'
                            },
                            // promo.promoId 값을 문자열로 감싸서 JavaScript 구문 오류 방지
                            body: 'promoId=' + '${promo.promoId}' 
                        })
                        .then(response => response.json())
                        .then(data => {
                            if (data.msg === 'success') {
                                window.showCommonModal("삭제 완료", "게시글이 성공적으로 삭제되었습니다.").then(() => {
                                    window.location.href = '${contextPath}/promoBoard'; // 목록 페이지로 이동
                                });
                            } else {
                                window.showCommonModal("삭제 실패", "게시글 삭제에 실패했습니다. 다시 시도해주세요.");
                            }
                        })
                        .catch(error => {
                            console.error('삭제 요청 중 오류 발생:', error);
                            window.showCommonModal("오류 발생", "삭제 중 오류가 발생했습니다.");
                        });
                    } else {
                        console.log("게시글 삭제 취소됨.");
                    }
                });
            }
        });
    </script>
</body>
</html>
