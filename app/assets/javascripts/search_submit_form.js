$(document).ready(function() {

  $("#ambiance_name").change(function() {
    $("form#auto_search").submit();
  });
  $("#furniture_type").change(function() {
    $("form#auto_search").submit();
  });


});
