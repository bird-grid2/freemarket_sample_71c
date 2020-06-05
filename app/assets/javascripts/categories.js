$(function() {
  function appendOption(category){
    var html = `<option value="${category.id}"  data-category="${category.id}">${category.name}</option>`;
    return html;
  }
});

