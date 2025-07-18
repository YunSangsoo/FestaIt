// 김현주 : 홍보 게시판/세부 페이지 전용 스크립트

document.addEventListener("DOMContentLoaded", () => {
  const postGrid = document.getElementById("postGrid");
  // 실제 포스터 이미지 URL 배열 (총 12개)
  // JSP에서 선언된 CONTEXT_PATH 변수를 사용합니다.
  const posterImages = [
    CONTEXT_PATH + "/resources/images/poster_01.jpg", // 예시 1
    CONTEXT_PATH + "/resources/images/poster_02.jpg", // 예시 2
    CONTEXT_PATH + "/resources/images/poster_03.jpg", // 예시 3
    CONTEXT_PATH + "/resources/images/poster_04.jpg", // 예시 4
    CONTEXT_PATH + "/resources/images/poster_05.jpg",
    CONTEXT_PATH + "/resources/images/poster_06.jpg",
    CONTEXT_PATH + "/resources/images/poster_07.jpg",
    CONTEXT_PATH + "/resources/images/poster_08.jpg",
    CONTEXT_PATH + "/resources/images/poster_09.jpg",
    CONTEXT_PATH + "/resources/images/poster_10.jpg",
    CONTEXT_PATH + "/resources/images/poster_11.jpg",
    CONTEXT_PATH + "/resources/images/poster_12.jpg"  // 예시 12
  ];

  // 포스터 데이터 (예시)
  const posts = Array.from({ length: 12 }, (_, i) => ({
    id: i + 1,
    title: `축제 제목 ${i + 1}`,
    date: `2024.0${i + 1}.01 - 2024.0${i + 1}.31`,
    imageUrl: posterImages[i]
  }));

  // 페이지당 포스터 수
  const postsPerPage = 8;
  let currentPage = 1;

  // 포스터 렌더링 함수
  function renderPosts(page) {
    if (!postGrid) { // postGrid가 없으면 함수 종료
        console.error("postGrid 요소를 찾을 수 없습니다.");
        return;
    }
    postGrid.innerHTML = ''; // 기존 포스터 초기화
    const start = (page - 1) * postsPerPage;
    const end = start + postsPerPage;
    const paginatedPosts = posts.slice(start, end);

    paginatedPosts.forEach(post => {
      const postDiv = document.createElement("div");
      postDiv.classList.add("post");
      postDiv.innerHTML = `
        <div class="poster">
          <img src="${post.imageUrl}" alt="${post.title} 포스터">
        </div>
        <h3 class="post-title">${post.title}</h3>
        <p class="post-date">${post.date}</p>
      `;
      postDiv.addEventListener("click", () => {
        // 포스터 클릭 시 상세 페이지로 이동 (예시)
        console.log(`${post.title} 클릭됨!`);
        // 실제로는 window.location.href = CONTEXT_PATH + "/promotion/detail?id=" + post.id; 등으로 연결
      });
      postGrid.appendChild(postDiv);
    });
  }

  // 페이지네이션 렌더링 함수
  function renderPagination() {
    const totalPages = Math.ceil(posts.length / postsPerPage);
    const paginationContainer = document.querySelector(".pagination");
    if (!paginationContainer) { // paginationContainer가 없으면 함수 종료
        console.error("pagination 요소를 찾을 수 없습니다.");
        return;
    }
    paginationContainer.innerHTML = ''; // 기존 페이지네이션 초기화

    // 이전 페이지 버튼
    const prevBtn = document.createElement("a");
    prevBtn.href = "#";
    prevBtn.innerHTML = "&lt;";
    prevBtn.addEventListener("click", (e) => {
      e.preventDefault();
      if (currentPage > 1) {
        currentPage--;
        renderPosts(currentPage);
        renderPagination();
      }
    });
    paginationContainer.appendChild(prevBtn);

    // 페이지 번호 버튼
    for (let i = 1; i <= totalPages; i++) {
      const pageLink = document.createElement("a");
      pageLink.href = "#";
      pageLink.textContent = i;
      if (i === currentPage) {
        pageLink.classList.add("active");
      }
      pageLink.addEventListener("click", (e) => {
        e.preventDefault();
        currentPage = i;
        renderPosts(currentPage);
        renderPagination();
      });
      paginationContainer.appendChild(pageLink);
    }

    // 다음 페이지 버튼
    const nextBtn = document.createElement("a");
    nextBtn.href = "#";
    nextBtn.innerHTML = "&gt;";
    nextBtn.addEventListener("click", (e) => {
      e.preventDefault();
      if (currentPage < totalPages) {
        currentPage++;
        renderPosts(currentPage);
        renderPagination();
      }
    });
    paginationContainer.appendChild(nextBtn);
  }

  // 초기 렌더링
  renderPosts(currentPage);
  renderPagination();

  // 🌟🌟🌟 모달 관련 요소 가져오기 및 이벤트 리스너 (이 부분만 수정/추가되었습니다) 🌟🌟🌟
  const openRegisterModalBtn = document.getElementById("openRegisterModalBtn"); // register-promo-btn 에 id="openRegisterModalBtn" 추가
  const registerModal = document.getElementById("registerModal");
  const closeButton = document.querySelector(".close-button"); // 모달 내부의 X 버튼
  const confirmRegisterBtn = document.getElementById("confirmRegisterBtn");
  const cancelRegisterBtn = document.getElementById("cancelRegisterBtn");

  // "등록하기" 버튼 클릭 시 모달 열기
  if (openRegisterModalBtn) {
    openRegisterModalBtn.addEventListener("click", () => {
      if (registerModal) { // 🌟 추가: registerModal이 존재하는지 확인 🌟
        registerModal.style.display = "flex"; // CSS에서 .modal의 display를 flex로 설정했으므로 flex로 변경
      } else {
        console.error("오류: 'registerModal' 요소를 찾을 수 없습니다. HTML에 id='registerModal'이 있는지 확인하세요.");
      }
    });
  } else {
    console.error("오류: 'openRegisterModalBtn' 요소를 찾을 수 없습니다. '등록하기' 버튼에 id='openRegisterModalBtn'이 있는지 확인하세요.");
  }

  // 모달 닫기 (X 버튼 클릭 시)
  if (closeButton) {
    closeButton.addEventListener("click", () => {
      if (registerModal) { // 🌟 추가: registerModal이 존재하는지 확인 🌟
        registerModal.style.display = "none";
      }
    });
  }

  // 모달 외부 클릭 시 닫기
  if (registerModal) {
    window.addEventListener("click", (event) => {
      if (event.target == registerModal) {
        registerModal.style.display = "none";
      }
    });
  }

  // "확인" 버튼 클릭 시
  if (confirmRegisterBtn) {
    confirmRegisterBtn.addEventListener("click", () => {
      alert("게시물이 등록되었습니다!"); // 실제 등록 로직은 여기에 구현
      if (registerModal) { // 🌟 추가: registerModal이 존재하는지 확인 🌟
        registerModal.style.display = "none";
      }
    });
  }

  // "취소" 버튼 클릭 시
  if (cancelRegisterBtn) {
    cancelRegisterBtn.addEventListener("click", () => {
      if (registerModal) { // 🌟 추가: registerModal이 존재하는지 확인 🌟
        registerModal.style.display = "none";
      }
    });
  }
}); // DOMContentLoaded end