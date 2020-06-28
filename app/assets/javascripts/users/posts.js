function previewImage1(obj){
  var fileReader = new FileReader();
  fileReader.onload = (function() {
    document.getElementById('preview1').src = fileReader.result;
  });
  fileReader.readAsDataURL(obj.files[0]);
}

function previewImage2(obj){
  var fileReader = new FileReader();
  fileReader.onload = (function() {
    document.getElementById('preview2').src = fileReader.result;
  });
  fileReader.readAsDataURL(obj.files[0]);
}

function previewImage3(obj){
  var fileReader = new FileReader();
  fileReader.onload = (function() {
    document.getElementById('preview3').src = fileReader.result;
  });
  fileReader.readAsDataURL(obj.files[0]);
}

function previewImage4(obj){
  var fileReader = new FileReader();
  fileReader.onload = (function() {
    document.getElementById('preview4').src = fileReader.result;
  });
  fileReader.readAsDataURL(obj.files[0]);
}

function previewImage5(obj){
  var fileReader = new FileReader();
  fileReader.onload = (function() {
    document.getElementById('preview5').src = fileReader.result;
  });
  fileReader.readAsDataURL(obj.files[0]);
}
