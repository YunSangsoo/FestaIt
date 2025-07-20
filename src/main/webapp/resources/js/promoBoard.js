// 김현주 : 홍보 게시판/세부 페이지 전용 스크립트

document.addEventListener("DOMContentLoaded", () => {
  const postGrid = document.getElementById("postGrid");

  // 실제 포스터 이미지 URL 배열 (총 12개)
  // JSP에서 선언된 CONTEXT_PATH 변수를 사용합니다.
  const posterImages = [
    CONTEXT_PATH + "/resources/images/poster_01.jpg",
    CONTEXT_PATH + "/resources/images/poster_02.jpg",
    CONTEXT_PATH + "/resources/images/poster_03.jpg",
    CONTEXT_PATH + "/resources/images/poster_04.jpg",
    CONTEXT_PATH + "/resources/images/poster_05.jpg",
    CONTEXT_PATH + "/resources/images/poster_06.jpg",
    CONTEXT_PATH + "/resources/images/poster_07.jpg",
    CONTEXT_PATH + "/resources/images/poster_08.jpg",
    CONTEXT_PATH + "/resources/images/poster_09.jpg",
    CONTEXT_PATH + "/resources/images/poster_10.jpg",
    CONTEXT_PATH + "/resources/images/poster_11.jpg",
    CONTEXT_PATH + "/resources/images/poster_12.jpg"
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
    if (!postGrid) {
      console.error("postGrid 요소를 찾을 수 없습니다.");
      return;
    }
    postGrid.innerHTML = ''; // 초기화

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
        console.log(`${post.title} 클릭됨!`);
        // 예: 상세 페이지 이동
        // window.location.href = CONTEXT_PATH + "/promotion/detail?id=" + post.id;
      });
      postGrid.appendChild(postDiv);
    });
  }

  // 페이지네이션 렌더링 함수
  function renderPagination() {
    const totalPages = Math.ceil(posts.length / postsPerPage);
    const paginationContainer = document.querySelector(".pagination");
    if (!paginationContainer) {
      console.error("pagination 요소를 찾을 수 없습니다.");
      return;
    }
    paginationContainer.innerHTML = ''; // 초기화

    // 이전 페이지 버튼
    const prevBtn = document.createElement("a");
    prevBtn.href = "#";
    prevBtn.innerHTML = "&lt;";
    prevBtn.addEventListener("click", e => {
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
      if (i === currentPage) pageLink.classList.add("active");

      pageLink.addEventListener("click", e => {
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
    nextBtn.addEventListener("click", e => {
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

  // 🌟 모달 관련 로직: 공통 모달 showCommonModal 사용
  const openRegisterModalBtn = document.getElementById("openRegisterModalBtn");

  if (openRegisterModalBtn) {
    openRegisterModalBtn.addEventListener("click", () => {
      window.showCommonModal("행사 등록 확인", "행사를 등록하시겠습니까?", {
        confirmButtonText: "확인",
        cancelButtonText: "취소",
        onConfirm: () => {
          alert("게시물이 등록되었습니다!");
          // 실제 등록 로직 구현 예정
        },
        onCancel: () => {
          console.log("게시물 등록이 취소되었습니다.");
        }
      }).then(result => {
        if (result) {
          console.log("모달이 '확인'으로 닫혔습니다.");
        } else {
          console.log("모달이 '취소' 또는 외부 클릭으로 닫혔습니다.");
        }
      });
    });
  } else {
    console.error("오류: 'openRegisterModalBtn' 요소를 찾을 수 없습니다. 등록하기 버튼에 id='openRegisterModalBtn'을 확인하세요.");
  }
});
