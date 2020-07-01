$(window).on('load', function() {
  if(document.URL.match(/users/)) {
    let side_tabs = $(".mypage-side__nav__list--item");
    let target_url = location.href;


    side_tabs.removeClass("active")

    side_tabs.forEach

    target = side_tabs.find(target_url);
    
    target.addClass("active");
    console.log(target)
  

    console.log(side_tabs)

  };
});