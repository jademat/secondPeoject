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
            <div class="modal-body">
              <form>
                <div class="form-group">
                  <label for="recipient-name" class="col-form-label">주소 : </label>
                  <input type="text" class="form-control" id="recipient-name" value="DB주소">
                </div>
                <div class="form-group">
                  <label for="message-text" class="col-form-label">상세 주소 입력 :</label>
                  <textarea class="form-control" id="message-text"></textarea>
                </div>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
              <button type="button" class="btn btn-primary">입력</button>
            </div>
          </div>
        </div>
      </div>
