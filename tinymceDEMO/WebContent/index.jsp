<!-- source take from docs and http://stackoverflow.com/questions/3872009/upload-image-from-local-into-tinymce -->
<!DOCTYPE html>
<html>
<head>
    <script src='//cdn.tinymce.com/4.3/tinymce.min.js'></script>
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script>
	    $( document ).ready(function() {
	        //alert( "jquery" );
	    });
    </script>
    <script>
    tinymce.init({
    	selector: "textarea",
	    plugins: [
	        "advlist autolink lists link image charmap print preview anchor",
	        "searchreplace visualblocks code fullscreen",
	        "insertdatetime media table contextmenu paste imagetools"
	    ],
	    image_advtab: true,
	    toolbar: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent |image link imageupload",
	    imagetools_toolbar: "rotateleft rotateright | flipv fliph | editimage imageoptions",
	    setup: function(editor) {
            var inp = $('<input id="tinymce-uploader" type="file" name="pic" accept="image/*" style="display:none">');
            $(editor.getElement()).parent().append(inp);
            inp.on("change",function(){
                var input = inp.get(0);
                var file = input.files[0];
                var fr = new FileReader();
                fr.onload = function() {
                    var img = new Image();
                    img.src = fr.result;
                    alert(img.src);
                    tinyMCE.activeEditor.setContent('');
                    editor.insertContent('<img src="'+img.src+'"/>');
                    inp.val('');
                    //alert(tinyMCE.activeEditor.getContent());
                    alert("jaja--->"+tinyMCE.get('ta1').getContent().split('<p><img src="')[1].split('" /></p>')[0])
                    //alert(tinyMCE.get('ta2').getContent());
                }
                fr.readAsDataURL(file);
            });
            editor.addButton( 'imageupload', {
                text:"",
                icon: 'image',
                onclick: function(e) {
                    inp.trigger('click');
                }
            });
        }
    });
    </script>
<script type="text/javascript">
function actupload(){
    var data = new FormData();
    var blob = [];
    var type = [];
    var width = [];
    var height = [];
    // <p><img src="blob:http://localhost:6060/14d8fa4e-7f4a-494b-8366-3f5b67db7566" width="49" height="37" /></p>
    
    
    
    
    
    
    for(var jkl = 1;jkl <= 2;jkl++){
    	var temp1=tinyMCE.get('ta'+jkl).getContent().split('<p><img src="')[1].split('"')[0];
        var blob1= this.canvasToBlob(temp1,temp1.split(";")[0].split("/")[1]);
        var width1=tinyMCE.get('ta'+jkl).getContent().split(' ')[2].split('"')[1].split('"')[0];
        var height1=tinyMCE.get('ta'+jkl).getContent().split(' ')[3].split('"')[1].split('"')[0];
        alert("width: "+width1+" height "+height1)
        var type1=temp1.split(";")[0].split("/")[1];
        data.append("type"+''+jkl,type1);
        data.append("width"+''+jkl,width1);
        data.append("height"+''+jkl,height1);
        data.append("blob"+''+jkl,blob1);
    }
    data.append("length",2);
    
    
    
    
    
    
    
    
    
    /* for(var jkl = 1;jkl <= 2;jkl++){
    	var temp1=tinyMCE.get('ta'+jkl).getContent().split('<p><img src="')[1].split('"')[0];
        var blob1= this.canvasToBlob(temp1,temp1.split(";")[0].split("/")[1]);
        var width1=tinyMCE.get('ta'+jkl).getContent().split(' ')[2].split('"')[1].split('"')[0];
        var height1=tinyMCE.get('ta'+jkl).getContent().split(' ')[3].split('"')[1].split('"')[0];
        alert("width: "+width1+" height "+height1)
        var type1=temp1.split(";")[0].split("/")[1];
        type.push(type1);
        width.push(width1);
        height.push(height1);
        alert("blaaa "+blob1)
        data.append("blob"+''+jkl,blob1);
    }
    data.append("type",type);
    data.append("width",width);
    data.append("height",height);
    data.append("length",2); */
    
    
    
    
    /* var temp1=tinyMCE.get('ta1').getContent().split('<p><img src="')[1].split('"')[0];
    var blob1= this.canvasToBlob(temp1,temp1.split(";")[0].split("/")[1]);
    var width1=tinyMCE.get('ta1').getContent().split(' ')[2].split('"')[1].split('"')[0];
    var height1=tinyMCE.get('ta1').getContent().split(' ')[3].split('"')[1].split('"')[0];
    alert("width: "+width1+" height "+height1)
    var type1=temp1.split(";")[0].split("/")[1];
  
  
    
    var temp2=tinyMCE.get('ta2').getContent().split('<p><img src="')[1].split('"')[0];
    var blob2= this.canvasToBlob(temp2,temp2.split(";")[0].split("/")[1]);
    var width2=tinyMCE.get('ta2').getContent().split(' ')[2].split('"')[1].split('"')[0];
    var height2=tinyMCE.get('ta2').getContent().split(' ')[3].split('"')[1].split('"')[0];
    //alert("width: "+width2+" height "+height2)
    var type2=temp2.split(";")[0].split("/")[1];
    
    blob.push(blob1);
    type.push(type1);
    width.push(width1);
    height.push(height1);
    
    blob.push(blob2);
    type.push(type2);
    width.push(width2);
    height.push(height2);
    
    //alert("blob length ->"+blob.length)
    data.append("type",type);
    data.append("width",width);
    data.append("height",height); 
    
    
    
    
    data.append("blob1",blob1);
    data.append("blob2",blob2);
    data.append("length",length); */
    
    
    this.uploadToServer(data);
}
function canvasToBlob(canvas,type){
	var byteString = atob(canvas.split(",")[1]);
    var ab = new ArrayBuffer(byteString.length);
    var ia = new Uint8Array(ab);
    var i;
	for (i = 0; i < byteString.length; i++) {
	    ia[i] = byteString.charCodeAt(i);
	}
	return new Blob([ab], {
	    type: type
	});
}
function uploadToServer(formData){
	 xhr = new XMLHttpRequest();
     xhr.open("post", "http://localhost:6060/tinymceDEMO/imgupload", true);
     xhr.onreadystatechange = function() {
         if (xhr.readyState == 4) {
        	 alert(xhr.responseText);
         }
     };
     xhr.send(formData);
}
</script>
</head>
<body>
	<form>
		<textarea id="ta1" name="ta1"></textarea>
		<textarea id="ta2" name="ta2"></textarea>
		<input type="submit" value="submit" onclick="actupload()">
	</form>
</body>
</html>