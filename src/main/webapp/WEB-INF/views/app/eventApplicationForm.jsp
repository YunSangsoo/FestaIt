<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	
	<c:set var="requestUri" value="${requestScope['javax.servlet.forward.request_uri']}" />
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />
    <c:set var="isViewMode" value="${fn:startsWith(requestUri, contextPath.concat('/eventApp/'))}" />
	<c:set var="formActionUrl" value="${contextPath}/myEventApp/appSave" />
    <c:if test="${isViewMode}">
        <c:set var="formActionUrl" value="${contextPath}/eventApp/approve" /> <%-- 수정 기능이 있다면 이 URL로 POST --%>
    </c:if>
	
	
	<main class="container shadow p-3 mb-5 rounded">
        <form:form modelAttribute="eventApplication" action="${formActionUrl }" method="post" enctype="multipart/form-data" class="needs-validation" novalidate="novalidate">
        <form:hidden path="appId"/>
        <input type="hidden" name="existingImgNo" id="existingImgNo" 
               value="${empty eventApplication.posterImage.imgNo ? 0 : eventApplication.posterImage.imgNo }" />
        <c:if test="${eventApplication.statCode == 'S' || isViewMode}">  <%-- 조건 변경: 'S'와 같을 때 --%>
        	<fieldset disabled>
    	</c:if>
        
		<div class="row p-md-5">
		
		<div class="col-4">
			
    		<div class="container">
			
					<c:if test="${not empty eventApplication.posterImage.imgNo && eventApplication.posterImage.imgNo != 0}">
			        <button type="button" class="btn btn-outline-secondary btn-lg px-4 delete-image-btn mb-2" 
			                  style="z-index: 10;" data-img-no="${eventApplication.posterImage.imgNo}">이미지 비우기</button>
			        </c:if>
					
			        <div class="w-100 border border-1 d-flex justify-content-center align-items-center bg-gray-200 text-center overflow-hidden position-relative" id="posterArea">
			            <span id="posterPlaceholder" class="${not empty eventApplication.posterImage.changeName ? 'd-none' : ''}">포스터</span>
			            
			            <img id="posterImage" class="w-100 h-100 object-fit-contain img-poster ${empty eventApplication.posterImage.changeName ? 'd-none' : ''}"
			            src="${not empty eventApplication.posterImage.changeName ? pageContext.request.contextPath.concat(eventApplication.posterImage.changeName) : ''}"
			            alt="업로드된 포스터 이미지">
			        </div>
			        <input type="file" class="form-control input-poster" accept="images/*" id="inputPoster" name="inputPoster"/>
			        
					
					<div class="homepage-link-section mt-4">
					    <label for="homepageLink" class="form-label">행사 홈페이지</label>
					    
		  				<div class="input-group">
						    <form:input path="website" type="text" class="form-control" id="homepageLink" placeholder="사이트 주소"/>
						    <button type="button" class="btn input-group-text btn-success" id="visitHomepageBtn" style="display: none;" disabled>링크</button>
						</div>
					</div>
			
				</div>
			
		</div>
		
		<div class="vr order-md-2" style="padding-left: 1px;padding-right: 1px;"></div>
		
		<div class="col-7 order-md-last">
        
          <div class="row g-3">
			<div class="form-floating col-4">
              <form:select path="eventCode" class="form-select text-center fs-5 h-100" id="category" required="required">
                <option selected>행사 종류</option>
                <option value="L">지역축제</option>
                <option value="F">박람회</option>
                <option value="E">전시회</option>
                <option value="O">기타</option>
              </form:select>
  			<label for="category" class="mx-1">행사 종류</label>
            </div>
            <div class="w-100"></div>
          <hr class="my-3 mx-3">
          
          	<div class=" col-sm-10">
            <div class="form-floating">
              <form:input type="text" path="appSubTitle" class="form-control" id="middle-title" placeholder="행사 소제목 입력" value="" required="required"/>
              <label for="middle-title">행사 소제목</label>
              <div class="invalid-feedback">
              	행사 소제목을 입력해주세요.
              </div>
            </div>
            </div>

            <div class="col-sm-10">
            <div class="form-floating">
              <form:input type="text" path="appTitle" class="form-control" id="title" placeholder="행사 제목 입력" value="" required="required"/>
              <label for="title">행사 제목</label>
              <div class="invalid-feedback">
              	행사 제목을 입력해주세요.
              </div>
            </div>
            </div>

            <div class="col-3">
            	<form:input type="text" path="startDate" class="form-control" id="startDate" placeholder="행사 시작일" value="" required="required"/>
            </div>
            
            <div class="col-3">
            	<form:input type="text" path="endDate" class="form-control" id="endDate" placeholder="행사 종료일" value="" required="required"/>
            </div>
            <div class="w-100"></div>
          <hr class="my-3 mx-3">
          
          <div class="row col-12 justify-content-center">
          	<div class="col-6 row">
          	<p class="form-label col-12"> 관람 시간 </p>
          		<div class="col-10 my-3">
          		<!-- placeholder="관람 시작 시간"-->
          			<form:input type="text" path="startTime" class="form-control" id="startTime" placeholder="관람 시작 시간" value="" required="required"/>
          		</div>
          		<div class="col-10 my-3">
          			<form:input type="text" path="endTime" class="form-control" id="endTime" placeholder="관람 종료 시간" value="" required="required"/>
          		</div>
          	</div>
			<div class="vr order-md-2" style="padding-left: 1px;padding-right: 1px;"></div>
          	<div class="col-6 row order-md-last">
          	
          		<p class="form-label col-9"> 행사 장소 </p>
          		<button type="button" onclick="findAddress()" class="btn btn-outline-secondary col-3 fs-6 btn-sm" id="findAddressBtn">검색</button>
          		<div class="col-5 my-1">
          			<form:input type="text" path="postCode" class="form-control" readonly="true" id="postcode" placeholder="우편 번호" value="" required="required"/>
          		</div>
          		<div class="col-12 my-1">
          			<form:input type="text" path="location" class="form-control" readonly="true" id="address" placeholder="주소" value="" required="required"/>
          		</div>
          		<div class="col-12 my-1">
          			<form:input type="text" path="locationDetail" class="form-control" id="adressDetail" placeholder="상세 주소" value=""/>
          		</div>
          		
          	</div>
          </div>
          
          <hr class="my-3 mx-3">
          	<div class="col-12 mb-2">
			  <div class="form-floating">
			    <form:textarea class="form-control overflow-y-auto" path="appDetail" id="app_detail" style="height: 200px" placeholder="행사의 내용을 입력해주세요." required="required"></form:textarea>
			    <label for="app_detail">행사 소개</label>
			  </div>
		  </div>
		  
		  <div class="col-8">
		  	<div class="input-group">
		  		<span class="input-group-text">입장료</span>
          		<form:input type="text" path="appFee" class="form-control" id="app_fee" placeholder="" value=""/>
		  	</div>
		  </div>
            
		  <div class="col-12">
		  	<div class="input-group">
		  		<span class="input-group-text">품목명</span>
          		<form:input type="text" path="appItem" class="form-control" id="app_item" placeholder="" value=""/>
		  	</div>
		  </div>
		  <div class="col-12">
		  	<div class="input-group">
		  		<span class="input-group-text">주최명</span>
          		<form:input type="text" path="appHost" class="form-control" id="app_host" placeholder="" value=""/>
		  	</div>
		  </div>
		  <div class="col-12">
		  	<div class="input-group">
		  		<span class="input-group-text">주관처명</span>
          		<form:input type="text" path="appOrg" class="form-control" id="app_org" placeholder="" value="" required="required"/>
		  	</div>
		  </div>
		  <div class="col-12">
		  	<div class="input-group">
		  		<span class="input-group-text">후원사명</span>
          		<form:input type="text" path="appSponser" class="form-control" id="app_sponser" placeholder="" value=""/>
		  	</div>
		  </div>
          <hr class="my-3 mx-3">
          
          
          <form:hidden path="appManager.appId"/>
		  <div class="col-5">
		  	<div class="input-group">
		  		<span class="input-group-text">담당자명</span>
          		<form:input type="text" path="appManager.managerName" class="form-control" id="manager_name" placeholder="" value=""/>
		  	</div>
		  </div>
		  
           <div class="col-12">
		  	<div class="input-group">
		  		<span class="input-group-text">EMAIL</span>
             	<form:input type="email" path="appManager.email" class="form-control" id="email" placeholder="sample@example.com"/>
             <div class="invalid-feedback">
               Please enter a valid email address for shipping updates.
             </div>
		  	</div>
           </div>
		  <div class="col-12">
		  	<div class="input-group">
		  		<span class="input-group-text">TEL</span>
                <form:input path="appManager.tel" type="tel" class="form-control" id="tel" name="tel"/>
		  	</div>
		  </div>
		  <div class="col-12">
		  	<div class="input-group">
		  		<span class="input-group-text">FAX</span>
          		<form:input path="appManager.fax" type="text" class="form-control" id="fax" placeholder="" value=""/>
		  	</div>
		  </div>
          <hr class="my-3 mx-3">

			</div>

        </div>
        
	</div>
			<div class="row">
				<div class="d-grid col-3 mx-auto">
			          <button class="w-10 btn btn-primary btn-lg" name="action" type="submit" formaction="${pageContext.request.contextPath}/myEventApp/appSave" value="save" formnovalidate="formnovalidate">임시 저장</button> 
			    </div>
				<div class="d-grid col-3 mx-auto">
			          <button class="w-10 btn btn-primary btn-lg" name="action" type="submit" value="submit">행사 신청</button> 
			    </div>
		    </div>
	    <c:if test="${eventApplication.statCode == 'S' || isViewMode}">  <%-- 조건 변경: 'S'와 같을 때 --%>
	    	</fieldset>
	    </c:if>
	</form:form>
	</main>
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	
	<script>
		
    // 이 변수들은 JSP 템플릿 엔진에 의해 렌더링될 때 값이 채워집니다.
    	const initialPosterSrc = "${not empty eventApplication.posterImage.changeName ? pageContext.request.contextPath.concat(eventApplication.posterImage.changeName) : ''}";
    	const initialExistingImgNo = "${empty eventApplication.posterImage.imgNo ? 0 : eventApplication.posterImage.imgNo }";
	</script>
	<script src="<%= request.getContextPath() %>/resources/js/app/eventApplicationForm.js"></script>
</body>
</html>