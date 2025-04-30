-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 30-Jun-2022 às 00:48
-- Versão do servidor: 10.4.24-MariaDB
-- versão do PHP: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `sgm`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `agencia_funeraria`
--

CREATE TABLE `agencia_funeraria` (
  `CodAgen` int(5) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `contacto1` int(9) NOT NULL,
  `contacto2` int(9) NOT NULL,
  `bairro` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `agencia_funeraria`
--

INSERT INTO `agencia_funeraria` (`CodAgen`, `nome`, `contacto1`, `contacto2`, `bairro`) VALUES
(45432, 'Maputo-Agenc', 873435646, 862345346, 'Alto-mae'),
(65476, 'Matola-Agenc', 824485646, 84655346, 'Trevo'),
(65846, 'Brigada-Agenc', 82345646, 87235346, 'Brigada');

-- --------------------------------------------------------

--
-- Estrutura da tabela `camera`
--

CREATE TABLE `camera` (
  `codCam` int(5) NOT NULL,
  `numero` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `camera`
--

INSERT INTO `camera` (`codCam`, `numero`) VALUES
(5343, 1),
(6456, 2),
(6577, 3),
(8667, 4);

-- --------------------------------------------------------

--
-- Estrutura da tabela `camera_morgue`
--

CREATE TABLE `camera_morgue` (
  `codCam` int(5) NOT NULL,
  `codMor` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `camera_morgue`
--

INSERT INTO `camera_morgue` (`codCam`, `codMor`) VALUES
(5343, 5534),
(6456, 5534),
(6577, 22334),
(8667, 22334);

-- --------------------------------------------------------

--
-- Estrutura da tabela `corposconhecidos_agenciasfunerarias`
--

CREATE TABLE `corposconhecidos_agenciasfunerarias` (
  `CodCorpo` int(5) NOT NULL,
  `CodAgen` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `corposconhecidos_agenciasfunerarias`
--

INSERT INTO `corposconhecidos_agenciasfunerarias` (`CodCorpo`, `CodAgen`) VALUES
(1, 45432),
(2, 65476);

-- --------------------------------------------------------

--
-- Estrutura da tabela `corpos_camera`
--

CREATE TABLE `corpos_camera` (
  `CodCorpo` int(5) NOT NULL,
  `codCam` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `corpos_camera`
--

INSERT INTO `corpos_camera` (`CodCorpo`, `codCam`) VALUES
(1000, 5343),
(1001, 6456),
(1, 6577),
(2, 8667);

-- --------------------------------------------------------

--
-- Estrutura da tabela `corpos_conhecidos`
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
-- Extraindo dados da tabela `corpos_conhecidos`
--

INSERT INTO `corpos_conhecidos` (`CodCorpo`, `nome`, `idade`, `genero`, `faixaEtaria`, `Local_Morte`, `Causa_Morte`, `Data_Morte`) VALUES
(1, 'Ernesto', 13, 'M', 'Adolescent', 'Magude', 'stress', '0000-00-00'),
(2, 'Arnaldo', 30, 'M', 'Jovem', 'Malanga', 'Doenca', '0000-00-00'),
(3, 'Mario', 23, 'M', 'Jovem', 'Baixa', 'Acidente', '0000-00-00'),
(4, 'Edna', 48, 'F', 'Adulto', 'Jardim', 'Doenca', '0000-00-00');

--
-- Acionadores `corpos_conhecidos`
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

-- --------------------------------------------------------

--
-- Estrutura da tabela `corpos_conhecidos__morgue`
--

CREATE TABLE `corpos_conhecidos__morgue` (
  `CodCorpo` int(5) NOT NULL,
  `codMor` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `corpos_conhecidos__morgue`
--

INSERT INTO `corpos_conhecidos__morgue` (`CodCorpo`, `codMor`) VALUES
(1, 5534),
(2, 22334);

-- --------------------------------------------------------

--
-- Estrutura da tabela `corpos_desconhecidos`
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
-- Extraindo dados da tabela `corpos_desconhecidos`
--

INSERT INTO `corpos_desconhecidos` (`CodCorpo`, `Raca`, `Altura`, `Descricao`, `genero`, `faixaEtaria`, `Local_Morte`, `Data_Morte`, `Causa_Morte`) VALUES
(1000, 'Negro', '1.00', 'Alto_Gordo', 'M', 'Adulto', 'Maputo', '0000-00-00', 'Acidente'),
(1001, 'Negro', '1.80', 'Alto_Magro', 'F', 'Adulto', 'Maputo', '0000-00-00', 'Doenca'),
(1002, 'Negro', '1.30', 'Baixo_Magro', 'M', 'Jovem', 'Matola', '0000-00-00', 'stress'),
(1232, 'branco', '1.40', 'baixo_sem dentes', 'm', 'adulto', 'matola', '2021-08-06', 'doenca');

--
-- Acionadores `corpos_desconhecidos`
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

-- --------------------------------------------------------

--
-- Estrutura da tabela `corpos_desconhecidos_valamorgue`
--

CREATE TABLE `corpos_desconhecidos_valamorgue` (
  `CodCorpo` int(5) NOT NULL,
  `codMor` int(5) NOT NULL,
  `CodVala` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `corpos_desconhecidos_valamorgue`
--

INSERT INTO `corpos_desconhecidos_valamorgue` (`CodCorpo`, `codMor`, `CodVala`) VALUES
(1, 5534, 7800);

-- --------------------------------------------------------

--
-- Estrutura da tabela `corpos_parentes`
--

CREATE TABLE `corpos_parentes` (
  `CodCorpo` int(5) NOT NULL,
  `codParen` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `corpos_parentes`
--

INSERT INTO `corpos_parentes` (`CodCorpo`, `codParen`) VALUES
(1, 998),
(4, 998),
(2, 999),
(3, 999);

-- --------------------------------------------------------

--
-- Estrutura da tabela `funcionario`
--

CREATE TABLE `funcionario` (
  `codFunc` int(5) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `funcao` varchar(10) NOT NULL,
  `contacto1` int(9) NOT NULL,
  `contacto2` int(9) NOT NULL,
  `bairro` varchar(20) NOT NULL,
  `total_Funcionarios` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `funcionario`
--

INSERT INTO `funcionario` (`codFunc`, `nome`, `funcao`, `contacto1`, `contacto2`, `bairro`, `total_Funcionarios`) VALUES
(3545, 'Lino', 'motorista', 83564667, 875749634, 'trevo', 1),
(5467, 'Ader', 'gestor', 7643242, 455424234, 'jardim', 1);

--
-- Acionadores `funcionario`
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
-- Estrutura da tabela `funcionario_morgue`
--

CREATE TABLE `funcionario_morgue` (
  `codFunc` int(5) NOT NULL,
  `codMor` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `funcionario_morgue`
--

INSERT INTO `funcionario_morgue` (`codFunc`, `codMor`) VALUES
(3545, 5534),
(5467, 5534);

-- --------------------------------------------------------

--
-- Estrutura da tabela `morgue`
--

CREATE TABLE `morgue` (
  `codMor` int(5) NOT NULL,
  `contacto1` int(9) NOT NULL,
  `contacto2` int(9) NOT NULL,
  `bairro` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `morgue`
--

INSERT INTO `morgue` (`codMor`, `contacto1`, `contacto2`, `bairro`) VALUES
(5534, 83446, 87346, 'Matola'),
(22334, 87666, 85766, 'Baixa');

-- --------------------------------------------------------

--
-- Estrutura da tabela `parentes`
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
-- Extraindo dados da tabela `parentes`
--

INSERT INTO `parentes` (`codParen`, `nome`, `grauParentesco`, `contacto1`, `contacto2`, `bairro`) VALUES
(998, 'Adigm', 'irmao', 85455832, 83502389, 'matola'),
(999, 'Askle', 'tio', 86345832, 84302389, '700_C');

-- --------------------------------------------------------

--
-- Estrutura da tabela `representante`
--

CREATE TABLE `representante` (
  `CodRepre` int(5) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `contacto1` int(9) NOT NULL,
  `contacto2` int(9) NOT NULL,
  `bairro` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `representante`
--

INSERT INTO `representante` (`CodRepre`, `nome`, `contacto1`, `contacto2`, `bairro`) VALUES
(7568, 'Tonito', 8245459, 8456432, 'Jonasse'),
(8888, 'Admiro', 8763459, 8934532, 'Nkobe');

-- --------------------------------------------------------

--
-- Estrutura da tabela `representantes_agenciasfuneraria`
--

CREATE TABLE `representantes_agenciasfuneraria` (
  `CodRepre` int(5) NOT NULL,
  `CodAgen` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `representantes_agenciasfuneraria`
--

INSERT INTO `representantes_agenciasfuneraria` (`CodRepre`, `CodAgen`) VALUES
(7568, 45432),
(8888, 65476);

-- --------------------------------------------------------

--
-- Estrutura da tabela `vala_comum`
--

CREATE TABLE `vala_comum` (
  `CodVala` int(5) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `contacto1` int(9) NOT NULL,
  `contacto2` int(9) NOT NULL,
  `bairro` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `vala_comum`
--

INSERT INTO `vala_comum` (`CodVala`, `nome`, `contacto1`, `contacto2`, `bairro`) VALUES
(7800, 'MML', 85333, 87999, 'Matola'),
(7801, 'PML', 85633, 824995, 'Maputo');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `agencia_funeraria`
--
ALTER TABLE `agencia_funeraria`
  ADD PRIMARY KEY (`CodAgen`);

--
-- Índices para tabela `camera`
--
ALTER TABLE `camera`
  ADD PRIMARY KEY (`codCam`);

--
-- Índices para tabela `camera_morgue`
--
ALTER TABLE `camera_morgue`
  ADD PRIMARY KEY (`codCam`),
  ADD KEY `codMor` (`codMor`);

--
-- Índices para tabela `corposconhecidos_agenciasfunerarias`
--
ALTER TABLE `corposconhecidos_agenciasfunerarias`
  ADD UNIQUE KEY `CodCorpo` (`CodCorpo`),
  ADD UNIQUE KEY `CodAgen` (`CodAgen`);

--
-- Índices para tabela `corpos_camera`
--
ALTER TABLE `corpos_camera`
  ADD PRIMARY KEY (`CodCorpo`),
  ADD KEY `codCam` (`codCam`);

--
-- Índices para tabela `corpos_conhecidos`
--
ALTER TABLE `corpos_conhecidos`
  ADD PRIMARY KEY (`CodCorpo`);

--
-- Índices para tabela `corpos_conhecidos__morgue`
--
ALTER TABLE `corpos_conhecidos__morgue`
  ADD UNIQUE KEY `CodCorpo` (`CodCorpo`),
  ADD UNIQUE KEY `codMor` (`codMor`);

--
-- Índices para tabela `corpos_desconhecidos`
--
ALTER TABLE `corpos_desconhecidos`
  ADD PRIMARY KEY (`CodCorpo`);

--
-- Índices para tabela `corpos_desconhecidos_valamorgue`
--
ALTER TABLE `corpos_desconhecidos_valamorgue`
  ADD UNIQUE KEY `CodCorpo` (`CodCorpo`),
  ADD UNIQUE KEY `codMor` (`codMor`),
  ADD UNIQUE KEY `CodVala` (`CodVala`);

--
-- Índices para tabela `corpos_parentes`
--
ALTER TABLE `corpos_parentes`
  ADD PRIMARY KEY (`CodCorpo`),
  ADD KEY `codParen` (`codParen`);

--
-- Índices para tabela `funcionario`
--
ALTER TABLE `funcionario`
  ADD PRIMARY KEY (`codFunc`);

--
-- Índices para tabela `funcionario_morgue`
--
ALTER TABLE `funcionario_morgue`
  ADD PRIMARY KEY (`codFunc`),
  ADD KEY `codMor` (`codMor`);

--
-- Índices para tabela `morgue`
--
ALTER TABLE `morgue`
  ADD PRIMARY KEY (`codMor`);

--
-- Índices para tabela `parentes`
--
ALTER TABLE `parentes`
  ADD PRIMARY KEY (`codParen`);

--
-- Índices para tabela `representante`
--
ALTER TABLE `representante`
  ADD PRIMARY KEY (`CodRepre`);

--
-- Índices para tabela `representantes_agenciasfuneraria`
--
ALTER TABLE `representantes_agenciasfuneraria`
  ADD UNIQUE KEY `CodRepre` (`CodRepre`),
  ADD UNIQUE KEY `CodAgen` (`CodAgen`);

--
-- Índices para tabela `vala_comum`
--
ALTER TABLE `vala_comum`
  ADD PRIMARY KEY (`CodVala`);

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `camera_morgue`
--
ALTER TABLE `camera_morgue`
  ADD CONSTRAINT `camera_morgue_ibfk_1` FOREIGN KEY (`codMor`) REFERENCES `morgue` (`codMor`);

--
-- Limitadores para a tabela `corposconhecidos_agenciasfunerarias`
--
ALTER TABLE `corposconhecidos_agenciasfunerarias`
  ADD CONSTRAINT `corposconhecidos_agenciasfunerarias_ibfk_1` FOREIGN KEY (`CodCorpo`) REFERENCES `corpos_conhecidos` (`CodCorpo`),
  ADD CONSTRAINT `corposconhecidos_agenciasfunerarias_ibfk_2` FOREIGN KEY (`CodAgen`) REFERENCES `agencia_funeraria` (`CodAgen`);

--
-- Limitadores para a tabela `corpos_camera`
--
ALTER TABLE `corpos_camera`
  ADD CONSTRAINT `corpos_camera_ibfk_1` FOREIGN KEY (`codCam`) REFERENCES `camera` (`codCam`);

--
-- Limitadores para a tabela `corpos_conhecidos__morgue`
--
ALTER TABLE `corpos_conhecidos__morgue`
  ADD CONSTRAINT `corpos_conhecidos__morgue_ibfk_1` FOREIGN KEY (`CodCorpo`) REFERENCES `corpos_conhecidos` (`CodCorpo`),
  ADD CONSTRAINT `corpos_conhecidos__morgue_ibfk_2` FOREIGN KEY (`codMor`) REFERENCES `morgue` (`codMor`);

--
-- Limitadores para a tabela `corpos_desconhecidos_valamorgue`
--
ALTER TABLE `corpos_desconhecidos_valamorgue`
  ADD CONSTRAINT `corpos_desconhecidos_valamorgue_ibfk_1` FOREIGN KEY (`CodCorpo`) REFERENCES `corpos_conhecidos` (`CodCorpo`),
  ADD CONSTRAINT `corpos_desconhecidos_valamorgue_ibfk_2` FOREIGN KEY (`codMor`) REFERENCES `morgue` (`codMor`),
  ADD CONSTRAINT `corpos_desconhecidos_valamorgue_ibfk_3` FOREIGN KEY (`CodVala`) REFERENCES `vala_comum` (`CodVala`);

--
-- Limitadores para a tabela `corpos_parentes`
--
ALTER TABLE `corpos_parentes`
  ADD CONSTRAINT `corpos_parentes_ibfk_1` FOREIGN KEY (`codParen`) REFERENCES `parentes` (`codParen`);

--
-- Limitadores para a tabela `funcionario_morgue`
--
ALTER TABLE `funcionario_morgue`
  ADD CONSTRAINT `funcionario_morgue_ibfk_1` FOREIGN KEY (`codMor`) REFERENCES `morgue` (`codMor`);

--
-- Limitadores para a tabela `representantes_agenciasfuneraria`
--
ALTER TABLE `representantes_agenciasfuneraria`
  ADD CONSTRAINT `representantes_agenciasfuneraria_ibfk_1` FOREIGN KEY (`CodRepre`) REFERENCES `representante` (`CodRepre`),
  ADD CONSTRAINT `representantes_agenciasfuneraria_ibfk_2` FOREIGN KEY (`CodAgen`) REFERENCES `agencia_funeraria` (`CodAgen`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
