// Bootstrap 5 기준: 모달 요소와 인스턴스 초기화
const commonModalElement = document.getElementById('commonModal');
let commonModal = null;
let commonModalTitle = null;
let commonModalBody = null;
let commonModalFooter = null;

// DOMContentLoaded 이후에 Bootstrap 모달 인스턴스를 초기화 (안정성 강화)
document.addEventListener('DOMContentLoaded', () => {
    if (commonModalElement) {
        commonModal = new bootstrap.Modal(commonModalElement);
        commonModalTitle = commonModalElement.querySelector('.modal-title');
        commonModalBody = commonModalElement.querySelector('.modal-body');
        commonModalFooter = commonModalElement.querySelector('.modal-footer');

        // 모달이 완전히 닫힐 때 Promise를 resolve(false)하는 이벤트 리스너 (한 번만 등록)
        // 이 리스너는 모달이 확인 버튼 외의 방식으로 닫혔을 때 (취소, ESC, 백드롭 클릭) Promise를 처리합니다.
        commonModalElement.addEventListener('hidden.bs.modal', function () {
            // 현재 활성 Promise의 resolve 함수가 있다면 호출하고 초기화
            if (commonModalElement._currentModalPromiseResolve) {
                commonModalElement._currentModalPromiseResolve(false);
                commonModalElement._currentModalPromiseResolve = null; // 초기화
            }
        });

    } else {
        console.error("Error: The commonModal HTML structure (ID 'commonModal') was not found. Please ensure commonModal.jsp is included.");
    }
});


/**
 * 공통 모달을 표시하고 사용자의 선택 결과를 Promise로 반환하는 함수
 *
 * @param {string} title - 모달의 제목
 * @param {string} content - 모달의 내용 (HTML 문자열도 가능)
 * @param {object} options - 추가 옵션 (선택 사항)
 * @param {boolean} [options.showCancelButton=true] - 취소 버튼 표시 여부
 * @param {string} [options.cancelButtonText="취소"] - 취소 버튼 텍스트
 * @param {function} [options.onCancel=null] - 취소 버튼 클릭 시 실행될 콜백 함수 (Promise 결과에 영향X)
 * @param {boolean} [options.showConfirmButton=true] - 확인 버튼 표시 여부
 * @param {string} [options.confirmButtonText="확인"] - 확인 버튼 텍스트
 * @param {function} [options.onConfirm=null] - 확인 버튼 클릭 시 실행될 콜백 함수 (Promise 결과에 영향X)
 * @returns {Promise<boolean>} - 확인 버튼 클릭 시 `true`, 취소/닫기 시 `false`를 resolve하는 Promise
 */
window.showCommonModal = function(title, content, options = {}) {
	if (!commonModal) {
		console.error("Common Modal is not initialized. HTML structure might be missing or not loaded yet.");
    	return Promise.resolve(false); // 모달이 초기화되지 않았다면 바로 false 반환
    }

    return new Promise((resolve) => {
    
        // 이전 Promise를 덮어쓰지 않도록, 모달 요소에 resolve 함수를 저장
        commonModalElement._currentModalPromiseResolve = resolve;
        
        const defaultOptions = { showCancelButton: true, cancelButtonText: "취소", onCancel: null, showConfirmButton: true, confirmButtonText: "확인", onConfirm: null };
        
        const mergedOptions = Object.assign({}, defaultOptions, options);

        // 제목 및 내용 설정
        if (commonModalTitle) commonModalTitle.innerHTML = title;
        if (commonModalBody) commonModalBody.innerHTML = content;

        // 푸터 버튼 초기화 및 설정
        if (commonModalFooter) {
            commonModalFooter.innerHTML = ''; // 기존 버튼 모두 제거

            // 취소 버튼 생성
            if (mergedOptions.showCancelButton) {
                const cancelButton = document.createElement('button');
                cancelButton.type = 'button';
                cancelButton.classList.add('btn', 'btn-secondary');
                cancelButton.textContent = mergedOptions.cancelButtonText;
                cancelButton.setAttribute('data-bs-dismiss', 'modal'); // Bootstrap 기본 닫기 기능
                cancelButton.addEventListener('click', () => {
                    if (mergedOptions.onCancel) {
                        mergedOptions.onCancel();
                    }
                    // Promise는 hidden.bs.modal 이벤트 리스너에서 처리 (false)
                });
                commonModalFooter.appendChild(cancelButton);
            }

            // 확인 버튼 생성
            if (mergedOptions.showConfirmButton) {
                const confirmButton = document.createElement('button');
                confirmButton.type = 'button';
                confirmButton.classList.add('btn', 'btn-primary');
                confirmButton.textContent = mergedOptions.confirmButtonText;
                confirmButton.addEventListener('click', () => {
                    if (mergedOptions.onConfirm) {
                        mergedOptions.onConfirm();
                    }
                    commonModal.hide(); // 확인 버튼 클릭 후 모달 닫기
                    // Promise를 true로 resolve
                    if (commonModalElement._currentModalPromiseResolve) {
                        commonModalElement._currentModalPromiseResolve(true);
                        commonModalElement._currentModalPromiseResolve = null; // 사용 후 초기화
                    }
                });
                commonModalFooter.appendChild(confirmButton);
            }
        }

        // 모달 표시
        commonModal.show();
        
    });
};