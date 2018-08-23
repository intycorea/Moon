var express = require("express");
var session = require("express-session");
var bodyParser = require("body-parser");
var mysql = require("mysql");
var app = express();
var credenciales ={
  user:"root",
  password:"",
  database:"bd_moon",
  host:"localhost",
  port:"3306"  
};

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies

app.use(express.static("public"));
app.use(session({secret:"ASDFE$%#%",resave:true, saveUninitialized:true}));

//Verificar si existe una variable de sesion para poner publica la carpeta public admin
var publicAdmin = express.static("public_admin");
var publicCajero = express.static("public_cajero");


            //Exponer una carpeta como publica, unicamente para archivos estaticos: .html, imagenes, .css, .js
            app.use(express.static("public"));

            //Crear y levantar el servidor web.
            app.listen(3000);
            console.log("Servidor iniciado");