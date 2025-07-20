// src/main/webapp/resources/js/myPromo.js

$(document).ready(function() {
    // 1. 홍보 상세/수정 모달 열릴 때 데이터 로드 및 폼 채우기
    $('#promoDetailModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // 모달을 트리거한 링크 (게시글 제목)
        var promoNo = button.data('promo-no'); // data-promo-no 속성에서 게시글 번호 가져오기

        // 폼 초기화 (이전 데이터 잔여 방지)
        $('#promoDetailForm')[0].reset();
        $('#currentPoster').attr('src', ''); // 이미지 미리보기 초기화
        $('#detailPromoNo').val(''); // hidden input 초기화

        // AJAX 요청으로 해당 게시글 정보 가져오기
        $.ajax({
            url: CONTEXT_PATH + "/myPromo/detail", // MyPromoController의 상세 조회 URL
            type: "GET",
            data: { promoNo: promoNo },
            dataType: "json", // JSON 형태로 응답 받을 것임을 명시
            success: function(response) {
                if (response) {
                    // MyPromoVo 객체의 필드명에 맞춰 모달 폼 필드 채우기
                    $('#detailPromoNo').val(response.promoNo);
                    $('#detailTitle').val(response.promoTitle);
                    $('#detailContent').val(response.promoContent);
                    $('#detailPromotionUrl').val(response.promotionPageUrl);
                    $('#detailCreateDate').val(formatDate(response.createDate));
                    $('#detailUpdateDate').val(response.updateDate ? formatDate(response.updateDate) : '없음');
                    $('#detailViews').val(response.promoViews);
                    $('#detailStatus').val(response.promoStatus);
                    $('#detailAppId').val(response.appId); // app_id 필드 채우기

                    // 포스터 이미지 처리
                    if (response.posterPath) {
                        $('#currentPoster').attr('src', CONTEXT_PATH + response.posterPath).show();
                    } else {
                        $('#currentPoster').hide(); // 이미지가 없으면 숨김
                    }

                    // 초기에는 읽기 전용 모드
                    setFormReadonly(true);
                    $('#updateSubmitBtn').hide(); // 수정 버튼 숨김
                    $('#deletePromoBtn').show(); // 삭제 버튼 보임
                } else {
                    alert("게시글 정보를 불러오는데 실패했습니다.");
                    $('#promoDetailModal').modal('hide');
                }
            },
            error: function(xhr, status, error) {
                console.error("AJAX Error: ", status, error);
                alert("게시글 정보를 불러오는 중 오류가 발생했습니다.");
                $('#promoDetailModal').modal('hide');
            }
        });
    });

    // 폼 필드 읽기 전용/편집 가능 설정 함수
    function setFormReadonly(isReadonly) {
        $('#promoDetailForm input[type="text"], #promoDetailForm textarea, #promoDetailForm input[type="url"], #promoDetailForm select').prop('readonly', isReadonly);
        $('#detailPosterFile').prop('disabled', isReadonly); // 파일 입력 필드는 disabled로 제어
        if (isReadonly) {
            $('#detailPosterFile').val(''); // 읽기 전용일 때 파일 입력 필드 초기화
        }
    }

    // '수정' 버튼 클릭 시 폼 필드 활성화
    // (여기서는 상세 모달의 "수정" 버튼이 submit 버튼이므로, 별도의 "수정" 버튼이 필요하다면 추가)
    // 현재는 모달이 열리면 바로 수정 가능하도록 하거나, 별도의 "수정 모드" 버튼을 추가해야 함.
    // 일단은 모달이 열리면 바로 수정 가능하도록 하고, 삭제 버튼만 별도 처리.

    // '삭제' 버튼 클릭 이벤트
    $('#deletePromoBtn').on('click', function() {
        if (confirm('정말 이 게시글을 삭제하시겠습니까?')) {
            var promoNoToDelete = $('#detailPromoNo').val();
            var userNo = $('input[name="userNo"]').val(); // 현재 로그인된 userNo 가져오기

            $.ajax({
                url: CONTEXT_PATH + "/myPromo/delete",
                type: "POST",
                data: { promoNo: promoNoToDelete, userNo: userNo }, // userNo도 함께 전송
                success: function(response) {
                    alert(response.msg); // 컨트롤러에서 RedirectAttributes로 보낸 메시지
                    $('#promoDetailModal').modal('hide');
                    location.reload(); // 페이지 새로고침하여 목록 업데이트
                },
                error: function(xhr, status, error) {
                    console.error("삭제 AJAX 오류: ", status, error);
                    alert("게시글 삭제 중 오류가 발생했습니다.");
                }
            });
        }
    });

    // 날짜 포맷팅 헬퍼 함수 (Date 객체를 YYYY.MM.DD HH:mm 형식으로)
    function formatDate(dateString) {
        if (!dateString) return '';
        var date = new Date(dateString);
        var year = date.getFullYear();
        var month = String(date.getMonth() + 1).padStart(2, '0');
        var day = String(date.getDate()).padStart(2, '0');
        var hours = String(date.getHours()).padStart(2, '0');
        var minutes = String(date.getMinutes()).padStart(2, '0');
        return `${year}.${month}.${day} ${hours}:${minutes}`;
    }

    // 작성 모달이 닫힐 때 폼 초기화
    $('#promoWriteModal').on('hidden.bs.modal', function () {
        $('#promoWriteForm')[0].reset();
    });

    // 수정 모달이 닫힐 때 폼 초기화
    $('#promoDetailModal').on('hidden.bs.modal', function () {
        $('#promoDetailForm')[0].reset();
    });

    // 폼 제출 시 메시지 처리 (AJAX 제출이 아닌 일반 폼 제출 시)
    // 이 부분은 컨트롤러에서 RedirectAttributes를 사용하므로,
    // 페이지 로드 시 URL 파라미터나 FlashAttribute를 확인하여 메시지를 표시합니다.
    // <c:if test="${not empty msg}"> ... </c:if> 로 이미 처리됨.
});