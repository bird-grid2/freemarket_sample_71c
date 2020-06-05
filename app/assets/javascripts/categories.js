$(function() {
  function appendOption(category){
    var html = `<option value="${category.id}"  data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  function appendChidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<div id= 'children_options'>
                        <i class='fas fa-chevron-down'></i>
                        <select class="category__form--child" id="child_category" name="item[child_id]">
                          <option value="---" data-category="">選択して下さい</option>
                          ${insertHTML}
                        <select>
                      </div>`;
    $('.category__form').append(childSelectHtml);
  }
});

