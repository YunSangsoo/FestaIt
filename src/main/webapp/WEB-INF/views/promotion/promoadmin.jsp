<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 홍보 관리 게시판</title>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet" />
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
            color: #333;
        }

        .container { 
            margin-top: 50px; 
            max-width: 1160px;
        }

        .table img {
            max-width: 80px;
            max-height: 80px;
            object-fit: cover;
            border-radius: 5px;
        }
        
        /* 테이블 헤더 색상 수정 */
        thead.lavender-header th {
            background-color: #eedbfd;
            color: #5e2b97;
        }
        /* 퐁당퐁당(줄무늬) 스타일 제거 */
        .table tbody tr {
            background-color: #fff;
        }
        
        .table-hover tbody tr:hover {
            background-color: inherit;
        }
        
        .table tbody tr td a {
            text-decoration: none;
            color: inherit;
        }
        
        .table tbody tr td a:hover {
            text-decoration: underline;
        }

        .table td {
            vertical-align: middle;
        }

        /* 검색창 및 버튼 스타일 조정 */
		#searchForm {
			width: 70%;
		}
		.search-form {
			display:flex;
			justify-content: flex-end;
			margin-bottom: 20px;
		}
		#select-list {
			width: fit-content;
			height: 100%;
			margin-right: 8px;
		}
		.search-btn {
			width: 100px;
			height: 38px !important;
		}
		
		.btn.lavender-btn {
			background-color: #B481D9;
			color: white;
			border: 1px solid #A069CB;
			height:fit-content;
			padding: 3px 10px;
		}
		.btn.lavender-btn:hover {
			background-color: #A069CB;
			border-color: #904EBC;
		}
		
        /* 페이지네이션 컨테이너 */
        .pagination-container,
        .pagination-area {
            margin-top: 30px;
            margin-bottom: 50px;
            width: 100%;
            display: flex;
            justify-content: center;
        }
        
        .pagination .page-item {
            margin: 0;
        }
        
        .pagination .page-item .page-link {
            color: #7B4BB7;
            border: 1px solid #ddd; 
            transition: background-color 0.2s ease, color 0.2s ease, border-color 0.2s ease;
            border-radius: 0;
        }
        
        .pagination .page-item .page-link:hover {
            color: #212529;
            background-color: #E9ECEF;
            border-color: #904EBC;
        }
        
        .pagination .page-item.active .page-link {
            background-color: #B481D9;
            border-color: #A069CB;
            color: white;
        }
        
        .pagination .page-item:first-child .page-link {
            border-top-left-radius: 5px;
            border-bottom-left-radius: 5px;
        }
        
        .pagination .page-item:last-child .page-link {
            border-top-right-radius: 5px;
            border-bottom-right-radius: 5px;
        }
        
        /* 삭제 버튼 */
        .btn-gray {
            background-color: #E9ECEF;
            color: rgb(0, 0, 0);
            border: 1px solid #B9B9B9;
            padding: 5px 10px;
            border-radius: 3px;
            font-size: 0.9em;
        }
        
        .btn-gray:hover {
            background-color: #FF0000;
            border-color: #FF0000;
            color: white;
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<sec:authorize access="hasRole('ADMIN')">
    <div class="container">
        <h2 class="fw-bold mb-3">홍보 관리 게시판</h2>
        <div class="search-area">
            <form action="${contextPath}/promoAdmin" method="get" class="search-form d-flex justify-content-end align-items-center">
	        <select class="form-select" name="searchType" id="select-list">
                <option value="title" ${searchType eq 'title' ? 'selected' : ''}>제목</option>
                <option value="writer" ${searchType eq 'writer' ? 'selected' : ''}>작성자</option>
	        </select>			
				<input type="text" name="keyword" placeholder="search"
					value="${keyword}" class="form-control me-2"
					style="max-width: 250px;" />
				<button type="submit" class="btn lavender-btn search-btn">검색</button>
			</form>
        </div>
		<table class="table table-hover">
				<thead class="lavender-header">
				    <tr>
				        <th class="text-center">번호</th>
				        <th class="text-center">제목</th>
				        <th class="text-center">작성자</th>
				        <th class="text-center">작성일</th>
				        <th class="text-center">조회수</th>
				        <th class="text-center">상태</th>
				        <th class="text-center">관리</th>
				    </tr>
				</thead>
		        <c:choose>
		            <c:when test="${empty promoList}">
		                <tr>
		                    <td colspan="7" class="text-center">조회된 홍보 게시글이 없습니다.</td>
		                </tr>
		            </c:when>
		            <c:otherwise>
		                <c:forEach var="promo" items="${promoList}">
		                    <tr onclick="location.href='${contextPath}/promoBoard/detail?promoId=${promo.promoId}'" style="cursor: pointer;">
		                        <td class="text-center"><c:out value="${promo.promoId}" /></td>
		                        <td class="text-center">
		                            <a href="${contextPath}/promoBoard/detail?promoId=${promo.promoId}" onclick="event.stopPropagation();">
		                                <c:out value="${promo.promoTitle}" />
		                            </a>
		                        </td>
		                        <td class="text-center"><c:out value="${promo.promoWriter}" /></td>
		                        <td class="text-center"><fmt:formatDate value="${promo.createDate}" pattern="yyyy.MM.dd HH:mm" /></td>
		                        <td class="text-center"><c:out value="${promo.views}" /></td>
		                        <td class="text-center">
		                            <c:choose>
		                                <c:when test="${fn:trim(promo.userStatus) eq 'T'}">활성</c:when>
		                                <c:when test="${fn:trim(promo.userStatus) eq 'F'}">비활성</c:when>
		                                <c:otherwise><c:out value="${promo.userStatus}" /></c:otherwise>
		                            </c:choose>
		                        </td>
		                        <td class="text-center" onclick="event.stopPropagation();">
		                            <button type="button" class="btn-gray"
		                                    onclick="deletePromo(${promo.promoId})">삭제</button>
		                        </td>
		                    </tr>
		                </c:forEach>
		            </c:otherwise>
		        </c:choose>
		    </tbody>
		</table>

        <div class="pagination-area">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li class="page-item ${pi.currentPage <= 1 ? 'disabled' : ''}">
                        <c:url var="prevPageUrl" value="/promoAdmin">
                            <c:param name="cpage" value="${pi.currentPage - 1}"/>
                            <c:param name="searchType" value="${searchType}"/>
                            <c:param name="keyword" value="${keyword}"/>
                        </c:url>
                        <a class="page-link" href="${prevPageUrl}" aria-label="Previous">
                            <span aria-hidden="true">이전</span>
                        </a>
                    </li>
                    
                    <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
                        <li class="page-item ${p == pi.currentPage ? 'active' : ''}">
                            <c:url var="pageUrl" value="/promoAdmin">
                                <c:param name="cpage" value="${p}"/>
                                <c:param name="searchType" value="${searchType}"/>
                                <c:param name="keyword" value="${keyword}"/>
                            </c:url>
                            <a class="page-link" href="${pageUrl}">${p}</a>
                        </li>
                    </c:forEach>
                    
                    <li class="page-item ${pi.currentPage >= pi.totalPage ? 'disabled' : ''}">
                        <c:url var="nextPageUrl" value="/promoAdmin">
                            <c:param name="cpage" value="${pi.currentPage + 1}"/>
                            <c:param name="searchType" value="${searchType}"/>
                            <c:param name="keyword" value="${keyword}"/>
                        </c:url>
                        <a class="page-link" href="${nextPageUrl}" aria-label="Next">
                            <span aria-hidden="true">다음</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</sec:authorize>

<sec:authorize access="!hasRole('ADMIN')">
    <div class="container mt-5 text-center">
        <div class="alert alert-danger" role="alert">
            관리자만 접근할 수 있는 페이지입니다.
        </div>
        <a href="${contextPath}/" class="btn btn-primary">홈으로 돌아가기</a>
    </div>
</sec:authorize>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<jsp:include page="/WEB-INF/views/common/modal.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script>
    const contextPath = "<c:out value='${contextPath}'/>";
    
    function deletePromo(promoId) {
        window.showCommonModal("게시글 삭제 확인", "정말 이 게시글을 삭제하시겠습니까?")
            .then((confirmed) => {
                if (confirmed) {
                    const csrfInput = document.querySelector('input[name=\"_csrf\"]');

                    if (!csrfInput || !csrfInput.value) {
                        window.showCommonModal("오류 발생", "보안 토큰을 찾을 수 없습니다. 페이지를 새로고침해주세요.");
                        return;
                    }

                    const csrfToken = csrfInput.value;
                    const csrfHeader = "X-CSRF-TOKEN";

                    fetch('${contextPath}/promoAdmin/deletePromoPost', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                            [csrfHeader]: csrfToken
                        },
                        body: 'promoId=' + promoId
                    })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Server responded with status: ' + response.status);
                        }
                        return response.json();
                    })
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
                } else {
                    console.log("게시글 삭제 취소됨.");
                }
            });
    }
</script>
<script src="${contextPath}/resources/js/commonModal.js"></script>

</body>
</html>