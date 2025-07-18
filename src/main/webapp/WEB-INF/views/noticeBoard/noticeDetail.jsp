<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    .container { max-width: 800px; margin-top: 50px; }
</style>
</head>
<body class="bg-light">

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container bg-white p-4 shadow-sm rounded">
    <h4 class="border-bottom pb-2">공지사항 상세</h4>

    <!-- 플래시 메시지 출력 -->
    <!--<c:if test="${not empty msg}">
        <div class="alert alert-info">${msg}</div>
    </c:if>-->

    <form id="noticeForm" action="${pageContext.request.contextPath}/noticeBoard/update" method="post">
        <input type="hidden" name="noticeId" value="${notice.noticeId}" />

        <div class="mb-3">
            <label class="form-label"><strong>제목</strong></label>
            <input type="text" class="form-control" name="noticeTitle" value="${notice.noticeTitle}" readonly />
        </div>

        <div class="mb-3">
            <label class="form-label"><strong>작성일</strong></label>
            <div>
                <fmt:formatDate value="${notice.createDate}" pattern="yyyy.MM.dd HH:mm" />
            </div>
        </div>

        <div class="mb-3">
  			<label class="form-label"><strong>내용</strong></label>
  			<textarea class="form-control" name="noticeDetail" rows="10" readonly><c:out value="${notice.noticeDetail}" /></textarea>
		</div>

		<div class="d-flex justify-content-between mt-4">
  			<a href="${pageContext.request.contextPath}/noticeBoard/list" class="btn btn-outline-secondary">게시판으로 돌아가기</a>

  			<!-- 수정 폼 -->
  			<form id="noticeForm" action="${pageContext.request.contextPath}/noticeBoard/update" method="post" style="display: inline;">
    			<input type="hidden" name="noticeId" value="${notice.noticeId}" />
    
    			<!-- 버튼들을 감싸는 div에 flex 적용 -->
    			<div style="display: flex; gap: 10px;">
        			<button type="submit" class="btn btn-success" style="display:none;" id="saveBtn">저장</button>
        			<button type="button" class="btn btn-secondary" onclick="cancelEdit()" style="display:none;" id="cancelBtn">취소</button>
    			</div>
			</form>

  			<div id="adminButtons" style="display:flex; gap: 10px;">
    			<button type="button" class="btn btn-primary" onclick="enableEdit()">수정</button>

    			<!-- 삭제 폼은 수정 폼 밖에 독립 폼으로 작성 -->
    			<form action="${pageContext.request.contextPath}/noticeBoard/delete" method="post" style="display:inline;">
      				<input type="hidden" name="noticeId" value="${notice.noticeId}" />
      				<button type="submit" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
    			</form>
  			</div>
		</div>
    </form>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
	function enableEdit() {
	  	document.querySelector('input[name="noticeTitle"]').removeAttribute('readonly');
	  	document.querySelector('textarea[name="noticeDetail"]').removeAttribute('readonly');
	  	document.getElementById("adminButtons").style.display = "none";
	  	document.getElementById("noticeForm").querySelector('#saveBtn').style.display = "inline-block";
	  	document.getElementById("noticeForm").querySelector('#cancelBtn').style.display = "inline-block";
	}

    function cancelEdit() {
        location.reload(); // 원상복구 위해 페이지 새로고침
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>