$(window).on('load', function() {
  if(document.URL.match(/users/)) {
    let side_tabs = $(".mypage-side__nav__list").find('li');
    const index = side_tabs.index(side_tabs);

    side_tabs.removeClass("active")

    


    if (location.pathname.match())
      side_tabs.eq(index).addClass("active");

    
    console.log(side_tabs)
    console.log(index)
    
    i = '"' + location.href + '"'

    console.log(side_tabs.match(location.pathname))

  };
});