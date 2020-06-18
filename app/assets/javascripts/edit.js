$(document).on('turbolinks:load',()=> {

  let num = ($('#image-box').find('img').length - 1); 

  for ( let i = 0; i < num; i++){

    $('#image-box__container').attr('class', `item-num-${num}`)
    
  };
});

$(function(){
  
  var dataBox = new DataTransfer();
  
  var file_field = document.querySelector('input[type=file]');

  var files = $('input[type="file"]').prop('files')[0];
  
  $('#img-file').change(function(){
    
    $.each(this.files, function(i, file){
  
      var fileReader = new FileReader();

      dataBox.items.add(file)
      
      file_field.files = dataBox.files

      var num = $('.item-image').length + 1 + i
      fileReader.readAsDataURL(file);
      
      if (num == 5){
        $('#image-box__container').css('display', 'none')   
      }
      
      fileReader.onloadend = () => {
        var src = fileReader.result
        var html= `<div class='item-image' data-image="${file.name}">
                    <div class=' item-image__content'>
                      <div class='item-image__content--icon'>
                        <img src=${src} width="70" height="70" >
                      </div>
                    </div>
                    <div class='item-image__operetion'>
                      <div class='item-image__operetion--delete'>削除</div>
                    </div>
                  </div>`
        
        $('#image-box__container').before(html);
      };
      
      $('#image-box__container').attr('class', `item-num-${num}`)
      $('.item-image').css({})
      
    });
  });
    
  $(document).on("click", '.item-image__operetion--delete', function(){
    
    var target_image = $(this).parent().parent()
    
    var target_name = $(target_image).data('image')
    
    if(file_field.files.length==1){
      
      $('input[type=file]').val(null)
      dataBox.clearData();
      console.log(dataBox)
    }else{
      
      $.each(file_field.files, function(i,input){
        
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
});


window.onload = (e) => {

  var dropArea = document.getElementById("image-box");

  dropArea.addEventListener("dragover", function(e) {
    e.preventDefault();
    $(this).children('#image-box__container').css({'border': '1px solid rgb(204, 204, 204)','box-shadow': '0px 0px 4px'})
  },false);

  dropArea.addEventListener("dragleave", function(e) {
    e.preventDefault();
    $(this).children('#image-box__container').css({'border': '1px dashed rgb(204, 204, 204)','box-shadow': '0px 0px 0px'})      
  },false);

  dropArea.addEventListener("drop", function (e) {

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

      fileReader.onload = () => {

        var src = fileReader.result
        var html =`<div class='item-image' data-image="${file.name}">
                    <div class=' item-image__content'>
                      <div class='item-image__content--icon'>
                        <img src=${src} width="70" height="70" >
                      </div>
                    </div>
                    <div class='item-image__operetion'>
                      <div class='item-image__operetion--delete'>削除</div>
                    </div>
                  </div>`

        $('#image-box__container').before(html);
        $('.item-image').css({
          'display' : 'flex',
          'flex-direction' : 'column',
          'justify-content' : 'space-around',
          'width' : '80px'
        });
        $('.item-image__content').css( 'margin', '5px auto 20px');
        $('.item-image__operation').css({
          'text-align' : 'center',
          'font-size' : '20px',
          'background-color' : '$mainColor',
          'border' : '1px solid $mainColor',
          'color' : '#fff',
          'margin' : '0px 5px 5px 5px',
          'line-height' : '30px'
        });
      };

      $('#image-box__container').attr('class', `item-num-${num}`)
    });
  });
};

$(document).on("click", '.item-image__edit--delete', function() {

  
  const targetData = $(this).parent().parent();

  targetData.remove();

  var num = $('.item-image').length;

  $('#image-box__container').show()
  $('#image-box__container').attr('class', `item-num-${num}`)

});