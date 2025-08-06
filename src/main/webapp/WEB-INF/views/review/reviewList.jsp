<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>행사 세부 페이지 내 리뷰창</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<style>
.review {
	width: 100%;
}

.reviewAction {
	text-align: center;
}

.clickable {
	cursor: pointer;
	text-decoration: none;
}

.btn-edit-delete {
	display: none;
}

.profileImage {
	width: 80px;
	height: 80px;
	border-radius: 8px;
}

#profileImage-user {
	border-radius: 8px;
}
</style>
</head>
<body>
	
	<br><hr>
	
	<div class="container my-5" id="review-container">
		<h2 style="margin-bottom: 20px; font-weight: bold;">리뷰 (총 ${totalCount} 건)</h2>
		<form action="${pageContext.request.contextPath}/reviewBoard/create"
			method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="appId" value="${param.appId}" />
			<input type="hidden" name="page" value="${param.page}" />
			
				
			<div class="input-group">
				<!-- 마이페이지 확인 후 수정 ============================================================================================== -->
				<c:choose>
				  <c:when test="${not empty loginProfileImage}">
				    <img id="profileImage-user" class="profileImage-user ${empty loginProfileImage ? 'd-none' : ''}"
	            	src="${not empty loginProfileImage ? pageContext.request.contextPath.concat(loginProfileImage) : ''}"
	            	width="60" height="60"
	            	onerror="this.onerror=null;this.src='https://placehold.co/400x400/e0e0e0/ffffff?text=No+Image';">
				  </c:when>
				  <c:otherwise>
				    <svg xmlns="http://www.w3.org/2000/svg" width="60" height="60" fill="gray" class="bi bi-person-square" viewBox="0 0 16 16">
					  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
					  <path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm12 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1v-1c0-1-1-4-6-4s-6 3-6 4v1a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1z"/>
					</svg>
				  </c:otherwise>
				</c:choose>
				<textarea name="comment" class="form-control mx-2" rows="4"
					maxlength="100" placeholder="100자 이내로 작성해주세요."
					style="resize: none;" required></textarea>
				<div class="reviewAction">
					<select name="rating" class="form-select form-select-sm"
						aria-label="별점 선택">
						<option selected value="1">★☆☆☆☆</option>
						<option value="2">★★☆☆☆</option>
						<option value="3">★★★☆☆</option>
						<option value="4">★★★★☆</option>
						<option value="5">★★★★★</option>
					</select>
					<button class="btn btn-outline-secondary mt-2 col-12" type="submit"
						style="font-size: 20px;">작성</button>
				</div>
			</div>
		</form>
		<table class="table table-hover text-center align-middle">
			<thead>
				<hr style="margin-top: 40px; margin-bottom: 0px;">
			</thead>

			<tbody>
				<c:choose>
					<c:when test="${empty reviewList}">
						<tr>
							<td colspan="3" class="text-center py-5">등록된 리뷰가 없습니다.</td>
						</tr>
					</c:when>

					<c:otherwise>
						<c:forEach var="review" items="${reviewList}">
							<tr class="review-row" data-comment-id="${review.userNo}">
								<td>
									<div class="d-flex my-4" data-comment-id="${review.userNo}">
										<!-- 왼쪽: 프로필 이미지 -->
										<div class="mx-3">
											<c:choose>
											  <c:when test="${not empty review.profileImage.changeName}">
											    <img id="profileImage" class="profileImage ${empty review.profileImage.changeName ? 'd-none' : ''}"
								            	src="${not empty review.profileImage.changeName ? pageContext.request.contextPath.concat(review.profileImage.changeName) : ''}"
								            	onerror="this.onerror=null;this.src='https://placehold.co/400x400/e0e0e0/ffffff?text=No+Image';">
											  </c:when>
											  <c:otherwise>
											    <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="gray" class="bi bi-person-square" viewBox="0 0 16 16">
												  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
												  <path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm12 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1v-1c0-1-1-4-6-4s-6 3-6 4v1a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1z"/>
												</svg>
											  </c:otherwise>
											</c:choose>
										</div>
										<!-- 오른쪽: 닉네임, 작성일, 댓글 내용 -->
										<div class="flex-grow-1">
											<div
												class="d-flex align-items-center fw-bold justify-content-between">
												<div class="d-flex align-items-center flex-wrap">
													<span class="me-2">${review.userId}(${review.nickname})</span>
													<small class="text-muted ms-2 star-display"> <c:forEach
															var="i" begin="1" end="${review.rating}">★</c:forEach><c:forEach
															var="i" begin="${review.rating + 1}" end="5">☆</c:forEach>
													</small> <small class="text-muted ms-3 d-flex"> <fmt:formatDate
															value="${review.createDate}"
															pattern="yyyy.MM.dd HH:mm:ss" />
														<div class="edit-check"
															style="display: ${empty review.updateDate ? 'none' : 'block'}">(수정됨)</div>
													</small>
												</div>

												<!-- 수정/삭제 버튼 -->
												<div class="btn-edit-delete">
													<button type="button" class="btn btn-primary btn-sm me-2 btn-edit"
														data-userno="${review.userNo}"
														data-comment="${fn:escapeXml(review.comment)}"
														onclick="handleEditClick(this)">수정</button>
													<button type="button" class="btn btn-danger btn-sm"
														onclick="openDeleteModal(${review.userNo})" data-userno="${review.userNo}">삭제</button>
												</div>
											</div>

											<!-- 댓글 내용 -->
											<div class="mt-1 comment-text text-start"
												id="comment-text-${review.userNo}">${review.comment}</div>
										</div>
									</div>
								</td>
							</tr>
						</c:forEach>

						<!-- 수정 확인 모달 -->
						<div class="modal fade" id="saveConfirmModal" tabindex="-1"
							aria-labelledby="saveConfirmModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-dialog-centered">
								<form id="editForm"
									action="${pageContext.request.contextPath}/reviewBoard/update"
									method="post">
									<input type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}" />
									<input type="hidden" name="appId" value="${param.appId}" />
									<input type="hidden" name="page" value="${param.page}" />
										
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="saveConfirmModalLabel">댓글 수정</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="닫기"></button>
										</div>
										<div class="modal-body">
											<input type="hidden" name="userNo" id="editUserNo" />
											<div class="mb-3">

												<div
													class="d-flex align-items-center justify-content-between">
													<label for="editComment" class="form-label">댓글 내용</label> <select
														name="rating" class="form-select form-select-sm"
														aria-label="별점 선택" style="width: 116px;" id="editrating">
														<option value="1">★☆☆☆☆</option>
														<option value="2">★★☆☆☆</option>
														<option value="3">★★★☆☆</option>
														<option value="4">★★★★☆</option>
														<option value="5">★★★★★</option>
													</select>
												</div>
												<textarea name="comment" id="editComment"
													class="form-control" rows="3" maxlength="100"
													style="resize: none;" required></textarea>
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal">취소</button>
											<button type="submit" class="btn btn-primary">수정 완료</button>
										</div>
									</div>
								</form>
							</div>
						</div>

						<!-- 삭제 확인 모달 -->
						<div class="modal fade" id="deleteConfirmModal" tabindex="-1"
							aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-dialog-centered">
								<form id="deleteForm"
									action="${pageContext.request.contextPath}/reviewBoard/delete"
									method="post">
								<input type="hidden" name="appId" value="${param.appId}" />
								<input type="hidden" name="page" value="${param.page}" />
									<input type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}" />
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="deleteConfirmModalLabel">댓글
												삭제</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="닫기"></button>
										</div>
										<div class="modal-body">댓글을 정말 삭제하시겠습니까?</div>
										<div class="modal-footer">
											<input type="hidden" name="userNo" id="deleteUserNo" />
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal">취소</button>
											<button type="submit" class="btn btn-danger">삭제</button>
										</div>
									</div>
								</form>
							</div>
						</div>
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
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/eventBoard/detail?appId=${param.appId}&page=${currentPage - 1}#review-container">이전</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item disabled"><span class="page-link">이전</span></li>
					</c:otherwise>
				</c:choose>

				<!-- 페이지 번호 -->
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					<c:choose>
						<c:when test="${i == currentPage}">
							<li class="page-item active"><span class="page-link">${i}</span></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link"
								href="${pageContext.request.contextPath}/eventBoard/detail?appId=${param.appId}&page=${i}#review-container">${i}</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<!-- 다음 버튼 -->
				<c:choose>
					<c:when test="${currentPage < totalPage}">
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/eventBoard/detail?appId=${param.appId}&page=${currentPage + 1}#review-container">다음</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item disabled"><span class="page-link">다음</span></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</nav>
	</div>

	<script>
	
    const loginUserNo = ${loginUserNo};
    const reviewIdentifier = ${reviewIdentifier};
    
    // 비로그인 시+이미 리뷰를 작성했을 시 재작성 금지
    document.addEventListener("DOMContentLoaded", function () {
    	if (loginUserNo === -1 || reviewIdentifier > 0) {
            const textarea = document.querySelector('textarea[name="comment"]');
            if (textarea) {
                textarea.readOnly = true;
                if(reviewIdentifier > 0) textarea.placeholder = '이미 리뷰를 작성한 행사입니다.';
                else textarea.placeholder = '로그인 후 리뷰를 작성할 수 있습니다.';
            }
            const select = document.querySelector('select[name="rating"].form-select.form-select-sm');
            if (select) {
                select.disabled = true;
            }
            const button = document.querySelector('button.btn.btn-outline-secondary.mt-2.col-12');
            if (button) {
                button.disabled = true;
            }
        }
	});
    
    
	// 수정 모달 열기
	function openEditModal(userNo, comment) {
		document.getElementById('editUserNo').value = userNo;
		document.getElementById('editrating').value = rating;
		document.getElementById('editComment').value = comment;
		
		const saveModal = new bootstrap.Modal(document.getElementById('saveConfirmModal'));
		saveModal.show();
	}
		
	// 삭제 모달 열기
	function openDeleteModal(userNo) {
		document.getElementById('deleteUserNo').value = userNo;
		const deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
		deleteModal.show();
	}
	
	function handleEditClick(button) {
		const userNo = button.dataset.userno;
		const comment = button.dataset.comment;
		document.getElementById('editUserNo').value = userNo;
		document.getElementById('editComment').value = comment;
		new bootstrap.Modal(document.getElementById('saveConfirmModal')).show();
	}
	
	// 수정 삭제 버튼
	document.addEventListener("DOMContentLoaded", function () {
	    document.querySelectorAll('.review-row').forEach(function (row) {
	        const commentUserNo = parseInt(row.dataset.commentId); // data-comment-id
	        if (commentUserNo === loginUserNo || loginUserNo === 126) {
	            const btn = row.querySelector('.btn-edit-delete');
	            if (btn) {
	                btn.style.display = 'block';
	            }
	        }
	        if (loginUserNo === 126) {
	            const btn = row.querySelector('.btn-edit');
	            if (btn) {
	                btn.style.display = 'none';
	            }
	        }
	    });
	});
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>