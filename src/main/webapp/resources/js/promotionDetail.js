// 김현주 : 홍보세부페이지 관련 스크립트

// promotionDetail.js
document.addEventListener("DOMContentLoaded", () => {
    const detailPosterImg = document.querySelector('.detail-poster-img');
    const posterPlaceholderText = document.querySelector('.poster-placeholder-text');

    if (detailPosterImg && posterPlaceholderText) {
        detailPosterImg.addEventListener('error', () => {
            // 이미지 로드 실패 시 플레이스홀더 텍스트 표시
            detailPosterImg.style.display = 'none';
            posterPlaceholderText.style.display = 'block';
        });

        // 이미지가 정상적으로 로드되면 플레이스홀더 텍스트 숨김 (JSP에서 이미 처리 가능)
        if (detailPosterImg.complete && detailPosterImg.naturalWidth !== 0) {
            posterPlaceholderText.style.display = 'none';
        } else {
            posterPlaceholderText.style.display = 'block';
        }
    }
});