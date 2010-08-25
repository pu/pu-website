$(document).ready(function(){
  $(".tablesorter").tablesorter({widgets: ['zebra']}); 
  
  $("a[rel='colorbox']").colorbox({
    current: "{current} von {total}",
    previous:	"Vorheriges",
    next: "Nächstes",
    close: "Schließen" 
  });
  
})