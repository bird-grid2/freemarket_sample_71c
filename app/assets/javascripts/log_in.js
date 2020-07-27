$(window).on('turbolinks:load', ()=>{
  if(document.URL.match(/users/)) {
    $('#seller').on('click', ()=>{
      $('#user_email').val('test-user@gmail.com')
      $('#password').val('12345678')
      $('input[type="submit"]').click()
    });
    $('#buyer').on('click', ()=>{
      $('#user_email').val('test-user_2@gmail.com')
      $('#password').val('12345678')
      $('input[type="submit"]').click()
    });
  }
});