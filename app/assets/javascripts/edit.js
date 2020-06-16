$(document).on('turbolinks:load',()=> {

  let num = ($('#image-box').find('img').length - 1); 

  for ( let i = 0; i < num; i++){

    let src = $('#image-box').find('img').data('index', i).attr("src");

    let name = num + '.jpg';

    let html =`<div class='item-image' data-image="${name}">
                    <div class=' item-image__content'>
                      <div class='item-image__content--icon'>
                        <img src=${src} width="70" height="70" >
                      </div>
                    </div>
                    <div class='item-image__operation'>
                      <div class='item-image__operation--delete'>削除</div>
                    </div>
                  </div>`

    $('#image-box__container').before(html);

    $('#image-box__container').attr('class', `item-num-${num}`)

    
  };
});

$(document).on("click", '.item-image__operation--delete', ()=> {

  var target_image = $(this).parent().parent()

  var target_name = $(target_image).data('image')

  if(file_field.files.length==1){

    $('input[type=file]').val(null)
    dataBox.clearData();
    console.log(dataBox)
  }else{

    $.each(file_field.files, (i,input)=> {
      if(input.name==target_name){
        dataBox.items.remove(i) 
      }
    })

    file_field.files = dataBox.files
  }
  
  target_image.remove()

  var num = $('.item-image').length
  $('#image-box__container').show()
  $('#image-box__container').attr('class', `item-num-${num}`)
})