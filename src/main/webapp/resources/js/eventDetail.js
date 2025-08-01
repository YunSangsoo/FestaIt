document.addEventListener('DOMContentLoaded', function() {

// 북마크 아이콘 로직
const bookmarkIcon = document.getElementById('bookmarkIcon');
const bookmarkText = document.getElementById('bookmarkText');

// CSRF 토큰 가져오기 (JSP head에 meta 태그가 있는지 확인)
const csrfToken = document.querySelector('meta[name="_csrf"]').content;
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').content;

// 로그인된 사용자만 북마크 기능 활성화
if (bookmarkIcon && loginMemberUserNo !== 0) {
    bookmarkIcon.style.cursor = 'pointer';

    bookmarkIcon.addEventListener('click', function() {
        const url = eventBookmarked === 'true' ? `${contextPath}/bookmark/remove` : `${contextPath}/bookmark/add`;

        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                [csrfHeader]: csrfToken // CSRF 토큰 헤더에 추가
            },
            body: `appId=${eventAppId}`
        })
        .then(response => {
            // ⭐⭐⭐ 중요 수정: response.json() 호출 제거 ⭐⭐⭐
            // BookmarkController가 JSON 응답을 보내지 않으므로, HTTP 상태 코드만 확인합니다.
            if (response.ok) { // HTTP 상태 코드가 200-299 범위인 경우
                return true; // 성공
            } else {
                return false; // 실패 (예: 4xx, 5xx 에러)
            }
        })
        .then(isSuccess => {
            if (isSuccess) {
                // 북마크 상태 토글 (JSP 변수 업데이트)
                eventBookmarked = eventBookmarked === 'true' ? 'false' : 'true';

                // 아이콘과 텍스트 업데이트
                if (eventBookmarked === 'true') {
                    bookmarkIcon.classList.remove('bi-bookmark');
                    bookmarkIcon.classList.add('bi-bookmark-star-fill');
                    bookmarkText.textContent = '북마크됨';
                    alert("북마크에 추가되었습니다."); // 사용자에게 알림
                } else {
                    bookmarkIcon.classList.remove('bi-bookmark-star-fill');
                    bookmarkIcon.classList.add('bi-bookmark');
                    bookmarkText.textContent = '북마크';
                    alert("북마크가 제거되었습니다."); // 사용자에게 알림
                }
            } else {
                // 서버에서 200번대 상태 코드를 보내지 않은 경우 (오류 상황)
                alert("북마크 처리 중 오류가 발생했습니다. 다시 시도해 주세요.");
                console.error("서버에서 북마크 요청 실패 (HTTP Status NOT OK)");
            }
        })
        .catch(error => {
            console.error("북마크 요청 중 네트워크 또는 기타 오류 발생:", error);
            alert("북마크 요청 중 네트워크 오류가 발생했습니다. 인터넷 연결을 확인하거나 관리자에게 문의하세요.");
        });
    });
} else if (bookmarkIcon) { // 비로그인 상태일 때
    bookmarkIcon.style.cursor = 'default';
    // Jsp에서 이미 title 속성을 설정했으므로 추가적인 JavaScript 설정은 불필요.
}

    // 카카오맵 초기화 및 마커 표시
    if (typeof kakao !== 'undefined' && kakao.maps && eventLocation) {
        var mapContainer = document.getElementById('map');
        var mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667),
            level: 3
        };  
        
        var map = new kakao.maps.Map(mapContainer, mapOption); 
        var geocoder = new kakao.maps.services.Geocoder();
        
        geocoder.addressSearch(eventLocation, function(result, status) {
             if (status === kakao.maps.services.Status.OK) {
        
                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
        
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });
        
                var infowindow = new kakao.maps.InfoWindow({
                    content: '<div style="width:150px;text-align:center;padding:6px 0;">' + eventLocation + '</div>'
                });
                infowindow.open(map, marker);
        
                map.setCenter(coords);
            } else {
                console.error("카카오맵 주소 검색 실패:", status);
                mapContainer.innerHTML = '<p style="text-align:center; padding-top:50px;">지도 정보를 불러올 수 없습니다.</p>';
            } 
        });    
    } else if (document.getElementById('map')) {
        document.getElementById('map').innerHTML = '<p style="text-align:center; padding-top:50px;">지도 API 로드 실패 또는 장소 정보 없음.</p>';
    }

    // 공유하기 버튼 클릭 이벤트
    const shareLinkButton = document.getElementById('shareLinkButton');
    if (shareLinkButton) {
        shareLinkButton.addEventListener('click', function() {
            const currentUrl = window.location.href;
            navigator.clipboard.writeText(currentUrl).then(function() {
                alert('링크가 클립보드에 복사되었습니다!');
            }).catch(function(err) {
                console.error('링크 복사 실패:', err);
                alert('링크 복사에 실패했습니다. 수동으로 복사해주세요: ' + currentUrl);
            });
        });
    }
});