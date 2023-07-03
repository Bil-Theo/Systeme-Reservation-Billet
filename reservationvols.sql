-- phpMyAdmin SQL Dump
-- version 4.5.4.1
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Lun 03 Juillet 2023 à 12:56
-- Version du serveur :  5.7.11
-- Version de PHP :  5.6.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `reservationvols`
--

DELIMITER $$
--
-- Fonctions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `reserver` (`seat` INT, `class` VARCHAR(20), `vol` INT, `client` INT) RETURNS INT(11) BEGIN
	DECLARE v_seat int;
    DECLARE ret int DEFAULT 1;
    
    if class = "Economy" THEN
    	select nbrEco into v_seat from vol WHERE _id =  vol ;
        
        if v_seat >= seat THEN
    		INSERT into reservation values (null, seat, class, vol, client);
            UPDATE vol set nbrEco = nbrEco - seat;
            set ret = 0;
          end if;
     
    ELSEIF class = "Business" THEN
    	select nbrBuz into v_seat from vol WHERE _id =  vol ;
    
   	    if v_seat >= seat THEN
    		INSERT into reservation values (null, seat, class, vol, client);
            UPDATE vol set nbrBuz = nbrBuz - seat;
            set ret = 0;
         end if;
    ELSE
     	select nbr1ereClasse into v_seat from vol WHERE _id =  vol ;
        
        if v_seat >= seat THEN
    		INSERT into reservation values (null, seat, class, vol, client);
            UPDATE vol set nbr1ereClasse = nbr1ereClasse - seat;
            set ret = 0;
        end if;
    END if;

RETURN ret;

end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

CREATE TABLE `reservation` (
  `_id` int(10) NOT NULL,
  `seats` int(10) NOT NULL,
  `class` varchar(15) NOT NULL,
  `_idVol` int(10) NOT NULL,
  `_idClient` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `reservation`
--

INSERT INTO `reservation` (`_id`, `seats`, `class`, `_idVol`, `_idClient`) VALUES
(1, 4, 'Economy', 2, 2),
(3, 2, 'Business', 4, 2),
(4, 2, 'First Class', 5, 2),
(7, 1, 'Economy', 4, 3),
(12, 3, 'Economy', 5, 3),
(18, 3, 'Economy', 10, 3),
(19, 1, 'Economy', 4, 3),
(20, 1, 'Economy', 4, 4),
(21, 2, 'Economy', 12, 2);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `_id` int(10) NOT NULL,
  `nom` varchar(20) NOT NULL,
  `prenom` varchar(25) DEFAULT NULL,
  `email` varchar(30) NOT NULL,
  `motpass` varchar(15) NOT NULL,
  `type` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `utilisateur`
--

INSERT INTO `utilisateur` (`_id`, `nom`, `prenom`, `email`, `motpass`, `type`) VALUES
(1, 'ITOUA', 'Bil Theo', 'biltheoitoua@hotmail.com', '12345', 'admin'),
(2, 'NGalomi', 'Bts', 'biltheoitoua@gmail.com', '12345N', 'customer'),
(3, 'Mahamat', 'saleh', 'salehindev@gmail.com', '12345', 'customer'),
(4, 'Mahamat iss', 'sale', 'salehindev@salehindev.com', 'aaaa', 'customer');

-- --------------------------------------------------------

--
-- Structure de la table `vol`
--

CREATE TABLE `vol` (
  `_id` int(10) NOT NULL,
  `volNom` varchar(10) NOT NULL,
  `villeDep` varchar(20) NOT NULL,
  `villeArr` varchar(20) NOT NULL,
  `dateDep` date NOT NULL,
  `dateArr` date NOT NULL,
  `nbrEco` int(5) NOT NULL,
  `nbrBuz` int(5) NOT NULL,
  `nbr1ereClasse` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `vol`
--

INSERT INTO `vol` (`_id`, `volNom`, `villeDep`, `villeArr`, `dateDep`, `dateArr`, `nbrEco`, `nbrBuz`, `nbr1ereClasse`) VALUES
(2, 'fk-0023', 'Shanghai', 'Lyon', '2023-06-18', '2023-06-21', -1, 10, 3),
(3, 'fk-133', 'Kinshasa', 'Moscow', '2023-02-01', '2023-06-03', -9, 15, 4),
(4, 'fk-02673', 'Alger', 'Lyon', '2023-08-18', '2023-06-19', 16, 20, 4),
(5, 'fk-1810', 'Paris', 'Oran', '2023-12-25', '2023-12-25', 0, 20, 4),
(7, 'fk-009', 'Tokyo', 'Lyon', '2023-06-30', '2023-07-02', 15, 15, 5),
(10, 'fk-47567', 'Alger', 'Ndjamena', '2023-06-30', '2023-06-30', 15, 15, 10);

--
-- Index pour les tables exportées
--

--
-- Index pour la table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`_id`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `vol`
--
ALTER TABLE `vol`
  ADD PRIMARY KEY (`_id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `vol`
--
ALTER TABLE `vol`
  MODIFY `_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
