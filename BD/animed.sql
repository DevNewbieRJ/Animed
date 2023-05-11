-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 11-Maio-2023 às 02:00
-- Versão do servidor: 8.0.31
-- versão do PHP: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `animed`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `agenda`
--

DROP TABLE IF EXISTS `agenda`;
CREATE TABLE IF NOT EXISTS `agenda` (
  `id_agenda` int NOT NULL AUTO_INCREMENT,
  `data_agendamento` date NOT NULL,
  `hora` time NOT NULL,
  `tipo_servico` varchar(50) NOT NULL,
  `id_animal` int NOT NULL,
  `id_veterinario` int NOT NULL,
  `id_funcionario` int NOT NULL,
  PRIMARY KEY (`id_agenda`),
  KEY `id_animal` (`id_animal`),
  KEY `id_veterinario` (`id_veterinario`),
  KEY `agenda_ibfk_3_idx` (`id_funcionario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura da tabela `animais`
--

DROP TABLE IF EXISTS `animais`;
CREATE TABLE IF NOT EXISTS `animais` (
  `id_animal` int NOT NULL,
  `nome_animal` varchar(45) NOT NULL,
  `especie_animal` varchar(45) NOT NULL,
  `raca_animal` varchar(45) NOT NULL,
  `idade_animal` int NOT NULL,
  `peso_animal` float NOT NULL,
  `id_cliente` int NOT NULL,
  `temperatura_animal` int NOT NULL,
  PRIMARY KEY (`id_animal`),
  KEY `FK_Cliente_idx` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura da tabela `atendimento_clinico`
--

DROP TABLE IF EXISTS `atendimento_clinico`;
CREATE TABLE IF NOT EXISTS `atendimento_clinico` (
  `id_atendimento` int NOT NULL,
  `data_atendimento` date NOT NULL,
  `descricao_atendimento` longtext NOT NULL,
  `id_veterinario` int DEFAULT NULL,
  `id_animal` int DEFAULT NULL,
  PRIMARY KEY (`id_atendimento`),
  KEY `FK_animal_idx` (`id_animal`),
  KEY `FK_Vet_idx` (`id_veterinario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cirurgias`
--

DROP TABLE IF EXISTS `cirurgias`;
CREATE TABLE IF NOT EXISTS `cirurgias` (
  `id_cirurgia` int NOT NULL,
  `data_cirurgia` date NOT NULL,
  `tipo_cirurgia` varchar(45) NOT NULL,
  `observacoes` varchar(200) NOT NULL,
  `valor_cirurgia` float NOT NULL,
  `id_animal` int NOT NULL,
  `id_veterinario` int NOT NULL,
  `valor_anestesista` float NOT NULL,
  PRIMARY KEY (`id_cirurgia`),
  KEY `fk_Cirugia_animal_idx` (`id_animal`),
  KEY `Fk_cirugia_veterinario_idx` (`id_veterinario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura da tabela `clientes`
--

DROP TABLE IF EXISTS `clientes`;
CREATE TABLE IF NOT EXISTS `clientes` (
  `id_cliente` int NOT NULL,
  `nome_cliente` varchar(30) NOT NULL,
  `telefone_cliente` varchar(45) NOT NULL,
  `email_cliente` varchar(45) NOT NULL,
  `endereco_cliente` varchar(45) NOT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura da tabela `contas_pagar`
--

DROP TABLE IF EXISTS `contas_pagar`;
CREATE TABLE IF NOT EXISTS `contas_pagar` (
  `id_conta` int NOT NULL,
  `descricao` varchar(45) NOT NULL,
  `valor` float NOT NULL,
  `data_vencimento` date NOT NULL,
  `data_pagamento` date NOT NULL,
  `id_fornecedor` int NOT NULL,
  PRIMARY KEY (`id_conta`),
  KEY `fk_fornecedor_contas_a_Pagar_idx` (`id_fornecedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura da tabela `contas_receber`
--

DROP TABLE IF EXISTS `contas_receber`;
CREATE TABLE IF NOT EXISTS `contas_receber` (
  `id_conta` int NOT NULL,
  `descricao` varchar(45) NOT NULL,
  `valor` float NOT NULL,
  `data_vencimento` date NOT NULL,
  `data_pagamento` date NOT NULL,
  `id_cliente` int NOT NULL,
  `id_atendimento` int NOT NULL,
  `id_cirurgia` int NOT NULL,
  PRIMARY KEY (`id_conta`),
  KEY `fk_ct_a_receber_cliente_idx` (`id_cliente`),
  KEY `fk_atendimento_ct_a_receber_idx` (`id_atendimento`),
  KEY `fk_ct_a_receber_cirugia_idx` (`id_cirurgia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura da tabela `estoque`
--

DROP TABLE IF EXISTS `estoque`;
CREATE TABLE IF NOT EXISTS `estoque` (
  `id_item` int NOT NULL,
  `nome_item` varchar(45) NOT NULL,
  `quantidade` int NOT NULL,
  `unidade_medida` varchar(45) NOT NULL,
  `data_entrada` date NOT NULL,
  `data_validade` date NOT NULL,
  `id_fornecedor` int NOT NULL,
  `valor_unitario` float NOT NULL,
  PRIMARY KEY (`id_item`),
  KEY `fk_estoque_fornecedor_idx` (`id_fornecedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura da tabela `exames`
--

DROP TABLE IF EXISTS `exames`;
CREATE TABLE IF NOT EXISTS `exames` (
  `id_exame` int NOT NULL AUTO_INCREMENT,
  `tipo_exame` varchar(50) NOT NULL,
  `data` date NOT NULL,
  `resultados` varchar(100) NOT NULL,
  `id_animal` int NOT NULL,
  `id_veterinario` int NOT NULL,
  PRIMARY KEY (`id_exame`),
  KEY `fk_animal_exame` (`id_animal`),
  KEY `fk_vet_exame` (`id_veterinario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura da tabela `fornecedores`
--

DROP TABLE IF EXISTS `fornecedores`;
CREATE TABLE IF NOT EXISTS `fornecedores` (
  `id_fornecedor` int NOT NULL,
  `nome_fornecedor` varchar(45) NOT NULL,
  `telefone_fornecedor` varchar(45) NOT NULL,
  `email_fornecedor` varchar(45) NOT NULL,
  PRIMARY KEY (`id_fornecedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura da tabela `funcionarios`
--

DROP TABLE IF EXISTS `funcionarios`;
CREATE TABLE IF NOT EXISTS `funcionarios` (
  `id_funcionario` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `cargo` varchar(50) NOT NULL,
  `salario` decimal(10,2) NOT NULL,
  `carga_horaria` int NOT NULL,
  PRIMARY KEY (`id_funcionario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura da tabela `historico_clinico`
--

DROP TABLE IF EXISTS `historico_clinico`;
CREATE TABLE IF NOT EXISTS `historico_clinico` (
  `id_historico` int NOT NULL AUTO_INCREMENT,
  `id_animal` int NOT NULL,
  `id_servico` int NOT NULL,
  `data_servico` date NOT NULL,
  PRIMARY KEY (`id_historico`),
  KEY `id_animal` (`id_animal`),
  KEY `id_servico` (`id_servico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura da tabela `internacoes`
--

DROP TABLE IF EXISTS `internacoes`;
CREATE TABLE IF NOT EXISTS `internacoes` (
  `id_internacao` int NOT NULL AUTO_INCREMENT,
  `data_entrada` date NOT NULL,
  `data_saida` date NOT NULL,
  `motivo` varchar(100) NOT NULL,
  `tratamento` varchar(100) NOT NULL,
  `id_animal` int NOT NULL,
  `id_veterinario` int NOT NULL,
  PRIMARY KEY (`id_internacao`),
  KEY `id_animal` (`id_animal`),
  KEY `id_veterinario` (`id_veterinario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura da tabela `medicamentos`
--

DROP TABLE IF EXISTS `medicamentos`;
CREATE TABLE IF NOT EXISTS `medicamentos` (
  `id_medicamento` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `principio_ativo` varchar(50) NOT NULL,
  `dosagem` varchar(20) NOT NULL,
  `forma_administracao` varchar(50) NOT NULL,
  PRIMARY KEY (`id_medicamento`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura da tabela `servicos`
--

DROP TABLE IF EXISTS `servicos`;
CREATE TABLE IF NOT EXISTS `servicos` (
  `id_servico` int NOT NULL AUTO_INCREMENT,
  `nome_servico` varchar(50) NOT NULL,
  `valor_servico` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_servico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vacinas`
--

DROP TABLE IF EXISTS `vacinas`;
CREATE TABLE IF NOT EXISTS `vacinas` (
  `id_vacina` int NOT NULL,
  `nome_vacina` varchar(45) NOT NULL,
  `data_aplicacao` date NOT NULL,
  `data_proxima_dose` date NOT NULL,
  `lote_vacina` varchar(45) NOT NULL,
  `fabricante_vacina` varchar(45) NOT NULL,
  `numero_doses` int NOT NULL,
  `dose_atual` int NOT NULL,
  `id_animal` int NOT NULL,
  `id_contas_a_pagar` int NOT NULL,
  PRIMARY KEY (`id_vacina`),
  KEY `fk_animais_idx` (`id_animal`),
  KEY `fk_contas_a_pagar_vacinas_idx` (`id_contas_a_pagar`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura da tabela `veterinarios`
--

DROP TABLE IF EXISTS `veterinarios`;
CREATE TABLE IF NOT EXISTS `veterinarios` (
  `id_veterinario` int NOT NULL,
  `nome_veterinario` varchar(45) NOT NULL,
  `especialidade` varchar(45) NOT NULL,
  `telefone_veterinario` varchar(45) NOT NULL,
  `email_veterinario` varchar(45) NOT NULL,
  `CRMV` int NOT NULL,
  `Senha` varchar(9) NOT NULL,
  PRIMARY KEY (`id_veterinario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `agenda`
--
ALTER TABLE `agenda`
  ADD CONSTRAINT `agenda_ibfk_1` FOREIGN KEY (`id_animal`) REFERENCES `animais` (`id_animal`),
  ADD CONSTRAINT `agenda_ibfk_2` FOREIGN KEY (`id_veterinario`) REFERENCES `veterinarios` (`id_veterinario`),
  ADD CONSTRAINT `agenda_ibfk_3` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionarios` (`id_funcionario`);

--
-- Limitadores para a tabela `atendimento_clinico`
--
ALTER TABLE `atendimento_clinico`
  ADD CONSTRAINT `FK_animal` FOREIGN KEY (`id_animal`) REFERENCES `animais` (`id_animal`),
  ADD CONSTRAINT `FK_Vet` FOREIGN KEY (`id_veterinario`) REFERENCES `veterinarios` (`id_veterinario`);

--
-- Limitadores para a tabela `cirurgias`
--
ALTER TABLE `cirurgias`
  ADD CONSTRAINT `fk_Cirugia_animal` FOREIGN KEY (`id_animal`) REFERENCES `animais` (`id_animal`),
  ADD CONSTRAINT `Fk_cirugia_veterinario` FOREIGN KEY (`id_veterinario`) REFERENCES `veterinarios` (`id_veterinario`);

--
-- Limitadores para a tabela `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `FK_Animais` FOREIGN KEY (`id_cliente`) REFERENCES `animais` (`id_cliente`);

--
-- Limitadores para a tabela `contas_pagar`
--
ALTER TABLE `contas_pagar`
  ADD CONSTRAINT `fk_fornecedor_contas_a_Pagar` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedores` (`id_fornecedor`);

--
-- Limitadores para a tabela `contas_receber`
--
ALTER TABLE `contas_receber`
  ADD CONSTRAINT `fk_atendimento_ct_a_receber` FOREIGN KEY (`id_atendimento`) REFERENCES `atendimento_clinico` (`id_atendimento`),
  ADD CONSTRAINT `fk_ct_a_receber_cirugia` FOREIGN KEY (`id_cirurgia`) REFERENCES `cirurgias` (`id_cirurgia`),
  ADD CONSTRAINT `fk_ct_a_receber_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`);

--
-- Limitadores para a tabela `estoque`
--
ALTER TABLE `estoque`
  ADD CONSTRAINT `fk_estoque_fornecedor` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedores` (`id_fornecedor`);

--
-- Limitadores para a tabela `exames`
--
ALTER TABLE `exames`
  ADD CONSTRAINT `fk_animal_exame` FOREIGN KEY (`id_animal`) REFERENCES `animais` (`id_animal`),
  ADD CONSTRAINT `fk_vet_exame` FOREIGN KEY (`id_veterinario`) REFERENCES `veterinarios` (`id_veterinario`);

--
-- Limitadores para a tabela `historico_clinico`
--
ALTER TABLE `historico_clinico`
  ADD CONSTRAINT `historico_clinico_ibfk_1` FOREIGN KEY (`id_animal`) REFERENCES `animais` (`id_animal`),
  ADD CONSTRAINT `historico_clinico_ibfk_2` FOREIGN KEY (`id_servico`) REFERENCES `servicos` (`id_servico`);

--
-- Limitadores para a tabela `internacoes`
--
ALTER TABLE `internacoes`
  ADD CONSTRAINT `internacoes_ibfk_1` FOREIGN KEY (`id_animal`) REFERENCES `animais` (`id_animal`),
  ADD CONSTRAINT `internacoes_ibfk_2` FOREIGN KEY (`id_veterinario`) REFERENCES `veterinarios` (`id_veterinario`);

--
-- Limitadores para a tabela `vacinas`
--
ALTER TABLE `vacinas`
  ADD CONSTRAINT `fk_animais_vacinas` FOREIGN KEY (`id_animal`) REFERENCES `animais` (`id_animal`),
  ADD CONSTRAINT `fk_contas_a_pagar_vacinas` FOREIGN KEY (`id_contas_a_pagar`) REFERENCES `contas_pagar` (`id_conta`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
