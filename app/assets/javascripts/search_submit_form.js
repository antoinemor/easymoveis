
$("#ambiance_name").change(function() {
  $("form#auto_search").submit();
});
$("#furniture_type").change(function() {
  $("form#auto_search").submit();
});
$("#city").focusout(function() {
  $("form#auto_search").submit();
});
$( "#slider-range" ).on( "slidechange", function( event, ui ) {
  $("form#auto_search").submit();
});
