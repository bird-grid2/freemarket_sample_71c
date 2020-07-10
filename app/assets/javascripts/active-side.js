$(window).on('turbolinks:load', function() {
  if(document.URL.match(/users/)) {
    let side_tabs = $(".mypage-side__nav__list").find('a');

    //activeクラスの削除
    side_tabs.removeClass("active")

    //配列の定義
    let a_list = [];

    //pathname(user/1/....)を配列に格納
    side_tabs.each(function (index){

      a_list.push(side_tabs[index].pathname);

    });

    //pathnameが一致したところにactiveクラスを追加
    a_list.forEach(function(val, index){
      if(location.pathname == a_list[index]) {
        side_tabs.eq(index).addClass("active");
      };
    });
  };
});