$(document).on('turbolinks:load',()=> {

  let num = ($('#image-box').find('img').length - 1); 

  for ( let i = 0; i < num; i++){

    $('#image-box__container').attr('class', `item-num-${num}`)

    $('.hidden-destroy').hide();
    
  };
});


$(document).on("click", '.item-image__operation--delete', ()=> {

  let target_image = $(this).parent().parent()

  let target_name = $(target_image).data('image')

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
});


window.onload = function(e){

  var dropArea = document.getElementById("image-box");

  dropArea.addEventListener("dragover", function(e){
    e.preventDefault();
    $(this).children('#image-box__container').css({'border': '1px solid rgb(204, 204, 204)','box-shadow': '0px 0px 4px'})
  },false);

  dropArea.addEventListener("dragleave", function(e){
    e.preventDefault();
    $(this).children('#image-box__container').css({'border': '1px dashed rgb(204, 204, 204)','box-shadow': '0px 0px 0px'})      
  },false);

  dropArea.addEventListener("drop", function(e) {
    e.preventDefault();
    
    $(this).children('#image-box__container').css({'border': '1px dashed rgb(204, 204, 204)','box-shadow': '0px 0px 0px'});
    
    var files = e.dataTransfer.files;

    $.each(files, function(i,file){

      var fileReader = new FileReader();

      dataBox.items.add(file)
      file_field.files = dataBox.files

      var num = $('.item-image').length + i + 1

      fileReader.readAsDataURL(file);

      if (num==5){
        $('#image-box__container').css('display', 'none')   
      }

      fileReader.onload = function() {

        var src = fileReader.result
        var html =`<div class='item-image'>
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
      };

      $('#image-box__container').attr('class', `item-num-${num}`)
    })
  })
}

$(document).on("click", '.item-image__edit--delete', ()=> {

  const targetIndex = $(this).parent().data('index');

  const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);

  if (hiddenCheck) hiddenCheck.prop('checked', true);

    $(this).parent().remove();
    
    $(`img[data-index="${targetIndex}"]`).remove();

  var num = $('.item-image').length
  
  $('#image-box__container').show()
  $('#image-box__container').attr('class', `item-num-${num}`)

});