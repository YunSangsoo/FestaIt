<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>내 홍보 리스트</title>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${contextPath}/resources/css/myPromo.css" />
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container mt-4" style="min-height: 600px;">
    <h2 class="fw-bold mb-3">내 홍보 리스트</h2>

    <div class="d-flex justify-content-end mb-3">
        <a href="${contextPath}/promoBoard/promoWrite" class="btn lavender-btn">등록하기</a>
    </div>

    <c:if test="${not empty alertMsg}">
        <div class="alert alert-info">${alertMsg}</div>
    </c:if>

    <table class="table table-hover text-center align-middle">
        <thead class="lavender-header">
            <tr>
                <th style="width: 10%;">번호</th>
                <th>제목</th>
                <th style="width: 15%;">조회수</th>
                <th style="width: 20%;">작성일</th>
                <th style="width: 15%;">관리</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty myPromoList}">
                    <c:forEach var="promo" items="${myPromoList}">
                        <tr>
                            <td>${promo.promoId}</td>
                            <td class="text-center">
                                <a href="${contextPath}/promoBoard/detail?promoId=${promo.promoId}" class="text-decoration-none text-dark">
                                    ${promo.promoTitle}
                                </a>
                            </td>
                            <td>${promo.views}</td>
                            <td><fmt:formatDate value="${promo.createDate}" pattern="yyyy.MM.dd HH:mm" /></td>
                            <td>
                                <a href="${contextPath}/promoBoard/promoUpdate?promoId=${promo.promoId}" class="btn-update me-1">수정</a>
                                <button type="button" class="btn-gray" onclick="deletePromo(${promo.promoId})">삭제</button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="5">작성하신 홍보 게시글이 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <div class="pagination-container d-flex justify-content-center">
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <li class="page-item ${pi.currentPage <= 1 ? 'disabled' : ''}">
                    <c:url var="prevPageUrl" value="${contextPath}/myPage/myPromo">
                        <c:param name="cpage" value="${pi.currentPage - 1}" />
                    </c:url>
                    <a class="page-link" href="${prevPageUrl}" aria-label="Previous">
                        <span aria-hidden="true">이전</span>
                    </a>
                </li>
                <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
                    <li class="page-item ${i == pi.currentPage ? 'active' : ''}">
                        <c:url var="pageUrl" value="/myPage/myPromo">
                            <c:param name="cpage" value="${i}" />
                        </c:url>
                        <a class="page-link" href="${pageUrl}">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${pi.currentPage >= pi.totalPage ? 'disabled' : ''}">
                    <c:url var="nextPageUrl" value="${contextPath}/myPage/myPromo">
                        <c:param name="cpage" value="${pi.currentPage + 1}" />
                    </c:url>
                    <a class="page-link" href="${nextPageUrl}" aria-label="Next">
                        <span aria-hidden="true">다음</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<jsp:include page="/WEB-INF/views/common/modal.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/js/commonModal.js"></script>

<script>
function deletePromo(promoId) {
    window.showCommonModal("게시글 삭제 확인", "정말 이 게시글을 삭제하시겠습니까?")
        .then((confirmed) => {
            if (confirmed) {
                fetch('${contextPath}/promoBoard/delete', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'promoId=' + promoId
                })
                .then(response => response.json())
                .then(data => {
                    if (data.msg === 'success') {
                        window.showCommonModal("삭제 완료", "게시글이 성공적으로 삭제되었습니다.")
                            .then(() => window.location.reload());
                    } else {
                        window.showCommonModal("삭제 실패", "게시글 삭제에 실패했습니다. 다시 시도해주세요.");
                    }
                })
                .catch(error => {
                    console.error('삭제 요청 중 오류:', error);
                    window.showCommonModal("오류 발생", "삭제 중 문제가 발생했습니다.");
                });
            }
        });
}
</script>
</body>
</html>
