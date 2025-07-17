// 김현주 : 홍보 게시판/세부 페이지 전용 스크립트

document.addEventListener("DOMContentLoaded", () => {
  const postGrid = document.getElementById("postGrid");
  
  // JavaScript에서 contextPath를 동적으로 가져오는 방법
  // window.location.pathname: 현재 URL의 경로 (예: /my_project/promotionBoard.jsp)
  // .substring(0, window.location.pathname.indexOf("/",2)): 첫 번째 '/' 다음의 두 번째 '/'까지 잘라냄
  // 예시: /my_project/promotionBoard.jsp -> /my_project
  const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));

  // 실제 포스터 이미지 URL 배열 (총 12개)
  // 이 배열에 실제 이미지 파일 경로를 넣어주세요.
  // 이미지는 src/main/webapp/resources/images/ 폴더에 있다고 가정합니다.
  const posterImages = [
    contextPath + "/resources/images/poster_01.jpg", // 예시 1
    contextPath + "/resources/images/poster_02.jpg", // 예시 2
    contextPath + "/resources/images/poster_03.jpg", // 예시 3
    contextPath + "/resources/images/poster_04.jpg", // 예시 4
    contextPath + "/resources/images/poster_05.jpg",
    contextPath + "/resources/images/poster_06.jpg",
    contextPath + "/resources/images/poster_07.jpg",
    contextPath + "/resources/images/poster_08.jpg",
    contextPath + "/resources/images/poster_09.jpg",
    contextPath + "/resources/images/poster_10.jpg",
    contextPath + "/resources/images/poster_11.jpg",
    contextPath + "/resources/images/poster_12.jpg"  // 예시 12
  ];

  // 총 12개의 포스터 생성
  for (let i = 0; i < 12; i++) {
    const post = document.createElement("div");
    post.className = "post";

    // 포스터 이미지 URL 가져오기
    const imageUrl = posterImages[i]; // 배열의 순서대로 이미지를 가져옵니다.

    // poster div 생성
    const posterDiv = document.createElement("div");
    posterDiv.className = "poster";

    // img 태그 생성 및 src, alt 설정
    const img = document.createElement("img");
    img.src = imageUrl;
    img.alt = `홍보 포스터 ${i + 1}`; // 대체 텍스트: 포스터 번호를 표시

    // poster div에 img 태그 추가
    posterDiv.appendChild(img);

    // post div에 포스터, 제목, 날짜 추가
    post.appendChild(posterDiv); // posterDiv를 post의 첫 번째 자식으로 추가
    post.innerHTML += `
      <div class="post-title">[홍보 게시물 제목 ${i + 1}]</div>
      <div class="post-date">행사 시작 일자 - 행사 종료 일자</div>
    `;
    
    postGrid.appendChild(post);
  }
});