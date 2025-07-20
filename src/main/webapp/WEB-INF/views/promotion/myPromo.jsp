<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>내 홍보 리스트</title>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />

    <!-- 외부 CSS 및 JS 라이브러리 -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <link rel="stylesheet" href="${contextPath}/resources/css/myPromo.css"> <!-- 내 홍보 전용 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <script>
        const CONTEXT_PATH = "${contextPath}"; // JavaScript에서 contextPath 사용을 위함
    </script>
</head>
<body>
    <%-- 공통 헤더 포함 --%>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    <div class="page-wrapper">
        <div class="top-spacer"></div>

        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="fw-bold">내 홍보 리스트</h2>
            <!-- '홍보 작성' 버튼 클릭 시 모달 띄우기 -->
            <button type="button" class="btn lavender-btn" data-bs-toggle="modal" data-bs-target="#promoWriteModal">홍보 작성</button>
        </div>

        <c:if test="${not empty msg}">
            <div class="alert alert-info">${msg}</div>
        </c:if>

        <table class="table table-hover text-center align-middle">
            <thead class="lavender-header">
                <tr>
                    <th style="width: 10%;">번호</th>
                    <th>제목</th>
                    <th style="width: 15%;">작성일</th>
                    <th style="width: 10%;">조회수</th>
                    <th style="width: 10%;">상태</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty myPromoList}">
                        <c:forEach var="promo" items="${myPromoList}">
                            <tr>
                                <td>${promo.promoNo}</td>
                                <td class="text-start">
                                    <!-- 상세 보기/수정 모달을 띄우는 링크/버튼 -->
                                    <a href="#" class="text-decoration-none text-dark promo-detail-link"
                                       data-promo-no="${promo.promoNo}" data-bs-toggle="modal" data-bs-target="#promoDetailModal">
                                        ${promo.promoTitle}
                                    </a>
                                </td>
                                <td>
                                    <fmt:formatDate value="${promo.createDate}" pattern="yyyy.MM.dd HH:mm" />
                                </td>
                                <td>${promo.promoViews}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${promo.promoStatus eq 'Y'}">활성</c:when>
                                        <c:otherwise>비활성</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5">등록된 홍보 게시글이 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <!-- 페이징 영역 -->
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <c:choose>
                    <c:when test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${contextPath}/myPromo/list?page=${currentPage - 1}">이전</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item disabled">
                            <span class="page-link">이전</span>
                        </li>
                    </c:otherwise>
                </c:choose>

                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <li class="page-item active">
                                <span class="page-link">${i}</span>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item">
                                <a class="page-link" href="${contextPath}/myPromo/list?page=${i}">${i}</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:choose>
                    <c:when test="${currentPage < totalPage}">
                        <li class="page-item">
                            <a class="page-link" href="${contextPath}/myPromo/list?page=${currentPage + 1}">다음</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item disabled">
                            <span class="page-link">다음</span>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </nav>

    </div>

    <%-- 공통 푸터 포함 --%>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <!-- 1. 홍보 작성 모달 -->
    <div class="modal fade" id="promoWriteModal" tabindex="-1" aria-labelledby="promoWriteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="promoWriteModalLabel">새 홍보 게시글 작성</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <!-- 파일 업로드를 위해 enctype="multipart/form-data" 필수 -->
                <form id="promoWriteForm" action="${contextPath}/myPromo/create" method="post" enctype="multipart/form-data">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="writeTitle" class="form-label">제목</label>
                            <input type="text" class="form-control" id="writeTitle" name="promoTitle" required>
                        </div>
                        <div class="mb-3">
                            <label for="writeContent" class="form-label">내용</label>
                            <textarea class="form-control" id="writeContent" name="promoContent" rows="5" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="writePoster" class="form-label">포스터 이미지</label>
                            <input type="file" class="form-control" id="writePoster" name="posterFile">
                            <small class="form-text text-muted">권장 이미지 비율: 16:9 또는 4:3</small>
                        </div>
                        <div class="mb-3">
                            <label for="writePromotionUrl" class="form-label">프로모션 URL</label>
                            <input type="url" class="form-control" id="writePromotionUrl" name="promotionPageUrl" placeholder="예: https://www.yourfestival.com">
                        </div>
                        <!-- 사용자의 userNo는 세션에서 가져와 hidden 필드로 추가 -->
                        <input type="hidden" name="userNo" value="${sessionScope.loginUser.userNo}">
                        <!-- app_id는 사용자가 선택하거나, 기본값을 설정하거나, 다른 방식으로 처리해야 함 -->
                        <input type="hidden" name="appId" value="1234"> <!-- 임시 app_id, 실제로는 동적으로 선택/생성 -->
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                        <button type="submit" class="btn lavender-btn">작성</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- 2. 홍보 상세/수정 모달 -->
    <div class="modal fade" id="promoDetailModal" tabindex="-1" aria-labelledby="promoDetailModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="promoDetailModalLabel">홍보 게시글 상세/수정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <!-- 폼의 action은 JS에서 동적으로 변경될 수 있음 -->
                <form id="promoDetailForm" action="${contextPath}/myPromo/update" method="post" enctype="multipart/form-data">
                    <div class="modal-body">
                        <input type="hidden" id="detailPromoNo" name="promoNo">
                        <input type="hidden" name="userNo" value="${sessionScope.loginUser.userNo}"> <!-- 현재 로그인된 userNo -->
                        
                        <div class="mb-3">
                            <label for="detailTitle" class="form-label">제목</label>
                            <input type="text" class="form-control" id="detailTitle" name="promoTitle" required>
                        </div>
                        <div class="mb-3">
                            <label for="detailContent" class="form-label">내용</label>
                            <textarea class="form-control" id="detailContent" name="promoContent" rows="7" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="detailPosterPath" class="form-label">현재 포스터</label>
                            <img id="currentPoster" src="" alt="현재 포스터" class="promo-poster">
                            <input type="file" class="form-control" id="detailPosterFile" name="posterFile">
                            <small class="form-text text-muted">새로운 포스터 업로드 시 기존 포스터가 대체됩니다.</small>
                        </div>
                        <div class="mb-3">
                            <label for="detailPromotionUrl" class="form-label">프로모션 URL</label>
                            <input type="url" class="form-control" id="detailPromotionUrl" name="promotionPageUrl" placeholder="예: https://www.yourfestival.com">
                        </div>
                        <div class="mb-3">
                            <label for="detailCreateDate" class="form-label">작성일</label>
                            <input type="text" class="form-control" id="detailCreateDate" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="detailUpdateDate" class="form-label">수정일</label>
                            <input type="text" class="form-control" id="detailUpdateDate" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="detailViews" class="form-label">조회수</label>
                            <input type="text" class="form-control" id="detailViews" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="detailStatus" class="form-label">상태</label>
                            <select class="form-select" id="detailStatus" name="promoStatus">
                                <option value="Y">활성</option>
                                <option value="N">비활성</option>
                            </select>
                        </div>
                        <!-- app_id는 사용자가 선택하거나, 기본값을 설정하거나, 다른 방식으로 처리해야 함 -->
                        <input type="hidden" name="appId" id="detailAppId" value=""> <!-- 실제로는 동적으로 선택/생성 -->
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="deletePromoBtn">삭제</button>
                        <button type="submit" class="btn lavender-btn" id="updateSubmitBtn">수정</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery 추가 (AJAX 및 DOM 조작에 유용) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${contextPath}/resources/js/myPromo.js"></script> <!-- 내 홍보 전용 JS -->
</body>
</html>