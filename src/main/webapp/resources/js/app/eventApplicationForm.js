
(function () {
  'use strict';

  // Bootstrap 유효성 검사 스타일을 적용할 모든 폼 가져오기
  var forms = document.querySelectorAll('.needs-validation');
  
  
  // 각 폼을 순회하며 제출 이벤트 리스너 추가
  Array.prototype.slice.call(forms)
    .forEach(function (form) {
      form.addEventListener('submit', function (event) {
        // 제출을 발생시킨 버튼을 찾습니다. (HTML5 'submit' 이벤트의 submitter 속성 활용)
        const submitter = event.submitter;
        
        console.log(submitter);
        
        // 1. 만약 제출된 버튼에 'formnovalidate' 속성이 있다면
        if (submitter && submitter.hasAttribute('formnovalidate')) {
          // 브라우저의 기본 동작(폼 제출)을 막지 않고, Bootstrap의 유효성 검사도 건너뜝니다.
          // 이렇게 하면 HTML5 formnovalidate가 의도한 대로 작동합니다.
          console.log("Formnovalidate 버튼 클릭됨. Bootstrap 유효성 검사를 건너뜝니다.");
          return; // 이벤트 리스너에서 빠져나가 기본 폼 제출을 허용
        }

        // 2. 'formnovalidate' 속성이 없는 일반 제출 버튼인 경우 (예: '최종 제출')
        //    Bootstrap의 유효성 검사 로직을 수행합니다.
        if (!form.checkValidity()) {
          event.preventDefault(); // 기본 폼 제출 동작을 막음
          event.stopPropagation(); // 이벤트 버블링 중지
        } else {
          // 유효성 검사 통과 시 추가적인 동작이 필요하다면 여기에 추가
        }

        // 유효성 검사 결과를 시각적으로 보여주기 위한 클래스 추가
        form.classList.add('was-validated');
      }, false);
    });
    
    
})();

$('#startDate').datepicker({
	dateFormat: 'yy-mm-dd', // 날짜 형식: YYYY-MM-DD
	//showOn: 'button',       // 입력 필드 클릭 또는 버튼 클릭 시 표시
	//buttonText: '<i>선택</i>', // 버튼 아이콘 (Font Awesome 사용)
		minDate: 0,          // 오늘 이전 날짜 선택 불가
	// maxDate: '+1M +10D', // 오늘로부터 한 달 10일 후까지 선택 가능 (선택 사항)
	onSelect: function(selectedDate) {
		// 날짜 선택 시 실행되는 콜백 함수
		var startDate = $(this).datepicker('getDate');
		$('#endDate').datepicker('option', 'minDate', startDate);
		var endDate = $('#endDate').datepicker('getDate');
		if (endDate && endDate < startDate) {
			$('#endDate').val(''); // 종료 날짜 필드 비움
			$('#selectedEndDate').text('선택되지 않음'); // 종료 날짜 텍스트 초기화
		}
}

});
$('#endDate').datepicker({
	dateFormat: 'yy-mm-dd', // 날짜 형식: YYYY-MM-DD
	//showOn: 'button',       // 입력 필드 클릭 또는 버튼 클릭 시 표시
	//buttonText: '<i>선택</i>', // 버튼 아이콘 (Font Awesome 사용)
		minDate: 0,          // 오늘 이전 날짜 선택 불가
	// maxDate: '+1M +10D', // 오늘로부터 한 달 10일 후까지 선택 가능 (선택 사항)
	onSelect: function(dateText, inst) {
		// 날짜 선택 시 실행되는 콜백 함수
		//$('#startDate').text(dateText);
}
});


