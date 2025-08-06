<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>행사 관리 리스트</title>
<style>
            /* 공지 작성 버튼 스타일 */
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


<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.css">
</head>
<body>

	<!-- HEADER -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<c:set var="requestUri" value="${requestScope['javax.servlet.forward.request_uri']}" />
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />
    <c:set var="isViewMode" value="${fn:startsWith(requestUri, contextPath.concat('/eventApp'))}" />
    <c:set var="isEditMode" value="${fn:startsWith(requestUri, contextPath.concat('/myEventApp'))}" />
    
    
	<div class="container my-5" style="min-height: 600px;">
	

        <div class="d-flex justify-content-between align-items-center mb-3">
            <c:choose>
	            <c:when test="${isEditMode}" >
		            <h2 class="fw-bold">내가 신청한 행사</h2>
					    <a href="${contextPath}/myEventApp/appWrite" class="btn lavender-btn">행사 신청서 작성</a>
				</c:when>
				<c:otherwise>
	            	<h2 class="fw-bold">행사 게시판</h2>
	            	
           			<form method="get" action="${contextPath}/eventApp" class="search-form d-flex justify-content-end align-items-center" id="searchForm">
					<div class="input-group mx-2">
		                <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false" id="searchTypeDropdownText">
		                    <%-- Model에서 넘어온 searchType 값에 따라 기본 텍스트 설정 --%>
		                    <c:choose>
		                        <c:when test="${searchType eq 'applicant'}">신청자</c:when>
		                        <c:when test="${searchType eq 'eventType'}">행사 종류</c:when>
		                        <c:when test="${searchType eq 'eventName'}">행사명</c:when>
		                        <c:when test="${searchType eq 'status'}">신청 상태</c:when>
		                        <c:otherwise>전체</c:otherwise> <%-- 기본값 또는 '전체' --%>
		                    </c:choose>
		                </button>
		                <ul class="dropdown-menu">
		                    <li><a class="dropdown-item" href="#" data-search-type="">전체</a></li>
		                    <li><a class="dropdown-item" href="#" data-search-type="managerName">신청자</a></li>
		                    <li><a class="dropdown-item" href="#" data-search-type="eventType">행사 종류</a></li>
		                    <li><a class="dropdown-item" href="#" data-search-type="appTitle">행사명</a></li>
		                    <li><a class="dropdown-item" href="#" data-search-type="statType">신청 상태</a></li>
		                </ul>
			            <input type="hidden" name="searchType" id="searchType" value="${searchType}">
			
			            <input type="text" class="form-control" name="keyword" value="${keyword}" placeholder="검색어를 입력하세요" aria-label="검색어">
			            
			            <button class="btn btn-outline-secondary" type="submit">검색</button>
	            	</div>
	            
					</form>
				</c:otherwise>
			</c:choose>
        </div>
        
        <table class="table table-hover text-center align-middle">
            <thead class="lavender-header">
                <tr>
	            	<c:if test="${isViewMode}" >
                    	<th style="width: 10%;">신청자</th>
                    </c:if>
                    <th style="width: 10%;">행사 종류</th>
                    <th>행사명</th>
                    <th style="width: 20%;">신청일</th>
                    <th style="width: 20%;">진행 상태</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty list}">
                        <c:forEach var="app" items="${list}">
                            <tr>
                           
	            		<c:if test="${fn:startsWith(requestScope['javax.servlet.forward.request_uri'], pageContext.request.contextPath.concat('/eventApp'))}" >
                                <td>
                                	<c:choose>
                                        <c:when test="${not empty app.appManager and not empty app.appManager.managerName}">
                                            ${app.appManager.managerName}
                                        </c:when>
                                        <c:otherwise>
                                            -
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                        </c:if>
                                <td>
                                	<c:choose>
                                        <c:when test="${app.eventCode eq 'L'}">지역축제</c:when>
                                        <c:when test="${app.eventCode eq 'F'}">박람회</c:when>
                                        <c:when test="${app.eventCode eq 'E'}">전시회</c:when>
                                        <c:when test="${app.eventCode eq 'O'}">기타</c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-start">
                                	<c:choose>
                                		<c:when test="${isEditMode}">
                                    		<a href="${contextPath}/myEventApp/appEdit/${app.appId}" class="text-decoration-none text-dark">
                                    	</c:when>
                                    	<c:when test="${isViewMode }">
                                    		<a href="${contextPath}/eventApp/appDetail/${app.appId}" class="text-decoration-none text-dark">
                                    	</c:when>
                                    	<c:otherwise><a></c:otherwise>
                                	</c:choose>
    									${app.appTitle}
									</a>
                                </td>
                                
                                <td>
                                	<c:choose>
                                        <c:when test="${empty app.submittedDate}">
                                            미정
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatDate value="${app.submittedDate}" pattern="yyyy-MM-dd"/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                
                                
                                <td>
                                	<c:choose>
                                        <c:when test="${app.statCode eq 'S'}">제출 완료</c:when>
                                        <c:when test="${app.statCode eq 'A'}">승인</c:when>
                                        <c:when test="${app.statCode eq 'R'}">반려</c:when>
                                        <c:otherwise>작성중</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="3"> 조회된 행사 신청 내역이 없습니다.</td>
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
            	<c:when test="${pi.currentPage > 1}">
                	<li class="page-item">
                		
		            <c:choose>
			            <c:when test="${isEditMode}" >
                    	<a class="page-link" href="${pageContext.request.contextPath}/myEventApp?page=${pi.currentPage - 1}">이전</a>
                    	</c:when>
                    <c:otherwise>
                    	<a class="page-link" href="${pageContext.request.contextPath}/eventApp?page=${pi.currentPage - 1}">이전</a>
                    </c:otherwise>
                </c:choose>
                	</li>
            	</c:when>
            	<c:otherwise>
                	<li class="page-item disabled">
                    	<span class="page-link">이전</span>
                	</li>
            	</c:otherwise>
        	</c:choose>

        	<!-- 페이지 번호 -->
        	<c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
            	<c:choose>
                	<c:when test="${i == pi.currentPage}">
                    	<li class="page-item active">
                        	<span class="page-link">${i}</span>
                    	</li>
                	</c:when>
                	<c:otherwise>
                    	<li class="page-item">
                    	
				            <c:choose>
					            <c:when test="${isEditMode}" >
                       				<a class="page-link" href="${pageContext.request.contextPath}/myEventApp?page=${i}">${i}</a>
		                    	</c:when>
			                    <c:otherwise>
                       				<a class="page-link" href="${pageContext.request.contextPath}/eventApp?page=${i}">${i}</a>
			                    </c:otherwise>
			                </c:choose>
                    	
                    	
                    	</li>
                	</c:otherwise>
            	</c:choose>
        	</c:forEach>

        	<!-- 다음 버튼 -->
        	<c:choose>
            	<c:when test="${pi.currentPage < pi.totalPage}">
                	<li class="page-item">
			            <c:choose>
				            <c:when test="${isEditMode}" >
                    			<a class="page-link" href="${pageContext.request.contextPath}/myEventApp?page=${pi.currentPage + 1}">다음</a>
	                    	</c:when>
		                    <c:otherwise>
                    			<a class="page-link" href="${pageContext.request.contextPath}/eventApp?page=${pi.currentPage + 1}">다음</a>
		                    </c:otherwise>
		                </c:choose>
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
	
	
	<!-- FOOTER -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js"></script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	
	<script>
    $(document).ready(function() {
        // 드롭다운 아이템 클릭 시
        $('.dropdown-menu .dropdown-item').on('click', function(event) {
            event.preventDefault(); // 기본 링크 동작 방지

            var $this = $(this);
            var searchType = $this.data('search-type'); // data-search-type 값 가져오기
            
            // 1. 드롭다운 버튼 텍스트 변경
            $('#searchTypeDropdownText').text($this.text());
            
            // 2. 숨겨진 input 필드의 값 업데이트
            $('#searchType').val(searchType);
            
            console.log('선택된 검색 기준:', searchType);
        });

        // (선택 사항) 엔터 키로 폼 제출 기능
        $('input[name="keyword"]').keypress(function(e) {
            if (e.which == 13) { // Enter key
                e.preventDefault(); // 기본 엔터 동작 방지
                $('#searchForm').submit(); // 폼 제출
            }
        });

        // 페이지 로드 시 현재 검색 기준에 맞는 드롭다운 텍스트 설정 (반복되는 코드 제거)
        // 다만, 필요에 따라 초기화 로직을 추가할 수 있습니다.
    });
</script>
</body>
</html>