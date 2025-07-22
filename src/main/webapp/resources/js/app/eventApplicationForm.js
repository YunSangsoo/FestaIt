
(() => {
  'use strict'

  // Fetch all the forms we want to apply custom Bootstrap validation styles to
  const forms = document.querySelectorAll('.needs-validation')

  // Loop over them and prevent submission
  Array.from(forms).forEach(form => {
    form.addEventListener('submit', event => {
      if (!form.checkValidity()) {
        event.preventDefault()
        event.stopPropagation()
      }

      form.classList.add('was-validated')
    }, false)
  })
})()



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

const posterInput = document.querySelector('.input-poster');

posterInput.addEventListener('change', function(event) {
	const file = event.target.files[0];
	const posterImg = document.querySelector('.img-poster');
	const posterPlaceholder = document.getElementById('posterPlaceholder');
	posterImg.classList.remove('d-none');

	if (file) {
			const reader = new FileReader();
			reader.onload = function(e) {
				posterImg.src = e.target.result;
				posterImg.style.display = 'block'; // 이미지 보이기
				posterPlaceholder.style.display = 'none'; // "포스터" 텍스트 숨기기
			};
			reader.readAsDataURL(file);
	} else {
		uploadedImage.src = '#';
		uploadedImage.style.display = 'none'; // 이미지 숨기기
		posterPlaceholder.style.display = 'block'; // "포스터" 텍스트 다시 보이기
	}
});

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
		document.getElementById('postCode').value = data.zonecode;
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