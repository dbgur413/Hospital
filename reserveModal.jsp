<!-- module/reserveModal.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <input type="hidden" id="hospitalName" name="hName" value="병원이름">
        <h5 class="modal-title" id="exampleModalLabel">병원이름</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="PageControl.jsp" method="get">
        <input type="hidden" id="IdHospital" name="IdHospital" value="id 가져오기 실패">
        <input type="hidden" id="Idpatient" name="Idpatient" value="<%= session.getAttribute("memId") %>">
        <div class="modal-body">
          <div class="container">
            <h5>예약날짜</h5>
            <div class="input-group date">
              <input type="text" id="datepicker" name="reserveDate">
            </div>
            <div class="col-md-4_1" style="width: 100%;">
              <table class="table table-striped">
                <colgroup><col width="200"><col></colgroup>
                <thead><tr><th scope="col"></th><th scope="col"></th></tr></thead>
                <tbody style="border: solid 1px #f0f0f0;border-radius: 5px;">
                  <tr>
                    <td class="booking_table_list">진료과<span>*</span>
                      <select name="department" id="department" class="treatment_sel_box" style="width: 90%">
                        <option value="">진료과목 선택</option>
                        <option value="002">ex)치과</option>
                      </select>
                    </td>
                    <td class="booking_table_list">예약구분<span>*</span>
                      <select name="reserveDiv" id="reserveDiv" class="treatment_sel_box" style="width: 90%;">
                        <option value="">예약 선택</option>
                        <option value="진료">진료</option>
                        <option value="검진">검진</option>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <td class="booking_table_list">진료 받으실 분 <span>*</span></td>
                    <td>
                      <select name="department1" id="department1" class="treatment_sel_box" style="width: 90%;">
                        <option value="본인">본인</option>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <td class="booking_table_list">주민번호 뒷자리<span>*</span></td>
                    <td>
                      생년월일:
                      <select name="birth_1" id="birth_1">
                        <option value="">년도</option>
                        <% for(int y=2025; y>=1930; y--) { %>
                          <option value="<%= y %>"><%= y %></option>
                        <% } %>
                      </select>
                      <select name="birth_2" id="birth_2">
                        <option value="">월</option>
                        <% for(int m=1; m<=12; m++) { %>
                          <option value="<%= String.format("%02d", m) %>"><%= m %></option>
                        <% } %>
                      </select>
                      <select name="birth_3" id="birth_3">
                        <option value="">일</option>
                        <% for(int d=1; d<=31; d++) { %>
                          <option value="<%= String.format("%02d", d) %>"><%= d %></option>
                        <% } %>
                      </select>
                      <br/>-주민번호 뒷자리:
                      <input type="password" id="registrationBackNumber" name="registrationBackNumber" size="7" maxlength="7">
                    </td>
                  </tr>
                  <tr>
                    <td class="booking_table_list">증상<span>*</span></td>
                    <td>
                      <textarea name="symptom" id="symptom" class="treatment_txt_box" style="width: 90%; height: 125px; resize: none; outline: 0;"></textarea>
                    </td>
                  </tr>
                </tbody>
              </table>
              <input type="hidden" name="namepatient" value="<%= session.getAttribute("memName") %>">
              <input type="hidden" id="namehospital" name="namehospital" value="병원이름">
              <input type="hidden" name="rdAction" value="insert">
            </div>
          </div>
        </div>
        <div class="modal-footer">
		<button type="button" class="btn btn-primary btn-sm"
  data-bs-toggle="modal"
  data-bs-target="#exampleModal"
  onclick="transParam('병원명', '진료과목', 'hpid')">예약</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
function transParam(dutyName, dgidIdName, hpid){
  const arr = dgidIdName.split(',');
  $("#IdHospital").val(hpid);
  $("#hospitalName").val(dutyName);
  $("#namehospital").val(dutyName);
  $("#exampleModalLabel").text(dutyName);
  $('#department').empty();
  for (let i = 0; i < arr.length; i++) {
    $('#department').append(`<option value="${arr[i]}">${arr[i]}</option>`);
  }
}
</script>

