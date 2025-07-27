<%-- /WEB-INF/views/myPage.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
        body { padding: 20px; }
    </style>
</head>
<body>
    <h1>내 애플리케이션 페이지</h1>
    <p>여기는 `myPage.jsp`의 콘텐츠입니다.</p>

    <button type="button" class="btn btn-primary" id="showAlertModalBtn">알림 모달 열기</button>
    <button type="button" class="btn btn-warning" id="showConfirmModalBtn">확인 모달 열기</button>
    <button type="button" class="btn btn-danger" id="showDeleteConfirmModalBtn">삭제 확인 모달 열기</button>

    <jsp:include page="/WEB-INF/views/common/modal.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>

    <script src="${pageContext.request.contextPath}/resources/js/commonModal.js"></script>

    <script>
    // DOMContentLoded 이벤트 리스너를 commonModal.js 에 포함했으므로, 여기서는 바로 버튼에 이벤트 리스너를 추가해도 됩니다.
    // 하지만 혹시 모를 로딩 순서 문제를 완전히 배제하려면 여기도 DOMContentLoaded 안에 넣는 것이 가장 안전합니다.
    
    document.getElementById('showAlertModalBtn').addEventListener('click', async () => {
        const result = await window.showCommonModal(
            "알림",
            "작업이 성공적으로 완료되었습니다.",
            {
                showCancelButton: false, // 취소 버튼 없음
                confirmButtonText: "확인",
                onConfirm: () => {
                    console.log("콜백: 알림 모달에서 확인 버튼 클릭!");
                }
            }
        );
        console.log("Promise 결과: 알림 모달 닫힘. 결과:", result ? "확인" : "취소/닫기");
    });

    document.getElementById('showConfirmModalBtn').addEventListener('click', async () => {
        const result = await window.showCommonModal(
            "선택 확인",
            "계속 진행하시겠습니까?<br>이 작업은 중요합니다.",
            {
                cancelButtonText: "아니오",
                confirmButtonText: "네, 진행합니다",
                onConfirm: () => {
                    console.log("콜백: 진행합니다!");
                },
                onCancel: () => {
                    console.log("콜백: 취소합니다.");
                }
            }
        );
        if (result) {
            console.log("Promise 결과: 사용자가 '네, 진행합니다'를 선택했습니다.");
            // 다음 작업 수행
        } else {
            console.log("Promise 결과: 사용자가 '아니오' 또는 닫기를 선택했습니다.");
        }
    });

    document.getElementById('showDeleteConfirmModalBtn').addEventListener('click', async () => {
        const result = await window.showCommonModal(
            "삭제 경고",
            "<p>정말 이 데이터를 <strong>삭제</strong>하시겠습니까?</p><p class='text-danger'>이 작업은 되돌릴 수 없습니다!</p>",
            {
                cancelButtonText: "취소",
                confirmButtonText: "예, 삭제합니다",
                onConfirm: () => {
                    console.log("콜백: 삭제 로직 실행!");
                    // 여기에 실제 삭제 API 호출 등 백엔드 통신 로직 추가
                },
                // onCancel 콜백은 생략 가능 (Promise 결과만으로 판단 가능)
            }
        );
        if (result) {
            console.log("Promise 결과: 사용자가 삭제를 확인했습니다. 데이터 삭제를 진행합니다.");
        } else {
            console.log("Promise 결과: 사용자가 삭제를 취소했습니다.");
        }
    });
    </script>
</body>
</html>