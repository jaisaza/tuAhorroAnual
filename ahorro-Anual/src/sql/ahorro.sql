-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-07-2021 a las 20:04:12
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ahorro`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades`
--

CREATE TABLE `actividades` (
  `id_ahorrador` int(11) NOT NULL,
  `nombre` varchar(55) NOT NULL,
  `intereses` int(10) NOT NULL,
  `actividad_ polla` int(10) NOT NULL,
  `actividad_bingo` int(10) NOT NULL,
  `actividad_algo` int(10) NOT NULL,
  `actividad_paseo` int(10) NOT NULL,
  `total_general` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividad_algos`
--

CREATE TABLE `actividad_algos` (
  `fecha` date NOT NULL,
  `numero_algos_vendidos` int(11) NOT NULL,
  `valor_algos_vendidos` int(11) NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividad_bingo`
--

CREATE TABLE `actividad_bingo` (
  `fecha_juego` date NOT NULL,
  `ingresos` int(11) NOT NULL,
  `total_ingresos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividad_paseo`
--

CREATE TABLE `actividad_paseo` (
  `fecha` date NOT NULL,
  `id_ahorrador` int(11) NOT NULL,
  `nombre` varchar(55) NOT NULL,
  `valor_ahorro` int(11) NOT NULL,
  `gastos_paseo` int(11) NOT NULL,
  `total_ganancia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividad_pollas`
--

CREATE TABLE `actividad_pollas` (
  `fecha_pago` date NOT NULL,
  `valor_pago` int(11) NOT NULL,
  `valor_entregado_ganador` int(11) NOT NULL,
  `total_actividad_pollas` int(11) NOT NULL,
  `id_ahorrador` int(11) NOT NULL,
  `nombre` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ahorro`
--

CREATE TABLE `ahorro` (
  `fecha` date NOT NULL,
  `id_ahorrador` int(11) NOT NULL,
  `nombre` varchar(55) NOT NULL,
  `valor_ahorro` int(11) NOT NULL,
  `total_ahorro` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consignaciones`
--

CREATE TABLE `consignaciones` (
  `fecha` date NOT NULL,
  `valor_consignacion` int(11) NOT NULL,
  `valor_ingreso_semanal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `intereses`
--

CREATE TABLE `intereses` (
  `fecha` date NOT NULL,
  `nombre` int(11) NOT NULL,
  `id_ahorrador` int(11) NOT NULL,
  `total` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `total_general`
--

CREATE TABLE `total_general` (
  `fecha` date NOT NULL,
  `id_ahorrador` int(11) NOT NULL,
  `nombre` varchar(55) NOT NULL,
  `valor_ahorro` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actividades`
--
ALTER TABLE `actividades`
  ADD PRIMARY KEY (`id_ahorrador`);

--
-- Indices de la tabla `intereses`
--
ALTER TABLE `intereses`
  ADD KEY `id_ahorrador` (`id_ahorrador`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actividades`
--
ALTER TABLE `actividades`
  MODIFY `id_ahorrador` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `intereses`
--
ALTER TABLE `intereses`
  ADD CONSTRAINT `intereses_ibfk_1` FOREIGN KEY (`id_ahorrador`) REFERENCES `actividades` (`id_ahorrador`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
