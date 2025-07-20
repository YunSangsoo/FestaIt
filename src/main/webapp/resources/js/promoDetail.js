// src/main/webapp/resources/js/promoDetail.js
// 홍보 세부 페이지에 특화된 JavaScript 코드를 여기에 작성합니다.

document.addEventListener('DOMContentLoaded', function() {
    console.log("promoDetail.js 로드됨");

    // "게시물 보러가기" 버튼에 대한 특정 로직 (필요시)
    // 현재는 JSP에서 onclick 이벤트로 처리하고 있지만,
    // 동적으로 버튼을 생성하거나 추가적인 이벤트 처리가 필요할 경우 여기에 작성합니다.
    const promoViewButton = document.querySelector('.promo-button.btn-primary');
    if (promoViewButton) {
        promoViewButton.addEventListener('click', function() {
            console.log("게시물 보러가기 버튼 클릭됨");
            // 클릭 통계 추적 등 추가적인 자바스크립트 로직을 여기에 구현할 수 있습니다.
        });
    }

    // 다른 동적인 요소나 상호작용이 필요하다면 여기에 코드를 추가하세요.
});