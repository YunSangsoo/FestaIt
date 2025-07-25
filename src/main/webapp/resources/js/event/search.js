
/* 버튼 사용 후 기간 수정 시 버튼 select 해제 */
function resetDateBtn(){	
    document.querySelectorAll('.btn-date').forEach(b => {
      if (b.classList.contains('selected')) {
        b.classList.remove('selected', 'active');
      }
	});
}

document.querySelectorAll('.dateInput').forEach(di => {
  di.addEventListener('input', resetDateBtn());
});

$('#startDate').datepicker({
	dateFormat: 'yy-mm-dd', // 날짜 형식: YYYY-MM-DD
	//showOn: 'button',       // 입력 필드 클릭 또는 버튼 클릭 시 표시
	//buttonText: '<i>선택</i>', // 버튼 아이콘 (Font Awesome 사용)
	//	minDate: 0,          // 오늘 이전 날짜 선택 불가
	// maxDate: '+1M +10D', // 오늘로부터 한 달 10일 후까지 선택 가능 (선택 사항)
	onSelect: function(selectedDate) {
		// 날짜 선택 시 실행되는 콜백 함수
		resetDateBtn();
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
	//	minDate: 0,          // 오늘 이전 날짜 선택 불가
	// maxDate: '+1M +10D', // 오늘로부터 한 달 10일 후까지 선택 가능 (선택 사항)
	onSelect: function(dateText, inst) {
		resetDateBtn();
		// 날짜 선택 시 실행되는 콜백 함수
		//$('#startDate').text(dateText);
}
});

$(".event-card").on("mouseenter", function() {
	$(this).find(".EventItemHover-img").fadeIn(100);
	$(this).find(".event-info").fadeOut(300);
}).on("mouseleave", function() {
	$(this).find(".EventItemHover-img").fadeOut(100);
	$(this).find(".event-info").fadeIn(300);
});


// 오늘 날짜 구하는 함수 (yyyy-MM-dd)
function getToday() {
  const today = new Date();
  
  return today.toISOString().split('T')[0];
}

// N일 뒤 날짜 구하는 함수
function getFutureDate(days) {
  var today = new Date();
  
  switch(days){
  case 7: today.setDate(today.getDate() + days); break;
  case 30: today.setMonth(today.getMonth() + 1); break;
  case 90: today.setMonth(today.getMonth() + 3); break;
  case 180: today.setMonth(today.getMonth() + 6); break;
  }
  return today.toISOString().split('T')[0];
}


// 버튼 클릭 핸들러
document.querySelectorAll('.btn-date').forEach(btn => {
  btn.addEventListener('click', function() {
    // 모든 버튼 선택 해제
    document.querySelectorAll('.btn-date').forEach(b => b.classList.remove('selected', 'active'));
    // 현재 버튼 선택
    this.classList.add('selected', 'active');

    // 기간 가져오기
    const days = parseInt(this.dataset.period, 10);
    // 날짜 계산
    const startDate = getToday();
    const endDate = getFutureDate(days);

    // form input에 값 삽입
    document.getElementById('startDate').value = startDate;
    document.getElementById('endDate').value = endDate;
  });
});


$('.btn-category').on("click", function() {
	if ($(this).hasClass('selected')) {
	  // 이미 선택된 버튼을 다시 클릭하면 선택 해제
		$(this).removeClass('selected active');
	} else {
		$(this).addClass('selected active');
	}
   
	  // 선택된 버튼들 찾기
	  const selectedValues = [];
	  $('.btn-category.selected').each(function() {
	    selectedValues.push(this.value);
	  });

	  // ','로 구분된 문자열로 연결
	  const categoryAll = selectedValues.join(',');
	  // hidden input에 반영
	  $('#eventCode').val(categoryAll);
});
 
 
 
 
 
 