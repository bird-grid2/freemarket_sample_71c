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
  function appendGrandchidrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div id= 'grandchildren_options'>
                              <i class='fas fa-chevron-down'></i>
                              <select class="category__form--grandchild" id="grandchild_category" name="item[category_id]">
                                <option value="---" data-category="">選択して下さい</option>
                                ${insertHTML}
                              </select>
                            </div>`;
    $('.category__form').append(grandchildSelectHtml);
  }

  $('.category__form--parent').on('change', function() {
    var parent_category_id = document.getElementById('parent_id').value;
    if (parent_category_id != ""){ 
      $.ajax({
        url: '/items/category/get_children_categories',
        type: 'GET',
        data: { parent_id: parent_category_id },
        dataType: 'json'
      })
      .done(function(children){
        $('#children_options').remove(); 
        $('#grandchildren_options').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_options').remove(); 
      $('#grandchildren_options').remove();
    }
  });
});

