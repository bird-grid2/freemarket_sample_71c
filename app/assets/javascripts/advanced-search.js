document.addEventListener("turbolinks:load", function() {
  /* ソート パラメーター取得 */
  function getSortParam(name,url){
    if (!url) url = window.location.href;
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
  }
  /* ソート プルダウンの選択でフォームをsubmit */
  $("#q_sorts").change(function() {
    $(this.form).submit();
  });
  /* ソート 検索結果のページで選ばれた項目を表示 */
  if (location['href'].match(/&q%5Bsorts%5D/)!= null) {
    var sort_order = getSortParam('q%5Bsorts%5D');
    if(sort_order == 'id asc'){
      document.querySelector('option[value="id asc"]').selected=true;
    }else if(sort_order == 'price asc'){
      document.querySelector('option[value="price asc"]').selected=true;
    }else if(sort_order == 'price desc'){
      document.querySelector('option[value="price desc"]').selected=true;
    }else if(sort_order == 'updated_at desc'){
      document.querySelector('option[value="updated_at desc"]').selected=true;
    }else if(sort_order == 'likes_count desc'){
      document.querySelector('option[value="likes_count desc"]').selected=true;
    }
  }
  /* カテゴリー 子カテゴリーのビュー */
  function appendOption(category){
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  function appendChidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<div class="form_group__input" id="children_box">
                        <select name="q[category_id]" class="category__form--child" id="child_category">
                          <option value="---" data-category="">すべて</option>
                          ${insertHTML}
                        <select>
                      </div>`;
    $('#category_form').append(childSelectHtml);
  }
  /* カテゴリー 孫カテゴリーのビュー */
  function appendCheckbox(category){
    var html = `<div id="grandchildren_options" class="check-box">
                  <input type="checkbox" value="${category.id}" name="q[category_id_in][]" id="q_category_id_in_${category.id}" class="granchild_input_box">
                  <label for="q_category_id_in_${category.id}">${category.name}
                </div>`;
    return html;
  }
  function appendGrandchidrenBox(insertHTML){
    var grandchildSelectHtml = '';
      grandchildSelectHtml = `<div class="form_group__input" id="grandchildren_box">
                                <div class="check-boxes">
                                  ${insertHTML}
                                </div>
                              </div>`;
    $('#category_form').append(grandchildSelectHtml);
  }
  /* カテゴリー 親カテゴリー選択時 */
  $('#q_category_id').on('change', function() {
    var parent_category_id = document.getElementById('q_category_id').value;
    if (parent_category_id !== ""){ 
      $.ajax({
        url: '/items/category/get_children_categories',
        type: 'GET',
        data: { parent_id: parent_category_id },
        dataType: 'json'
      })
      .done(function(children){
        $('#children_box').remove(); 
        $('#grandchildren_box').remove();
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
      $('#children_box').remove(); 
      $('#grandchildren_box').remove();
    }
  });
  /* カテゴリー 子カテゴリー選択時 */
  $('#category_form').on('change', '#child_category', function(){
    var child_category_id = $('#child_category option:selected').data('category');
    if (child_category_id !== ""){
      $.ajax({
        url: '/items/category/get_grandchildren_categories',
        type: 'GET',
        data: { child_id: child_category_id },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length !== 0) {
          $('#grandchildren_box').remove();
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendCheckbox(grandchild);
          });
          appendGrandchidrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchildren_box').remove();
    }
  });
  /* カテゴリー パラメーター取得 */
  function getCategoryParam(){
    var params_array = [];
    var params=location.search.substring(1).split('&');
    for(var i=0;params[i];i++) {
      var param = params[i]
      if (param.indexOf(`category_id`) > -1)
        params_array.push(param);
    }
    return params_array;
  }
  /* カテゴリー 検索結果のページに選択された項目を表示する */
  if (location['href'].match(/&q%5Bcategory_id%5D/)!= null) {
    var category_ids = getCategoryParam();
    var parent_id = category_ids[0];
    var child_id = category_ids[1];
    var granchild_id = category_ids.slice(2,30);
    if (parent_id){
      var selected_parent = parent_id.split('=');
      var parent_value = selected_parent[1];
      $("#q_category_id").val(parent_value).prop('selected', true);
      $.ajax({
        url: '/items/category/get_children_categories',
        type: 'GET',
        data: { parent_id: parent_value },
        dataType: 'json'
      })
      .done(function(children){
        $('#children_box').remove(); 
        $('#grandchildren_box').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
        if(child_id){
          var selected_child = child_id.split('=');
          var child_value = selected_child[1];
          $("#child_category").val(child_value).prop('selected', true);
          $.ajax({
            url: '/items/category/get_grandchildren_categories',
            type: 'GET',
            data: { child_id: child_value },
            dataType: 'json'
          })
          .done(function(grandchildren){
            if (grandchildren.length !== 0) {
              $('#grandchildren_box').remove();
              var insertHTML = '';
              grandchildren.forEach(function(grandchild){
                insertHTML += appendCheckbox(grandchild);
              });
              appendGrandchidrenBox(insertHTML);
              if(granchild_id){
                $.each(granchild_id, function(index, value){
                  var selected_granchild = value.split('=');
                  var granchild_value = selected_granchild[1];
                  $("#q_category_id_in_"+granchild_value).prop('checked', true);
                });
              }
            }
          });
        }
      });
    }
  }
  /* カテゴリー 親カテゴリーのみ選ばれている場合は子カテゴリーの空文字を削除 */
  $('.submit-query').click(function() {
    if ($('#child_category').val() == "---") {
      $('#child_category').remove();
    }
  });
  /* 価格 プルダウンで選択された内容に応じて価格幅を自動入力 */
  $("#price_range").change(function() {
    var price_range = $(this).val();
    if (price_range == 1 ){
      $("#q_price_gteq").val("300");
      $("#q_price_lteq").val("1000");
    } else if (price_range == 2 ){
      $("#q_price_gteq").val("1000");
      $("#q_price_lteq").val("5000");
    } else if (price_range == 3 ){
      $("#q_price_gteq").val("5000");
      $("#q_price_lteq").val("10000");
    } else if (price_range == 4 ){
      $("#q_price_gteq").val("10000");
      $("#q_price_lteq").val("30000");
    } else if (price_range == 5 ){
      $("#q_price_gteq").val("30000");
      $("#q_price_lteq").val("50000");
    } else {
      $("#q_price_gteq").val("");
      $("#q_price_lteq").val("");
    }
  });
  /* 商品の状態 */
  $('#conditions_all').on('click', function() {
    $("input[name='q[condition_id_in][]']").prop('checked', this.checked);
  });
  $("input[name='q[condition_id_in][]']").on('click', function() {
    if ($('#conditions-option :checked').length == 6) {
      $('#conditions_all').prop('checked', true);
    } else {
      $('#conditions_all').prop('checked', false);
    }
  });
  /* 配送料の負担 */
  $('#postage_all').on('click', function() {
    $("input[name='q[postage_id_in][]']").prop('checked', this.checked);
  });
  $("input[name='q[postage_id_in][]']").on('click', function() {
    if ($('#postage-option :checked').length == 2) {
      $('#postage_all').prop('checked', true);
    } else {
      $('#postage_all').prop('checked', false);
    }
  });
  /* 販売状況 */
  $('#status_all').on('click', function() {
    $("input[name='q[buyer_id_null]']").prop('checked', this.checked);
    $("input[name='q[buyer_id_not_null]']").prop('checked', this.checked);
  });
  $("input[name='q[buyer_id_null]']").on('click', function() {
    if ($('#status-option :checked').length == 2) {
      $('#status_all').prop('checked', true);
    } else {
      $('#status_all').prop('checked', false);
    }
  });
  $("input[name='q[buyer_id_not_null]']").on('click', function() {
    if ($('.status-option :checked').length == 2) {
      $('#status_all').prop('checked', true);
    } else {
      $('#status_all').prop('checked', false);
    }
  });
  /* 再読み込みの時にすべてボタンにチェックを入れるか判定 */
  if(document.URL.match(/search/)) {
    if ($('#conditions-option :checked').length == 6) {
      $('#conditions_all').prop('checked', true);
    }
    if ($('#postage-option :checked').length == 2) {
      $('#postage_all').prop('checked', true);
    }
    if ($('.status-option :checked').length == 2) {
      $('#status_all').prop('checked', true);
    }
  }
  /* クリア */
  $(".reset-query").on("click", function () {
    clearForm(this.form);
  });
  function clearForm (form) {
    $(form)
        .find("input, select")
        .not(":button, :submit, :reset, :hidden")
        .val("")
        .prop("checked", false)
        .prop("selected", false)
    ;
    $("select[name='q[sorts]']").children().first().prop('selected', true);
    $('#children_box').remove();
    $('#grandchildren_box').remove();
  }
});