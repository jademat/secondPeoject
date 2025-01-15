<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<!-- Modal 코드 -->
    <div class="modal fade" id="cartAddrModal" tabindex="-1" aria-labelledby="cartAddrModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="cartAddrModalLabel">상세 주소 입력 란</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            
            <form method="post" action="<%= request.getContextPath() %>/orderInsertMemo.go">
	            <div class="modal-body">
	                <div class="form-group">
	                  <label for="recipient-name" class="col-form-label">배송 메세지 : </label>
	                </div>
	                <div class="form-group">
	                  <textarea class="form-control" id="message-text" name="memo"></textarea>
	                </div>
	            </div>
	            <div class="modal-footer">
	              <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	              <button type="submit" class="btn btn-primary">입력</button>
	            </div>
            </form>
            
          </div>
        </div>
      </div>
