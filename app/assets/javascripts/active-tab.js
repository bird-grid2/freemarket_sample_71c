$(function()  {
  let tabs = $(".mypage-tabs").find("li");
  let links = tabs.find("a")
  let contents = $(".mypage-tab-container").find("tab-content").find("ul");

  function tabSwitch() {

    const index = tabs.index(this);
    
    tabs.removeClass("active").eq(index).addClass("active");
    links.removeClass("active")
    contents.removeClass("active").eq(index).addClass("active");
  }

  tabs.click(tabSwitch);   
});

$(function()  {
  let tabs = $(".mypage-tab-goods").find("li");
  let links = tabs.find("a")
  let contents = $(".mypage-tab-container__goods").find("tab-content").find("ul");

  function tabSwitch() {

    const index = tabs.index(this);
    
    tabs.removeClass("active").eq(index).addClass("active");
    links.removeClass("active")
    contents.removeClass("active").eq(index).addClass("active");
  }

  tabs.click(tabSwitch);   
});