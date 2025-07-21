document.addEventListener('DOMContentLoaded', function() {
    const promoUpdateForm = document.getElementById('promoUpdateForm');
    const adminButtons = document.getElementById('adminButtons'); // 수정/삭제 버튼 그룹
    const editButtons = document.getElementById('editButtons');   // 저장/취소 버튼 그룹
    const editableFields = promoUpdateForm.querySelectorAll('input[name="promoTitle"], textarea[name="promoDetail"], input[name="promotionPageUrl"]');
    const deleteButton = promoUpdateForm.querySelector('#adminButtons .btn-danger'); // 삭제 버튼

    // 수정 모드 활성화 함수
    window.enableEdit = function() {
        editableFields.forEach(field => {
            field.removeAttribute('readonly'); // 읽기 전용 해제
            field.classList.remove('form-control[readonly]'); // 읽기 전용 스타일 제거 (CSS에서 처리)
        });
        adminButtons.style.display = 'none'; // 수정/삭제 버튼 숨김
        editButtons.style.display = 'flex';  // 저장/취소 버튼 표시
    };

    // 수정 모드 비활성화 및 원본 값 복원 함수
    window.cancelEdit = function() {
        editableFields.forEach(field => {
            field.setAttribute('readonly', true); // 읽기 전용 설정
            // 여기서는 원본 값을 복원하는 로직이 필요합니다.
            // 서버에서 받은 초기 값을 어딘가에 저장해두고 복원해야 합니다.
            // 예: field.value = field.dataset.originalValue;
        });
        adminButtons.style.display = 'flex'; // 수정/삭제 버튼 표시
        editButtons.style.display = 'none';  // 저장/취소 버튼 숨김
    };

    // 삭제 버튼 클릭 이벤트 (커스텀 모달 사용)
    if (deleteButton) {
        deleteButton.addEventListener('click', function(event) {
            event.preventDefault(); // 기본 폼 제출 방지

            // 커스텀 모달 호출 (commonModal.js에 정의된 showCommonModal 함수 사용)
            // window.showCommonModal 함수가 전역에 노출되어 있다고 가정
            if (typeof window.showCommonModal === 'function') {
                window.showCommonModal("게시글 삭제 확인", "정말 이 게시글을 삭제하시겠습니까?").then(confirmed => {
                    if (confirmed) {
                        // 사용자가 확인을 누르면 삭제 폼 제출
                        // 삭제 폼이 별도의 form 태그로 되어 있으므로 해당 폼을 찾아서 제출
                        const deleteForm = deleteButton.closest('form');
                        if (deleteForm) {
                            deleteForm.submit();
                        }
                    } else {
                        console.log("게시글 삭제 취소됨.");
                    }
                });
            } else {
                // showCommonModal 함수가 없을 경우 대체 처리 (개발 중 확인용)
                console.warn("showCommonModal 함수를 찾을 수 없습니다. commonModal.js가 올바르게 로드되었는지 확인하세요.");
                if (confirm('정말 삭제하시겠습니까? (커스텀 모달 없음)')) {
                    const deleteForm = deleteButton.closest('form');
                    if (deleteForm) {
                        deleteForm.submit();
                    }
                }
            }
        });
    }
});
