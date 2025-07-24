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
                    	<a class="page-link" href="${pageContext.request.contextPath}/myEventApp?page=${pi.currentPage - 1}">이전</a>
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
                        	<a class="page-link" href="${pageContext.request.contextPath}/myEventApp?page=${i}">${i}</a>
                    	</li>
                	</c:otherwise>
            	</c:choose>
        	</c:forEach>

        	<!-- 다음 버튼 -->
        	<c:choose>
            	<c:when test="${pi.currentPage < pi.totalPage}">
                	<li class="page-item">
                    	<a class="page-link" href="${pageContext.request.contextPath}/myEventApp?page=${pi.currentPage + 1}">다음</a>
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
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>