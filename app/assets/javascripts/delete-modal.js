document.addEventListener("turbolinks:load", ()=> {
  if(document.URL.match(/items/)) {
    $( (e)=> {
      $("#modal-open-btn")[0].onclick =()=> {
        $('#overlay').fadeIn();
        $('#modal-close-btn')[0].onclick =()=> {
          $('#overlay').fadeOut();
        };
        $("#delete-comformation-btn")[0].onclick =()=> {
          $("#item-delete-btn")[0].click();
        };
      };
    });
  };
});