document.addEventListener('DOMContentLoaded', function() {
    const homepageLinkInput = document.getElementById('homepageLink');
    const visitHomepageBtn = document.getElementById('visitHomepageBtn');

    // 페이지 로드 시 초기 상태 설정 및 버튼 활성화/비활성화 제어
    function updateHomepageButtonVisibility() {
        if (homepageLinkInput.value.trim() !== '') {
            visitHomepageBtn.style.display = 'block'; // 값이 있으면 버튼 보이기
            visitHomepageBtn.disabled = false;       // 버튼 활성화
        } else {
            visitHomepageBtn.style.display = 'none'; // 값이 없으면 버튼 숨기기
            visitHomepageBtn.disabled = true;        // 버튼 비활성화
        }
    }
    // 입력 필드 값이 변경될 때마다 버튼 가시성 및 활성화 상태 업데이트
    homepageLinkInput.addEventListener('input', updateHomepageButtonVisibility);

    // 버튼 클릭 시 해당 링크로 이동
    visitHomepageBtn.addEventListener('click', function() {
        let url = homepageLinkInput.value.trim();
        if (url) {
            // URL이 'http://' 또는 'https://'로 시작하지 않으면 추가
            if (!url.startsWith('http://') && !url.startsWith('https://')) {
                url = 'http://' + url;
            }
            window.open(url, '_blank'); // 새 탭에서 열기
        }
    });

    // 페이지 로드 시 한 번 실행하여 초기 상태 설정
    updateHomepageButtonVisibility();
    
    
    if(isViewMode){
    	const dSetElements = document.querySelectorAll('.dSet');
	    dSetElements.forEach(element => {
	        // element.disabled = true;
	        // 이 방법은 <input>, <select>, <textarea>, <button>, <fieldset> 같은 폼 요소에 직접적으로 적용됩니다.
	        // 다른 일반적인 HTML 태그(예: div, span)에는 semantic하게 'disabled'가 적용되지 않지만,
	        // 속성 자체는 설정됩니다.
	
	        // 더 범용적으로 HTML 속성을 설정하려면 setAttribute를 사용할 수 있습니다.
	        // 하지만 폼 컨트롤의 'disabled' 상태 변경에는 .disabled = true/false 가 더 일반적이고 권장됩니다.
	        element.setAttribute('disabled', 'true'); // HTML 속성으로 'disabled="true"' 추가
	    });
    }
    const categorySelect = document.getElementById('category');
        if (categorySelect && initialEventCode) {
            // 할당하기 전에 혹시 모를 공백 제거
            categorySelect.value = initialEventCode.trim();
        }
});

const posterInput = document.querySelector('.input-poster');
const existingImgNoInput = document.getElementById('existingImgNo'); // 추가: hidden input
const deleteImageBtn = document.querySelector('.delete-image-btn'); // 삭제 버튼

posterInput.addEventListener('change', function(event) {
	const file = event.target.files[0];
	const posterImg = document.querySelector('.img-poster');
	const posterPlaceholder = document.getElementById('posterPlaceholder');
	posterImg.classList.remove('d-none');

	if (file) {
			const reader = new FileReader();
			reader.onload = function(e) {
				posterImg.src = e.target.result;
	            posterImg.classList.remove('d-none'); // 이미지를 보이게 함
	            posterPlaceholder.classList.add('d-none'); // 플레이스홀더 숨김
	            existingImgNoInput.value = 0; // 새 파일 업로드 시 existingImgNo를 0으로 설정
			};
			reader.readAsDataURL(file);
	} else {
		// 파일 선택 취소 시 (파일을 선택했다가 취소 버튼 누른 경우)
        // 기존 이미지가 있었으면 다시 표시하고, 없었으면 플레이스홀더 표시
        if (existingImgNoInput.value !== '0' && existingImgNoInput.value !== '-1' && existingImgNoInput.value !== '') { 
            // 원래 있던 이미지라면 이 시점에서는 원래 이미지가 없으므로 서버로부터 다시 받아와야 정확하지만,
            // 간단하게는 기존 이미지 정보(src)가 있었다면 그것을 유지하도록 할 수 있습니다.
            // 여기서는 페이지를 다시 로드하거나, 원래 이미지 URL을 저장해두는 방식이 더 확실합니다.
            // 다만, 사용자가 파일을 선택하다가 취소했을 때, 이전 상태를 복원하는 것은 JS만으로는 한계가 있습니다.
            // 새로고침을 유도하거나, '취소' 버튼을 통해 폼을 초기화하는 기능을 제공하는 것이 일반적입니다.

            // 현재는 파일이 없으므로 플레이스홀더를 보여주고 이미지 숨기기
            posterImage.src = 'initialPosterSrc';
            posterImage.classList.add('d-none');
            posterPlaceholder.classList.remove('d-none');
            existingImgNoInput.value = initialExistingImgNo; // 기존 이미지 번호 복원
            // existingImgNoInput 값은 그대로 유지
            if (deleteImageBtn) deleteImageBtn.classList.remove('d-none'); // 삭제 버튼 다시 보여주기
            
        } else { // 원래 이미지가 없던 상태에서 취소
            posterImage.src = '#';
            posterImage.classList.add('d-none');
            posterPlaceholder.classList.remove('d-none');
            existingImgNoInput.value = 0; // 0으로 유지
        }
	
	
		//uploadedImage.src = '#';
		//uploadedImage.style.display = 'none'; // 이미지 숨기기
		//posterPlaceholder.style.display = 'block'; // "포스터" 텍스트 다시 보이기
	}
});

if (deleteImageBtn) {
    deleteImageBtn.addEventListener('click', function() {
        if (confirm('정말로 이 이미지를 삭제하시겠습니까?')) {
            // 화면에서 이미지 제거 및 플레이스홀더 표시
            posterImage.src = '#';
            posterImage.classList.add('d-none');
            posterPlaceholder.classList.remove('d-none');
            this.classList.add('d-none'); // 삭제 버튼 숨기기

            // input type="file" 초기화 (선택된 파일 없앰)
            posterInput.value = ''; 

            // hidden input[name="existingImgNo"]의 값을 -1로 설정하여 서버에 이미지 삭제를 알림
            existingImgNoInput.value = -1; 
        }
    });
}



