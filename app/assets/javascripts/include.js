function requesttoggle(){
  $(".forgot").slideToggle('slow');
}
function editdescribe(){
  $(".describe").slideToggle('slow');
}
function ayantoggle(){
  $(".forgot").slideToggle('slow');
}
$(document).on('turbolinks:load', function() {
  $('.datepicker').datetimepicker({
    format: 'YYYY-MM-D HH:MM'
  });
  $(".responstable tr[data-link]").click(function() {
    window.location = $(this).data("link")
  });
  $('#event_rq_form').submit(function() {
    var days = $("#days").val();
    if(days.length == 0 || parseInt(days) <= 0){days = 0}
      $("#txt_duration").val(days + " Days, " + $("#hour").val() + " Hours");
  });
  if ($('input.rating[type=number]').length > 0) {
    $('input.rating[type=number]').rating();
  }
});

$(document).ready(function() {
  $('.sdsd').click(function(event){
    event.preventDefault();
    $('#products .item').addClass('list-group-item');
  });
  $('#grid').click(function(event){
    event.preventDefault();
    $('#products .item').removeClass('list-group-item');
    $('#products .item').addClass('grid-group-item');
  });
  $('#errorModal').modal("show");
  var panels = $('.user-infos');
  var panelsButton = $('.dropdown-user');
  panels.hide();
  panelsButton.click(function() {
    var dataFor = $(this).attr('data-for');
    var idFor = $(dataFor);
    var currentButton = $(this);
    idFor.slideToggle(400, function() {
      if(idFor.is(':visible'))
      {
        currentButton.html('<i class="glyphicon glyphicon-chevron-up text-muted"></i>');
      }
      else
      {
        currentButton.html('<i class="glyphicon glyphicon-chevron-down text-muted"></i>');
      }
    })
  });
  $('[data-toggle="tooltip"]').tooltip();
  $('#list').click(function(event){event.preventDefault();$('#products .item').addClass('list-group-item');});
  $('#grid').click(function(event){event.preventDefault();$('#products .item').removeClass('list-group-item');$('#products .item').addClass('grid-group-item');});

});

