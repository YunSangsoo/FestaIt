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

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" xintegrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    
    <style>
        .container { max-width: 800px; margin-top: 50px; }
        .form-label { font-weight: bold; color: #555; }
        .btn-group-bottom {
            display: flex;
            justify-content: space-between; /* 양 끝 정렬 */
            align-items: center;
            margin-top: 30px;
        }
        .btn-group-right {
            display: flex;
            gap: 10px; /* 버튼 사이 간격 */
        }
    </style>
</head>
<body class="bg-light">

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container bg-white p-4 shadow-sm rounded">
    <h4 class="border-bottom pb-2">홍보 게시글 수정/삭제</h4>

    <!-- 플래시 메시지 출력 (PromoBoardController에서 alertMsg로 전달) -->
    <c:if test="${not empty alertMsg}">
        <div class="alert alert-info">${alertMsg}</div>
    </c:if>

    <!-- 수정 폼 -->
    <form id="promoUpdateForm" action="${contextPath}/promoBoard/update" method="post">
        <input type="hidden" name="promoId" value="${promo.promoId}" />

        <div class="mb-3">
            <label class="form-label"><strong>제목</strong></label>
            <input type="text" class="form-control" name="promoTitle" value="${promo.promoTitle}" readonly />
        </div>

        <div class="mb-3">
            <label class="form-label"><strong>작성일</strong></label>
            <div>
                <fmt:formatDate value="${promo.createDate}" pattern="yyyy.MM.dd HH:mm" />
            </div>
        </div>
        
        <div class="mb-3">
            <label class="form-label"><strong>내용</strong></label>
            <textarea class="form-control" name="promoDetail" rows="10" readonly><c:out value="${promo.promoDetail}" /></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label"><strong>조회수</strong></label>
            <input type="text" class="form-control" value="${promo.views}" readonly />
        </div>

        <div class="mb-3">
            <label class="form-label"><strong>프로모션 URL</strong></label>
            <input type="url" class="form-control" name="promotionPageUrl" value="${promo.promotionPageUrl}" readonly />
        </div>

        <div class="d-flex justify-content-between mt-4">
            <a href="${contextPath}/promoBoard" class="btn btn-outline-secondary">게시판으로 돌아가기</a>

            <div id="adminButtons" class="btn-group-right">
                <button type="button" class="btn btn-primary" onclick="enableEdit()">수정</button>
                
                <!-- 삭제 폼은 별도로 작성 -->
                <form action="${contextPath}/promoBoard/delete" method="post" style="display:inline;">
                    <input type="hidden" name="promoId" value="${promo.promoId}" />
                    <button type="submit" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
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

<!-- promoUpdate.js 파일 포함 -->
<script src="${contextPath}/resources/js/promoUpdate.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
