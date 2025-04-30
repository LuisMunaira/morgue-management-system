-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 30, 2022 at 01:02 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sgm`
--

-- --------------------------------------------------------

--
-- Table structure for table `agencia_funeraria`
--

CREATE TABLE `agencia_funeraria` (
  `CodAgen` int(5) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `contacto1` int(9) NOT NULL,
  `contacto2` int(9) NOT NULL,
  `bairro` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `agencia_funeraria`
--

INSERT INTO `agencia_funeraria` (`CodAgen`, `nome`, `contacto1`, `contacto2`, `bairro`) VALUES
(45432, 'Maputo-Agenc', 873435646, 862345346, 'Alto-mae'),
(65476, 'Matola-Agenc', 824485646, 84655346, 'Trevo'),
(65846, 'Brigada-Agenc', 82345646, 87235346, 'Brigada');

-- --------------------------------------------------------

--
-- Table structure for table `camera`
--

CREATE TABLE `camera` (
  `codCam` int(5) NOT NULL,
  `numero` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `camera`
--

INSERT INTO `camera` (`codCam`, `numero`) VALUES
(5343, 1),
(6456, 2),
(6577, 3),
(8667, 4);

-- --------------------------------------------------------

--
-- Table structure for table `camera_morgue`
--

CREATE TABLE `camera_morgue` (
  `codCam` int(5) NOT NULL,
  `codMor` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `camera_morgue`
--

INSERT INTO `camera_morgue` (`codCam`, `codMor`) VALUES
(5343, 5534),
(6456, 5534),
(6577, 22334),
(8667, 22334);

-- --------------------------------------------------------

--
-- Table structure for table `corposconhecidos_agenciasfunerarias`
--

CREATE TABLE `corposconhecidos_agenciasfunerarias` (
  `CodCorpo` int(5) NOT NULL,
  `CodAgen` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `corposconhecidos_agenciasfunerarias`
--

INSERT INTO `corposconhecidos_agenciasfunerarias` (`CodCorpo`, `CodAgen`) VALUES
(1, 45432),
(2, 65476);

-- --------------------------------------------------------

--
-- Table structure for table `corpos_camera`
--

CREATE TABLE `corpos_camera` (
  `CodCorpo` int(5) NOT NULL,
  `codCam` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `corpos_camera`
--

INSERT INTO `corpos_camera` (`CodCorpo`, `codCam`) VALUES
(1000, 5343),
(1001, 6456),
(1, 6577),
(2, 8667);

-- --------------------------------------------------------

--
-- Table structure for table `corpos_conhecidos`
--

CREATE TABLE `corpos_conhecidos` (
  `CodCorpo` int(5) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `idade` int(2) NOT NULL,
  `genero` varchar(10) NOT NULL,
  `faixaEtaria` varchar(10) NOT NULL,
  `Local_Morte` varchar(10) NOT NULL,
  `Causa_Morte` varchar(10) NOT NULL,
  `Data_Morte` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `corpos_conhecidos`
--

INSERT INTO `corpos_conhecidos` (`CodCorpo`, `nome`, `idade`, `genero`, `faixaEtaria`, `Local_Morte`, `Causa_Morte`, `Data_Morte`) VALUES
(1, 'Ernesto', 13, 'M', 'Adolescent', 'Magude', 'stress', '0000-00-00'),
(2, 'Arnaldo', 30, 'M', 'Jovem', 'Malanga', 'Doenca', '0000-00-00'),
(3, 'Mario', 23, 'M', 'Jovem', 'Baixa', 'Acidente', '0000-00-00'),
(4, 'Edna', 48, 'F', 'Adulto', 'Jardim', 'Doenca', '0000-00-00'),
(8767, 'Alvaro', 56, 'M', 'Adulto', 'Matola', 'doenca', '2021-09-03');

--
-- Triggers `corpos_conhecidos`
--
DELIMITER $$
CREATE TRIGGER `tr_datamenor` BEFORE INSERT ON `corpos_conhecidos` FOR EACH ROW begin
     if ((year(new.Data_Morte) < 0) and (month(new.Data_Morte) < 0) and (day(new.Data_Morte) < 0))then
        signal sqlstate '45000'
          set message_text = 'Dado invalido';
   end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_insert_corposConhecidos` AFTER INSERT ON `corpos_conhecidos` FOR EACH ROW begin 
  update estatistica
    set TotalCorpos = TotalCorpos + 1;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `corpos_conhecidos__morgue`
--

