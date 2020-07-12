document.addEventListener("turbolinks:load", function() {
  if(document.URL.match(/items/)) {
    $( (e) => {
      $("#modal-open-btn")[0].onclick = function () {
        $('#overlay').fadeIn();
        $('#modal-close-btn')[0].onclick = function () {
          $('#overlay').fadeOut();
        };
        $("#delete-comformation-btn")[0].onclick = function () {
          $("#item-delete-btn")[0].click();
        };
      };
    });
  };
});