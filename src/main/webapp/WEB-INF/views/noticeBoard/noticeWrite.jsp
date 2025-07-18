<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
  <meta charset="UTF-8" />
  <title>공지 작성</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>

<body>

  <jsp:include page="/WEB-INF/views/common/header.jsp" />

  <div class="container my-5" style="max-width: 700px;">
    <h3 class="mb-4 border-bottom pb-2">공지 게시판 작성</h3>
	
    <form action="${pageContext.request.contextPath}/noticeBoard/create" method="post" enctype="multipart/form-data">
	  <!-- 제목 -->
      <div class="mb-3">
        <label for="noticeTitle" class="form-label fw-semibold">제목</label>
        <input type="text" id="noticeTitle" name="noticeTitle" class="form-control" placeholder="제목을 입력해주세요." required />
      </div>
	
	  <!-- 내용 -->
      <div class="mb-3">
        <label for="content" class="form-label fw-semibold">내용</label>
        <textarea id="noticeDetail" name="noticeDetail" class="form-control" rows="7" placeholder="내용을 입력해주세요." required></textarea>
      </div>
	
	  <!-- 첨부파일 -->
      <div class="mb-4">
        <label for="noticeFile" class="form-label fw-semibold">첨부파일</label>
        <input class="form-control" type="file" id="noticeFile" name="noticeFile" />
      </div>
	  
	  <!-- 버튼 -->
      <div class="d-flex justify-content-end">
        <button type="submit" class="btn btn-primary px-4">등록</button>
      </div>
    </form>
  </div>
  
  <jsp:include page="/WEB-INF/views/common/footer.jsp" />

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>