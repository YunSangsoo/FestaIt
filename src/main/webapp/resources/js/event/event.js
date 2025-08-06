

// 캘린더 호버 이벤트
$(document).on('mouseenter', '.fc-daygrid-event', function(e) {
  $('#event-hover-thumbcard')
    .css({
      display: 'block',
      left: e.pageX + 10 + 'px',
      top: e.pageY + 10 + 'px'
    });
});

$(document).on('mouseleave', '.fc-daygrid-event', function() {
  $('#event-hover-thumbcard').hide();
});

$(document).on('mousemove', '.fc-daygrid-event', function(e) {
  $('#event-hover-thumbcard')
    .css({
      left: e.pageX + 10 + 'px',
      top: e.pageY + 10 + 'px'
    });
});


// 북마크 기본 설정

const bookmarkEmpty = 'M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1z';
const bookmarkFill = 'M2 15.5V2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.74.439L8 13.069l-5.26 2.87A.5.5 0 0 1 2 15.5M8.16 4.1a.178.178 0 0 0-.32 0l-.634 1.285a.18.18 0 0 1-.134.098l-1.42.206a.178.178 0 0 0-.098.303L6.58 6.993c.042.041.061.1.051.158L6.39 8.565a.178.178 0 0 0 .258.187l1.27-.668a.18.18 0 0 1 .165 0l1.27.668a.178.178 0 0 0 .257-.187L9.368 7.15a.18.18 0 0 1 .05-.158l1.028-1.001a.178.178 0 0 0-.098-.303l-1.42-.206a.18.18 0 0 1-.134-.098z';

document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll('.bookmark').forEach(function (bookmarkEl) {
        const path = bookmarkEl.querySelector('path');
        if (path) {
            path.setAttribute('d', bookmarkEmpty);
        }
    });
    document.querySelectorAll('.bookmark.selected').forEach(function (bookmarkEl) {
        const path = bookmarkEl.querySelector('path');
        if (path) {
            path.setAttribute('d', bookmarkFill);
        }
    });
});

// 북마크 클릭 이벤트
$(document).ready(function () {
	$('.bookmark').on('click', function () {

		const token = $("meta[name='_csrf']").attr("content");
        const header = $("meta[name='_csrf_header']").attr("content");
	  
		const $this = $(this);
		const appId = $this.data('app-id');
		const path = this.querySelector('path');
		
		
		$.ajax({
	url: $this.hasClass('selected') ? '/festait/bookmark/remove' : '/festait/bookmark/add',
	method: 'POST',
	beforeSend: function(xhr) {
		if (token && header) {
			xhr.setRequestHeader(header, token);
		}
	},
		success: function(res) {
			// 응답이 비어있으면(로그인 성공) 정상적으로 처리
			if (!res) {
				$this.toggleClass('selected'); // 선택 상태 토글
				if ($this.hasClass('selected')) path.setAttribute('d', bookmarkFill);
				else path.setAttribute('d', bookmarkEmpty);
			} else {
				// 응답이 비어있지 않으면(로그인 페이지로 리다이렉트 된 경우)
				window.showCommonModal('알림', "로그인 후 사용할 수 있는 기능입니다.", {
					showCancelButton: false,
					confirmButtonText: '확인',
					// 모달의 '확인' 버튼 클릭 시 로그인 페이지로 이동
					onConfirm: function() {
						window.location.href = '/festait/user/login';
					}
				});
			}
		},
		data: {
			appId: appId
		},
		error: function(xhr, status, error) {
			// 실제 네트워크 오류나 서버 오류 발생 시 처리
			console.log("Error:", error);
			window.showCommonModal('알림', "서버에 문제가 발생했습니다. 다시 시도해 주세요.", {
				showCancelButton: false,
				confirmButtonText: '확인'
			});
		}
	});
  });
});




 
 
 
 