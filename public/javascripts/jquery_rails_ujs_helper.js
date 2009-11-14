
// Ajaxify links and form elements with ujs class
$(document).ready(function() {
  
  $('a.ujs').click(function() { return false; });
  
  // Uses the new live method in jQuery 1.3+
  $('a.ujs-delete').live('click', function(event) {
    if ( confirm("Are you sure?") )
      $.ajax({
        url: this.href,
        type: 'post',
        dataType: 'script',
        data: {
          '_method': 'delete'
        },
        success: function() {
          // the item has been deleted
          // might want to remove it from the interface
          // or redirect or reload by setting window.location
        }
      });
    return false;
  });
  
  $('form.ujs').submit(function() {
    $.ajax({
        data: $.param($(this).serializeArray()),
        dataType: 'script',
        type: 'post',
        url: $(this).attr('action')
    });
    $(this).reset();
    return false;
  });

  // Uses the authenticity token from the variables created by yield_authenticity_token
  $.ajaxSetup({
    data: { authenticity_token : AUTH_TOKEN }
  });
  
});
