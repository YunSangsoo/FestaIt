<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>	
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>행사 세부 페이지 내 리뷰창</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
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
</style>
</head>
<body>
	<c:set var="loginUser" value="${sessionScope.loginUser}" />
	
	<div class="container my-5">
	<h2 style="margin-bottom: 20px; font-weight: bold;">리뷰 (총 ${totalCount} 건)</h2>
		<form action="${pageContext.request.contextPath}/reviewBoard/create"
			method="post">
			<div class="input-group">
				<svg height="60" width="60" xmlns="http://www.w3.org/2000/svg">
					<rect width="100%" height="100%" fill="gray" />
				</svg>
				<textarea name="comment" class="form-control mx-2" rows="4"
					maxlength="100" placeholder="100자 이내로 작성해주세요."
					style="resize: none;" required></textarea>
				<div class="reviewAction">
					<select name="rating" class="form-select form-select-sm" aria-label="별점 선택">
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
						<tr><td colspan="3" class="text-center py-5">등록된 리뷰가 없습니다.</td></tr>
					</c:when>

					<c:otherwise>
						<c:forEach var="review" items="${reviewList}">
							<tr data-comment-id="${review.userNo}">
								<td>
									<div class="d-flex my-4" data-comment-id="${review.userNo}">
										<!-- 왼쪽: 프로필 이미지 -->
										<div class="mx-3">
											<svg height="80" width="80" xmlns="http://www.w3.org/2000/svg">
              									<rect width="100%" height="100%" fill="gray" />
            								</svg>
										</div>
										<!-- 오른쪽: 닉네임, 작성일, 댓글 내용 -->
										<div class="flex-grow-1">
											<div
												class="d-flex align-items-center fw-bold justify-content-between">
												<div class="d-flex align-items-center flex-wrap">
													<span class="me-2">${review.userId}(${review.nickname})</span>
													<small class="text-muted ms-2 star-display">
														<c:forEach var="i" begin="1" end="${review.rating}">★</c:forEach><c:forEach
															var="i" begin="${review.rating + 1}" end="5">☆</c:forEach>
													</small>
													<small class="text-muted ms-3">
														<fmt:formatDate value="${review.createDate}" pattern="yyyy.MM.dd HH:mm:ss" />
													</small>
												</div>

												<!-- 수정/삭제 버튼 -->
												<div>
													<button type="button" class="btn btn-primary btn-sm me-2"
														data-userno="${review.userNo}"
														data-comment="${fn:escapeXml(review.comment)}"
														onclick="handleEditClick(this)">수정</button>
													<button type="button" class="btn btn-danger btn-sm"
														onclick="openDeleteModal(${review.userNo})">삭제</button>
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
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="saveConfirmModalLabel">댓글 수정</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="닫기"></button>
										</div>
										<div class="modal-body">
											<input type="hidden" name="userNo" id="editUserNo" />
											<div class="mb-3">
												<label for="editComment" class="form-label">댓글 내용</label>
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
							href="${pageContext.request.contextPath}/reviewBoard/list?page=${currentPage - 1}">이전</a>
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
								href="${pageContext.request.contextPath}/reviewBoard/list?page=${i}">${i}</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<!-- 다음 버튼 -->
				<c:choose>
					<c:when test="${currentPage < totalPage}">
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/reviewBoard/list?page=${currentPage + 1}">다음</a>
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
	// 수정 모달 열기
	function openEditModal(userNo, comment) {
		document.getElementById('editUserNo').value = userNo;
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
	</script>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>