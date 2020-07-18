$(document).on("turbolinks:load", function() {
  if (document.URL.match(/item/)) {
    $('.mini_image').on('click', function(){
        target = $(this).clone(true)[0]
        $('.item-content__photo--top img').remove()
        $('.item-content__photo--top').append(target)
        $('.item-content__photo--top img').removeClass('mini_image')
    });
  };
});
