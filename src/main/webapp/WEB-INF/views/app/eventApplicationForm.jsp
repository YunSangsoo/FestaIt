<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.css">

<title>행사 신청하기</title>

<style>
	.ui-datepicker {
	    z-index: 1060 !important;
	}
	/* Bootstrap 폼 컨트롤과 jQuery UI Datepicker 아이콘 간격 조절 (선택 사항) */
	.form-control.hasDatepicker + .ui-datepicker-trigger {
	    margin-left: 5px;
	}
        #posterArea {
            min-height: 400px; /* 포스터 영역의 최소 높이 */
        }
    #app_detail{
    	resize: none; /* 사용자 크기 조절 비활성화 */
        overflow-y: auto; /* 내용이 넘칠 때만 세로 스크롤바 표시 */
    }
</style>
</head>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<main class="container">
	
        <form class="needs-validation" novalidate>
		<div class="row p-md-5">
		
		<div class="col-4">
			
    		<div class="container">
			
					
			        <div class="w-100 border border-1 d-flex justify-content-center align-items-center bg-gray-200 text-center overflow-hidden position-relative" id="posterArea">
			            <span id="posterPlaceholder">포스터</span>
			            <img id="posterImage" class="w-100 h-100 d-none object-fit-contain img-poster" src="#" alt="업로드된 포스터 이미지">
			        </div>
			        <input type="file" class="form-control input-poster" accept="images/*" id="inputPoster">
			        
					
					<div class="homepage-link-section mt-4">
					    <label for="homepageLink" class="form-label">행사 홈페이지</label>
					    <input type="text" class="form-control" id="homepageLink" placeholder="홈페이지 주소를 입력하세요">
					</div>
			
				</div>
			
		</div>
		
		<div class="vr order-md-2" style="padding-left: 1px;padding-right: 1px;"></div>
		
		<div class="col-7 order-md-last">
        
          <div class="row g-3">
          	
			<div class="col-md-3">
              <select class="form-select text-center" id="category" required>
                <option value="" disabled selected>행사 종류</option>
                <option value="L">지역축제</option>
                <option value="F">박람회</option>
                <option value="E">전시회</option>
                <option value="O">기타</option>
              </select>
              <div class="invalid-feedback">
              	행사 종류를 선택해주세요.
              </div>
            </div>
            <div class="w-100"></div>
          <hr class="my-3 mx-3">
          
          
            <div class="col-sm-10">
              <input type="text" class="form-control" id="middle-title" placeholder="행사 소제목 입력" value="" required>
              <div class="invalid-feedback">
              	행사 소제목을 입력해주세요.
              </div>
            </div>

            <div class="col-sm-10">
              <input type="text" class="form-control fs-2" id="title" placeholder="행사 제목 입력" value="" required>
              <div class="invalid-feedback">
              	행사 제목을 입력해주세요.
              </div>
            </div>

            <div class="col-3">
            	<input type="text" class="form-control" id="startDate" placeholder="행사 시작일" value="">
            </div>
            
            <div class="col-3">
            	<input type="text" class="form-control" id="endDate" placeholder="행사 종료일" value="">
            </div>
            <div class="w-100"></div>
          <hr class="my-3 mx-3">
          
          <div class="row col-12 justify-content-center">
          	<div class="col-6 row">
          	<p class="form-label col-12"> 관람 시간 </p>
          		<div class="col-10 my-3">
          			<input type="text" class="form-control" id="startTime" placeholder="관람 시작 시간" value="">
          		</div>
          		<div class="col-10 my-3">
          			<input type="text" class="form-control" id="endTime" placeholder="관람 종료 시간" value="">
          		</div>
          	</div>
			<div class="vr order-md-2" style="padding-left: 1px;padding-right: 1px;"></div>
          	<div class="col-6 row order-md-last">
          	
          		<p class="form-label col-9"> 행사 장소 </p>
          		<button type="button" onclick="findAddress()" class="col-3 fs-6 btn-sm" id="findAddressBtn">검색</button>
          		<div class="col-5 my-1">
          			<input type="text" class="form-control" id="postCode" placeholder="우편 번호" value="">
          		</div>
          		<div class="col-12 my-1">
          			<input type="text" class="form-control" id="address" placeholder="주소" value="">
          		</div>
          		<div class="col-12 my-1">
          			<input type="text" class="form-control" id="adressDetail" placeholder="상세 주소" value="">
          		</div>
          		
          	</div>
          </div>
          
          <hr class="my-3 mx-3">
          	<div class="col-12 mb-2">
			  <div class="form-group">
			    <label for="app_detail">행사 소개</label>
			    <textarea class="form-control" id="app_detail" rows="8"></textarea>
			  </div>
		  </div>
		  
		  <div class="col-8">
		  	<div class="input-group">
		  		<span class="input-group-text">입장료</span>
          		<input type="text" class="form-control" id="app_fee" placeholder="" value="">
		  	</div>
		  </div>
            
		  <div class="col-12">
		  	<div class="input-group">
		  		<span class="input-group-text">품목명</span>
          		<input type="text" class="form-control" id="app_item" placeholder="" value="">
		  	</div>
		  </div>
		  <div class="col-12">
		  	<div class="input-group">
		  		<span class="input-group-text">주최명</span>
          		<input type="text" class="form-control" id="app_host" placeholder="" value="">
		  	</div>
		  </div>
		  <div class="col-12">
		  	<div class="input-group">
		  		<span class="input-group-text">주관처명</span>
          		<input type="text" class="form-control" id="app_org" placeholder="" value="">
		  	</div>
		  </div>
		  <div class="col-12">
		  	<div class="input-group">
		  		<span class="input-group-text">후원사명</span>
          		<input type="text" class="form-control" id="app_sponser" placeholder="" value="">
		  	</div>
		  </div>
          <hr class="my-3 mx-3">
          
		  <div class="col-5">
		  	<div class="input-group">
		  		<span class="input-group-text">담당자명</span>
          		<input type="text" class="form-control" id="manager_name" placeholder="" value="">
		  	</div>
		  </div>
		  
           <div class="col-12">
		  	<div class="input-group">
		  		<span class="input-group-text">EMAIL</span>
             	<input type="email" class="form-control" id="email" placeholder="sample@example.com">
             <div class="invalid-feedback">
               Please enter a valid email address for shipping updates.
             </div>
		  	</div>
           </div>
		  <div class="col-12">
		  	<div class="input-group">
		  		<span class="input-group-text">TEL</span>
                <input type="tel" class="form-control" id="tel" name="tel">
		  	</div>
		  </div>
		  <div class="col-12">
		  	<div class="input-group">
		  		<span class="input-group-text">FAX</span>
          		<input type="text" class="form-control" id="fax" placeholder="" value="">
		  	</div>
		  </div>
          <hr class="my-3 mx-3">

