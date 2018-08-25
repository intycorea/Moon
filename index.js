var express = require("express");
var session = require("express-session");
var bodyParser = require("body-parser");
var mysql = require("mysql");
var url = require("url");
var http = require("http")
var app = express();

var credenciales ={
  user:"root",
  password:"",
  database:"bd_moon",
  host:"localhost",
  port:"3306"  
};

app.use(express.static("public"));

//Verificar si existe una variable de sesion para poner publica la carpeta public admin
var publicStarter = express.static("public_starter");
var publicDeveloper = express.static("public_developer");
var publicSuper = express.static("public_super");

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies




app.use(session({secret:"AR$#@FE$%#%",resave:true, saveUninitialized:true}));


app.use(
    function(peticion,respuesta,next){
        if (peticion.session.correo){
            //Significa que el usuario si esta logueado
            if (peticion.session.codigoTipoUsuario == 1)
              publicStarter(peticion,respuesta,next);
            else if (peticion.session.codigoTipoUsuario == 2)
              publicDeveloper(peticion,respuesta,next);
            else if (peticion.session.codigoTipoUsuario == 3)
            publicSuper(peticion,respuesta,next);
        }
        else
            return next();
    }
);



///Para agregar seguridad a una ruta especifica:
function verificarAutenticacion(peticion, respuesta, next){
	if(peticion.session.correo)
		return next();
	else
		respuesta.send("ERROR, ACCESO NO AUTORIZADO");
}

app.post("/login", function(peticion, respuesta){
    var conexion = mysql.createConnection(credenciales);

    conexion.query("SELECT codigo_usuario, codigo_tipo_usuario, nombre, correo FROM tbl_usuarios  WHERE correo=? and contrasena=?",
        [peticion.body.correo, peticion.body.contrasena],
        function(err, data, fields){
                if (data.length>0){
                    peticion.session.correo = data[0].correo;
                    peticion.session.codigoTipoUsuario = data[0].codigo_tipo_usuario;
                    data[0].estatus = 0;
                    respuesta.send(data[0]); 
                }else{
                    respuesta.send({estatus:1, mensaje: "Login fallido"}); 
                }
            	
         }
    ); 
});

app.get("/obtener-sesion", function(peticion, respuesta){
    respuesta.send("Valor de la variable de sesion almacenado: " + peticion.session.correo);
 });
 
 app.get("/logout",function(peticion, respuesta){
     peticion.session.destroy();
     respuesta.redirect("index.html");
     //respuesta.send("Sesion eliminada");
 });
 
 app.get("/ruta-restringida",verificarAutenticacion,  function(peticion, respuesta){
     respuesta.send("Bienvenido a la ruta restringida");
 });


            //Crear y levantar el servidor web.
            app.listen(3000);
            console.log("Servidor iniciado");