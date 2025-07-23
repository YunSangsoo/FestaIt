<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
    <title>내 홍보 리스트</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
       
        <style>
            /* 작성 버튼 스타일 */
            a.btn.lavender-btn {
                background-color: #b481d9;
                color: white;
                border: 1px solid #a069cb;
            }

            a.btn.lavender-btn:hover {
                background-color: #a069cb;
                border-color: #904ebc;
            }

            /* 테이블 헤더 스타일 */
            thead.lavender-header th {
                background-color: #e6ccff;
                color: #5E2B97;
            }
            
            
        </style>
</head>

<body>

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="container my-5" style="min-height: 600px;">

        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="fw-bold">내 홍보 리스트</h2>
            <a href="${pageContext.request.contextPath}/promoBoard/promoWrite" class="btn lavender-btn">등록하기</a>
        
        <!--<c:if test="${not empty msg}">
        	<div class="alert alert-info">${msg}</div>
    	</c:if>-->
        
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

        <!-- 페이징 영역 -->
        <nav aria-label="Page navigation">
    	<ul class="pagination justify-content-center">

        	<!-- 이전 버튼 -->
        	<c:choose>
            	<c:when test="${currentPage > 1}">
                	<li class="page-item">
                    	<a class="page-link" href="${listUrl}&cpage=${pi.currentPage - 1}">이전</a>
                	</li>
            	</c:when>
            	<c:otherwise>
                	<li class="page-item disabled">
                    	<span class="page-link">이전</span>
                	</li>
            	</c:otherwise>
        	</c:choose>

        	<!-- 페이지 번호 -->
                  <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
                      <li class="page-item <c:if test="${p == pi.currentPage}">active</c:if>">
                          <a class="page-link" href="${listUrl}&cpage=${p}">${p}</a>
                      </li>
                  </c:forEach>

        	<!-- 다음 버튼 -->
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

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>