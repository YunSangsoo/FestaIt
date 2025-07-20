// 김현주 : 행사 페이지 전용 스크립트

// DOM(문서 객체 모델)이 모두 로드되면 함수 실행
$(document).ready(function() {

    // '목록 보기' 버튼 클릭 이벤트 처리
    // .list-btn 클래스를 가진 요소에 클릭 이벤트 리스너를 추가합니다.
    $('.list-btn').on('click', function(e) {
        e.preventDefault(); // 버튼의 기본 이벤트(예: 폼 제출) 방지

        // 이전 페이지(홍보게시판)로 이동합니다.
        // 현재는 홍보게시판이 비어있으므로 단순히 뒤로 가기 기능을 사용합니다.
        window.history.back(); 
        
        // --- [향후 홍보 게시판 페이지 구현 시 사용] ---
        // 만약 특정 홍보 게시판 URL로 이동해야 한다면 아래 주석을 해제하고 사용하세요.
        // 참고: ${contextPath}는 JSP에서 설정한 컨텍스트 경로이므로,
        //      JavaScript 파일에서는 직접 사용할 수 없습니다.
        //      이를 해결하려면 JSP에서 JavaScript 변수로 넘겨주거나,
        //      하드코딩된 상대 경로를 사용해야 합니다.
        //      여기서는 JSP에서 넘어온다고 가정하고 주석 처리했습니다.
        //
        // 예시: var contextPath = "${contextPath}"; 를 JSP에 추가 후 사용
        // location.href = contextPath + '/promote/list'; 
        // ------------------------------------------
    });

    // '게시물 홍보하기' 버튼 클릭 이벤트 처리
    // .promote-btn 클래스를 가진 요소에 클릭 이벤트 리스너를 추가합니다.
    $('.promote-btn').on('click', function(e) {
        e.preventDefault(); // 버튼의 기본 이벤트 방지

        alert('게시물 홍보하기 버튼이 클릭되었습니다. 홍보글 작성 페이지로 이동합니다.');
        
        // --- [향후 홍보글 작성 페이지 구현 시 사용] ---
        // 아래 코드를 통해 홍보글 작성 페이지로 이동시킬 수 있습니다.
        // 현재 페이지가 없으므로 주석 처리합니다.
        //
        // 예시: var contextPath = "${contextPath}"; 를 JSP에 추가 후 사용
        // location.href = contextPath + '/promote/write'; 
        // ------------------------------------------
    });

    // ====================================================================
    // 카카오맵 지도 초기화 및 주소 표시 로직
    // ====================================================================

    // #map 요소가 존재하는지 확인 (지도 없는 페이지도 있을 수 있으므로)
    if ($('#map').length && typeof kakao !== 'undefined' && kakao.maps) {
        initKakaoMap();
    }

    function initKakaoMap() {
        var mapContainer = document.getElementById('map'); // 지도를 표시할 div의 ID
        var mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667), // 초기 지도 중심 (제주 카카오 본사, 주소가 없을 때 임시)
            level: 3 // 지도의 확대 레벨
        };  
        
        // 지도를 생성합니다    
        var map = new kakao.maps.Map(mapContainer, mapOption); 

        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();

        // JSP에서 받아온 행사 주소 정보를 사용합니다.
        // eventLocation 변수는 eventDetail.jsp의 <script> 태그에서 전역 변수로 선언됩니다.
        var addressToSearch = eventLocation; // eventDetail.jsp에서 설정한 eventLocation 변수 사용

        // eventLocation이 비어있지 않다면 주소로 좌표를 검색하여 지도에 표시합니다.
        if (addressToSearch && addressToSearch.trim() !== '') {
            geocoder.addressSearch(addressToSearch, function(result, status) {
                // 정상적으로 검색이 완료됐으면 
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                    // 결과값으로 받은 위치를 마커로 표시합니다
                    var marker = new kakao.maps.Marker({
                        map: map,
                        position: coords
                    });

                    // 인포윈도우로 장소에 대한 설명을 표시합니다
                    var infowindow = new kakao.maps.InfoWindow({
                        content: '<div style="width:150px;text-align:center;padding:6px 0;">' + addressToSearch + '</div>'
                    });
                    infowindow.open(map, marker);

                    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                    map.setCenter(coords);
                } else {
                    // 주소 검색 실패 시 콘솔에 에러를 출력합니다.
                    console.error("주소-좌표 변환 실패:", status);
                    // 실패 시 기본 중심 좌표로 지도 표시 (혹은 사용자에게 알림)
                    map.setCenter(new kakao.maps.LatLng(37.566826, 126.9786567)); // 서울 시청 (예시)
                }   
            });
        } else {
            console.log("표시할 행사 주소 정보가 없습니다. 기본 위치로 지도를 표시합니다.");
            map.setCenter(new kakao.maps.LatLng(37.566826, 126.9786567)); // 서울 시청 (기본)
        }
    }
});