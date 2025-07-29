<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>포스트잇 불꽃놀이</title>

  <!-- 손글씨 느낌의 폰트 불러오기 -->
  <link href="https://fonts.googleapis.com/css2?family=Caveat&display=swap" rel="stylesheet" />

  <style>
    /* 전체 화면 설정 및 기본 스타일 */
    body {
      background-color: #a200ff;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      overflow: hidden;
      transition: background-color 0.5s ease-in-out;
      /*배경 화면 전환 속도*/
    }

    body.dark {
      background-color: #000;
    }


    /* 입체감을 위한 wrapper */
    .wrapper {
      position: relative;
      perspective: 1000px;
    }

    /* 포스트잇 스타일 */
    .postit {
      background: linear-gradient(145deg, #fff64e, #fff068);
      /* 노란색 그라디언트 */
      width: 300px;
      height: 300px;
      position: relative;
      display: flex;
      justify-content: center;
      align-items: center;
      box-shadow: 10px 10px 20px rgba(0, 0, 0, 0.2);
      cursor: pointer;
      transform-origin: top center;
      transform: rotate(-5deg);
      animation: swingX 2s ease-in-out infinite;
      /* 좌우 흔들리는 애니메이션 */
      transition: transform 6s ease, opacity 6s ease;
      clip-path: polygon(0 0, 100% 0, 100% 83%, 83% 100%, 0 109%);
      /* 종이 모양 클리핑 */
    }

    /* 클릭 후 떨어지는 애니메이션 적용 */
    .postit.fall {
      animation: fallDown 2s forwards ease-in;
    }

    /* 흔들리는 애니메이션 정의 */
    @keyframes swingX {

      0%,
      100% {
        transform: rotateX(0deg) rotate(-5deg);
      }

      50% {
        transform: rotateX(5deg) rotate(-5deg);
      }
    }

    /* 아래로 떨어지며 사라지는 애니메이션 */
    @keyframes fallDown {
      0% {
        transform: rotateX(0deg) rotate(-5deg);
      }

      100% {
        transform: translateY(800px) rotate(15deg);
        opacity: 0;
      }
    }

    /* 포스트잇의 접힌 모서리 효과 */
    .postit::before {
      content: "";
      position: absolute;
      bottom: 0;
      right: 0;
      width: 0;
      height: 0;
      border-style: solid;
      border-width: 0 0 50px 50px;
      border-color: transparent transparent #a06de0 transparent;
      box-shadow: -6px -2px 10px rgba(0, 0, 0, 0.1);
    }

    /* 포스트잇 안의 텍스트 스타일 */
    .logo-text {
      font-family: 'Caveat', cursive;
      font-size: 3.5rem;
      color: #000;
      user-select: none;
      font-weight: bold;
    }

    /* 전체 화면에 덮이는 불꽃놀이 캔버스 */
    #fireworkCanvas {
      opacity: 0;
      transition: opacity 1s ease-in-out;
      /*이것도 전환 속도*/
      display: block;
      /* 항상 표시되도록 */
      pointer-events: none;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      z-index: 10;
    }

    /* 슬로건과 버튼 컨테이너 */
    .slogan-container {
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      text-align: center;
      color: white;
      z-index: 20;
      opacity: 0;
      transition: opacity 1.5s ease;
      pointer-events: none;
    }

    .slogan-text {
      font-size: 2rem;
      font-weight: bold;
      margin-bottom: 20px;
      text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
    }

    .go-button {
      font-size: 1.2rem;
      padding: 10px 20px;
      background-color: #fff64e;
      border: none;
      border-radius: 5px;
      color: #000;
      cursor: pointer;
      font-weight: bold;
      box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
      transition: transform 0.3s ease;
      pointer-events: auto;
    }

    .go-button:hover {
      transform: scale(1.05);
    }

    .slogan-visible {
      opacity: 1;
    }
  </style>
</head>

