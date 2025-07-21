// promoUpdate.js
// 홍보 게시글 수정/삭제 페이지 관련 JavaScript

/**
 * 게시글 수정 모드를 활성화합니다.
 * 입력 필드의 readonly 속성을 제거하고, 관리 버튼을 숨기고, 저장/취소 버튼을 표시합니다.
 */
function enableEdit() {
    // 제목, 내용, 프로모션 URL 필드 편집 가능하게 변경
    document.querySelector('#promoUpdateForm input[name="promoTitle"]').removeAttribute('readonly');
    document.querySelector('#promoUpdateForm textarea[name="promoDetail"]').removeAttribute('readonly');
    document.querySelector('#promoUpdateForm input[name="promotionPageUrl"]').removeAttribute('readonly');

    // 관리 버튼 숨기고 수정/취소 버튼 표시
    document.getElementById("adminButtons").style.display = "none";
    document.getElementById("editButtons").style.display = "flex"; // flex로 변경
}

/**
 * 게시글 수정 모드를 취소하고 페이지를 새로고침하여 원상복구합니다.
 */
function cancelEdit() {
    location.reload(); // 페이지 새로고침하여 원상복구
}
