$(window).onload = function() {
  if (document.URL.match(/edit/)) {
    var dropzone = $(".upload-images-edit");
    var input_area = $(".input-area");
    var preview = $("#preview");
    var upload_image = $(".upload-images-edit label");
    var reader = new FileReader();

    // 登録済画像と新規追加画像を全て格納する配列（ビュー用）
    var images = [];
    // 登録済画像データだけの配列（DB用）
    var registered_images_ids = [];
    // 新規追加画像データだけの配列（DB用)
    var new_image_files = [];

    // 登録済画像のプレビュー表示
    gon.item_images.forEach(function(image, index){
      var img = $(`<div class= "add_img"><div class="img_area"><img class="image"></div></div>`);

      // カスタムデータ属性を付与
      img.data("image", index)

      var btn_wrapper = $('<div class="btn_wrapper"><a class="rounded-pill">削除</a></div>');

      // 画像に編集・削除ボタンをつける
      img.append(btn_wrapper);

      binary_data = gon.item_images_binary_datas[index]

      // 表示するビューにバイナリーデータを付与
      img.find("img").attr({
        src: "data:image/jpeg;base64," + binary_data,
        width: '70px', height: '70px'
      });

      // 登録済画像のビューをimagesに格納
      images.push(img)
      registered_images_ids.push(image.id)
    });

    // 画像が４枚以下のとき
    if (images.length <= 4) {
      $('#preview').empty();
      $.each(images, function(index, image) {
        image.data('image', index);
        preview.append(image);
      })
      dropzone.css({
        'width': `calc(100% - (20% * ${images.length}))`
      })

      // 画像が５枚のとき１段目の枠を消す
    } else if (images.length == 5) {
      $("#preview").empty();
      $.each(images, function(index, image) {
        image.data("image", index);
        preview.append(image);
      });
      dropzone.css({
        display: "none"
      });
    };

    //inputタグの追加とラベル更新
    var new_image = $(
      `<input multiple= "multiple" name="item_images[image][]" class="upload-image" data-image= ${images.length} type="file" id="item_images_image_${images.length}"  style: "display: none" accept='image/*'>`
    );
    input_area.append(new_image);

    id = new_image.prop('id');

    upload_image.attr( "for", id );

    // 画像を新しく追加する場合
    $("#edit_item .images__form__dropzone").on("change", 'input[type= "file"].upload-image', function() {

      var file = $(this).prop("files")[0];
      new_image_files.push(file);
     
      var img = $(`<div class= "add_img"><div class="img_area"><img class="image"></div></div>`);
      reader.onload = function(e) {
        var btn_wrapper = $('<div class="btn_wrapper"><a class="rounded-pill">削除</a></div>');

        // 画像に削除ボタンをつける
        img.append(btn_wrapper);
        img.find("img").attr({
          src: e.target.result,
          width: '70px', height: '70px'
        });
      };

      reader.readAsDataURL(file);
      images.push(img);

      // 画像が４枚以下のとき
      if (images.length <= 4) {
        $('#preview').empty();
        $.each(images, function(index, image) {
          image.data('image', index);
          preview.append(image);
        })
        dropzone.css({
          'width': `calc(100% - (20% * ${images.length}))`
        })

        // 画像が５枚のとき１段目の枠を消す
      } else if (images.length == 5) {
        $("#preview").empty();
        $.each(images, function(index, image) {
          image.data("image", index);
          preview.append(image);
        });
        dropzone.css({
          display: "none"
        });
      } 

      //inputタグの追加とラベル更新
      var new_image = $(
        `<input multiple= "multiple" name="item_images[image][]" class="upload-image" data-image= ${images.length} type="file" id="item_images_image_${images.length}"  style: "display: none" accept='image/*'>`
      );
      input_area.append(new_image);

      create_id = new_image.prop('id');
      upload_image.attr( "for", create_id );
    });

    // 削除ボタン
    $("#edit_item .images__form__dropzone").on('click', '.rounded-pill', function() {

      // 削除ボタンを押した画像を取得
      var target_image = $(this).parent().parent();

      // 削除画像のdata-image番号を取得
      var target_image_num = target_image.data('image');

      const hiddenCheck = $(`input[data-index="${target_image_num}"].hidden-destroy`);

      if (hiddenCheck) hiddenCheck.prop('checked', true);

      // 対象の画像をビュー上で削除
      target_image.remove();

      // 対象の画像を削除した新たな配列を生成
      images.splice(target_image_num, 1);

      // target_image_numが登録済画像の数以下の場合は登録済画像データの配列から削除、それより大きい場合は新たに追加した画像データの配列から削除
      if (target_image_num < registered_images_ids.length) {
        registered_images_ids.splice(target_image_num, 1);
      } else {
        new_image_files.splice((target_image_num - registered_images_ids.length), 1);
      };

      if(images.length == 0) {
        $('input[type= "file"].upload-image').attr({'data-image': (target_image_num - 1)})
      };

      // 削除後の配列の中身の数で条件分岐
      // 画像が４枚以下のとき
      if (images.length <= 4) {
        $('#preview').empty();
        $.each(images, function(index, image) {
          image.data('image', index);
          preview.append(image);
        });
        dropzone.css({
          'width': `calc(100% - (20% * ${images.length}))`
        });
      // 画像が５枚のとき１段目の枠を消す
      } else if (images.length == 5) {
        $('#preview').empty();
        $.each(images, function(index, image) {
          image.data('image', index);
          preview.append(image);
        });
        dropzone.css({
          'display': 'none'
        });
      };

      $('input[type= "file"]:last').remove();

      delete_id = $('input[type= "file"]:last').prop('id');
      
      upload_image.attr( "for", delete_id );

    });

    // ドラック&ドロップした場合の処理
    $("#edit_item .images__form__dropzone").on("dragover", function(e) {
      e.stopPropagation();
      e.preventDefault();
    });

    $("#edit_item .images__form__dropzone").on("drop", function(e) {
      e.stopPropagation();
      e.preventDefault();

      var drop_file = e.originalEvent.dataTransfer.files;
      console.log(drop_file[0]);
      var target_img = $("#item_images_image_" + images.length);
      new_image_files.push(drop_file[0]);

      var img = $(`<div class= "add_img"><div class="img_area"><img class="image"></div></div>`);

      target_img.files = drop_file[0];

      reader.readAsDataURL(target_img.files);

      reader.onload = function(e) {
        var btn_wrapper = $('<div class="btn_wrapper"><a class="rounded-pill">削除</a></div>');

        // 画像に削除ボタンをつける
        img.append(btn_wrapper);
        img.find("img").attr({
          src: e.target.result,
          width: '70px', height: '70px'
        });
      };
      
      images.push(img);
     
      // 画像が４枚以下のとき
      if (images.length <= 4) {
        $('#preview').empty();
        $.each(images, function(index, image) {
          image.data('image', index);
          preview.append(image);
        });
        
        dropzone.css({
          'width': `calc(100% - (20% * ${images.length}))`
        });

        // 画像が５枚のとき１段目の枠を消す
      } else if (images.length == 5) {
        $("#preview").empty();
        $.each(images, function(index, image) {
          image.data("image", index);
          preview.append(image);
        });
        dropzone.css({
          display: "none"
        });
      };

      //inputタグの追加とラベル更新
      var new_image = $(
        `<input multiple= "multiple" name="item_images[image][]" class="upload-image" data-image= ${images.length} type="file" id="item_images_image_${images.length}"  style: "display: none" accept='image/*'>`
      );
      input_area.append(new_image);

      var drop_id = new_image.prop('id');
      upload_image.attr( "for", drop_id );
      console.log(target_img)
    });
    
    $('#edit_item').on('submit', function(e){
      
       // 通常のsubmitイベントを止める
      e.preventDefault()

      // images以外のform情報をformDataに追加
      var formData = new FormData($(this).get(0));
      var url = $(this).attr("action");

      // 登録済画像が残っていない場合は便宜的に0を入れる
      if (registered_images_ids.length == 0) {
        formData.append("registered_images_ids[ids][]", 0)
      // 登録済画像で、まだ残っている画像があればidをformDataに追加していく
      } else {
        registered_images_ids.forEach(function(registered_image){
          formData.append("registered_images_ids[ids][]", registered_image)
        });
      }
  
      // 新しく追加したimagesがない場合は便宜的に空の文字列を入れる
      if (new_image_files.length == 0) {
        formData.append("new_images[images][]", " ")
      // 新しく追加したimagesがある場合はformDataに追加する
      } else {
        new_image_files.forEach(function(file){
          formData.append("new_images[images][]", file)
        });
      };
      $.ajax({
        url:          url,
        type:        "PATCH",
        data:        formData,
        contentType: false,
        processData: false
      });
    });
  };
};