<body>
  <!-- 포스트잇을 감싸는 래퍼 -->
  <div class="wrapper">
    <div class="postit" id="postit">
      <div class="logo-text">festa-it</div>
    </div>
  </div>

  <!-- 불꽃놀이 그리기용 캔버스 -->
  <canvas id="fireworkCanvas"></canvas>

  <!-- 슬로건 + 버튼 -->
  <div class="slogan-container" id="sloganBox">
    <div class="slogan-text">대한민국 모든 축제와 박람회를 한눈에</div>
    <button class="go-button" onclick="location.href='/festait'">지금 보러가기 →</button>
  </div>

  <script>
    // 캔버스와 컨텍스트 준비
    const canvas = document.getElementById('fireworkCanvas');
    const ctx = canvas.getContext('2d');
    let W, H;

    function resize() {
      W = window.innerWidth;
      H = window.innerHeight;
      canvas.width = W;
      canvas.height = H;
    }
    resize();
    window.addEventListener('resize', resize);

    // 랜덤 함수
    function random(min, max) {
      return Math.random() * (max - min) + min;
    }

    // 색상 생성 함수들
    const colorGenerators = {
      '보라~핑크': () => `hsl(${Math.floor(Math.random() * 50 + 270)}, 100%, 60%)`,
      '주황': () => `hsl(${Math.floor(Math.random() * 20 + 20)}, 100%, 60%)`,
      '노랑': () => `hsl(${Math.floor(Math.random() * 15 + 45)}, 100%, 60%)`,
      '빨강': () => `hsl(${Math.floor(Math.random() * 20 + 350) % 360}, 100%, 60%)`,
      '파랑': () => `hsl(${Math.floor(Math.random() * 40 + 200)}, 100%, 60%)`
    };

    class Particle {
      constructor(x, y, color, angle, speed, size, decay, gravityEnabled = false) {
        this.x = x;
        this.y = y;
        this.color = color;
        this.angle = angle;
        this.speed = speed;
        this.size = size;
        this.decay = decay;
        this.alpha = 1;
        this.gravityEnabled = gravityEnabled;
        this.gravity = 0.08;
        this.vx = Math.cos(angle) * speed;
        this.vy = Math.sin(angle) * speed;
      }

      update() {
        if (this.gravityEnabled) {
          this.vy += this.gravity;
          this.vx *= 0.98;
          this.vy *= 0.98;
        }
        this.x += this.vx;
        this.y += this.vy;
        this.alpha -= this.decay;
      }

      draw(ctx) {
        ctx.save();
        ctx.globalAlpha = Math.max(this.alpha, 0);
        ctx.fillStyle = this.color;
        ctx.shadowColor = this.color;
        ctx.shadowBlur = 8;
        ctx.beginPath();
        ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
        ctx.fill();
        ctx.restore();
      }
    }

    // Firework 클래스들 (FireworkNormal 예시만 사용)
    class FireworkNormal {
      constructor(colorGenerator) {
        this.x = random(W * 0.1, W * 0.9);
        this.y = H;
        this.targetY = random(H * 0.1, H * 0.5);
        this.speedY = random(7, 11);
        this.length = random(20, 40);
        this.exploded = false;
        this.particles = [];
        this.colorGenerator = colorGenerator;
      }

      update() {
        if (!this.exploded) {
          this.y -= this.speedY;
          if (this.y <= this.targetY) {
            this.explode();
            this.exploded = true;
          }
        } else {
          this.particles.forEach(p => p.update());
          this.particles = this.particles.filter(p => p.alpha > 0);
        }
      }

      explode() {
        const count = random(50, 80);
        for (let i = 0; i < count; i++) {
          const angle = (Math.PI * 2 / count) * i;
          const speed = random(2, 5);
          const size = random(0.5, 3);
          const decay = random(0.008, 0.015);
          const color = this.colorGenerator();
          this.particles.push(
            new Particle(this.x, this.y, color, angle, speed, size, decay, false)
          );
        }
      }

      draw(ctx) {
        if (!this.exploded) {
          ctx.save();
          ctx.strokeStyle = 'white';
          ctx.lineWidth = 0.5;
          ctx.shadowColor = 'white';
          ctx.shadowBlur = 10;
          ctx.beginPath();
          ctx.moveTo(this.x, this.y);
          ctx.lineTo(this.x, this.y + this.length);
          ctx.stroke();
          ctx.restore();
        } else {
          this.particles.forEach(p => p.draw(ctx));
        }
      }

      isDead() {
        return this.exploded && this.particles.length === 0;
      }
    }


    // FireworkGravity: 입자에만 중력 적용
    class FireworkGravity {
      constructor(colorGenerator) {
        this.x = random(W * 0.1, W * 0.9);
        this.y = H;
        this.targetY = random(H * 0.1, H * 0.5);
        this.speedY = random(7, 11);
        this.length = random(20, 40);
        this.exploded = false;
        this.particles = [];
        this.colorGenerator = colorGenerator;
      }

      update() {
        if (!this.exploded) {
          this.y -= this.speedY;
          if (this.y <= this.targetY) {
            this.explode();
            this.exploded = true;
          }
        } else {
          this.particles.forEach(p => p.update());
          this.particles = this.particles.filter(p => p.alpha > 0);
        }
      }

      explode() {
        const count = random(60, 90);
        for (let i = 0; i < count; i++) {
          const angle = (Math.PI * 2 / count) * i;
          const speed = random(2, 5);
          const size = random(0.5, 3);
          const decay = random(0.008, 0.015);
          const color = this.colorGenerator();
          this.particles.push(
            new Particle(this.x, this.y, color, angle, speed, size, decay, true)
          );
        }
      }

      draw(ctx) {
        if (!this.exploded) {
          ctx.save();
          ctx.strokeStyle = 'white';
          ctx.lineWidth = 0.8;
          ctx.shadowColor = 'white';
          ctx.shadowBlur = 10;
          ctx.beginPath();
          ctx.moveTo(this.x, this.y);
          ctx.lineTo(this.x, this.y + this.length);
          ctx.stroke();
          ctx.restore();
        } else {
          this.particles.forEach(p => p.draw(ctx));
        }
      }

      isDead() {
        return this.exploded && this.particles.length === 0;
      }
    }

    // FireworkDouble: 중력X, 이중 폭발 (두 군데서 터짐)
    class FireworkDouble {
      constructor(colorKey, colorGenerator) {
        this.x = random(W * 0.1, W * 0.9);
        this.y = H;
        this.targetY = random(H * 0.1, H * 0.5);
        this.speedY = random(7, 11);
        this.length = random(20, 40);
        this.exploded = false;
        this.particles = [];
        this.colorKey = colorKey;
        this.colorGenerator = colorGenerator;
      }

      update() {
        if (!this.exploded) {
          this.y -= this.speedY;
          if (this.y <= this.targetY) {
            this.explode();
            this.exploded = true;
          }
        } else {
          this.particles.forEach(p => p.update());
          this.particles = this.particles.filter(p => p.alpha > 0);
        }
      }

      explode() {
        const innerCount = 30;
        const outerCount = 60;

        // 안쪽 폭발용 색상 생성기 결정
        let innerColorGenerator = this.colorGenerator;
        if (this.colorKey === '주황') innerColorGenerator = colorGenerators['노랑'];
        else if (this.colorKey === '보라~핑크') innerColorGenerator = colorGenerators['빨강'];
        else if (this.colorKey === '파랑') innerColorGenerator = colorGenerators['보라~핑크'];
        else if (this.colorKey === '노랑') innerColorGenerator = colorGenerators['주황'];
        else if (this.colorKey === '빨강') innerColorGenerator = colorGenerators['주황'];


        // 안쪽 폭발
        for (let i = 0; i < innerCount; i++) {
          const angle = (Math.PI * 2 / innerCount) * i;
          const speed = random(1, 2);
          const size = random(0.5, 2.5);
          const decay = random(0.015, 0.02);
          const color = innerColorGenerator();
          this.particles.push(
            new Particle(this.x, this.y, color, angle, speed, size, decay, false)
          );
        }

        // 바깥 폭발
        for (let i = 0; i < outerCount; i++) {
          const angle = (Math.PI * 2 / outerCount) * i;
          const speed = random(2.5, 4);
          const size = random(0.5, 3);
          const decay = random(0.01, 0.015);
          const color = this.colorGenerator();
          this.particles.push(
            new Particle(this.x, this.y, color, angle, speed, size, decay, false)
          );
        }
      }

      draw(ctx) {
        if (!this.exploded) {
          ctx.save();
          ctx.strokeStyle = 'white';
          ctx.lineWidth = 0.8;
          ctx.shadowColor = 'white';
          ctx.shadowBlur = 10;
          ctx.beginPath();
          ctx.moveTo(this.x, this.y);
          ctx.lineTo(this.x, this.y + this.length);
          ctx.stroke();
          ctx.restore();
        } else {
          this.particles.forEach(p => p.draw(ctx));
        }
      }

      isDead() {
        return this.exploded && this.particles.length === 0;
      }
    }

    //이중 링
    class FireworkDoubleRing {
      constructor(colorKey, colorGenerator) {
        this.x = random(W * 0.1, W * 0.9);
        this.y = H;
        this.targetY = random(H * 0.2, H * 0.5);
        this.speedY = random(7, 10);
        this.length = random(20, 40);
        this.exploded = false;
        this.particles = [];
        this.colorKey = colorKey;
        this.colorGenerator = colorGenerator;
      }

      update() {
        if (!this.exploded) {
          this.y -= this.speedY;
          if (this.y <= this.targetY) {
            this.explode();
            this.exploded = true;
          }
        } else {
          this.particles.forEach(p => p.update());
          this.particles = this.particles.filter(p => p.alpha > 0);
        }
      }

      explode() {
        const innerCount = 30;
        const outerCount = 60;
        const innerRadius = random(1.0, 1.8); // 내부 링 속도
        const outerRadius = random(2.0, 3.0); // 외부 링 속도

        // 안쪽 링은 다른 색으로 (보조 색상)
        let innerColorGenerator = this.colorGenerator;
        if (this.colorKey === '주황') innerColorGenerator = colorGenerators['노랑'];
        else if (this.colorKey === '보라~핑크') innerColorGenerator = colorGenerators['빨강'];
        else if (this.colorKey === '파랑') innerColorGenerator = colorGenerators['보라~핑크'];
        else if (this.colorKey === '노랑') innerColorGenerator = colorGenerators['주황'];
        else if (this.colorKey === '빨강') innerColorGenerator = colorGenerators['주황'];

        // 안쪽 링 입자 생성
        for (let i = 0; i < innerCount; i++) {
          const angle = (Math.PI * 2 / innerCount) * i;
          const speed = innerRadius;
          const size = random(1.2, 2);
          const decay = random(0.012, 0.018);
          const color = innerColorGenerator();

          this.particles.push(
            new Particle(this.x, this.y, color, angle, speed, size, decay, false)
          );
        }

        // 바깥 링 입자 생성
        for (let i = 0; i < outerCount; i++) {
          const angle = (Math.PI * 2 / outerCount) * i;
          const speed = outerRadius;
          const size = random(1.5, 2.8);
          const decay = random(0.01, 0.015);
          const color = this.colorGenerator();

          this.particles.push(
            new Particle(this.x, this.y, color, angle, speed, size, decay, false)
          );
        }
      }

      draw(ctx) {
        if (!this.exploded) {
          ctx.save();
          ctx.strokeStyle = 'white';
          ctx.lineWidth = 0.5;
          ctx.shadowColor = 'white';
          ctx.shadowBlur = 10;
          ctx.beginPath();
          ctx.moveTo(this.x, this.y);
          ctx.lineTo(this.x, this.y + this.length);
          ctx.stroke();
          ctx.restore();
        } else {
          this.particles.forEach(p => p.draw(ctx));
        }
      }

      isDead() {
        return this.exploded && this.particles.length === 0;
      }
    }

    // 폭죽 배열
    let fireworks = [];
    let lastTime = 0;
    const interval = 800; // 0.8초마다 새 폭죽 생성

    // 애니메이션 루프
    function animate(time = 0) {
      ctx.fillStyle = 'rgba(0, 0, 0, 0.15)';
      ctx.fillRect(0, 0, W, H);

      if (time - lastTime > interval) {
        const keys = Object.keys(colorGenerators);
        const randomKey = keys[Math.floor(Math.random() * keys.length)];
        const colorGenerator = colorGenerators[randomKey];

        const fireworkType = Math.random();
        let firework;

        if (fireworkType < 0.25) {
          firework = new FireworkNormal(colorGenerator);
        } else if (fireworkType < 0.5) {
          firework = new FireworkGravity(colorGenerator);
        } else if (fireworkType < 0.75) {
          firework = new FireworkDouble(randomKey, colorGenerator);
        } else {
          firework = new FireworkDoubleRing(randomKey, colorGenerator); // 🔵 링 폭죽 추가
        }

        fireworks.push(firework);
        lastTime = time;
      }

      fireworks.forEach(fw => {
        fw.update();
        fw.draw(ctx);
      });

      fireworks = fireworks.filter(fw => !fw.isDead());

      requestAnimationFrame(animate);
    }

    // 포스트잇 제어
    const postit = document.getElementById('postit');
    const sloganBox = document.getElementById('sloganBox');

    setTimeout(() => {
      if (!postit.classList.contains('fall')) {
        postit.classList.add('fall');
      }
    }, 4000); //포스트잇 자동 떨어짐

    postit.addEventListener('click', () => {
      postit.classList.add('fall');
    });

    postit.addEventListener('animationend', (e) => {
      if (e.animationName === 'fallDown') {
        postit.style.display = 'none';

        // 1) 배경색 부드럽게 전환 시작
        document.body.classList.add('dark');

        // 2) 배경색 트랜지션 종료 후 캔버스 서서히 나타나도록 처리
        setTimeout(() => {
          canvas.style.opacity = '1'; // 캔버스 점점 보이게
          animate();

          // 1초 뒤 슬로건 등장
          setTimeout(() => {
            sloganBox.classList.add('slogan-visible');
          }, 1000);
        }, 200); // 트랜지션 시간과 동일하게 맞춤
      }
    });




  </script>
</body>

</html>