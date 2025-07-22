document.addEventListener('DOMContentLoaded', function() {
    const contextPath = document.getElementById('contextPath').value; // JSP에서 전달받은 contextPath

    const promoUpdateForm = document.getElementById('promoUpdateForm');
    const promoTitleInput = document.getElementById('promoTitle');
    const promoDetailTextarea = document.getElementById('promoDetail');
    const promotionPageUrlInput = document.getElementById('promotionPageUrl');
    const promoPosterInput = document.getElementById('promoPoster');
    const fileNameDisplay = document.getElementById('fileNameDisplay');
    const imagePreview = document.getElementById('imagePreview');
    const adminButtons = document.getElementById('adminButtons');
    const editButtons = document.getElementById('editButtons');
    const deleteButton = document.getElementById('deleteButton');
    const deleteOriginalImageCheckbox = document.getElementById('deleteOriginalImage');
    const originalPromoPosterPathInput = document.querySelector('input[name="originalPromoPosterPath"]');
    const originalPromoPosterPath = originalPromoPosterPathInput ? originalPromoPosterPathInput.value : '';

    // 수정 가능한 필드들
    const editableFields = [
        promoTitleInput,
        promoDetailTextarea,
        promotionPageUrlInput
    ];

    // ⭐ 디버깅을 위해 promo 객체 값 콘솔에 출력 (폼 필드에서 직접 가져옴) ⭐
    const promoData = {
        promoId: document.querySelector('input[name="promoId"]').value,
        promoTitle: promoTitleInput.value,
        promoDetail: promoDetailTextarea.value,
        promotionPageUrl: promotionPageUrlInput.value,
        posterPath: originalPromoPosterPath
    };
    console.log("Promotion object on page load:", promoData);
    console.log("Initial promoPosterInput disabled status:", promoPosterInput.disabled); // 초기 상태 로그

    // 원본 값 저장 (취소 시 복원용)
    const originalValues = {
        promoTitle: promoTitleInput.value,
        promoDetail: promoDetailTextarea.value,
        promotionPageUrl: promotionPageUrlInput.value,
        posterHtml: imagePreview.innerHTML, // 초기 이미지 미리보기 HTML 상태 저장
        fileName: fileNameDisplay.textContent // 초기 파일 이름 텍스트 저장
    };

    // 페이지 로드 시 기존 이미지 파일 이름 표시 (JavaScript로 처리)
    if (originalPromoPosterPath) {
        const parts = originalPromoPosterPath.split('/');
        const fileName = parts[parts.length - 1];
        fileNameDisplay.textContent = fileName;
    } else {
        fileNameDisplay.textContent = '선택된 파일 없음';
    }

    // 페이지 로드 시 기존 이미지가 있으면 '이미지 미리보기' 텍스트 제거
    if (imagePreview.querySelector('img')) {
        const noImageTextSpan = imagePreview.querySelector('.no-image-text');
        if (noImageTextSpan) {
            noImageTextSpan.remove();
        }
    }

    // 수정 모드 활성화 함수
    window.enableEdit = function() {
        console.log("enableEdit() function called."); // 함수 호출 로그
        editableFields.forEach(field => {
            field.removeAttribute('readonly'); // 읽기 전용 해제
        });
        promoPosterInput.removeAttribute('disabled'); // 파일 입력 활성화
        console.log("After enableEdit(), promoPosterInput disabled status:", promoPosterInput.disabled); // 활성화 후 상태 로그

        adminButtons.style.display = 'none'; // 수정/삭제 버튼 숨김
        editButtons.style.display = 'flex';  // 저장/취소 버튼 표시
    };

    // 수정 모드 비활성화 및 원본 값 복원 함수
    window.cancelEdit = function() {
        editableFields.forEach(field => {
            field.setAttribute('readonly', true); // 읽기 전용 설정
        });
        promoPosterInput.setAttribute('disabled', true); // 파일 입력 비활성화
        console.log("After cancelEdit(), promoPosterInput disabled status:", promoPosterInput.disabled); // 비활성화 후 상태 로그

        // 원본 값 복원
        promoTitleInput.value = originalValues.promoTitle;
        promoDetailTextarea.value = originalValues.promoDetail;
        promotionPageUrlInput.value = originalValues.promotionPageUrl;
        imagePreview.innerHTML = originalValues.posterHtml; // 이미지 미리보기 복원
        fileNameDisplay.textContent = originalValues.fileName; // 파일 이름 디스플레이 복원
        promoPosterInput.value = ''; // 파일 입력 초기화 (선택된 파일 제거)

        // 기존 이미지 삭제 체크박스도 초기화
        if (deleteOriginalImageCheckbox) {
            deleteOriginalImageCheckbox.checked = false;
        }

        adminButtons.style.display = 'flex'; // 수정/삭제 버튼 표시
        editButtons.style.display = 'none';  // 저장/취소 버튼 숨김
    };

    // 파일 선택 시 미리보기 처리
    promoPosterInput.addEventListener('change', function() {
        console.log("File input change event triggered."); // change 이벤트 발생 로그
        if (this.files && this.files[0]) {
            const file = this.files[0];
            fileNameDisplay.textContent = `새 파일: ${file.name}`; // 파일 이름 표시

            const reader = new FileReader();
            reader.onload = function(e) {
                const imageUrl = e.target.result;
                console.log("FileReader result (for assignment):", imageUrl);

                const noImageTextSpan = imagePreview.querySelector('.no-image-text');
                if (noImageTextSpan) {
                    noImageTextSpan.remove();
                }

                let imgElement = imagePreview.querySelector('img');
                if (imgElement) {
                    imgElement.src = imageUrl;
                } else {
                    imgElement = document.createElement('img');
                    imgElement.src = imageUrl;
                    imgElement.alt = "새 이미지 미리보기";
                    imagePreview.appendChild(imgElement);
                }

                // 새 파일 선택 시 기존 이미지 삭제 체크박스 해제
                if (deleteOriginalImageCheckbox) {
                     deleteOriginalImageCheckbox.checked = false;
                }
            };
            reader.onerror = function() {
                console.error("파일 읽기 오류:", reader.error);
                fileNameDisplay.textContent = '파일 읽기 오류';
                imagePreview.innerHTML = `<span class="no-image-text">이미지 미리보기 (오류)</span>`;
                if (deleteOriginalImageCheckbox) {
                     deleteOriginalImageCheckbox.checked = false;
                }
            };
            reader.readAsDataURL(file);
        } else {
            // 파일 선택 취소 시 기존 이미지 또는 "이미지 미리보기" 텍스트로 복원
            if (originalPromoPosterPath) {
                imagePreview.innerHTML = `<img src="${contextPath}/resources/uploadFiles/${originalPromoPosterPath}" alt="Existing Image">`;
                const parts = originalPromoPosterPath.split('/');
                const fileName = parts[parts.length - 1];
                fileNameDisplay.textContent = fileName;
            } else {
                imagePreview.innerHTML = `<span class="no-image-text">이미지 미리보기</span>`;
                fileNameDisplay.textContent = '선택된 파일 없음';
            }
        }
    });

    // 기존 이미지 삭제 체크박스 변경 시 미리보기 처리
    if (deleteOriginalImageCheckbox) {
        deleteOriginalImageCheckbox.addEventListener('change', function() {
            if (this.checked) {
                imagePreview.innerHTML = `<span class="no-image-text">이미지 미리보기</span>`;
                promoPosterInput.value = ''; // 파일 입력 초기화
                fileNameDisplay.textContent = '선택된 파일 없음';
            } else {
                // 체크 해제 시 기존 이미지가 있다면 다시 표시
                if (originalPromoPosterPath) {
                    imagePreview.innerHTML = `<img src="${contextPath}/resources/uploadFiles/${originalPromoPosterPath}" alt="Existing Image">`;
                    const parts = originalPromoPosterPath.split('/');
                    const fileName = parts[parts.length - 1];
                    fileNameDisplay.textContent = fileName;
                } else {
                    imagePreview.innerHTML = `<span class="no-image-text">이미지 미리보기</span>`;
                }
            }
        });
    }

    // 삭제 버튼 클릭 이벤트
    if (deleteButton) {
        deleteButton.addEventListener('click', function(event) {
            event.preventDefault(); // 기본 폼 제출 방지

            if (typeof window.showCommonModal === 'function') {
                window.showCommonModal("게시글 삭제 확인", "정말 이 게시글을 삭제하시겠습니까?").then(confirmed => {
                    if (confirmed) {
                        const deleteForm = deleteButton.closest('form');
                        if (deleteForm) {
                            deleteForm.submit();
                        }
                    } else {
                        console.log("게시글 삭제 취소됨.");
                    }
                });
            } else {
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
