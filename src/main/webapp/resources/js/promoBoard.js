// resources/js/promoBoard.js

document.addEventListener('DOMContentLoaded', function() {
    const searchButton = document.getElementById('searchButton');
    const searchKeywordInput = document.getElementById('searchKeyword');

    // 검색 버튼 클릭 이벤트 리스너
    if (searchButton && searchKeywordInput) {
        searchButton.addEventListener('click', function() {
            const keyword = searchKeywordInput.value;
            // 페이지네이션과 검색 키워드를 함께 전달
            // cpage=1로 설정하여 검색 시 항상 첫 페이지로 이동
            // contextPath는 JSP에서 전역 변수로 선언되어 넘어옵니다.
            window.location.href = `${contextPath}/promoBoard?cpage=1&searchKeyword=${encodeURIComponent(keyword)}`;
        });

        // Enter 키로 검색 실행
        searchKeywordInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchButton.click();
            }
        });
    }
});
