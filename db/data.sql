CREATE DATABASE  IF NOT EXISTS `voyage` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `voyage`;
-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: voyage_2
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assoc_pays_periodes_types`
--

DROP TABLE IF EXISTS `assoc_pays_periodes_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assoc_pays_periodes_types` (
  `id_pays` int(11) NOT NULL,
  `id_periodes` int(11) NOT NULL,
  `is_ok` tinyint(4) NOT NULL,
  `id_type` int(11) NOT NULL,
  PRIMARY KEY (`id_pays`,`id_periodes`,`id_type`),
  KEY `fk_assoc_pays_periodes_types_2_idx` (`id_periodes`),
  KEY `fk_assoc_pays_periodes_types_3_idx` (`id_type`),
  CONSTRAINT `fk_assoc_pays_periodes_types_1` FOREIGN KEY (`id_pays`) REFERENCES `pays` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_assoc_pays_periodes_types_2` FOREIGN KEY (`id_periodes`) REFERENCES `periodes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_assoc_pays_periodes_types_3` FOREIGN KEY (`id_type`) REFERENCES `types` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assoc_pays_periodes_types`
--

LOCK TABLES `assoc_pays_periodes_types` WRITE;
/*!40000 ALTER TABLE `assoc_pays_periodes_types` DISABLE KEYS */;
INSERT INTO `assoc_pays_periodes_types` VALUES (1,1,1,1),(1,1,1,2),(1,2,1,1),(1,3,1,1),(1,6,0,1),(1,7,0,1),(1,8,0,1),(2,1,1,1),(2,2,1,1),(2,3,1,1),(2,5,0,1),(2,6,0,1),(2,7,0,1),(2,8,0,1),(2,10,1,1),(3,1,1,1),(3,2,1,1),(3,7,0,1),(3,8,0,1),(3,9,0,1),(3,12,1,1),(4,3,0,1),(4,6,1,1),(4,7,1,1),(4,8,1,1),(4,11,0,1),(4,12,0,1),(5,1,1,1),(5,2,1,1),(5,3,1,1),(5,6,0,1),(5,7,0,1),(5,8,0,1),(6,1,0,1),(6,2,0,1),(6,3,1,1),(6,4,1,1),(6,5,1,1),(6,9,0,1);
/*!40000 ALTER TABLE `assoc_pays_periodes_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pays`
--

DROP TABLE IF EXISTS `pays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `capital` varchar(255) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  `nameFr` varchar(255) DEFAULT NULL,
  `flag` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1090 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pays`
--

LOCK TABLES `pays` WRITE;
/*!40000 ALTER TABLE `pays` DISABLE KEYS */;
INSERT INTO `pays` VALUES (1,'GUADELOUPE',NULL,NULL,NULL,NULL,NULL),(2,'Le CAP',NULL,NULL,NULL,NULL,NULL),(3,'SENEGAL',NULL,NULL,NULL,NULL,NULL),(4,'BRESIL',NULL,NULL,NULL,NULL,NULL),(5,'CUBA',NULL,NULL,NULL,NULL,NULL),(6,'MEXIQUE',NULL,NULL,NULL,NULL,NULL),(7,'CAMBODGE',NULL,NULL,NULL,NULL,NULL),(8,'SRI LANKA',NULL,NULL,NULL,NULL,NULL),(9,'CHYPRE',NULL,NULL,NULL,NULL,NULL),(10,'ILE MAURICE',NULL,NULL,NULL,NULL,NULL),(11,'BENIN',NULL,NULL,NULL,NULL,NULL),(12,'ARGENTINE',NULL,NULL,NULL,NULL,NULL),(13,'CHILI',NULL,NULL,NULL,NULL,NULL),(14,'ESPAGNE',NULL,NULL,NULL,NULL,NULL),(15,'NORVEGE',NULL,NULL,NULL,NULL,NULL),(16,'POLYNESIE FRANCAISE',NULL,NULL,NULL,NULL,NULL),(17,'AUSTRALIE',NULL,NULL,NULL,NULL,NULL),(18,'MARTINIQUE',NULL,NULL,NULL,NULL,NULL),(840,'Afghanistan','Kabul','Asia','AFG','Afghanistan','https://restcountries.eu/data/afg.svg'),(841,'Aland Islands','Mariehamn','Europe','ALA','Åland','https://restcountries.eu/data/ala.svg'),(842,'Albania','Tirana','Europe','ALB','Albanie','https://restcountries.eu/data/alb.svg'),(843,'Algeria','Algiers','Africa','DZA','Algérie','https://restcountries.eu/data/dza.svg'),(844,'American Samoa','Pago Pago','Oceania','ASM','Samoa américaines','https://restcountries.eu/data/asm.svg'),(845,'Andorra','Andorra la Vella','Europe','AND','Andorre','https://restcountries.eu/data/and.svg'),(846,'Angola','Luanda','Africa','AGO','Angola','https://restcountries.eu/data/ago.svg'),(847,'Anguilla','The Valley','Americas','AIA','Anguilla','https://restcountries.eu/data/aia.svg'),(848,'Antarctica','','Polar','ATA','Antarctique','https://restcountries.eu/data/ata.svg'),(849,'Antigua and Barbuda','Saint John\'s','Americas','ATG','Antigua-et-Barbuda','https://restcountries.eu/data/atg.svg'),(850,'Argentina','Buenos Aires','Americas','ARG','Argentine','https://restcountries.eu/data/arg.svg'),(851,'Armenia','Yerevan','Asia','ARM','Arménie','https://restcountries.eu/data/arm.svg'),(852,'Aruba','Oranjestad','Americas','ABW','Aruba','https://restcountries.eu/data/abw.svg'),(853,'Australia','Canberra','Oceania','AUS','Australie','https://restcountries.eu/data/aus.svg'),(854,'Austria','Vienna','Europe','AUT','Autriche','https://restcountries.eu/data/aut.svg'),(855,'Azerbaijan','Baku','Asia','AZE','Azerbaïdjan','https://restcountries.eu/data/aze.svg'),(856,'Bahamas','Nassau','Americas','BHS','Bahamas','https://restcountries.eu/data/bhs.svg'),(857,'Bahrain','Manama','Asia','BHR','Bahreïn','https://restcountries.eu/data/bhr.svg'),(858,'Bangladesh','Dhaka','Asia','BGD','Bangladesh','https://restcountries.eu/data/bgd.svg'),(859,'Barbados','Bridgetown','Americas','BRB','Barbade','https://restcountries.eu/data/brb.svg'),(860,'Belarus','Minsk','Europe','BLR','Biélorussie','https://restcountries.eu/data/blr.svg'),(861,'Belgium','Brussels','Europe','BEL','Belgique','https://restcountries.eu/data/bel.svg'),(862,'Belize','Belmopan','Americas','BLZ','Belize','https://restcountries.eu/data/blz.svg'),(863,'Benin','Porto-Novo','Africa','BEN','Bénin','https://restcountries.eu/data/ben.svg'),(864,'Bermuda','Hamilton','Americas','BMU','Bermudes','https://restcountries.eu/data/bmu.svg'),(865,'Bhutan','Thimphu','Asia','BTN','Bhoutan','https://restcountries.eu/data/btn.svg'),(866,'Bolivia (Plurinational State of)','Sucre','Americas','BOL','Bolivie','https://restcountries.eu/data/bol.svg'),(867,'Bonaire, Sint Eustatius and Saba','Kralendijk','Americas','BES','Bonaire, Saint-Eustache et Saba','https://restcountries.eu/data/bes.svg'),(868,'Bosnia and Herzegovina','Sarajevo','Europe','BIH','Bosnie-Herzégovine','https://restcountries.eu/data/bih.svg'),(869,'Botswana','Gaborone','Africa','BWA','Botswana','https://restcountries.eu/data/bwa.svg'),(870,'Bouvet Island','','','BVT','Île Bouvet','https://restcountries.eu/data/bvt.svg'),(871,'Brazil','Brasilia','Americas','BRA','Brésil','https://restcountries.eu/data/bra.svg'),(872,'British Indian Ocean Territory','Diego Garcia','Africa','IOT','Territoire britannique de l\'océan Indien','https://restcountries.eu/data/iot.svg'),(873,'United States Minor Outlying Islands','','Americas','UMI','Îles mineures éloignées des États-Unis','https://restcountries.eu/data/umi.svg'),(874,'Virgin Islands (British)','Road Town','Americas','VGB','Îles Vierges britanniques','https://restcountries.eu/data/vgb.svg'),(875,'Virgin Islands (U.S.)','Charlotte Amalie','Americas','VIR','Îles Vierges des États-Unis','https://restcountries.eu/data/vir.svg'),(876,'Brunei Darussalam','Bandar Seri Begawan','Asia','BRN','Brunei','https://restcountries.eu/data/brn.svg'),(877,'Bulgaria','Sofia','Europe','BGR','Bulgarie','https://restcountries.eu/data/bgr.svg'),(878,'Burkina Faso','Ouagadougou','Africa','BFA','Burkina Faso','https://restcountries.eu/data/bfa.svg'),(879,'Burundi','Bujumbura','Africa','BDI','Burundi','https://restcountries.eu/data/bdi.svg'),(880,'Cambodia','Phnom Penh','Asia','KHM','Cambodge','https://restcountries.eu/data/khm.svg'),(881,'Cameroon','Yaounde','Africa','CMR','Cameroun','https://restcountries.eu/data/cmr.svg'),(882,'Canada','Ottawa','Americas','CAN','Canada','https://restcountries.eu/data/can.svg'),(883,'Cabo Verde','Praia','Africa','CPV','Cap Vert','https://restcountries.eu/data/cpv.svg'),(884,'Cayman Islands','George Town','Americas','CYM','Îles Caïmans','https://restcountries.eu/data/cym.svg'),(885,'Central African Republic','Bangui','Africa','CAF','République centrafricaine','https://restcountries.eu/data/caf.svg'),(886,'Chad','N\'Djamena','Africa','TCD','Tchad','https://restcountries.eu/data/tcd.svg'),(887,'Chile','Santiago','Americas','CHL','Chili','https://restcountries.eu/data/chl.svg'),(888,'China','Beijing','Asia','CHN','Chine','https://restcountries.eu/data/chn.svg'),(889,'Christmas Island','Flying Fish Cove','Oceania','CXR','Île Christmas','https://restcountries.eu/data/cxr.svg'),(890,'Cocos (Keeling) Islands','West Island','Oceania','CCK','Îles Cocos','https://restcountries.eu/data/cck.svg'),(891,'Colombia','Bogota','Americas','COL','Colombie','https://restcountries.eu/data/col.svg'),(892,'Comoros','Moroni','Africa','COM','Comores','https://restcountries.eu/data/com.svg'),(893,'Congo','Brazzaville','Africa','COG','Congo','https://restcountries.eu/data/cog.svg'),(894,'Congo (Democratic Republic of the)','Kinshasa','Africa','COD','Congo (Rép. dém.)','https://restcountries.eu/data/cod.svg'),(895,'Cook Islands','Avarua','Oceania','COK','Îles Cook','https://restcountries.eu/data/cok.svg'),(896,'Costa Rica','San Jose','Americas','CRI','Costa Rica','https://restcountries.eu/data/cri.svg'),(897,'Croatia','Zagreb','Europe','HRV','Croatie','https://restcountries.eu/data/hrv.svg'),(898,'Cuba','Havana','Americas','CUB','Cuba','https://restcountries.eu/data/cub.svg'),(899,'Curacao','Willemstad','Americas','CUW','Curaçao','https://restcountries.eu/data/cuw.svg'),(900,'Cyprus','Nicosia','Europe','CYP','Chypre','https://restcountries.eu/data/cyp.svg'),(901,'Czech Republic','Prague','Europe','CZE','République tchèque','https://restcountries.eu/data/cze.svg'),(902,'Denmark','Copenhagen','Europe','DNK','Danemark','https://restcountries.eu/data/dnk.svg'),(903,'Djibouti','Djibouti','Africa','DJI','Djibouti','https://restcountries.eu/data/dji.svg'),(904,'Dominica','Roseau','Americas','DMA','Dominique','https://restcountries.eu/data/dma.svg'),(905,'Dominican Republic','Santo Domingo','Americas','DOM','République dominicaine','https://restcountries.eu/data/dom.svg'),(906,'Ecuador','Quito','Americas','ECU','Équateur','https://restcountries.eu/data/ecu.svg'),(907,'Egypt','Cairo','Africa','EGY','Égypte','https://restcountries.eu/data/egy.svg'),(908,'El Salvador','San Salvador','Americas','SLV','Salvador','https://restcountries.eu/data/slv.svg'),(909,'Equatorial Guinea','Malabo','Africa','GNQ','Guinée-Équatoriale','https://restcountries.eu/data/gnq.svg'),(910,'Eritrea','Asmara','Africa','ERI','Érythrée','https://restcountries.eu/data/eri.svg'),(911,'Estonia','Tallinn','Europe','EST','Estonie','https://restcountries.eu/data/est.svg'),(912,'Ethiopia','Addis Ababa','Africa','ETH','Éthiopie','https://restcountries.eu/data/eth.svg'),(913,'Falkland Islands (Malvinas)','Stanley','Americas','FLK','Îles Malouines','https://restcountries.eu/data/flk.svg'),(914,'Faroe Islands','Torshavn','Europe','FRO','Îles Féroé','https://restcountries.eu/data/fro.svg'),(915,'Fiji','Suva','Oceania','FJI','Fidji','https://restcountries.eu/data/fji.svg'),(916,'Finland','Helsinki','Europe','FIN','Finlande','https://restcountries.eu/data/fin.svg'),(917,'France','Paris','Europe','FRA','France','https://restcountries.eu/data/fra.svg'),(918,'French Guiana','Cayenne','Americas','GUF','Guayane','https://restcountries.eu/data/guf.svg'),(919,'French Polynesia','Papeete','Oceania','PYF','Polynésie française','https://restcountries.eu/data/pyf.svg'),(920,'French Southern Territories','Port-aux-Francais','Africa','ATF','Terres australes et antarctiques françaises','https://restcountries.eu/data/atf.svg'),(921,'Gabon','Libreville','Africa','GAB','Gabon','https://restcountries.eu/data/gab.svg'),(922,'Gambia','Banjul','Africa','GMB','Gambie','https://restcountries.eu/data/gmb.svg'),(923,'Georgia','Tbilisi','Asia','GEO','Géorgie','https://restcountries.eu/data/geo.svg'),(924,'Germany','Berlin','Europe','DEU','Allemagne','https://restcountries.eu/data/deu.svg'),(925,'Ghana','Accra','Africa','GHA','Ghana','https://restcountries.eu/data/gha.svg'),(926,'Gibraltar','Gibraltar','Europe','GIB','Gibraltar','https://restcountries.eu/data/gib.svg'),(927,'Greece','Athens','Europe','GRC','Grèce','https://restcountries.eu/data/grc.svg'),(928,'Greenland','Nuuk','Americas','GRL','Groenland','https://restcountries.eu/data/grl.svg'),(929,'Grenada','St. George\'s','Americas','GRD','Grenade','https://restcountries.eu/data/grd.svg'),(930,'Guadeloupe','Basse-Terre','Americas','GLP','Guadeloupe','https://restcountries.eu/data/glp.svg'),(931,'Guam','Hagatna','Oceania','GUM','Guam','https://restcountries.eu/data/gum.svg'),(932,'Guatemala','Guatemala City','Americas','GTM','Guatemala','https://restcountries.eu/data/gtm.svg'),(933,'Guernsey','St. Peter Port','Europe','GGY','Guernesey','https://restcountries.eu/data/ggy.svg'),(934,'Guinea','Conakry','Africa','GIN','Guinée','https://restcountries.eu/data/gin.svg'),(935,'Guinea-Bissau','Bissau','Africa','GNB','Guinée-Bissau','https://restcountries.eu/data/gnb.svg'),(936,'Guyana','Georgetown','Americas','GUY','Guyane','https://restcountries.eu/data/guy.svg'),(937,'Haiti','Port-au-Prince','Americas','HTI','Haïti','https://restcountries.eu/data/hti.svg'),(938,'Heard Island and McDonald Islands','','','HMD','Îles Heard-et-MacDonald','https://restcountries.eu/data/hmd.svg'),(939,'Holy See','Rome','Europe','VAT','voir Saint','https://restcountries.eu/data/vat.svg'),(940,'Honduras','Tegucigalpa','Americas','HND','Honduras','https://restcountries.eu/data/hnd.svg'),(941,'Hong Kong','City of Victoria','Asia','HKG','Hong Kong','https://restcountries.eu/data/hkg.svg'),(942,'Hungary','Budapest','Europe','HUN','Hongrie','https://restcountries.eu/data/hun.svg'),(943,'Iceland','Reykjavik','Europe','ISL','Islande','https://restcountries.eu/data/isl.svg'),(944,'India','New Delhi','Asia','IND','Inde','https://restcountries.eu/data/ind.svg'),(945,'Indonesia','Jakarta','Asia','IDN','Indonésie','https://restcountries.eu/data/idn.svg'),(946,'Cote d\'Ivoire','Yamoussoukro','Africa','CIV','Côte d\'Ivoire','https://restcountries.eu/data/civ.svg'),(947,'Iran (Islamic Republic of)','Tehran','Asia','IRN','Iran','https://restcountries.eu/data/irn.svg'),(948,'Iraq','Baghdad','Asia','IRQ','Irak','https://restcountries.eu/data/irq.svg'),(949,'Ireland','Dublin','Europe','IRL','Irlande','https://restcountries.eu/data/irl.svg'),(950,'Isle of Man','Douglas','Europe','IMN','Île de Man','https://restcountries.eu/data/imn.svg'),(951,'Israel','Jerusalem','Asia','ISR','Israël','https://restcountries.eu/data/isr.svg'),(952,'Italy','Rome','Europe','ITA','Italie','https://restcountries.eu/data/ita.svg'),(953,'Jamaica','Kingston','Americas','JAM','Jamaïque','https://restcountries.eu/data/jam.svg'),(954,'Japan','Tokyo','Asia','JPN','Japon','https://restcountries.eu/data/jpn.svg'),(955,'Jersey','Saint Helier','Europe','JEY','Jersey','https://restcountries.eu/data/jey.svg'),(956,'Jordan','Amman','Asia','JOR','Jordanie','https://restcountries.eu/data/jor.svg'),(957,'Kazakhstan','Astana','Asia','KAZ','Kazakhstan','https://restcountries.eu/data/kaz.svg'),(958,'Kenya','Nairobi','Africa','KEN','Kenya','https://restcountries.eu/data/ken.svg'),(959,'Kiribati','South Tarawa','Oceania','KIR','Kiribati','https://restcountries.eu/data/kir.svg'),(960,'Kuwait','Kuwait City','Asia','KWT','Koweït','https://restcountries.eu/data/kwt.svg'),(961,'Kyrgyzstan','Bishkek','Asia','KGZ','Kirghizistan','https://restcountries.eu/data/kgz.svg'),(962,'Lao People\'s Democratic Republic','Vientiane','Asia','LAO','Laos','https://restcountries.eu/data/lao.svg'),(963,'Latvia','Riga','Europe','LVA','Lettonie','https://restcountries.eu/data/lva.svg'),(964,'Lebanon','Beirut','Asia','LBN','Liban','https://restcountries.eu/data/lbn.svg'),(965,'Lesotho','Maseru','Africa','LSO','Lesotho','https://restcountries.eu/data/lso.svg'),(966,'Liberia','Monrovia','Africa','LBR','Liberia','https://restcountries.eu/data/lbr.svg'),(967,'Libya','Tripoli','Africa','LBY','Libye','https://restcountries.eu/data/lby.svg'),(968,'Liechtenstein','Vaduz','Europe','LIE','Liechtenstein','https://restcountries.eu/data/lie.svg'),(969,'Lithuania','Vilnius','Europe','LTU','Lituanie','https://restcountries.eu/data/ltu.svg'),(970,'Luxembourg','Luxembourg','Europe','LUX','Luxembourg','https://restcountries.eu/data/lux.svg'),(971,'Macao','','Asia','MAC','Macao','https://restcountries.eu/data/mac.svg'),(972,'Macedonia (the former Yugoslav Republic of)','Skopje','Europe','MKD','Macédoine','https://restcountries.eu/data/mkd.svg'),(973,'Madagascar','Antananarivo','Africa','MDG','Madagascar','https://restcountries.eu/data/mdg.svg'),(974,'Malawi','Lilongwe','Africa','MWI','Malawi','https://restcountries.eu/data/mwi.svg'),(975,'Malaysia','Kuala Lumpur','Asia','MYS','Malaisie','https://restcountries.eu/data/mys.svg'),(976,'Maldives','Male','Asia','MDV','Maldives','https://restcountries.eu/data/mdv.svg'),(977,'Mali','Bamako','Africa','MLI','Mali','https://restcountries.eu/data/mli.svg'),(978,'Malta','Valletta','Europe','MLT','Malte','https://restcountries.eu/data/mlt.svg'),(979,'Marshall Islands','Majuro','Oceania','MHL','Îles Marshall','https://restcountries.eu/data/mhl.svg'),(980,'Martinique','Fort-de-France','Americas','MTQ','Martinique','https://restcountries.eu/data/mtq.svg'),(981,'Mauritania','Nouakchott','Africa','MRT','Mauritanie','https://restcountries.eu/data/mrt.svg'),(982,'Mauritius','Port Louis','Africa','MUS','Île Maurice','https://restcountries.eu/data/mus.svg'),(983,'Mayotte','Mamoudzou','Africa','MYT','Mayotte','https://restcountries.eu/data/myt.svg'),(984,'Mexico','Mexico City','Americas','MEX','Mexique','https://restcountries.eu/data/mex.svg'),(985,'Micronesia (Federated States of)','Palikir','Oceania','FSM','Micronésie','https://restcountries.eu/data/fsm.svg'),(986,'Moldova (Republic of)','Chisinau','Europe','MDA','Moldavie','https://restcountries.eu/data/mda.svg'),(987,'Monaco','Monaco','Europe','MCO','Monaco','https://restcountries.eu/data/mco.svg'),(988,'Mongolia','Ulan Bator','Asia','MNG','Mongolie','https://restcountries.eu/data/mng.svg'),(989,'Montenegro','Podgorica','Europe','MNE','Monténégro','https://restcountries.eu/data/mne.svg'),(990,'Montserrat','Plymouth','Americas','MSR','Montserrat','https://restcountries.eu/data/msr.svg'),(991,'Morocco','Rabat','Africa','MAR','Maroc','https://restcountries.eu/data/mar.svg'),(992,'Mozambique','Maputo','Africa','MOZ','Mozambique','https://restcountries.eu/data/moz.svg'),(993,'Myanmar','Naypyidaw','Asia','MMR','Myanmar','https://restcountries.eu/data/mmr.svg'),(994,'Namibia','Windhoek','Africa','NAM','Namibie','https://restcountries.eu/data/nam.svg'),(995,'Nauru','Yaren','Oceania','NRU','Nauru','https://restcountries.eu/data/nru.svg'),(996,'Nepal','Kathmandu','Asia','NPL','Népal','https://restcountries.eu/data/npl.svg'),(997,'Netherlands','Amsterdam','Europe','NLD','Pays-Bas','https://restcountries.eu/data/nld.svg'),(998,'New Caledonia','Noumea','Oceania','NCL','Nouvelle-Calédonie','https://restcountries.eu/data/ncl.svg'),(999,'New Zealand','Wellington','Oceania','NZL','Nouvelle-Zélande','https://restcountries.eu/data/nzl.svg'),(1000,'Nicaragua','Managua','Americas','NIC','Nicaragua','https://restcountries.eu/data/nic.svg'),(1001,'Niger','Niamey','Africa','NER','Niger','https://restcountries.eu/data/ner.svg'),(1002,'Nigeria','Abuja','Africa','NGA','Nigéria','https://restcountries.eu/data/nga.svg'),(1003,'Niue','Alofi','Oceania','NIU','Niue','https://restcountries.eu/data/niu.svg'),(1004,'Norfolk Island','Kingston','Oceania','NFK','Île de Norfolk','https://restcountries.eu/data/nfk.svg'),(1005,'Korea (Democratic People\'s Republic of)','Pyongyang','Asia','PRK','Corée du Nord','https://restcountries.eu/data/prk.svg'),(1006,'Northern Mariana Islands','Saipan','Oceania','MNP','Îles Mariannes du Nord','https://restcountries.eu/data/mnp.svg'),(1007,'Norway','Oslo','Europe','NOR','Norvège','https://restcountries.eu/data/nor.svg'),(1008,'Oman','Muscat','Asia','OMN','Oman','https://restcountries.eu/data/omn.svg'),(1009,'Pakistan','Islamabad','Asia','PAK','Pakistan','https://restcountries.eu/data/pak.svg'),(1010,'Palau','Ngerulmud','Oceania','PLW','Palaos','https://restcountries.eu/data/plw.svg'),(1011,'Palestine, State of','Ramallah','Asia','PSE','Palestine','https://restcountries.eu/data/pse.svg'),(1012,'Panama','Panama City','Americas','PAN','Panama','https://restcountries.eu/data/pan.svg'),(1013,'Papua New Guinea','Port Moresby','Oceania','PNG','Papouasie-Nouvelle-Guinée','https://restcountries.eu/data/png.svg'),(1014,'Paraguay','Asuncion','Americas','PRY','Paraguay','https://restcountries.eu/data/pry.svg'),(1015,'Peru','Lima','Americas','PER','Pérou','https://restcountries.eu/data/per.svg'),(1016,'Philippines','Manila','Asia','PHL','Philippines','https://restcountries.eu/data/phl.svg'),(1017,'Pitcairn','Adamstown','Oceania','PCN','Îles Pitcairn','https://restcountries.eu/data/pcn.svg'),(1018,'Poland','Warsaw','Europe','POL','Pologne','https://restcountries.eu/data/pol.svg'),(1019,'Portugal','Lisbon','Europe','PRT','Portugal','https://restcountries.eu/data/prt.svg'),(1020,'Puerto Rico','San Juan','Americas','PRI','Porto Rico','https://restcountries.eu/data/pri.svg'),(1021,'Qatar','Doha','Asia','QAT','Qatar','https://restcountries.eu/data/qat.svg'),(1022,'Republic of Kosovo','Pristina','Europe','KOS',NULL,'https://restcountries.eu/data/kos.svg'),(1023,'Reunion','Saint-Denis','Africa','REU','Réunion','https://restcountries.eu/data/reu.svg'),(1024,'Romania','Bucharest','Europe','ROU','Roumanie','https://restcountries.eu/data/rou.svg'),(1025,'Russian Federation','Moscow','Europe','RUS','Russie','https://restcountries.eu/data/rus.svg'),(1026,'Rwanda','Kigali','Africa','RWA','Rwanda','https://restcountries.eu/data/rwa.svg'),(1027,'Saint Barthelemy','Gustavia','Americas','BLM','Saint-Barthélemy','https://restcountries.eu/data/blm.svg'),(1028,'Saint Helena, Ascension and Tristan da Cunha','Jamestown','Africa','SHN','Sainte-Hélène','https://restcountries.eu/data/shn.svg'),(1029,'Saint Kitts and Nevis','Basseterre','Americas','KNA','Saint-Christophe-et-Niévès','https://restcountries.eu/data/kna.svg'),(1030,'Saint Lucia','Castries','Americas','LCA','Saint-Lucie','https://restcountries.eu/data/lca.svg'),(1031,'Saint Martin (French part)','Marigot','Americas','MAF','Saint-Martin','https://restcountries.eu/data/maf.svg'),(1032,'Saint Pierre and Miquelon','Saint-Pierre','Americas','SPM','Saint-Pierre-et-Miquelon','https://restcountries.eu/data/spm.svg'),(1033,'Saint Vincent and the Grenadines','Kingstown','Americas','VCT','Saint-Vincent-et-les-Grenadines','https://restcountries.eu/data/vct.svg'),(1034,'Samoa','Apia','Oceania','WSM','Samoa','https://restcountries.eu/data/wsm.svg'),(1035,'San Marino','City of San Marino','Europe','SMR','Saint-Marin','https://restcountries.eu/data/smr.svg'),(1036,'Sao Tome and Principe','Sao Tome','Africa','STP','Sao Tomé-et-Principe','https://restcountries.eu/data/stp.svg'),(1037,'Saudi Arabia','Riyadh','Asia','SAU','Arabie Saoudite','https://restcountries.eu/data/sau.svg'),(1038,'Senegal','Dakar','Africa','SEN','Sénégal','https://restcountries.eu/data/sen.svg'),(1039,'Serbia','Belgrade','Europe','SRB','Serbie','https://restcountries.eu/data/srb.svg'),(1040,'Seychelles','Victoria','Africa','SYC','Seychelles','https://restcountries.eu/data/syc.svg'),(1041,'Sierra Leone','Freetown','Africa','SLE','Sierra Leone','https://restcountries.eu/data/sle.svg'),(1042,'Singapore','Singapore','Asia','SGP','Singapour','https://restcountries.eu/data/sgp.svg'),(1043,'Sint Maarten (Dutch part)','Philipsburg','Americas','SXM','Saint Martin (partie néerlandaise)','https://restcountries.eu/data/sxm.svg'),(1044,'Slovakia','Bratislava','Europe','SVK','Slovaquie','https://restcountries.eu/data/svk.svg'),(1045,'Slovenia','Ljubljana','Europe','SVN','Slovénie','https://restcountries.eu/data/svn.svg'),(1046,'Solomon Islands','Honiara','Oceania','SLB','Îles Salomon','https://restcountries.eu/data/slb.svg'),(1047,'Somalia','Mogadishu','Africa','SOM','Somalie','https://restcountries.eu/data/som.svg'),(1048,'South Africa','Pretoria','Africa','ZAF','Afrique du Sud','https://restcountries.eu/data/zaf.svg'),(1049,'South Georgia and the South Sandwich Islands','King Edward Point','Americas','SGS','Géorgie du Sud-et-les Îles Sandwich du Sud','https://restcountries.eu/data/sgs.svg'),(1050,'Korea (Republic of)','Seoul','Asia','KOR','Corée du Sud','https://restcountries.eu/data/kor.svg'),(1051,'South Sudan','Juba','Africa','SSD','Soudan du Sud','https://restcountries.eu/data/ssd.svg'),(1052,'Spain','Madrid','Europe','ESP','Espagne','https://restcountries.eu/data/esp.svg'),(1053,'Sri Lanka','Colombo','Asia','LKA','Sri Lanka','https://restcountries.eu/data/lka.svg'),(1054,'Sudan','Khartoum','Africa','SDN','Soudan','https://restcountries.eu/data/sdn.svg'),(1055,'Suriname','Paramaribo','Americas','SUR','Surinam','https://restcountries.eu/data/sur.svg'),(1056,'Svalbard and Jan Mayen','Longyearbyen','Europe','SJM','Svalbard et Jan Mayen','https://restcountries.eu/data/sjm.svg'),(1057,'Swaziland','Lobamba','Africa','SWZ','Swaziland','https://restcountries.eu/data/swz.svg'),(1058,'Sweden','Stockholm','Europe','SWE','Suède','https://restcountries.eu/data/swe.svg'),(1059,'Switzerland','Bern','Europe','CHE','Suisse','https://restcountries.eu/data/che.svg'),(1060,'Syrian Arab Republic','Damascus','Asia','SYR','Syrie','https://restcountries.eu/data/syr.svg'),(1061,'Taiwan','Taipei','Asia','TWN','Taïwan','https://restcountries.eu/data/twn.svg'),(1062,'Tajikistan','Dushanbe','Asia','TJK','Tadjikistan','https://restcountries.eu/data/tjk.svg'),(1063,'Tanzania, United Republic of','Dodoma','Africa','TZA','Tanzanie','https://restcountries.eu/data/tza.svg'),(1064,'Thailand','Bangkok','Asia','THA','Thaïlande','https://restcountries.eu/data/tha.svg'),(1065,'Timor-Leste','Dili','Asia','TLS','Timor oriental','https://restcountries.eu/data/tls.svg'),(1066,'Togo','Lome','Africa','TGO','Togo','https://restcountries.eu/data/tgo.svg'),(1067,'Tokelau','Fakaofo','Oceania','TKL','Tokelau','https://restcountries.eu/data/tkl.svg'),(1068,'Tonga','Nuku\'alofa','Oceania','TON','Tonga','https://restcountries.eu/data/ton.svg'),(1069,'Trinidad and Tobago','Port of Spain','Americas','TTO','Trinité et Tobago','https://restcountries.eu/data/tto.svg'),(1070,'Tunisia','Tunis','Africa','TUN','Tunisie','https://restcountries.eu/data/tun.svg'),(1071,'Turkey','Ankara','Asia','TUR','Turquie','https://restcountries.eu/data/tur.svg'),(1072,'Turkmenistan','Ashgabat','Asia','TKM','Turkménistan','https://restcountries.eu/data/tkm.svg'),(1073,'Turks and Caicos Islands','Cockburn Town','Americas','TCA','Îles Turques-et-Caïques','https://restcountries.eu/data/tca.svg'),(1074,'Tuvalu','Funafuti','Oceania','TUV','Tuvalu','https://restcountries.eu/data/tuv.svg'),(1075,'Uganda','Kampala','Africa','UGA','Uganda','https://restcountries.eu/data/uga.svg'),(1076,'Ukraine','Kiev','Europe','UKR','Ukraine','https://restcountries.eu/data/ukr.svg'),(1077,'United Arab Emirates','Abu Dhabi','Asia','ARE','Émirats arabes unis','https://restcountries.eu/data/are.svg'),(1078,'United Kingdom of Great Britain and Northern Ireland','London','Europe','GBR','Royaume-Uni','https://restcountries.eu/data/gbr.svg'),(1079,'United States of America','Washington, D.C.','Americas','USA','États-Unis','https://restcountries.eu/data/usa.svg'),(1080,'Uruguay','Montevideo','Americas','URY','Uruguay','https://restcountries.eu/data/ury.svg'),(1081,'Uzbekistan','Tashkent','Asia','UZB','Ouzbékistan','https://restcountries.eu/data/uzb.svg'),(1082,'Vanuatu','Port Vila','Oceania','VUT','Vanuatu','https://restcountries.eu/data/vut.svg'),(1083,'Venezuela (Bolivarian Republic of)','Caracas','Americas','VEN','Venezuela','https://restcountries.eu/data/ven.svg'),(1084,'Viet Nam','Hanoi','Asia','VNM','Viêt Nam','https://restcountries.eu/data/vnm.svg'),(1085,'Wallis and Futuna','Mata-Utu','Oceania','WLF','Wallis-et-Futuna','https://restcountries.eu/data/wlf.svg'),(1086,'Western Sahara','El Aaiun','Africa','ESH','Sahara Occidental','https://restcountries.eu/data/esh.svg'),(1087,'Yemen','Sana\'a','Asia','YEM','Yémen','https://restcountries.eu/data/yem.svg'),(1088,'Zambia','Lusaka','Africa','ZMB','Zambie','https://restcountries.eu/data/zmb.svg'),(1089,'Zimbabwe','Harare','Africa','ZWE','Zimbabwe','https://restcountries.eu/data/zwe.svg');
/*!40000 ALTER TABLE `pays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `periodes`
--

DROP TABLE IF EXISTS `periodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `periodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `month` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periodes`
--

LOCK TABLES `periodes` WRITE;
/*!40000 ALTER TABLE `periodes` DISABLE KEYS */;
INSERT INTO `periodes` VALUES (1,0),(2,1),(3,2),(4,3),(5,4),(6,5),(7,6),(8,7),(9,8),(10,9),(11,10),(12,11);
/*!40000 ALTER TABLE `periodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `types`
--

DROP TABLE IF EXISTS `types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types`
--

LOCK TABLES `types` WRITE;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
INSERT INTO `types` VALUES (1,'plage'),(2,'montagne');
/*!40000 ALTER TABLE `types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `login` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_UNIQUE` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,'$2b$08$jPsl0p2z7LrAWFHZ/jlE8OMidhs80iuClCNO02REE2wq4cO.tWk3.',NULL,'test');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-27 15:16:56
