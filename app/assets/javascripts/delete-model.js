$(window).on('turbolinks:load', function() {
  if (document.URL.match(/items/)) { 
    $(document).ready( function(e) {
        let modal_open = $("#modal-open-btn");
        modal_open.onclick = function () {
          $('#overlay').fadeIn();
          $('#modal-close-btn').onclick = function () {
            $('#overlay').fadeOut();
          };
          $("#delete-comformation-btn").onclick = function () {
            $("#item-delete-btn").click();
          };
        };
      },
      false
    );
  };
});