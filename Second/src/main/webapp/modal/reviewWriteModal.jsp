<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="modal" id="reviewWriteModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">리뷰작성</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    <table class="table table-borderless">
                        <tr>
                            <div class="form-group">
                                <label for="usr">제목</label>
                                <input type="text" class="form-control" id="usr">
                              </div>
                              <div class="form-group">
                                <label for="pwd">리뷰</label>
                                <textarea class="form-control" aria-label="With textarea" rows="5" cols="30" style="resize: none;"></textarea>
                              </div>
                              <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                  <span class="input-group-text" id="inputGroupFileAddon01">Upload</span>
                                </div>
                                <div class="custom-file">
                                  <input type="file" class="custom-file-input" id="inputGroupFile01" aria-describedby="inputGroupFileAddon01">
                                  <label class="custom-file-label" for="inputGroupFile01">사진첨부(필수)</label>
                                </div>
                              </div>
                        </tr>
                        
                      </table>
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>