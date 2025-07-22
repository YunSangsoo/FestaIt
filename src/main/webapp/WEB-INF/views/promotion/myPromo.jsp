<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 홍보 리스트</title>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    
    <!-- Custom CSS -->
    <link href="${contextPath}/resources/css/myPromo.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container my-5">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="fw-bold">내 홍보 리스트</h2>
            <!-- 내 홍보 리스트에서는 '홍보 작성' 버튼 대신 '내 정보' 등으로 변경될 수 있음 -->
            <!-- <a href="${contextPath}/promoBoard/promoWrite" class="btn lavender-btn">홍보 작성</a> -->
        </div>

        <!-- 검색 폼 -->
        <div class="row mb-3 justify-content-end">
            <div class="col-md-6">
                <form action="${contextPath}/myPage/myPromo" method="get" class="d-flex">
                    <select class="form-select form-select-lg me-2" name="searchType">
                        <option value="title" <c:if test="${param.searchType eq 'title'}">selected</c:if>>제목</option>
                        <option value="content" <c:if test="${param.searchType eq 'content'}">selected</c:if>>내용</option>
                    </select>
                    <input type="text" class="form-control form-control-lg me-2" name="searchKeyword" placeholder="검색어 입력" value="${param.searchKeyword}">
                    <button type="submit" class="btn btn-outline-secondary btn-lg">검색</button>
                    <input type="hidden" name="cpage" value="1">
                </form>
            </div>
        </div>

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
                                <td class="text-start">
                                    <a href="${contextPath}/promoBoard/detail?promoId=${promo.promoId}" class="text-decoration-none text-dark">
                                        ${promo.promoTitle}
                                    </a>
                                </td>
                                <td>${promo.views}</td>
                                <td>
                                    <fmt:formatDate value="${promo.createDate}" pattern="yyyy.MM.dd HH:mm" />
                                </td>
                                <td>
                                    <a href="${contextPath}/promoBoard/promoUpdate?promoId=${promo.promoId}" class="btn btn-sm btn-outline-primary me-1">수정</a>
                                    <button type="button" class="btn btn-sm btn-outline-danger" onclick="deletePromo(${promo.promoId})">삭제</button>
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

        <!-- 페이징 영역 (promoBoard.jsp 스타일로 변경) -->
        <div class="pagination-container">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <c:url var="listUrl" value="${contextPath}/myPage/myPromo">
                        <c:forEach var="entry" items="${param}">
                            <c:if test="${entry.key ne 'cpage'}">
                                <c:param name="${entry.key}" value="${entry.value}" />
                            </c:if>
                        </c:forEach>
                    </c:url>

                    <!-- 이전 페이지 -->
                    <c:if test="${pi.currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${listUrl}&cpage=${pi.currentPage - 1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <!-- 페이지 번호 -->
                    <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
                        <li class="page-item <c:if test="${p == pi.currentPage}">active</c:if>">
                            <a class="page-link" href="${listUrl}&cpage=${p}">${p}</a>
                        </li>
                    </c:forEach>

                    <!-- 다음 페이지 -->
                    <c:if test="${pi.currentPage < pi.maxPage}">
                        <li class="page-item">
                            <a class="page-link" href="${listUrl}&cpage=${pi.currentPage + 1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>
        <%-- 페이징 영역 끝 --%>

    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script src="${contextPath}/resources/js/mypromo.js"></script>
    <script src="${contextPath}/resources/js/commonModal.js"></script>
    <script>
        // 삭제 버튼 클릭 시 호출될 함수
        function deletePromo(promoId) {
            window.showCommonModal(
                "게시글 삭제 확인",
                "정말 이 게시글을 삭제하시겠습니까?"
            ).then(confirmed => {
                if (confirmed) {
                    // AJAX를 사용하여 삭제 요청 전송
                    fetch('${contextPath}/promoBoard/delete', { // promoBoard 컨트롤러의 delete 사용
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: 'promoId=' + promoId
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.msg === 'success') {
                            window.showCommonModal("삭제 완료", "게시글이 성공적으로 삭제되었습니다.").then(() => {
                                window.location.reload(); // 페이지 새로고침하여 목록 업데이트
                            });
                        } else if (data.msg === 'unauthorized') {
                            window.showCommonModal("권한 없음", "게시글을 삭제할 권한이 없습니다.");
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
    </script>
</body>
</html>
