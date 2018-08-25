$("#btn-login").click(function(){
    $.ajax({
        url:"/login",
        data:"correo="+$("#usuario").val()+"&contrasena="+$("#contrasena").val(),
        method:"POST",
        dataType:"json",
        success:function(respuesta){
            if (respuesta.estatus ==0 )
                //alert("Credenciales correctas");    
                window.location.href ="home.html";
            else
                alert("Credenciales incorrectas");
            console.log(respuesta);
        }
    });
});