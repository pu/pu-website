// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery(document).ready(function($) {

  // form description helper
  $("form div.description.hidden").hide();
  $("form a.description_icon").click(function(){
    $(this).next("div.description").slideToggle();
    return false;
  });
   
  $('ul.sf-menu').superfish({
    speed:       'fast'
  });
  
  
  /*
   * lightbox
   */
  $('a.lightbox').lightBox({
    fixedNavigation:   true,
    imageLoading:     '/images/admin/lightbox-ico-loading.gif',
    imageBtnPrev:     '/images/admin/lightbox-btn-prev.gif',
    imageBtnNext:     '/images/admin/lightbox-btn-next.gif',
    imageBtnClose:    '/images/admin/lightbox-btn-close.gif',
    imageBlank:       '/images/admin/lightbox-blank.gif'
  });
  

  $('.table-listing tr').live('dblclick', function(){
    location.href = $(this).attr('edit_url');
  });
  
  $(".markItUp").markItUp(mySettings);

});

(function($) {
  /*
   * dummy function for creating some kind of timeout
   * use it to have a timeout before calling other methods
   */
  jQuery.fn.pause = function(duration) {
    $(this).animate({ dummy: 1 }, duration);
    return this;
  };
})(jQuery);

$(document).ready(function() { 
    $(".tablesorter")
        .tablesorter({widthFixed: true, widgets: ['zebra']})
});