function findAddress(){
new daum.Postcode({
	oncomplete: function(data) {
		// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

		// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
		// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		var roadAddr = data.roadAddress; // 도로명 주소 변수
		// var extraRoadAddr = ''; // 참고 항목 변수

		// 법정동명이 있을 경우 추가한다. (법정리는 제외)
		// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		//if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		//    extraRoadAddr += data.bname;
		//}
		// 건물명이 있고, 공동주택일 경우 추가한다.
		//if(data.buildingName !== '' && data.apartment === 'Y'){
		//   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		//}
		// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		//if(extraRoadAddr !== ''){
		//    extraRoadAddr = ' (' + extraRoadAddr + ')';
		//}

		// 우편번호와 주소 정보를 해당 필드에 넣는다.
		document.getElementById('postcode').value = data.zonecode;
		document.getElementById("address").value = roadAddr;
		//document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
		
		// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
		//if(roadAddr !== ''){
		//    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
		//} else {
		//    document.getElementById("sample4_extraAddress").value = '';
		//}
	}
}).open();
}

document.getElementById('appForm').addEventListener('submit', async (event) => {
    event.preventDefault();
    
 	// 어떤 버튼이 제출을 유발했는지 확인합니다.
    const submitter = event.submitter;
    
    // 제출 버튼이 없으면 함수를 종료합니다.
    if (!submitter) {
        return;
    }
    
    
    const actionValue = submitter.value;
    let modalTitle = "";
    let modalContent = "";
    let approval = false;
    let actionUrl = "";
    
    if (actionValue === 'save') {
        modalTitle = "임시 저장";
        modalContent = "작업 내용을 임시로 저장하시겠습니까?";
    } else if (actionValue === 'edit') {
        modalTitle = "행사 수정";
        modalContent = "행사를 수정하시겠습니까?<br>제출 후에는 수정할 수 없습니다.";
    	actionUrl = submitter.getAttribute('formaction');
    } else if (actionValue === 'submit') {
        modalTitle = "최종 제출";
        modalContent = "신청서를 최종 제출하시겠습니까?<br>제출 후에는 수정할 수 없습니다.";
    } else if (actionValue == 'approval') {
    	modalTitle = "결재 처리";
    	approval = true;
    } else if( actionValue == 'delete') {
    	modalTitle= "신청서 삭제";
    	modalContent = "작성중인 신청서를 삭제합니다.";
    	actionUrl = submitter.getAttribute('formaction');
    }
    
    if(!approval){
	    const result = await window.showCommonModal(
	            modalTitle,
	            modalContent,
	        {
	            cancelButtonText: "아니오",
	            confirmButtonText: "네, 진행합니다"
        	}
        );
	    if (result) {
	    	window.showLoadingModal();
	    	
	        document.getElementById('actionHiddenInput').value = actionValue;
	        if(actionValue=='delete'||actionValue=='edit'){
	        	document.getElementById('appForm').action=actionUrl;
        	}
	        event.target.submit();
	        console.log("Promise 결과: 사용자가 '네, 진행합니다'를 선택했습니다.");
	        // 다음 작업 수행
	    } else {
	        console.log("Promise 결과: 사용자가 '아니오' 또는 닫기를 선택했습니다.");
	    }
    }else{
    	const result = await window.showCommonModal(
	            modalTitle,
	            '행사 결제를 승인하시겠습니까?',
	        {
	            cancelButtonText: "반려",
	            confirmButtonText: "승인"
	        }
	    );
	    if (result) {
	    	window.showLoadingModal();
		    document.getElementById('actionHiddenInput').value = 'A';
	        event.target.submit();
	        
	        
	    	window.hideLoadingModal();
	    	console.log("check");
	    } else {
	    	const rejectReasonResult = await window.showCommonModal(
		        '반려 사유 입력',
		        '<textarea id="rejectReason" class="form-control overflow-y-auto" name="adminComment" rows="5" placeholder="반려 사유를 입력하세요."></textarea>',
		        {
		            cancelButtonText: '취소',
		            confirmButtonText: '반려'
		        }
	    	);
        	if (rejectReasonResult) {
            	const reasonText = document.getElementById('rejectReason').value.trim();
            	if (reasonText === '') {
                	await window.showCommonModal('경고', '반려 사유를 입력해야 합니다.', {
                    showCancelButton: false,
                    confirmButtonText: '확인'
                	});
            	}else {
	    		window.showLoadingModal();
	            document.getElementById('actionHiddenInput').value = 'R';
	            document.getElementById('reasonHiddenInput').value = reasonText;
	           	event.target.submit(); // 폼 제출
	           	window.hideLoadingModal();
	        }
	        } 
    	}
    }
});


