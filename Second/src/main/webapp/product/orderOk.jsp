<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="../include/header.jsp" />

	<div align="center">
	    <div class="card mb-3" style="max-width: 800px;">
		  <img src="<%=request.getContextPath()%>/resource/img/bgImage.jpg" class="card-img-top" alt="...">
		  <div class="card-body">
		    <h3 class="card-title">구매완료</h3>
		    <p class="card-text">'HHLB'는 고객에게 최상의 쇼핑을 제공하고 입점 브랜드의 성장을 지원하는 것을 경영 목표로 하고 있습니다.
					스트릿 브랜드부터 캐주얼, 디자이너, 컨템포러리, 하이엔드, 명품 브랜드까지 패션에 특화된 고객 맞춤형 상품을 제안하고 있습니다.</p>
		    <p class="card-text"><small class="text-muted">상품 구매에 감사드립니다.</small></p>
		  </div>
		</div>
		<form action="<%= request.getContextPath()%>/user_main.go">
			<button type="submit" class="btn btn-primary">HOME</button>
		</form>
	</div>
    
<jsp:include page="../include/footer.jsp" />