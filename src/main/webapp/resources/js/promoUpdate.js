document.addEventListener('DOMContentLoaded', function () {
    const contextPathInput = document.getElementById('contextPath');
    let contextPath = contextPathInput ? contextPathInput.value.trim() : '';
    if (contextPath && !contextPath.endsWith('/')) {
        contextPath += '/';
    }
	const csrfTokenMeta = document.querySelector('meta[name="_csrf"]');
	const csrfHeaderMeta = document.querySelector('meta[name="_csrf_header"]');
	const csrfParamMeta = document.querySelector('meta[name="_csrf_parameter_name"]');
	
	const csrfToken = csrfTokenMeta ? csrfTokenMeta.content : '';
	const csrfHeader = csrfHeaderMeta ? csrfHeaderMeta.content : 'X-CSRF-TOKEN';
	const csrfParam = csrfParamMeta ? csrfParamMeta.content : '_csrf';
	

    // 엘리먼트 참조
    const promoTitleInput = document.getElementById('promoTitle');
    const promoDetailTextarea = document.getElementById('promoDetail');
    const promotionPageUrlInput = document.getElementById('promotionPageUrl');
    const promoPosterInput = document.getElementById('promoPoster');
    const fileNameDisplay = document.getElementById('fileNameDisplay');
    const imagePreview = document.getElementById('imagePreview');
    const adminButtons = document.getElementById('adminButtons');
    const editButtons = document.getElementById('editButtons');

    const originalPosterPathInput = document.getElementById('originalPromoPosterPath');
    const originalPromoPosterPath = originalPosterPathInput ? originalPosterPathInput.value.trim() : '';

    const editableFields = [promoTitleInput, promoDetailTextarea, promotionPageUrlInput];

    // 원본 값 저장
    const originalValues = {
        promoTitle: promoTitleInput ? promoTitleInput.value : '',
        promoDetail: promoDetailTextarea ? promoDetailTextarea.value : '',
        promotionPageUrl: promotionPageUrlInput ? promotionPageUrlInput.value : '',
        posterHtml: imagePreview ? imagePreview.innerHTML : '',
        fileName: fileNameDisplay ? fileNameDisplay.textContent : '선택된 파일 없음'
    };

    // 기존 이미지 파일 이름 표시
    if (originalPromoPosterPath && fileNameDisplay) {
        const filename = originalPromoPosterPath.split('/').pop();
        fileNameDisplay.textContent = filename;
    }

    // 이미지 있으면 텍스트 제거
    if (imagePreview) {
        const noImageText = imagePreview.querySelector('.no-image-text');
        if (imagePreview.querySelector('img') && noImageText) {
            noImageText.remove();
        }
    }

    // 수정 모드 활성화
    window.enableEdit = function () {
        editableFields.forEach(field => {
            if (field) field.removeAttribute('readonly');
        });
        if (promoPosterInput) promoPosterInput.disabled = false;
        if (adminButtons) adminButtons.style.display = 'none';
        if (editButtons) editButtons.style.display = 'flex';
    };

    // 수정 취소 및 원본 복원
    window.cancelEdit = function () {
        editableFields.forEach(field => {
            if (field) field.setAttribute('readonly', true);
        });
        if (promoPosterInput) {
            promoPosterInput.disabled = true;
            promoPosterInput.value = '';
        }
        if (promoTitleInput) promoTitleInput.value = originalValues.promoTitle;
        if (promoDetailTextarea) promoDetailTextarea.value = originalValues.promoDetail;
        if (promotionPageUrlInput) promotionPageUrlInput.value = originalValues.promotionPageUrl;
        if (imagePreview) imagePreview.innerHTML = originalValues.posterHtml;
        if (fileNameDisplay) fileNameDisplay.textContent = originalValues.fileName;

        if (adminButtons) adminButtons.style.display = 'flex';
        if (editButtons) editButtons.style.display = 'none';
    };

    // 파일 선택 시 이미지 미리보기
    if (promoPosterInput) {
        promoPosterInput.addEventListener('change', function () {
            if (this.files && this.files[0]) {
                const file = this.files[0];
                if (fileNameDisplay) fileNameDisplay.textContent = '새 파일: ' + file.name;

                const reader = new FileReader();
                reader.onload = function (e) {
                    if (!imagePreview) return;

                    let img = imagePreview.querySelector('img');
                    if (!img) {
                        img = document.createElement('img');
                        img.alt = '새 이미지 미리보기';
                        imagePreview.innerHTML = '';
                        imagePreview.appendChild(img);
                    }
                    img.src = e.target.result;
                };
                reader.onerror = function () {
                    if (imagePreview) {
                        imagePreview.innerHTML = '<span class="no-image-text">이미지 미리보기 (실패)</span>';
                    }
                    if (fileNameDisplay) {
                        fileNameDisplay.textContent = '파일 읽기 오류';
                    }
                };
                reader.readAsDataURL(file);
            } else {
                // 파일 선택 취소 시 원본 이미지 복원
                if (imagePreview && fileNameDisplay) {
                    if (originalPromoPosterPath) {
                        const filename = originalPromoPosterPath.split('/').pop();
                        imagePreview.innerHTML = `<img src="${contextPath}${originalPromoPosterPath}" alt="기존 이미지" onerror="this.onerror=null;this.src='https://placehold.co/600x600/e0e0e0/ffffff?text=No+Image';" />`;
                        fileNameDisplay.textContent = filename;
                    } else {
                        imagePreview.innerHTML = '<span class="no-image-text">이미지 미리보기</span>';
                        fileNameDisplay.textContent = '선택된 파일 없음';
                    }
                }
            }
        });
    }

    // 삭제 버튼 처리
     const deleteButtons = document.querySelectorAll('.deleteButton');
    deleteButtons.forEach(button => {
        button.addEventListener('click', function (e) {
            e.preventDefault();
            const deleteForm = this.closest('form');
            if (!deleteForm) return;

            const proceedDelete = function () {
                if (csrfToken && !deleteForm.querySelector(`input[name="${csrfParam}"]`)) {
                    const hidden = document.createElement('input');
                    hidden.type = 'hidden';
                    hidden.name = csrfParam;
                    hidden.value = csrfToken;
                    deleteForm.appendChild(hidden);
                }
                deleteForm.submit();
            };

            if (typeof window.showCommonModal === 'function') {
                window.showCommonModal('게시글 삭제 확인', '정말 이 게시글을 삭제하시겠습니까?')
                    .then(confirmed => {
                        if (confirmed) proceedDelete();
                    });
            } else {
                if (confirm('정말 삭제하시겠습니까?')) {
                    proceedDelete();
                }
            }
        });
    });

document.getElementById('promoUpdateForm').addEventListener('submit', async (event) => {
		    event.preventDefault();
		    
		    let modalTitle = "게시글 저장 확인";
		    let modalContent = "게시글 내용을 저장하시겠습니까?";
		    
		    const result = await window.showCommonModal(
		            modalTitle,
		            modalContent,
		        {
		            cancelButtonText: "아니오",
		            confirmButtonText: "네, 진행합니다"
	        	}
	        );
		    if (result){
	    		window.showLoadingModal();
		        event.target.submit();
	        }
});