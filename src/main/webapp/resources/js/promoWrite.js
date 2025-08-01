document.addEventListener('DOMContentLoaded', function() {
    console.log('홍보 게시글 작성 스크립트 로드됨');

    // 예시: 폼 제출 전 유효성 검사
    const promoWriteForm = document.getElementById('promoWriteForm');
    if (promoWriteForm) {
        promoWriteForm.addEventListener('submit', function(event) {
            const promoTitle = document.getElementById('promoTitle').value;
            const promoDetail = document.getElementById('promoDetail').value;
            const eventId = document.getElementById('eventId').value;

            if (!promoTitle.trim()) {
                alert('제목을 입력해주세요.');
                event.preventDefault(); // 폼 제출 방지
                return;
            }
            if (!promoDetail.trim()) {
                alert('내용을 입력해주세요.');
                event.preventDefault();
                return;
            }
            if (!eventId) {
                alert('연관 행사를 선택해주세요.');
                event.preventDefault();
                return;
            }
            // 추가적인 유효성 검사 로직을 여기에 작성할 수 있습니다.
        });
    }
});