CREATE TABLE `corpos_conhecidos__morgue` (
  `CodCorpo` int(5) NOT NULL,
  `codMor` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `corpos_conhecidos__morgue`
--

INSERT INTO `corpos_conhecidos__morgue` (`CodCorpo`, `codMor`) VALUES
(1, 5534),
(2, 22334);

-- --------------------------------------------------------

--
-- Table structure for table `corpos_desconhecidos`
--

CREATE TABLE `corpos_desconhecidos` (
  `CodCorpo` int(5) NOT NULL,
  `Raca` varchar(10) NOT NULL,
  `Altura` decimal(3,2) DEFAULT NULL,
  `Descricao` varchar(20) NOT NULL,
  `genero` varchar(10) NOT NULL,
  `faixaEtaria` varchar(10) NOT NULL,
  `Local_Morte` varchar(10) NOT NULL,
  `Data_Morte` date DEFAULT NULL,
  `Causa_Morte` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `corpos_desconhecidos`
--

INSERT INTO `corpos_desconhecidos` (`CodCorpo`, `Raca`, `Altura`, `Descricao`, `genero`, `faixaEtaria`, `Local_Morte`, `Data_Morte`, `Causa_Morte`) VALUES
(1000, 'Negro', '1.00', 'Alto_Gordo', 'M', 'Adulto', 'Maputo', '0000-00-00', 'Acidente'),
(1001, 'Negro', '1.80', 'Alto_Magro', 'F', 'Adulto', 'Maputo', '0000-00-00', 'Doenca'),
(1002, 'Negro', '1.30', 'Baixo_Magro', 'M', 'Jovem', 'Matola', '0000-00-00', 'stress'),
(1232, 'branco', '1.40', 'baixo_sem dentes', 'm', 'adulto', 'matola', '2021-08-06', 'doenca');

--
-- Triggers `corpos_desconhecidos`
--
DELIMITER $$
CREATE TRIGGER `tr_altura` BEFORE INSERT ON `corpos_desconhecidos` FOR EACH ROW begin
  if(new.Altura < 0)then
    signal sqlstate '45000'
 set message_text = 'Altura invalida';
end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_inserir_corposDesconhecidos` AFTER INSERT ON `corpos_desconhecidos` FOR EACH ROW begin 
  update estatistica
    set TotalCorpos = TotalCorpos + 1;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `corpos_desconhecidos_valamorgue`
--

CREATE TABLE `corpos_desconhecidos_valamorgue` (
  `CodCorpo` int(5) NOT NULL,
  `codMor` int(5) NOT NULL,
  `CodVala` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `corpos_desconhecidos_valamorgue`
--

INSERT INTO `corpos_desconhecidos_valamorgue` (`CodCorpo`, `codMor`, `CodVala`) VALUES
(1, 5534, 7800);

-- --------------------------------------------------------

--
-- Table structure for table `corpos_parentes`
--

CREATE TABLE `corpos_parentes` (
  `CodCorpo` int(5) NOT NULL,
  `codParen` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `corpos_parentes`
--

INSERT INTO `corpos_parentes` (`CodCorpo`, `codParen`) VALUES
(1, 998),
(4, 998),
(2, 999),
(3, 999);

-- --------------------------------------------------------

--
-- Table structure for table `estatistica`
--

CREATE TABLE `estatistica` (
  `TotalCorpos` int(4) NOT NULL,
  `TotalFuncionario` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `estatistica`
--

INSERT INTO `estatistica` (`TotalCorpos`, `TotalFuncionario`) VALUES
(9, 2);

-- --------------------------------------------------------

--
-- Table structure for table `funcionario`
--

CREATE TABLE `funcionario` (
  `codFunc` int(5) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `funcao` varchar(10) NOT NULL,
  `contacto1` int(9) NOT NULL,
  `contacto2` int(9) NOT NULL,
  `bairro` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `funcionario`
--

INSERT INTO `funcionario` (`codFunc`, `nome`, `funcao`, `contacto1`, `contacto2`, `bairro`) VALUES
(3545, 'Lino', 'motorista', 83564667, 875749634, 'trevo'),
(5467, 'Ader', 'gestor', 7643242, 455424234, 'jardim');

--
-- Triggers `funcionario`
--
DELIMITER $$
CREATE TRIGGER `tr_insertContact` BEFORE INSERT ON `funcionario` FOR EACH ROW begin
     if ((new.contacto1 = '') or (new.contacto2 = ''))then
        signal sqlstate '45000'
          set message_text = 'Introduza um contacto pelo menos';
   end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `funcionario_morgue`
--

CREATE TABLE `funcionario_morgue` (
  `codFunc` int(5) NOT NULL,
  `codMor` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `funcionario_morgue`
--

INSERT INTO `funcionario_morgue` (`codFunc`, `codMor`) VALUES
(3545, 5534),
(5467, 5534);

-- --------------------------------------------------------

--
-- Table structure for table `morgue`
--

CREATE TABLE `morgue` (
  `codMor` int(5) NOT NULL,
  `contacto1` int(9) NOT NULL,
  `contacto2` int(9) NOT NULL,
  `bairro` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `morgue`
--

INSERT INTO `morgue` (`codMor`, `contacto1`, `contacto2`, `bairro`) VALUES
(5534, 83446, 87346, 'Matola'),
(22334, 87666, 85766, 'Baixa');

-- --------------------------------------------------------

--
-- Table structure for table `parentes`
--

CREATE TABLE `parentes` (
  `codParen` int(5) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `grauParentesco` varchar(20) NOT NULL,
  `contacto1` int(9) NOT NULL,
  `contacto2` int(9) NOT NULL,
  `bairro` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `parentes`
--

INSERT INTO `parentes` (`codParen`, `nome`, `grauParentesco`, `contacto1`, `contacto2`, `bairro`) VALUES
(998, 'Adigm', 'irmao', 85455832, 83502389, 'matola'),
(999, 'Askle', 'tio', 86345832, 84302389, '700_C');

-- --------------------------------------------------------

--
-- Table structure for table `representante`
--

CREATE TABLE `representante` (
  `CodRepre` int(5) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `contacto1` int(9) NOT NULL,
  `contacto2` int(9) NOT NULL,
  `bairro` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `representante`
--

INSERT INTO `representante` (`CodRepre`, `nome`, `contacto1`, `contacto2`, `bairro`) VALUES
(7568, 'Tonito', 8245459, 8456432, 'Jonasse'),
(8888, 'Admiro', 8763459, 8934532, 'Nkobe');

-- --------------------------------------------------------

--
-- Table structure for table `representantes_agenciasfuneraria`
--

CREATE TABLE `representantes_agenciasfuneraria` (
  `CodRepre` int(5) NOT NULL,
  `CodAgen` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `representantes_agenciasfuneraria`
--

INSERT INTO `representantes_agenciasfuneraria` (`CodRepre`, `CodAgen`) VALUES
(7568, 45432),
(8888, 65476);

-- --------------------------------------------------------

--
-- Table structure for table `vala_comum`
--

CREATE TABLE `vala_comum` (
  `CodVala` int(5) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `contacto1` int(9) NOT NULL,
  `contacto2` int(9) NOT NULL,
  `bairro` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `vala_comum`
--

INSERT INTO `vala_comum` (`CodVala`, `nome`, `contacto1`, `contacto2`, `bairro`) VALUES
(7800, 'MML', 85333, 87999, 'Matola'),
(7801, 'PML', 85633, 824995, 'Maputo');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `agencia_funeraria`
--
ALTER TABLE `agencia_funeraria`
  ADD PRIMARY KEY (`CodAgen`);

--
-- Indexes for table `camera`
--
ALTER TABLE `camera`
  ADD PRIMARY KEY (`codCam`);

--
-- Indexes for table `camera_morgue`
--
ALTER TABLE `camera_morgue`
  ADD PRIMARY KEY (`codCam`),
  ADD KEY `codMor` (`codMor`);

--
-- Indexes for table `corposconhecidos_agenciasfunerarias`
--
ALTER TABLE `corposconhecidos_agenciasfunerarias`
  ADD UNIQUE KEY `CodCorpo` (`CodCorpo`),
  ADD UNIQUE KEY `CodAgen` (`CodAgen`);

--
-- Indexes for table `corpos_camera`
--
ALTER TABLE `corpos_camera`
  ADD PRIMARY KEY (`CodCorpo`),
  ADD KEY `codCam` (`codCam`);

--
-- Indexes for table `corpos_conhecidos`
--
ALTER TABLE `corpos_conhecidos`
  ADD PRIMARY KEY (`CodCorpo`);

--
-- Indexes for table `corpos_conhecidos__morgue`
--
ALTER TABLE `corpos_conhecidos__morgue`
  ADD UNIQUE KEY `CodCorpo` (`CodCorpo`),
  ADD UNIQUE KEY `codMor` (`codMor`);

--
-- Indexes for table `corpos_desconhecidos`
--
ALTER TABLE `corpos_desconhecidos`
  ADD PRIMARY KEY (`CodCorpo`);

--
-- Indexes for table `corpos_desconhecidos_valamorgue`
--
ALTER TABLE `corpos_desconhecidos_valamorgue`
  ADD UNIQUE KEY `CodCorpo` (`CodCorpo`),
  ADD UNIQUE KEY `codMor` (`codMor`),
  ADD UNIQUE KEY `CodVala` (`CodVala`);

--
-- Indexes for table `corpos_parentes`
--
ALTER TABLE `corpos_parentes`
  ADD PRIMARY KEY (`CodCorpo`),
  ADD KEY `codParen` (`codParen`);

--
-- Indexes for table `funcionario`
--
ALTER TABLE `funcionario`
  ADD PRIMARY KEY (`codFunc`);

--
-- Indexes for table `funcionario_morgue`
--
ALTER TABLE `funcionario_morgue`
  ADD PRIMARY KEY (`codFunc`),
  ADD KEY `codMor` (`codMor`);

--
-- Indexes for table `morgue`
--
ALTER TABLE `morgue`
  ADD PRIMARY KEY (`codMor`);

--
-- Indexes for table `parentes`
--
ALTER TABLE `parentes`
  ADD PRIMARY KEY (`codParen`);

--
-- Indexes for table `representante`
--
ALTER TABLE `representante`
  ADD PRIMARY KEY (`CodRepre`);

--
-- Indexes for table `representantes_agenciasfuneraria`
--
ALTER TABLE `representantes_agenciasfuneraria`
  ADD UNIQUE KEY `CodRepre` (`CodRepre`),
  ADD UNIQUE KEY `CodAgen` (`CodAgen`);

--
-- Indexes for table `vala_comum`
--
ALTER TABLE `vala_comum`
  ADD PRIMARY KEY (`CodVala`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `camera_morgue`
--
ALTER TABLE `camera_morgue`
  ADD CONSTRAINT `camera_morgue_ibfk_1` FOREIGN KEY (`codMor`) REFERENCES `morgue` (`codMor`);

--
-- Constraints for table `corposconhecidos_agenciasfunerarias`
--
ALTER TABLE `corposconhecidos_agenciasfunerarias`
  ADD CONSTRAINT `corposconhecidos_agenciasfunerarias_ibfk_1` FOREIGN KEY (`CodCorpo`) REFERENCES `corpos_conhecidos` (`CodCorpo`),
  ADD CONSTRAINT `corposconhecidos_agenciasfunerarias_ibfk_2` FOREIGN KEY (`CodAgen`) REFERENCES `agencia_funeraria` (`CodAgen`);

--
-- Constraints for table `corpos_camera`
--
ALTER TABLE `corpos_camera`
  ADD CONSTRAINT `corpos_camera_ibfk_1` FOREIGN KEY (`codCam`) REFERENCES `camera` (`codCam`);

--
-- Constraints for table `corpos_conhecidos__morgue`
--
ALTER TABLE `corpos_conhecidos__morgue`
  ADD CONSTRAINT `corpos_conhecidos__morgue_ibfk_1` FOREIGN KEY (`CodCorpo`) REFERENCES `corpos_conhecidos` (`CodCorpo`),
  ADD CONSTRAINT `corpos_conhecidos__morgue_ibfk_2` FOREIGN KEY (`codMor`) REFERENCES `morgue` (`codMor`);

--
-- Constraints for table `corpos_desconhecidos_valamorgue`
--
ALTER TABLE `corpos_desconhecidos_valamorgue`
  ADD CONSTRAINT `corpos_desconhecidos_valamorgue_ibfk_1` FOREIGN KEY (`CodCorpo`) REFERENCES `corpos_conhecidos` (`CodCorpo`),
  ADD CONSTRAINT `corpos_desconhecidos_valamorgue_ibfk_2` FOREIGN KEY (`codMor`) REFERENCES `morgue` (`codMor`),
  ADD CONSTRAINT `corpos_desconhecidos_valamorgue_ibfk_3` FOREIGN KEY (`CodVala`) REFERENCES `vala_comum` (`CodVala`);

--
-- Constraints for table `corpos_parentes`
--
ALTER TABLE `corpos_parentes`
  ADD CONSTRAINT `corpos_parentes_ibfk_1` FOREIGN KEY (`codParen`) REFERENCES `parentes` (`codParen`);

--
-- Constraints for table `funcionario_morgue`
--
ALTER TABLE `funcionario_morgue`
  ADD CONSTRAINT `funcionario_morgue_ibfk_1` FOREIGN KEY (`codMor`) REFERENCES `morgue` (`codMor`);

--
-- Constraints for table `representantes_agenciasfuneraria`
--
ALTER TABLE `representantes_agenciasfuneraria`
  ADD CONSTRAINT `representantes_agenciasfuneraria_ibfk_1` FOREIGN KEY (`CodRepre`) REFERENCES `representante` (`CodRepre`),
  ADD CONSTRAINT `representantes_agenciasfuneraria_ibfk_2` FOREIGN KEY (`CodAgen`) REFERENCES `agencia_funeraria` (`CodAgen`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