</div>

        </div>
        
	</div>
		<div class="d-grid col-6 mx-auto">
	          <button class="w-10 btn btn-primary btn-lg" type="submit">행사 신청</button> 
	    </div>
	</form>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	<script>

	    $('#startDate').datepicker({
	        dateFormat: 'yy-mm-dd', // 날짜 형식: YYYY-MM-DD
	        //showOn: 'button',       // 입력 필드 클릭 또는 버튼 클릭 시 표시
	        //buttonText: '<i>선택</i>', // 버튼 아이콘 (Font Awesome 사용)
	         minDate: 0,          // 오늘 이전 날짜 선택 불가
	        // maxDate: '+1M +10D', // 오늘로부터 한 달 10일 후까지 선택 가능 (선택 사항)
	        onSelect: function(selectedDate) {
	            // 날짜 선택 시 실행되는 콜백 함수
	        	var startDate = $(this).datepicker('getDate');
	        	$('#endDate').datepicker('option', 'minDate', startDate);
	        	var endDate = $('#endDate').datepicker('getDate');
                if (endDate && endDate < startDate) {
                    $('#endDate').val(''); // 종료 날짜 필드 비움
                    $('#selectedEndDate').text('선택되지 않음'); // 종료 날짜 텍스트 초기화
                }
	        }
	    });
	    $('#endDate').datepicker({
	        dateFormat: 'yy-mm-dd', // 날짜 형식: YYYY-MM-DD
	        //showOn: 'button',       // 입력 필드 클릭 또는 버튼 클릭 시 표시
	        //buttonText: '<i>선택</i>', // 버튼 아이콘 (Font Awesome 사용)
	         minDate: 0,          // 오늘 이전 날짜 선택 불가
	        // maxDate: '+1M +10D', // 오늘로부터 한 달 10일 후까지 선택 가능 (선택 사항)
	        onSelect: function(dateText, inst) {
	            // 날짜 선택 시 실행되는 콜백 함수
	            //$('#startDate').text(dateText);
	        }
	    });
	    
	    const posterInput = document.querySelector('.input-poster');

        posterInput.addEventListener('change', function(event) {
            const file = event.target.files[0];
    	    const posterImg = document.querySelector('.img-poster');
            const posterPlaceholder = document.getElementById('posterPlaceholder');
            posterImg.classList.remove('d-none');

            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                	posterImg.src = e.target.result;
                	posterImg.style.display = 'block'; // 이미지 보이기
                    posterPlaceholder.style.display = 'none'; // "포스터" 텍스트 숨기기
                };
                reader.readAsDataURL(file);
            } else {
                uploadedImage.src = '#';
                uploadedImage.style.display = 'none'; // 이미지 숨기기
                posterPlaceholder.style.display = 'block'; // "포스터" 텍스트 다시 보이기
            }
        });
	    
	    function findAddress(){
	    	new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                // var extraRoadAddr = ''; // 참고 항목 변수

	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                //if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                //    extraRoadAddr += data.bname;
	                //}
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                //if(data.buildingName !== '' && data.apartment === 'Y'){
	                //   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                //}
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                //if(extraRoadAddr !== ''){
	                //    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                //}

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('postCode').value = data.zonecode;
	                document.getElementById('postCode').setAttribute("disabled",true);
	                document.getElementById("address").value = roadAddr;
	                document.getElementById('address').setAttribute("disabled",true);
	                //document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
	                
	                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
	                //if(roadAddr !== ''){
	                //    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
	                //} else {
	                //    document.getElementById("sample4_extraAddress").value = '';
	                //}
	            }
	        }).open();
	    }
	    
	</script>
</body>
</html>