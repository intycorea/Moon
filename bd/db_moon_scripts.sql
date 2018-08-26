-- phpMyAdmin SQL Dump
-- version 4.8.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-08-2018 a las 06:24:46
-- Versión del servidor: 10.1.33-MariaDB
-- Versión de PHP: 7.2.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_moon`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_amigo`
--

CREATE TABLE `tbl_amigo` (
  `codigo_amigo` int(11) NOT NULL,
  `codigo_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_comentario`
--

CREATE TABLE `tbl_comentario` (
  `codigo_comentario` int(11) NOT NULL,
  `comentario` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_grupo`
--

CREATE TABLE `tbl_grupo` (
  `codigo_grupo` int(11) NOT NULL,
  `codigo_proyecto` int(11) NOT NULL,
  `nombre_grupo` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_mensajes`
--

CREATE TABLE `tbl_mensajes` (
  `codigo_mensaje` int(11) NOT NULL,
  `codigo_usuario_emisor` int(11) NOT NULL,
  `codigo_usuario_receptor` int(11) NOT NULL,
  `mensaje` varchar(4000) DEFAULT NULL,
  `fecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_proyecto`
--

CREATE TABLE `tbl_proyecto` (
  `codigo_proyecto` int(11) NOT NULL,
  `nombre_proyecto` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_solicitud`
--

CREATE TABLE `tbl_solicitud` (
  `codigo_solicitud` int(11) NOT NULL,
  `fecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_solicitudxusuarios`
--

CREATE TABLE `tbl_solicitudxusuarios` (
  `codigo_solicitud` int(11) NOT NULL,
  `codigo_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tipo_usuario`
--

CREATE TABLE `tbl_tipo_usuario` (
  `codigo_tipo_usuario` int(11) NOT NULL,
  `tipo_usuario` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_tipo_usuario`
--

INSERT INTO `tbl_tipo_usuario` (`codigo_tipo_usuario`, `tipo_usuario`) VALUES
(1, 'Starter'),
(2, 'Developer'),
(3, 'Super');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_usuarios`
--

CREATE TABLE `tbl_usuarios` (
  `codigo_usuario` int(11) NOT NULL,
  `codigo_tipo_usuario` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contrasena` varchar(300) NOT NULL,
  `fotografia` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_usuarios`
--

INSERT INTO `tbl_usuarios` (`codigo_usuario`, `codigo_tipo_usuario`, `nombre`, `apellido`, `correo`, `contrasena`, `fotografia`) VALUES
(1, 1, 'Inty', 'Corea', 'inty@gmail.com', 'asd.456', NULL),
(2, 2, 'Jorge', 'Perez', 'jorge@gmail.com', 'asd.456', NULL),
(3, 3, 'Raul', 'Romero', 'raul@gmail.com', 'asd.456', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_usuariosxcomentario`
--

CREATE TABLE `tbl_usuariosxcomentario` (
  `tbl_usuarios_codigo_usuario` int(11) NOT NULL,
  `tbl_comentario_codigo_comentario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_usuariosxgrupo`
--

CREATE TABLE `tbl_usuariosxgrupo` (
  `tbl_usuarios_codigo_usuario` int(11) NOT NULL,
  `tbl_grupo_codigo_grupo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_usuariosxproyecto`
--

CREATE TABLE `tbl_usuariosxproyecto` (
  `tbl_usuarios_codigo_usuario` int(11) NOT NULL,
  `tbl_proyecto_codigo_proyecto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbl_amigo`
--
ALTER TABLE `tbl_amigo`
  ADD PRIMARY KEY (`codigo_amigo`),
  ADD KEY `fk_tbl_amigo_tbl_usuarios1_idx` (`codigo_usuario`);

--
-- Indices de la tabla `tbl_comentario`
--
ALTER TABLE `tbl_comentario`
  ADD PRIMARY KEY (`codigo_comentario`);

--
-- Indices de la tabla `tbl_grupo`
--
ALTER TABLE `tbl_grupo`
  ADD PRIMARY KEY (`codigo_grupo`),
  ADD UNIQUE KEY `codigo_proyecto_UNIQUE` (`codigo_proyecto`),
  ADD KEY `fk_tbl_grupo_tbl_proyecto1_idx` (`codigo_proyecto`);

--
-- Indices de la tabla `tbl_mensajes`
--
ALTER TABLE `tbl_mensajes`
  ADD PRIMARY KEY (`codigo_mensaje`),
  ADD KEY `fk_tbl_mensajes_tbl_usuarios_idx` (`codigo_usuario_emisor`),
  ADD KEY `fk_tbl_mensajes_tbl_usuarios1_idx` (`codigo_usuario_receptor`);

--
-- Indices de la tabla `tbl_proyecto`
--
ALTER TABLE `tbl_proyecto`
  ADD PRIMARY KEY (`codigo_proyecto`);

--
-- Indices de la tabla `tbl_solicitud`
--
ALTER TABLE `tbl_solicitud`
  ADD PRIMARY KEY (`codigo_solicitud`);

--
-- Indices de la tabla `tbl_solicitudxusuarios`
--
ALTER TABLE `tbl_solicitudxusuarios`
  ADD PRIMARY KEY (`codigo_solicitud`,`codigo_usuario`),
  ADD KEY `fk_tbl_solicitud_has_tbl_usuarios_tbl_usuarios1_idx` (`codigo_usuario`),
  ADD KEY `fk_tbl_solicitud_has_tbl_usuarios_tbl_solicitud1_idx` (`codigo_solicitud`);

--
-- Indices de la tabla `tbl_tipo_usuario`
--
ALTER TABLE `tbl_tipo_usuario`
  ADD PRIMARY KEY (`codigo_tipo_usuario`);

--
-- Indices de la tabla `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  ADD PRIMARY KEY (`codigo_usuario`),
  ADD UNIQUE KEY `correo_UNIQUE` (`correo`),
  ADD UNIQUE KEY `codigo_tipo_usuario_UNIQUE` (`codigo_tipo_usuario`),
  ADD KEY `fk_tbl_usuarios_tbl_tipo_usuario1_idx` (`codigo_tipo_usuario`);

--
-- Indices de la tabla `tbl_usuariosxcomentario`
--
ALTER TABLE `tbl_usuariosxcomentario`
  ADD PRIMARY KEY (`tbl_usuarios_codigo_usuario`,`tbl_comentario_codigo_comentario`),
  ADD KEY `fk_tbl_usuarios_has_tbl_comentario_tbl_comentario1_idx` (`tbl_comentario_codigo_comentario`),
  ADD KEY `fk_tbl_usuarios_has_tbl_comentario_tbl_usuarios1_idx` (`tbl_usuarios_codigo_usuario`);

--
-- Indices de la tabla `tbl_usuariosxgrupo`
--
ALTER TABLE `tbl_usuariosxgrupo`
  ADD PRIMARY KEY (`tbl_usuarios_codigo_usuario`,`tbl_grupo_codigo_grupo`),
  ADD KEY `fk_tbl_usuarios_has_tbl_grupo_tbl_grupo1_idx` (`tbl_grupo_codigo_grupo`),
  ADD KEY `fk_tbl_usuarios_has_tbl_grupo_tbl_usuarios1_idx` (`tbl_usuarios_codigo_usuario`);

--
-- Indices de la tabla `tbl_usuariosxproyecto`
--
ALTER TABLE `tbl_usuariosxproyecto`
  ADD PRIMARY KEY (`tbl_usuarios_codigo_usuario`,`tbl_proyecto_codigo_proyecto`),
  ADD KEY `fk_tbl_usuarios_has_tbl_proyecto_tbl_proyecto1_idx` (`tbl_proyecto_codigo_proyecto`),
  ADD KEY `fk_tbl_usuarios_has_tbl_proyecto_tbl_usuarios1_idx` (`tbl_usuarios_codigo_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbl_amigo`
--
ALTER TABLE `tbl_amigo`
  MODIFY `codigo_amigo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbl_grupo`
--
ALTER TABLE `tbl_grupo`
  MODIFY `codigo_grupo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbl_solicitud`
--
ALTER TABLE `tbl_solicitud`
  MODIFY `codigo_solicitud` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbl_tipo_usuario`
--
ALTER TABLE `tbl_tipo_usuario`
  MODIFY `codigo_tipo_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  MODIFY `codigo_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_amigo`
--
ALTER TABLE `tbl_amigo`
  ADD CONSTRAINT `fk_tbl_amigo_tbl_usuarios1` FOREIGN KEY (`codigo_usuario`) REFERENCES `tbl_usuarios` (`codigo_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_grupo`
--
ALTER TABLE `tbl_grupo`
  ADD CONSTRAINT `fk_tbl_grupo_tbl_proyecto1` FOREIGN KEY (`codigo_proyecto`) REFERENCES `tbl_proyecto` (`codigo_proyecto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_mensajes`
--
ALTER TABLE `tbl_mensajes`
  ADD CONSTRAINT `fk_tbl_mensajes_tbl_usuarios` FOREIGN KEY (`codigo_usuario_emisor`) REFERENCES `tbl_usuarios` (`codigo_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tbl_mensajes_tbl_usuarios1` FOREIGN KEY (`codigo_usuario_receptor`) REFERENCES `tbl_usuarios` (`codigo_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_solicitudxusuarios`
--
ALTER TABLE `tbl_solicitudxusuarios`
  ADD CONSTRAINT `fk_tbl_solicitud_has_tbl_usuarios_tbl_solicitud1` FOREIGN KEY (`codigo_solicitud`) REFERENCES `tbl_solicitud` (`codigo_solicitud`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tbl_solicitud_has_tbl_usuarios_tbl_usuarios1` FOREIGN KEY (`codigo_usuario`) REFERENCES `tbl_usuarios` (`codigo_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  ADD CONSTRAINT `fk_tbl_usuarios_tbl_tipo_usuario1` FOREIGN KEY (`codigo_tipo_usuario`) REFERENCES `tbl_tipo_usuario` (`codigo_tipo_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_usuariosxcomentario`
--
ALTER TABLE `tbl_usuariosxcomentario`
  ADD CONSTRAINT `fk_tbl_usuarios_has_tbl_comentario_tbl_comentario1` FOREIGN KEY (`tbl_comentario_codigo_comentario`) REFERENCES `tbl_comentario` (`codigo_comentario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tbl_usuarios_has_tbl_comentario_tbl_usuarios1` FOREIGN KEY (`tbl_usuarios_codigo_usuario`) REFERENCES `tbl_usuarios` (`codigo_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_usuariosxgrupo`
--
ALTER TABLE `tbl_usuariosxgrupo`
  ADD CONSTRAINT `fk_tbl_usuarios_has_tbl_grupo_tbl_grupo1` FOREIGN KEY (`tbl_grupo_codigo_grupo`) REFERENCES `tbl_grupo` (`codigo_grupo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tbl_usuarios_has_tbl_grupo_tbl_usuarios1` FOREIGN KEY (`tbl_usuarios_codigo_usuario`) REFERENCES `tbl_usuarios` (`codigo_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_usuariosxproyecto`
--
ALTER TABLE `tbl_usuariosxproyecto`
  ADD CONSTRAINT `fk_tbl_usuarios_has_tbl_proyecto_tbl_proyecto1` FOREIGN KEY (`tbl_proyecto_codigo_proyecto`) REFERENCES `tbl_proyecto` (`codigo_proyecto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tbl_usuarios_has_tbl_proyecto_tbl_usuarios1` FOREIGN KEY (`tbl_usuarios_codigo_usuario`) REFERENCES `tbl_usuarios` (`codigo_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
