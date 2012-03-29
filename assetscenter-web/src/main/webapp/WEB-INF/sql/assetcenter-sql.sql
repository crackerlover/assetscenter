/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2011-11-2 16:25:09                           */
/*==============================================================*/


drop table if exists AC_ASSET;

drop table if exists AC_ASSET_TRANSFER;

drop table if exists AC_ASSET_TYPE;

drop table if exists AC_CASE;

drop table if exists AC_CASE_TYPE;

drop table if exists AC_ORDER;

drop table if exists AC_ORDER_ASSET;

drop table if exists AC_PROJECT;

drop table if exists AC_PROJECT_APPLY_RECORD;

drop table if exists AC_PROJECT_ASSET;

drop table if exists AC_PROJECT_TEAM;

drop table if exists AC_TEAM;

drop table if exists AC_TEAM_APPLY_RECORD;

drop table if exists AC_TEAM_ASSET;

drop table if exists AC_USER;

drop table if exists AC_USER_PROJECT;

drop table if exists AC_USER_TEAM;

drop table if exists AC_VERIFY;

/*==============================================================*/
/* Table: AC_ASSET                                              */
/*==============================================================*/
create table AC_ASSET
(
   ID                   int not null auto_increment,
   TYPE_ID              int not null,
   STATUS               tinyint not null,
   SN                   varchar(50),
   DESCRIPTION          text,
   ELTMS                varchar(50),
   ORDER_NAME           varchar(50),
   OWNER_NAME           varchar(50),
   WAREHOUSE_TIME       varchar(50),
   LOCATION             varchar(100),
   PRICE                double,
   USER_NAME            varchar(50),
   primary key (ID)
);

/*==============================================================*/
/* Table: AC_ASSET_TRANSFER                                     */
/*==============================================================*/
create table AC_ASSET_TRANSFER
(
   ID                   int not null auto_increment,
   TRANSFER             varchar(50) not null,
   RECEIVE              varchar(50) not null,
   STATUS               tinyint not null,
   TRANSFER_TIME        varchar(50) not null,
   MATERIAL_ID          int,
   TYPE                 int,
   EXPECT_TIME          varchar(50),
   primary key (ID)
);

/*==============================================================*/
/* Table: AC_ASSET_TYPE                                         */
/*==============================================================*/
create table AC_ASSET_TYPE
(
   ID                   int not null auto_increment,
   NAME                 varchar(30) not null,
   DESCRIPTION          text,
   primary key (ID)
);

/*==============================================================*/
/* Table: AC_CASE                                               */
/*==============================================================*/
create table AC_CASE
(
   ID                   int not null auto_increment,
   NAME                 varchar(50) not null,
   TOS					varchar(100) not null,
   SUBMITER             varchar(50),
   GMT_CREATE           varchar(50),
   GMT_FINISH           varchar(50),
   EXPECT_TIME          varchar(50),
   STATUS               tinyint,
   TYPE_ID              int,
   UPDATE_INFO			text,
   DESCRIPTION          text,
   primary key (ID)
);

/*==============================================================*/
/* Table: AC_CASE_TYPE                                          */
/*==============================================================*/
create table AC_CASE_TYPE
(
   ID                   int not null auto_increment,
   NAME                 varchar(50),
   DESCRIPTION          text,
   primary key (ID)
);

/*==============================================================*/
/* Table: AC_ORDER                                              */
/*==============================================================*/
create table AC_ORDER
(
   ID                   int not null auto_increment,
   NAME                 varchar(50) not null,
   DESCRIPTION          text,
   STATUS               tinyint not null,
   GMT_CREATE           varchar(50) not null,
   GMT_MODIFIED         varchar(50) not null,
   REQUEST_NAME         varchar(50) not null,
   primary key (ID)
);

/*==============================================================*/
/* Table: AC_ORDER_ASSET                                        */
/*==============================================================*/
create table AC_ORDER_ASSET
(
   ID                   int not null auto_increment,
   ORDER_ID             int not null,
   TYPE_NAME            varchar(50),
   QUANTITY             int not null,
   EXPECT_TIME          varchar(50) not null,
   primary key (ID)
);

/*==============================================================*/
/* Table: AC_PROJECT                                            */
/*==============================================================*/
create table AC_PROJECT
(
   ID                   int not null auto_increment,
   NAME                 varchar(30),
   DESCRIPTION          text,
   START_TIME           varchar(50),
   END_TIME             varchar(50),
   GMT_CREATE           varchar(50),
   primary key (ID)
);

/*==============================================================*/
/* Table: AC_PROJECT_APPLY_RECORD                               */
/*==============================================================*/
create table AC_PROJECT_APPLY_RECORD
(
   ID                   int not null auto_increment,
   APPLICANT            varchar(50),
   PROJECT              varchar(50),
   ROLE                 int,
   STATUS               tinyint,
   APPLY_TIME           varchar(50),
   primary key (ID)
);

/*==============================================================*/
/* Table: AC_PROJECT_ASSET                                      */
/*==============================================================*/
create table AC_PROJECT_ASSET
(
   ID                   int not null auto_increment,
   PROJECT_ID           int,
   ASSET_ID             int,
   SET_TIME             varchar(50),
   primary key (ID)
);

/*==============================================================*/
/* Table: AC_PROJECT_TEAM                                       */
/*==============================================================*/
create table AC_PROJECT_TEAM
(
   ID                   int not null auto_increment,
   PROJECT_ID           int,
   TEAM_ID              int,
   primary key (ID)
);

/*==============================================================*/
/* Table: AC_TEAM                                               */
/*==============================================================*/
create table AC_TEAM
(
   ID                   int not null auto_increment,
   NAME                 varchar(30) not null,
   DESCRIPTION          text,
   GMT_CREATE           varchar(50),
   primary key (ID)
);

/*==============================================================*/
/* Table: AC_TEAM_APPLY_RECORD                                  */
/*==============================================================*/
create table AC_TEAM_APPLY_RECORD
(
   ID                   int not null auto_increment,
   APPLICANT            varchar(50),
   TEAM                 varchar(50),
   ROLE                 int,
   STATUS               tinyint,
   APPLY_TIME           varchar(50),
   primary key (ID)
);

/*==============================================================*/
/* Table: AC_TEAM_ASSET                                         */
/*==============================================================*/
create table AC_TEAM_ASSET
(
   ID                   int not null auto_increment,
   TEAM_ID              int,
   ASSET_ID             int,
   SET_TIME             varchar(50),
   primary key (ID)
);

/*==============================================================*/
/* Table: AC_USER                                               */
/*==============================================================*/
create table AC_USER
(
   ID                   int not null auto_increment,
   USERNAME             varchar(30) not null,
   PASSWORD             varchar(30) not null,
   ROLE                 int,
   EMAIL                varchar(50),
   FULLNAME             varchar(50),
   GMT_CREATE           varchar(50),
   GMT_MODIFIED         varchar(50),
   primary key (ID)
);

/*==============================================================*/
/* Table: AC_USER_PROJECT                                       */
/*==============================================================*/
create table AC_USER_PROJECT
(
   ID                   int not null auto_increment,
   USERNAME             varchar(50) not null,
   PROJECT_ID           int not null,
   ROLE                 int not null,
   primary key (ID)
);

/*==============================================================*/
/* Table: AC_USER_TEAM                                          */
/*==============================================================*/
create table AC_USER_TEAM
(
   ID                   int not null auto_increment,
   USERNAME             varchar(50) not null,
   TEAM_ID              int not null,
   ROLE                 int,
   primary key (ID)
);

/*==============================================================*/
/* Table: AC_VERIFY                                             */
/*==============================================================*/
create table AC_VERIFY
(
   ID                   int not null auto_increment,
   USER_ID              int,
   VERIFY_STRING        varchar(50),
   STATUS               tinyint,
   START_TIME           varchar(50),
   TYPE                 int,
   primary key (ID)
);
-- ----------------------------
-- Records of ac_asset
-- ----------------------------
INSERT INTO AC_ASSET VALUES ('1', '1', '1', '', 'HEADSET FOR NEW HIRE', '', '', 'zhliu2', '2011-09-26', '', '550', 'zhliu2');
INSERT INTO AC_ASSET VALUES ('2', '2', '1', '318134191', 'uBR7200 NPE w', 'ITM02392508', '', 'yuliache', '2011-09-10', '', '125754.12', 'yuliache');
INSERT INTO AC_ASSET VALUES ('3', '2', '1', '317162241', 'uBR7200 NPE w', 'ITM02392507', '', 'yuliache', '2011-09-10', '', '125754.12', 'yuliache');
INSERT INTO AC_ASSET VALUES ('4', '2', '1', '318134611', 'uBR7200 NPE w', 'ITM02392506', '', 'yuliache', '2011-09-10', '', '125754.12', 'yuliache');
INSERT INTO AC_ASSET VALUES ('5', '3', '1', 'FDO1408X05T', 'Catalyst 3560 24 10/100 PoE + 2 SFP + IPS Image', 'ITM02392488', '', 'yuliache', '2011-08-24', '', '12372.86', 'yuliache');
INSERT INTO AC_ASSET VALUES ('6', '4', '0', '18749486/19378304/32996479/34123636', '32 port Asynchronous Module', '', '', 'shuzchen', '2011-08-24', '', '37943.45', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('7', '5', '1', 'FOC14106D3K', '64-CHANNEL PACKET VOICE/FAX DSP MODULE', 'ITM02386873', '', 'jieliu2', '2011-01-21', '', '7417.42', 'jieliu2');
INSERT INTO AC_ASSET VALUES ('8', '6', '0', 'ONT1349002B', '10GBASE-LR X2 MODULE', 'ITM02386860', '', 'juouyang', '2013-10-14', 'C13lab', '9271.78', 'juouyang');
INSERT INTO AC_ASSET VALUES ('9', '6', '0', 'ONT135000QL', '10GBASE-LR X2 MODULE', 'ITM02386859', '', 'juouyang', '2011-01-21', 'C13lab', '9271.78', 'juouyang');
INSERT INTO AC_ASSET VALUES ('10', '6', '0', 'ONT13490026', '10GBASE-LR X2 MODULE', 'ITM02386858', '', 'juouyang', '2011-01-21', 'C13lab', '9271.78', 'juouyang');
INSERT INTO AC_ASSET VALUES ('11', '6', '0', 'ONT135000HC', '10GBASE-LR X2 MODULE', 'ITM02386857', '', 'juouyang', '2011-01-21', 'C13lab', '9271.78', 'juouyang');
INSERT INTO AC_ASSET VALUES ('12', '6', '0', 'ONT1349002F', '10GBASE-LR X2 MODULE', 'ITM02386856', '', 'juouyang', '2011-01-21', 'C13lab', '9271.78', 'juouyang');
INSERT INTO AC_ASSET VALUES ('13', '6', '0', 'ONT1348037Z', '10GBASE-LR X2 MODULE', 'ITM02386855', '', 'juouyang', '2011-01-21', 'C13lab', '9271.78', 'juouyang');
INSERT INTO AC_ASSET VALUES ('14', '6', '0', 'ONT135000GU', '10GBASE-LR X2 MODULE', 'ITM02386854', '', 'juouyang', '2011-01-21', 'C13lab', '9271.78', 'juouyang');
INSERT INTO AC_ASSET VALUES ('15', '6', '0', 'ONT135000BR', '10GBASE-LR X2 MODULE', 'ITM02386853', '', 'juouyang', '2011-01-21', 'C13lab', '9271.78', 'juouyang');
INSERT INTO AC_ASSET VALUES ('16', '6', '0', 'ONT135000NC', '10GBASE-LR X2 MODULE', 'ITM02386852', '', 'juouyang', '2011-01-21', 'C13lab', '9271.78', 'juouyang');
INSERT INTO AC_ASSET VALUES ('17', '7', '0', 'ECL1151011C', '1000BASE-ZX SFP', 'ITM02391258', '', 'juouyang', '2011-04-29', 'C13lab', '9167.49', 'juouyang');
INSERT INTO AC_ASSET VALUES ('18', '7', '0', 'ECL1151010R', '1000BASE-ZX SFP', 'ITM02391257', '', 'juouyang', '2011-04-29', 'C13lab', '9167.49', 'juouyang');
INSERT INTO AC_ASSET VALUES ('19', '7', '0', 'ECL1151010T', '1000BASE-ZX SFP', 'ITM02391256', '', 'juouyang', '2011-04-29', 'C13lab', '9167.49', 'juouyang');
INSERT INTO AC_ASSET VALUES ('20', '7', '0', 'ECL1151010S', '1000BASE-ZX SFP', 'ITM02391255', '', 'juouyang', '2011-04-29', 'C13lab', '9167.49', 'juouyang');
INSERT INTO AC_ASSET VALUES ('21', '7', '0', 'ECL1151011L', '1000BASE-ZX SFP', 'ITM02391254', '', 'juouyang', '2011-04-29', 'C13lab', '9167.49', 'juouyang');
INSERT INTO AC_ASSET VALUES ('22', '7', '0', 'FNS120507NR', '1000BASE-ZX SFP', 'ITM02391253', '', 'juouyang', '2011-04-29', 'C13lab', '9167.49', 'juouyang');
INSERT INTO AC_ASSET VALUES ('23', '7', '0', 'ECL11510110', '1000BASE-ZX SFP', 'ITM02391252', '', 'juouyang', '2011-04-29', 'C13lab', '9167.49', 'juouyang');
INSERT INTO AC_ASSET VALUES ('24', '8', '0', 'FHK1319F394', '2811 w/ AC+POE,2FE,4HWICs,2PVDMs,1NME,2AIMS,IPBASE,128F/512D', 'ITM02391243', '', 'shuzchen', '2011-04-29', 'C13lab', '6482.64', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('25', '9', '0', 'FHK1337F0ST', '3825 w/AC PWR, 2GE,1SFP, 2NME, 4HWIC, IP Base, 128F/512D', 'ITM02391210', '', 'chen  Gengmin', '2011-04-29', 'B12lab', '21800.03', 'chen  Gengmin');
INSERT INTO AC_ASSET VALUES ('26', '9', '1', 'FHK1325F0R8', '3825 w/AC PWR, 2GE,1SFP, 2NME, 4HWIC, IP Base, 128F/512D', 'ITM02391209', '', 'shuzchen', '2011-04-29', '', '21800.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('27', '9', '1', 'FHK1325F0R6', '3825 w/AC PWR, 2GE,1SFP, 2NME, 4HWIC, IP Base, 128F/512D', 'ITM02391208', '', 'shuzchen', '2011-04-29', '', '21800.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('28', '10', '1', 'FHK1337F1MP', '3845 w/AC PWR,2GE,1SFP,4NME,4HWIC, IP Base, 128F/512D', 'ITM02391241', '', 'shuzchen', '2011-04-29', '', '29831.62', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('29', '11', '1', '', 'RF cable bundle,RF line card to RF Switch ,Lm,spare', 'ITM02391109', '', 'shuzchen', '2011-07-28', '', '31710.84', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('30', '12', '1', '', 'High Density 8-port EIA-232 Async', 'ITM02391107', '', 'shuzchen', '2011-07-28', '', '213.56', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('31', '13', '0', 'FOX1405H1XA', 'Catalyst 4948,ES Image,48*10/100', 'ITM02391108', '', 'juouyang', '2011-07-28', 'C13lab', '27051.29', 'juouyang');
INSERT INTO AC_ASSET VALUES ('32', '14', '1', '6833', 'N+1 RF Switch for CMTS Routers', 'ITM02390211', '', 'yuliache', '2011-05-19', '', '68239.5', 'yuliache');
INSERT INTO AC_ASSET VALUES ('33', '14', '1', '6880', 'N+1 RF Switch for CMTS Routers', 'ITM02390210', '', 'yuliache', '2011-05-19', '', '68239.5', 'yuliache');
INSERT INTO AC_ASSET VALUES ('34', '15', '1', 'FOX1342HB6C', 'Catalyst 4948, optnl sw, 48-Port 10/100/1000+4 SFP, no p/s', 'ITM02390208', '', 'shuzchen', '2011-05-26', '', '18185.83', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('35', '16', '1', 'FOC1319Z33B', 'Catalyst 3750 48 10/100/1000T + 4 SFP + IPS Image', 'ITM02390171', '', 'shuzchen', '2011-05-26', '', '50019.55', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('36', '16', '1', 'FOC1321Z45K', 'Catalyst 3750 48 10/100/1000T + 4 SFP + IPS Image', 'ITM02390170', '', 'shuzchen', '2011-05-26', '', '50019.55', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('37', '17', '1', 'FOC0925U0GA', 'Calalyst 3560 48 10/100/1000T+4SFP', 'ITM02390154', '', 'shuzchen', '2011-06-08', '', '18145.25', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('38', '17', '1', 'FOC0925U0C3', 'Calalyst 3560 48 10/100/1000T+4SFP', 'ITM02390153', '', 'shuzchen', '2011-06-08', '', '18145.25', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('39', '17', '1', 'FOC0925V0CT', 'Calalyst 3560 48 10/100/1000T+4SFP', 'ITM02390152', '', 'shuzchen', '2011-06-08', '', '18145.25', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('40', '18', '1', 'PAC13370LPZ', 'UBR7225 AC Power Supply, Option', 'ITM02390149', '', 'shuzchen', '2011-06-03', '', '1815.66', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('41', '18', '1', 'PAC13370LWH', 'UBR7225 AC Power Supply, Option', 'ITM02390148', '', 'shuzchen', '2011-06-03', '', '1815.66', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('42', '19', '1', 'FOX1215GJYD', 'UBR7225VXR CHASSIS,SPARE', 'ITM02390150', '', 'shuzchen', '2011-06-03', '', '15562.8', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('43', '20', '1', '19751167', '2 Ethernet 2 WAN Card Slot Network Module', 'ITM02381056', '', 'jieliu2', '2011-07-20', '', '5177.28', 'jieliu2');
INSERT INTO AC_ASSET VALUES ('44', '20', '1', '05540946', '2 Ethernet 2 WAN Card Slot Network Module', 'ITM02381055', '', 'jieliu2', '2011-07-20', '', '5177.28', 'jieliu2');
INSERT INTO AC_ASSET VALUES ('45', '20', '1', '22093801', '2 Ethernet 2 WAN Card Slot Network Module', 'ITM02381054', '', 'jieliu2', '2011-07-20', '', '5177.28', 'jieliu2');
INSERT INTO AC_ASSET VALUES ('46', '20', '1', '27220182', '2 Ethernet 2 WAN Card Slot Network Module', 'ITM02381053', '', 'jieliu2', '2011-07-20', '', '5177.28', 'jieliu2');
INSERT INTO AC_ASSET VALUES ('47', '21', '1', '26699912', 'Two-port Voice Interface Card - EandM-Spare', 'ITM02381230', '', 'jieliu2', '2011-07-20', '', '828.36', 'jieliu2');
INSERT INTO AC_ASSET VALUES ('48', '22', '0', 'ONT141802UN', '10GBASE-LR XENPAK Module with DOM support', 'ITM02385715', '', 'shuzchen', '2011-07-20', 'C13 Lab', '9060.24', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('49', '22', '1', 'ONT141802RP', '10GBASE-LR XENPAK Module with DOM support', 'ITM02385713', '', 'shuzchen', '2011-07-20', '', '9060.24', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('50', '22', '1', 'ONT141802R0', '10GBASE-LR XENPAK Module with DOM support', 'ITM02385712', '', 'shuzchen', '2011-07-20', '', '9060.24', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('51', '8', '0', 'FHK1319F394', '2811 w/ AC+POE,2FE,4HWICs,2PVDMs,1NME,2AIMS,IPBASE,128F/512D', 'ITM02391243', '', 'juouyang', '2011-07-20', 'C13lab', '5651.32', 'juouyang');
INSERT INTO AC_ASSET VALUES ('52', '23', '0', 'AGM1437227H', '1000BASE-T SFP', 'ITM02385714', '', 'juouyang', '2011-07-20', 'C13lab', '894.7', 'juouyang');
INSERT INTO AC_ASSET VALUES ('53', '24', '1', 'FNS14330GT0', '10GBASE-SR XENPAK Module', 'ITM02385711', '', 'shuzchen', '2011-07-20', '', '6795.18', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('54', '25', '0', '74213455', '7204VXR w/ NPE-225, 2 FE I/O, choice of specified WAN PA', 'ITM02387916', '', 'yuliache', '2011-06-03', 'C13lab', '40852.35', 'yuliache');
INSERT INTO AC_ASSET VALUES ('55', '25', '0', '74201427', '7204VXR w/ NPE-225, 2 FE I/O, choice of specified WAN PA', 'ITM02387914', '', 'xuemli', '2011-06-03', 'C13 Lab', '40852.35', 'xuemli');
INSERT INTO AC_ASSET VALUES ('56', '25', '0', '74212066', '7204VXR w/ NPE-225, 2 FE I/O, choice of specified WAN PA', 'ITM02387913', '', 'zhaoqwu', '2011-06-03', 'C13lab', '40852.35', 'zhaoqwu');
INSERT INTO AC_ASSET VALUES ('57', '26', '1', '74063419', '7204VXR, 4-slot chassis, Power Supply, w/o Slot Covers', 'ITM02387917', '', 'yuliache', '2011-06-03', '', '8300.16', 'yuliache');
INSERT INTO AC_ASSET VALUES ('58', '26', '1', '74076337', '7204VXR, 4-slot chassis, Power Supply, w/o Slot Covers', 'ITM02387915', '', 'yuliache', '2011-06-03', '', '8300.16', 'yuliache');
INSERT INTO AC_ASSET VALUES ('59', '26', '1', '74213352', '7204VXR, 4-slot chassis, Power Supply, w/o Slot Covers', 'ITM02387912', '', 'yuliache', '2011-06-03', '', '8300.16', 'yuliache');
INSERT INTO AC_ASSET VALUES ('60', '26', '1', '74072903', '7204VXR, 4-slot chassis, Power Supply, w/o Slot Covers', 'ITM02387911', '', 'yuliache', '2011-06-03', '', '8300.16', 'yuliache');
INSERT INTO AC_ASSET VALUES ('61', '26', '1', '74082573', '7204VXR, 4-slot chassis, Power Supply, w/o Slot Covers', 'ITM02387910', '', 'yuliache', '2011-06-03', '', '8300.16', 'yuliache');
INSERT INTO AC_ASSET VALUES ('62', '26', '1', '74037185', '7204VXR, 4-slot chassis, Power Supply, w/o Slot Covers', 'ITM02387909', '', 'yuliache', '2011-06-03', '', '8300.16', 'yuliache');
INSERT INTO AC_ASSET VALUES ('63', '27', '1', 'FOX1406G23K', 'Catalyst 4948, ES s/w, 48-Port 10/100/1000+4 SFP, 1 AC p/s', 'ITM02372613', '', 'shuzchen', '2011-06-15', '', '16589.94', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('64', '27', '1', 'FOX1352H08Z', 'Catalyst 4948, ES s/w, 48-Port 10/100/1000+4 SFP, 1 AC p/s', 'ITM02372583', '', 'shuzchen', '2011-06-15', '', '16589.94', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('65', '28', '1', '', 'Quad-shield RF cable bundle, RF Switch to HFC plant, 3m', 'ITM02385586', '', 'shuzchen', '2011-04-18', '', '50484.28', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('66', '29', '1', '', 'RF cable bundle, RF line card to RF Switch, 1m, spare', 'ITM02385587', '', 'shuzchen', '2011-04-18', '', '41305.32', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('67', '15', '1', 'FOX1404H7EH', 'Catalyst 4948, optnl sw, 48-Port 10/100/1000+4 SFP, no p/s', 'ITM02385981', '', 'shuzchen', '2011-03-08', '', '18399.05', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('68', '15', '1', 'FOX1418G0DC', 'Catalyst 4948, optnl sw, 48-Port 10/100/1000+4 SFP, no p/s', 'ITM02385979', '', 'shuzchen', '2011-03-08', '', '18399.05', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('69', '26', '1', 'FOX1415GXLR', '7204VXR, 4-slot chassis, Power Supply, w/o Slot Covers', 'ITM02387858', '', 'yuliache', '2011-06-10', '', '8300.16', 'yuliache');
INSERT INTO AC_ASSET VALUES ('70', '26', '1', '74227240', '7204VXR, 4-slot chassis, Power Supply, w/o Slot Covers', 'ITM02387857', '', 'yuliache', '2011-06-10', '', '8300.16', 'yuliache');
INSERT INTO AC_ASSET VALUES ('71', '26', '1', '74224925', '7204VXR, 4-slot chassis, Power Supply, w/o Slot Covers', 'ITM02387856', '', 'yuliache', '2011-06-10', '', '8300.16', 'yuliache');
INSERT INTO AC_ASSET VALUES ('72', '26', '1', '74227292', '7204VXR, 4-slot chassis, Power Supply, w/o Slot Covers', 'ITM02387855', '', 'yuliache', '2011-06-10', '', '8300.16', 'yuliache');
INSERT INTO AC_ASSET VALUES ('73', '26', '1', '74224674', '7204VXR, 4-slot chassis, Power Supply, w/o Slot Covers', 'ITM02387854', '', 'yuliache', '2011-06-10', '', '8300.16', 'yuliache');
INSERT INTO AC_ASSET VALUES ('74', '26', '1', '74243557', '7204VXR, 4-slot chassis, Power Supply, w/o Slot Covers', 'ITM02387853', '', 'yuliache', '2011-06-10', '', '8300.16', 'yuliache');
INSERT INTO AC_ASSET VALUES ('75', '30', '1', 'FOX1405H99Q', 'Catalyst 4948, IPB s/w, 48-Port 10/100/1000+4 SFP, 1 AC p/s', 'ITM02372602', '', 'shuzchen', '2011-06-13', '', '16589.94', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('76', '30', '1', 'FOX1413GPX5', 'Catalyst 4948, IPB s/w, 48-Port 10/100/1000+4 SFP, 1 AC p/s', 'ITM02372600', '', 'shuzchen', '2011-06-13', '', '16589.94', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('77', '30', '1', 'FOX100100VK', 'Catalyst 4948, IPB s/w, 48-Port 10/100/1000+4 SFP, 1 AC p/s', 'ITM02372599', '', 'shuzchen', '2011-06-13', '', '16589.94', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('78', '31', '1', 'FM500K296388', 'Single Port Router with 2 Phone Ports (United Kingdom)', 'ITM02386810', '', 'shuzchen', '2011-05-23', '', '174.69', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('79', '31', '1', 'FM500K295441', 'Single Port Router with 2 Phone Ports (United Kingdom)', 'ITM02386809', '', 'shuzchen', '2011-05-23', '', '174.69', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('80', '31', '1', 'FM500K296407', 'Single Port Router with 2 Phone Ports (United Kingdom)', 'ITM02386808', '', 'shuzchen', '2011-05-23', '', '174.69', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('81', '31', '1', 'FM500K295383', 'Single Port Router with 2 Phone Ports (United Kingdom)', 'ITM02386807', '', 'shuzchen', '2011-05-23', '', '174.69', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('82', '31', '1', 'FM500K295375', 'Single Port Router with 2 Phone Ports (United Kingdom)', 'ITM02386806', '', 'shuzchen', '2011-05-23', '', '174.69', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('83', '32', '0', 'FHG1437R03L', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385284', '', 'juouyang', '2011-04-14', 'C13lab', '5234.63', 'juouyang');
INSERT INTO AC_ASSET VALUES ('84', '32', '0', 'FHG1437R03M', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385283', '', 'xuemli', '2011-04-14', 'C13 Lab', '5234.63', 'xuemli');
INSERT INTO AC_ASSET VALUES ('85', '32', '0', 'FHG1437R03B', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385282', '', 'zhiqian', '2011-04-14', 'C13 Lab', '5234.63', 'zhiqian');
INSERT INTO AC_ASSET VALUES ('86', '32', '1', 'FHG1437R03X', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385281', '', 'shuzchen', '2011-04-14', '', '5234.63', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('87', '32', '1', 'FHG1437R037', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385280', '', 'shuzchen', '2011-04-14', '', '5234.63', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('88', '32', '1', 'FHG1437R03Y', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385278', '', 'shuzchen', '2011-04-14', '', '5234.63', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('89', '32', '1', 'FHG1437R043', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385277', '', 'shuzchen', '2011-04-14', '', '5234.63', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('90', '32', '1', 'FHG1437R03T', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385276', '', 'shuzchen', '2011-04-14', '', '5234.63', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('91', '32', '1', 'FHG1437R03H', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385275', '', 'shuzchen', '2011-04-14', '', '5234.63', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('92', '32', '1', 'FHG1437R03K', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385274', '', 'shuzchen', '2011-04-14', '', '5234.63', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('93', '32', '1', 'FHG1437R03G', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385273', '', 'shuzchen', '2011-04-14', '', '5234.63', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('94', '32', '1', 'FHG1437R03W', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385272', '', 'shuzchen', '2011-04-14', '', '5234.63', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('95', '32', '1', 'FHG1437R03U', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385271', '', 'shuzchen', '2011-04-14', '', '5234.63', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('96', '32', '1', 'FHG1437R038', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385270', '', 'shuzchen', '2011-04-14', '', '5234.63', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('97', '32', '1', 'FHG1437R03F', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385269', '', 'shuzchen', '2011-04-14', '', '5234.63', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('98', '32', '1', 'FHG1437R03E', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385268', '', 'shuzchen', '2011-04-14', '', '5234.63', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('99', '32', '1', 'FHG1437R03N', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385267', '', 'shuzchen', '2011-04-14', '', '5234.63', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('100', '32', '1', 'FHG1437R03D', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385266', '', 'shuzchen', '2011-04-14', '', '5234.63', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('101', '32', '1', 'FHG1437R042', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385265', '', 'shuzchen', '2011-04-14', '', '5234.63', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('102', '29', '1', '', 'RF cable bundle, RF line card to RF Switch, 1m, spare', '', '', 'shuzchen', '2011-04-18', '', '36715.84', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('103', '33', '1', '231439856', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384995', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('104', '33', '1', '231439782', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384988', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('105', '33', '1', '231439844', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384987', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('106', '33', '1', '231439780', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384982', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('107', '33', '1', '231439860', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384980', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('108', '33', '1', '231439839', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384973', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('109', '33', '1', '231439886', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384963', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('110', '33', '1', '231439746', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384948', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('111', '33', '1', '231439840', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384943', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('112', '33', '1', '231439742', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384939', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('113', '33', '1', '231439775', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384937', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('114', '33', '1', '231439636', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384923', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('115', '33', '1', '231439737', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384899', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('116', '33', '1', '231439777', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384893', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('117', '33', '1', '231439768', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384879', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('118', '33', '1', '231439751', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384877', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('119', '33', '1', '231439858', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384876', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('120', '33', '1', '231439747', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384870', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('121', '33', '1', '231439653', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384866', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('122', '33', '1', '231439850', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384858', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('123', '33', '1', '231439845', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384857', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('124', '33', '1', '231439769', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384848', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('125', '33', '1', '231439841', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384839', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('126', '33', '1', '231439648', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384830', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('127', '33', '1', '231439763', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384827', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('128', '33', '1', '231439686', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384825', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('129', '33', '1', '231439741', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384821', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('130', '33', '1', '231439867', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384820', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('131', '33', '1', '231439620', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384816', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('132', '33', '1', '231439660', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384814', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('133', '33', '1', '231439770', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384813', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('134', '33', '1', '231439616', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384807', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('135', '33', '1', '231439626', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384801', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('136', '33', '1', '231439781', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384792', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('137', '33', '1', '231439800', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384789', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('138', '33', '1', '231439696', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384782', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('139', '33', '1', '231439837', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384774', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('140', '33', '1', '231439857', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384769', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('141', '33', '1', '231439827', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384764', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('142', '33', '1', '231439612', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384758', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('143', '33', '1', '231439664', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384752', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('144', '33', '1', '231439661', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384746', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('145', '33', '1', '231439762', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384741', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('146', '33', '1', '231439772', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384740', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('147', '33', '1', '231439784', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384729', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('148', '33', '1', '231439896', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384719', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('149', '33', '1', '231439659', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384718', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('150', '33', '1', '231439889', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384703', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('151', '33', '1', '231439766', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384696', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('152', '33', '1', '231439863', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384693', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('153', '33', '1', '231439824', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384688', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('154', '33', '1', '231439749', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384686', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('155', '33', '1', '231439745', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384669', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('156', '33', '1', '231439876', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384665', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('157', '33', '1', '231439878', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384661', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('158', '33', '1', '231439761', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384654', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('159', '33', '1', '231439654', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384648', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('160', '33', '1', '231439778', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384645', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('161', '33', '1', '231439748', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384640', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('162', '33', '1', '231439859', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384638', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('163', '33', '1', '231439611', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384636', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('164', '33', '1', '231439849', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384635', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('165', '33', '1', '231439865', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384628', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('166', '33', '1', '231439880', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384617', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('167', '33', '1', '231439615', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384616', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('168', '33', '1', '231439703', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384615', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('169', '33', '1', '231439888', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384611', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('170', '33', '1', '231439765', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384610', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('171', '33', '1', '231439821', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384601', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('172', '33', '1', '231439693', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384600', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('173', '32', '1', 'FOC1133X3EG', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02384118', '', 'shuzchen', '2011-03-18', '', '5741.79', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('174', '32', '1', 'FOC1133X3FL', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02384117', '', 'shuzchen', '2011-03-18', '', '5741.79', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('175', '32', '1', 'FOC1133Z96Y', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02384116', '', 'shuzchen', '2011-03-18', '', '5741.79', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('176', '32', '1', 'FOC1134U3HG', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02384115', '', 'shuzchen', '2011-03-18', '', '5741.79', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('177', '34', '1', 'FOC1446X0Q9', 'Catalyst 2960 48 10/100 + 2 1000BT LAN Base Image', 'ITM02384104', '', 'shuzchen', '2011-03-18', '', '5741.79', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('178', '34', '1', 'FOC1446X0TS', 'Catalyst 2960 48 10/100 + 2 1000BT LAN Base Image', 'ITM02384103', '', 'shuzchen', '2011-03-18', '', '5741.79', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('179', '34', '1', 'FOC1436W334', 'Catalyst 2960 48 10/100 + 2 1000BT LAN Base Image', 'ITM02383335', '', 'shuzchen', '2011-03-08', '', '5741.79', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('180', '32', '1', 'FOC1426X41G', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02378004', '', 'shuzchen', '2011-03-01', '', '5249.64', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('181', '32', '1', 'FOC1413X22W', 'CATALYST 2960 48 10/100 + 2 T/SFP LAN BASE IMAGE', 'ITM02376247', '', 'shuzchen', '2010-12-02', '', '9603.05', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('182', '32', '1', 'FOC1413X22K', 'CATALYST 2960 48 10/100 + 2 T/SFP LAN BASE IMAGE', 'ITM02376238', '', 'shuzchen', '2010-12-02', '', '9603.05', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('183', '32', '1', 'FOC1413X202', 'CATALYST 2960 48 10/100 + 2 T/SFP LAN BASE IMAGE', 'ITM02376226', '', 'shuzchen', '2010-12-02', '', '9603.05', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('184', '35', '1', 'CAT11195G50', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('185', '35', '1', 'CAT11185FU9', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('186', '35', '1', 'CAT11185FU1', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('187', '35', '1', 'CAT11185FTM', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('188', '35', '1', 'CAT11185FTK', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('189', '35', '1', 'CAT11185FSM', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('190', '35', '1', 'CAT11105PD7', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('191', '35', '1', 'CAT11105PD5', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('192', '35', '1', 'CAT11045J7G', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('193', '35', '1', 'CAT11045J74', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('194', '35', '1', 'CAT1104531L', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('195', '35', '1', 'CAT105256GQ', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('196', '35', '1', 'CAT105256GK', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('197', '35', '1', 'CAT10425PXY', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('198', '35', '1', 'CAT10425PV6', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('199', '35', '1', 'CAT10395R75', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('200', '35', '1', 'CAT10395R71', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('201', '35', '1', 'CAT10395R6Q', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('202', '35', '1', 'CAT103956NV', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('203', '35', '1', 'CAT103551GE', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('204', '35', '1', 'CAT103551G7', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('205', '35', '1', 'CAT103551FL', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('206', '35', '1', 'CAT103551FF', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('207', '35', '1', 'CAT10345306', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('208', '35', '1', 'CAT10250TCV', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('209', '35', '1', 'CAT10250TAX', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('210', '35', '1', 'CAT10161306', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('211', '35', '1', 'CAT10161305', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('212', '35', '1', 'CAT10161304', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('213', '35', '1', 'CAT101612ZM', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('214', '35', '1', 'CAT10151XKV', 'UBR10-TCC+-T1', '', '', 'shuzchen', '2010-07-29', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('215', '36', '1', 'N/A', 'UBR10-MC-COVER=/', 'N/A', '', 'shuzchen', '2010-06-08', '', '436.99', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('216', '37', '1', '', 'N/A', '', '', 'shuzchen', '2010-04-14', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('217', '11', '1', '', 'RF cable bundle,RF line card to RF Switch ,Lm,spare', 'ITM02391109', '', 'shuzchen', '2011-07-28', '', '31710.84', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('218', '12', '1', '', 'High Density 8-port EIA-232 Async', 'ITM02391107', '', 'shuzchen', '2011-07-28', '', '213.56', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('219', '38', '0', '228736199', 'DPC3925 IP GW,4PT EMTA,USB,15V DESKTOP PS,S', 'ITM02390128', '', 'yuliache', '2011-05-05', 'C13lab', '680.12', 'yuliache');
INSERT INTO AC_ASSET VALUES ('220', '38', '0', '228735920', 'DPC3925 IP GW,4PT EMTA,USB,15V DESKTOP PS,S', 'ITM02390126', '', 'yuliache', '2011-05-05', 'C13lab', '680.12', 'yuliache');
INSERT INTO AC_ASSET VALUES ('221', '38', '0', '228735248', 'DPC3925 IP GW,4PT EMTA,USB,15V DESKTOP PS,S', 'ITM02390125', '', 'yuliache', '2011-05-05', 'C13lab', '680.12', 'yuliache');
INSERT INTO AC_ASSET VALUES ('222', '38', '0', '228736123', 'DPC3925 IP GW,4PT EMTA,USB,15V DESKTOP PS,S', 'ITM02390121', '', 'yuliache', '2011-05-05', 'C13lab', '680.12', 'yuliache');
INSERT INTO AC_ASSET VALUES ('223', '38', '1', '228736019', 'DPC3925 IP GW,4PT EMTA,USB,15V DESKTOP PS,S', 'ITM02390119', '', 'shuzchen', '2011-05-05', '', '680.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('224', '38', '1', '228736212', 'DPC3925 IP GW,4PT EMTA,USB,15V DESKTOP PS,S', 'ITM02390117', '', 'shuzchen', '2011-05-05', '', '680.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('225', '38', '1', '228736209', 'DPC3925 IP GW,4PT EMTA,USB,15V DESKTOP PS,S', 'ITM02390114', '', 'shuzchen', '2011-05-05', '', '680.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('226', '38', '1', '228735914', 'DPC3925 IP GW,4PT EMTA,USB,15V DESKTOP PS,S', 'ITM02390111', '', 'shuzchen', '2011-05-05', '', '680.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('227', '38', '1', '228736201', 'DPC3925 IP GW,4PT EMTA,USB,15V DESKTOP PS,S', 'ITM02390109', '', 'shuzchen', '2011-05-05', '', '680.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('228', '38', '1', '228736198', 'DPC3925 IP GW,4PT EMTA,USB,15V DESKTOP PS,S', 'ITM02390104', '', 'shuzchen', '2011-05-05', '', '680.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('229', '39', '1', '230737660', 'DPC3825 GW,DOCSIS 3.0.4PT,15V NA SW LPS,NO USB', 'ITM02390131', '', 'shuzchen', '2011-05-05', '', '511.8', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('230', '39', '1', '230737795', 'DPC3825 GW,DOCSIS 3.0.4PT,15V NA SW LPS,NO USB', 'ITM02390130', '', 'shuzchen', '2011-05-05', '', '511.8', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('231', '39', '1', '230737496', 'DPC3825 GW,DOCSIS 3.0.4PT,15V NA SW LPS,NO USB', 'ITM02390129', '', 'shuzchen', '2011-05-05', '', '511.8', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('232', '39', '1', '230737753', 'DPC3825 GW,DOCSIS 3.0.4PT,15V NA SW LPS,NO USB', 'ITM02390127', '', 'shuzchen', '2011-05-05', '', '511.8', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('233', '39', '1', '230737747', 'DPC3825 GW,DOCSIS 3.0.4PT,15V NA SW LPS,NO USB', 'ITM02390124', '', 'shuzchen', '2011-05-05', '', '511.8', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('234', '39', '1', '230737647', 'DPC3825 GW,DOCSIS 3.0.4PT,15V NA SW LPS,NO USB', 'ITM02390123', '', 'shuzchen', '2011-05-05', '', '511.8', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('235', '39', '1', '230737948', 'DPC3825 GW,DOCSIS 3.0.4PT,15V NA SW LPS,NO USB', 'ITM02390122', '', 'shuzchen', '2011-05-05', '', '511.8', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('236', '39', '1', '230737450', 'DPC3825 GW,DOCSIS 3.0.4PT,15V NA SW LPS,NO USB', 'ITM02390120', '', 'shuzchen', '2011-05-05', '', '511.8', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('237', '39', '1', '230737953', 'DPC3825 GW,DOCSIS 3.0.4PT,15V NA SW LPS,NO USB', 'ITM02390118', '', 'shuzchen', '2011-05-05', '', '511.8', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('238', '39', '1', '230737981', 'DPC3825 GW,DOCSIS 3.0.4PT,15V NA SW LPS,NO USB', 'ITM02390116', '', 'shuzchen', '2011-05-05', '', '511.8', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('239', '39', '1', '230737965', 'DPC3825 GW,DOCSIS 3.0.4PT,15V NA SW LPS,NO USB', 'ITM02390115', '', 'shuzchen', '2011-05-05', '', '511.8', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('240', '39', '1', '230737433', 'DPC3825 GW,DOCSIS 3.0.4PT,15V NA SW LPS,NO USB', 'ITM02390113', '', 'shuzchen', '2011-05-05', '', '511.8', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('241', '39', '1', '230737863', 'DPC3825 GW,DOCSIS 3.0.4PT,15V NA SW LPS,NO USB', 'ITM02390112', '', 'shuzchen', '2011-05-05', '', '511.8', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('242', '39', '1', '230737835', 'DPC3825 GW,DOCSIS 3.0.4PT,15V NA SW LPS,NO USB', 'ITM02390110', '', 'shuzchen', '2011-05-05', '', '511.8', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('243', '39', '1', '230737615', 'DPC3825 GW,DOCSIS 3.0.4PT,15V NA SW LPS,NO USB', 'ITM02390108', '', 'shuzchen', '2011-05-05', '', '511.8', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('244', '39', '1', '230737840', 'DPC3825 GW,DOCSIS 3.0.4PT,15V NA SW LPS,NO USB', 'ITM02390107', '', 'shuzchen', '2011-05-05', '', '511.8', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('245', '39', '1', '230736941', 'DPC3825 GW,DOCSIS 3.0.4PT,15V NA SW LPS,NO USB', 'ITM02390106', '', 'shuzchen', '2011-05-05', '', '511.8', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('246', '39', '1', '230737429', 'DPC3825 GW,DOCSIS 3.0.4PT,15V NA SW LPS,NO USB', 'ITM02390105', '', 'shuzchen', '2011-05-05', '', '511.8', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('247', '39', '1', '230737978', 'DPC3825 GW,DOCSIS 3.0.4PT,15V NA SW LPS,NO USB', 'ITM02390103', '', 'shuzchen', '2011-05-05', '', '511.8', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('248', '39', '1', '230737934', 'DPC3825 GW,DOCSIS 3.0.4PT,15V NA SW LPS,NO USB', 'ITM02390102', '', 'shuzchen', '2011-05-05', '', '511.8', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('249', '32', '0', 'FOC1416Y3KK', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02386881', '', 'shuzchen', '2011-07-20', 'C13lab', '5651.32', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('250', '33', '0', '232073723', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388274', 'c13lab', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('251', '33', '1', '232073776', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388273', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('252', '33', '1', '232073674', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388272', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('253', '33', '1', '232073632', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388271', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('254', '33', '1', '232073466', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388270', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('255', '33', '1', '232073911', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388269', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('256', '33', '1', '232073758', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388268', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('257', '33', '1', '232073660', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388267', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('258', '33', '1', '232073617', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388266', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('259', '33', '1', '232073644', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388265', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('260', '33', '1', '232073802', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388264', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('261', '33', '1', '232073868', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388263', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('262', '33', '1', '232073668', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388262', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('263', '33', '1', '232073616', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388261', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('264', '33', '1', '232073473', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388260', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('265', '33', '1', '232073716', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388259', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('266', '33', '1', '232073468', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388258', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('267', '33', '1', '232073693', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388257', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('268', '33', '1', '232073609', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388256', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('269', '33', '1', '232073733', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388255', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('270', '33', '1', '232073586', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388254', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('271', '33', '1', '232073806', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388253', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('272', '33', '1', '232073906', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388252', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('273', '33', '1', '232073489', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388251', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('274', '33', '1', '232073610', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388250', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('275', '33', '1', '232073853', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388249', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('276', '33', '1', '232073891', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388248', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('277', '33', '1', '232073566', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388247', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('278', '33', '1', '232073474', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388246', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('279', '33', '1', '232073697', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388245', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('280', '33', '1', '232073567', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388244', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('281', '33', '1', '232073661', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388243', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('282', '33', '1', '232073908', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388242', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('283', '33', '1', '232073789', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388241', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('284', '33', '1', '232073584', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388240', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('285', '33', '1', '232073695', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388239', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('286', '33', '1', '232073849', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388238', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('287', '33', '1', '232073611', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388237', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('288', '33', '1', '232073492', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388236', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('289', '33', '1', '232073793', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388235', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('290', '33', '1', '232073870', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388234', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('291', '33', '1', '232073899', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388233', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('292', '33', '1', '232073856', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388232', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('293', '33', '1', '232073749', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388231', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('294', '33', '1', '232073446', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388230', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('295', '33', '1', '232073740', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388229', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('296', '33', '1', '232073886', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388228', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('297', '33', '1', '232073488', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388227', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('298', '33', '1', '232073579', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388226', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('299', '33', '1', '232073681', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388225', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('300', '33', '1', '232073595', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388224', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('301', '33', '1', '232073663', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388223', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('302', '33', '1', '232073821', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388222', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('303', '33', '1', '232073643', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388221', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('304', '33', '1', '232073626', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388220', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('305', '33', '1', '232073591', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388219', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('306', '33', '1', '232073630', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388218', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('307', '33', '1', '232073608', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388217', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('308', '33', '1', '232073475', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388216', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('309', '33', '1', '232073560', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388215', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('310', '33', '1', '232073642', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388214', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('311', '33', '1', '232073748', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388213', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('312', '33', '1', '232073809', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388212', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('313', '33', '1', '232073585', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388211', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('314', '33', '1', '232073592', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388210', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('315', '33', '1', '232073810', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388209', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('316', '33', '1', '232073884', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388208', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('317', '33', '1', '232073726', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388207', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('318', '33', '1', '232073594', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388206', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('319', '33', '1', '232073557', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388205', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('320', '33', '1', '232073867', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388204', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('321', '33', '1', '232073707', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388203', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('322', '33', '1', '232073757', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388202', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('323', '33', '1', '232073658', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388201', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('324', '33', '1', '232073627', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388200', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('325', '33', '1', '232073615', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388199', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('326', '33', '1', '232073678', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388198', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('327', '33', '1', '232073914', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388197', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('328', '33', '1', '232073553', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388196', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('329', '33', '1', '232073696', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388195', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('330', '33', '1', '232073752', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388194', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('331', '33', '1', '232073892', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388193', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('332', '33', '1', '232073490', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388192', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('333', '33', '1', '232073768', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388191', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('334', '33', '1', '232073878', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388190', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('335', '33', '1', '232073665', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388189', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('336', '33', '1', '232073811', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388188', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('337', '33', '1', '232073552', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388187', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('338', '33', '1', '232073729', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388186', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('339', '33', '1', '232073556', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388185', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('340', '33', '1', '232073895', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388184', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('341', '33', '1', '232073680', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388183', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('342', '33', '1', '232073850', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388182', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('343', '33', '1', '232073645', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388181', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('344', '33', '1', '232073631', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388180', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('345', '33', '1', '232073790', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388179', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('346', '33', '1', '232073618', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388178', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('347', '33', '1', '232073745', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388177', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('348', '33', '1', '232073847', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388176', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('349', '33', '1', '232073682', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388175', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('350', '33', '1', '232073451', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388174', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('351', '33', '1', '232073650', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388173', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('352', '33', '1', '232073582', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388172', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('353', '33', '1', '232073855', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388171', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('354', '33', '1', '232073694', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388170', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('355', '33', '1', '232073879', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388169', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('356', '33', '1', '232073897', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388168', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('357', '33', '1', '232073551', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388167', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('358', '33', '1', '232073633', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388166', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('359', '33', '1', '232073485', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388165', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('360', '33', '1', '232073569', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388164', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('361', '33', '1', '232073817', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388163', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('362', '33', '1', '232073887', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388162', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('363', '33', '1', '232073846', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388161', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('364', '33', '1', '232073704', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388160', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('365', '33', '1', '232073635', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388159', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('366', '33', '1', '232073857', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388158', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('367', '33', '1', '232073889', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388157', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('368', '33', '1', '232073427', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388156', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('369', '33', '1', '232073916', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388155', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('370', '33', '1', '232073684', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388154', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('371', '33', '1', '232073573', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388153', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('372', '33', '1', '232073583', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388152', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('373', '33', '1', '232073863', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388151', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('374', '33', '1', '232073900', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388150', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('375', '33', '1', '232073812', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388149', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('376', '33', '1', '232073724', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388148', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('377', '33', '1', '232073773', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388147', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('378', '33', '1', '232073669', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388146', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('379', '33', '1', '232073653', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388145', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('380', '33', '1', '232073574', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388144', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('381', '33', '1', '232073918', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388143', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('382', '33', '1', '232073430', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388142', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('383', '33', '1', '232073550', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388141', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('384', '33', '1', '232073777', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388140', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('385', '33', '1', '232073896', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388139', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('386', '33', '1', '232073721', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388138', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('387', '33', '1', '232073709', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388137', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('388', '33', '1', '232073652', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388136', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('389', '33', '1', '232073662', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388135', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('390', '33', '1', '232073544', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388134', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('391', '33', '1', '232073654', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388133', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('392', '33', '1', '232073599', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388132', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('393', '33', '1', '232073457', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388131', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('394', '33', '1', '232073881', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388130', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('395', '33', '1', '232073791', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388129', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('396', '33', '1', '232073549', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388128', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('397', '33', '1', '232073744', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388127', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('398', '33', '1', '232073735', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388126', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('399', '33', '1', '232073719', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388125', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('400', '33', '1', '232073699', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388124', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('401', '33', '1', '232073450', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388123', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('402', '33', '1', '232073555', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388122', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('403', '33', '1', '232073439', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388121', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('404', '33', '1', '232073491', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388120', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('405', '33', '1', '232073747', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388119', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('406', '33', '1', '232073876', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388118', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('407', '33', '1', '232073659', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388117', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('408', '33', '1', '232073702', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388116', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('409', '33', '1', '232073710', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388115', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('410', '33', '1', '232073848', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388114', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('411', '33', '1', '232073785', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388113', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('412', '33', '1', '232073701', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388112', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('413', '33', '1', '232073862', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388111', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('414', '33', '1', '232073637', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388110', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('415', '33', '1', '232073677', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388109', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('416', '33', '1', '232073571', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388108', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('417', '33', '1', '232073602', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388107', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('418', '33', '1', '232073788', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388106', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('419', '33', '1', '232073746', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388105', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('420', '33', '1', '232073564', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388104', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('421', '33', '1', '232073649', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388103', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('422', '33', '1', '232073820', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388102', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('423', '33', '1', '232073581', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388101', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('424', '33', '1', '232073874', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388100', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('425', '33', '1', '232073764', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388099', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('426', '33', '1', '232073671', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388098', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('427', '33', '1', '232073687', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388097', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('428', '33', '1', '232073722', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388096', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('429', '33', '1', '232073597', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388095', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('430', '33', '1', '232073750', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388094', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('431', '33', '1', '232073561', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388093', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('432', '33', '1', '232073808', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388092', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('433', '33', '1', '232073604', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388091', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('434', '33', '1', '232073800', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388090', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('435', '33', '1', '232073651', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388089', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('436', '33', '1', '232073767', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388088', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('437', '33', '1', '232073890', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388087', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('438', '33', '1', '232073641', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388086', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('439', '33', '1', '232073766', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388085', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('440', '33', '1', '232073625', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388084', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('441', '33', '1', '232073698', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388083', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('442', '33', '1', '232073547', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388082', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('443', '33', '1', '232073580', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388081', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('444', '33', '1', '232073683', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388080', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('445', '33', '1', '232073795', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388079', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('446', '33', '1', '232073620', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388078', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('447', '33', '1', '232073437', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388077', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('448', '33', '1', '232073894', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388076', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('449', '33', '1', '232073559', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388075', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('450', '33', '1', '232073739', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388074', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('451', '33', '1', '232073731', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388073', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('452', '33', '1', '232073593', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388072', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('453', '33', '1', '232073769', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388071', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('454', '33', '1', '232073775', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388070', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('455', '33', '1', '232073548', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388069', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('456', '33', '1', '232073801', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388068', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('457', '33', '1', '232073670', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388067', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('458', '33', '1', '232073865', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388066', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('459', '33', '1', '232073706', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388065', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('460', '33', '1', '232073613', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388064', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('461', '33', '1', '232073621', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388063', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('462', '33', '1', '232073754', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388062', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('463', '33', '1', '232073453', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388061', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('464', '33', '1', '232073888', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388060', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('465', '33', '1', '232073910', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388059', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('466', '33', '1', '232073424', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388058', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('467', '33', '1', '232073816', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388057', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('468', '33', '1', '232073444', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388056', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('469', '33', '1', '232073743', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388055', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('470', '33', '1', '232073902', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388054', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('471', '33', '1', '232073833', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388053', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('472', '33', '1', '232073601', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388052', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('473', '33', '1', '232073690', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388051', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('474', '33', '1', '232073675', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388050', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('475', '33', '1', '232073577', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388049', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('476', '33', '1', '232073903', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388048', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('477', '33', '1', '232073885', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388047', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('478', '33', '1', '232073692', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388046', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('479', '33', '1', '232073634', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388045', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('480', '33', '1', '232073909', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388044', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('481', '33', '1', '232073787', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388043', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('482', '33', '1', '232073875', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388042', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('483', '33', '1', '232073570', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388041', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('484', '33', '1', '232073700', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388040', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('485', '33', '1', '232073730', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388039', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('486', '33', '1', '232073607', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388038', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('487', '33', '1', '232073568', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388037', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('488', '33', '1', '232073860', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388036', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('489', '33', '1', '232073753', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388035', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('490', '33', '1', '232073456', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388034', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('491', '33', '1', '232073792', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388033', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('492', '33', '1', '232073718', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388032', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('493', '33', '1', '232073606', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388031', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('494', '33', '1', '232073546', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388030', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('495', '33', '1', '232073449', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388029', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('496', '33', '1', '232073647', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388028', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('497', '33', '1', '232073798', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388027', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('498', '33', '1', '232073904', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388026', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('499', '33', '1', '232073703', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388025', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('500', '33', '1', '232073455', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388024', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('501', '33', '1', '232073738', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388023', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('502', '33', '1', '232073725', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388022', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('503', '33', '1', '232073851', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388021', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('504', '33', '1', '232073672', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388020', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('505', '33', '1', '232073600', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388019', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('506', '33', '1', '232073452', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388018', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('507', '33', '1', '232073565', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388017', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('508', '33', '1', '232073869', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388016', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('509', '33', '1', '232073619', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388015', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('510', '33', '1', '232073901', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388014', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('511', '33', '1', '232073558', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388013', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('512', '33', '1', '232073818', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388012', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('513', '33', '1', '232073646', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388011', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('514', '33', '1', '232073686', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388010', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('515', '33', '1', '232073657', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388009', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('516', '33', '1', '232073762', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388008', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('517', '33', '1', '232073572', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388007', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('518', '33', '1', '232073603', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388006', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('519', '33', '1', '232073676', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388005', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('520', '33', '1', '232073689', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388004', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('521', '33', '1', '232073822', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388003', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('522', '33', '1', '232073576', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388002', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('523', '33', '1', '232073736', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388001', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('524', '33', '1', '232073741', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02388000', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('525', '33', '1', '232073691', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387999', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('526', '33', '1', '232073666', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387998', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('527', '33', '1', '232073732', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387997', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('528', '33', '1', '232073864', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387996', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('529', '33', '1', '232073917', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387995', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('530', '33', '1', '232073714', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387994', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('531', '33', '1', '232073664', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387993', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('532', '33', '1', '232073656', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387992', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('533', '33', '1', '232073655', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387991', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('534', '33', '1', '232073436', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387990', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('535', '33', '1', '232073720', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387989', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('536', '33', '1', '232073759', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387988', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('537', '33', '1', '232073629', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387987', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('538', '33', '1', '232073713', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387986', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('539', '33', '1', '232073742', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387985', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('540', '33', '1', '232073854', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387984', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('541', '33', '1', '232073563', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387983', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('542', '33', '1', '232073852', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387982', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('543', '33', '1', '232073711', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387981', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('544', '33', '1', '232073477', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387980', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('545', '33', '1', '232073737', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387979', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('546', '33', '1', '232073498', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387978', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('547', '33', '1', '232073458', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387977', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('548', '33', '1', '232073679', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387976', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('549', '33', '1', '232073893', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387975', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('550', '33', '1', '232073434', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387974', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('551', '33', '1', '232073688', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387973', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('552', '33', '1', '232073518', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387972', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('553', '33', '1', '232073871', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387971', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('554', '33', '1', '232073624', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387970', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('555', '33', '1', '232073734', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387969', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('556', '33', '1', '232073866', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387968', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('557', '33', '1', '232073708', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387967', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('558', '33', '1', '232073760', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387966', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('559', '33', '1', '232073858', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387965', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('560', '33', '1', '232073765', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387964', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('561', '33', '1', '232073756', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387963', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('562', '33', '1', '232073761', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387962', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('563', '33', '1', '232073578', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387961', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('564', '33', '1', '232073445', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387960', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('565', '33', '1', '232073872', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387959', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('566', '33', '1', '232073638', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387958', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('567', '33', '1', '232073877', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387957', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('568', '33', '1', '232073622', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387956', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('569', '33', '1', '232073783', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387955', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('570', '33', '1', '232073545', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387954', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('571', '33', '1', '232073882', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387953', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('572', '33', '1', '232073588', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387952', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('573', '33', '1', '232073636', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387951', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('574', '33', '1', '232073478', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387950', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('575', '33', '1', '232073845', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387949', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('576', '33', '1', '232073779', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387948', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('577', '33', '1', '232073447', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387947', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('578', '33', '1', '232073575', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387946', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('579', '33', '1', '232073554', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387945', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('580', '33', '1', '232073880', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387944', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('581', '33', '1', '232073667', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387943', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('582', '33', '1', '232073673', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387942', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('583', '33', '1', '232073771', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387941', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('584', '33', '1', '232073628', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387940', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('585', '33', '1', '232073454', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387939', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('586', '33', '1', '232073562', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387938', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('587', '33', '1', '232073685', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387937', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('588', '33', '1', '232073919', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387936', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('589', '33', '1', '232073898', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02387935', '', 'shuzchen', '2011-06-14', '', '565.12', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('590', '28', '1', '', 'Quad-shield RF cable bundle, RF Switch to HFC plant, 3m', 'ITM02385586', '', 'shuzchen', '2011-04-18', '', '50484.28', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('591', '29', '1', '', 'RF cable bundle, RF line card to RF Switch, 1m, spare', 'ITM02385587', '', 'shuzchen', '2011-04-18', '', '41305.32', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('592', '40', '0', 'FOC1445Y48L', 'Catalyst 2960 48 10/100 + 2 T/SFP   LAN Lite Image', 'ITM02386818', '', 'shuzchen', '2011-05-23', 'C13lab', '2589.2', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('593', '34', '0', 'FOC1423X517', 'Catalyst 2960 48 10/100 + 2 1000BT LAN Base Image', 'ITM02386787', '', 'shuzchen', '2010-12-15', 'C13lab', '5263.52', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('594', '34', '0', 'FOC1423W4XM', 'Catalyst 2960 48 10/100 + 2 1000BT LAN Base Image', 'ITM02386786', '', 'shuzchen', '2010-12-15', 'C13lab', '5263.52', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('595', '40', '0', 'FOC1411Y4M0', 'Catalyst 2960 48 10/100 + 2 T/SFP   LAN Lite Image', 'ITM02385724', '', 'shuzchen', '2011-04-14', 'C13lab', '2856.95', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('596', '32', '0', 'FHG1437R03A', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385286', '', 'shuzchen', '2011-04-14', 'C13lab', '5234.63', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('597', '32', '1', 'FHG1437R03J', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385279', '', 'shuzchen', '2011-04-14', '', '5234.63', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('598', '29', '1', '', 'RF cable bundle, RF line card to RF Switch, 1m, spare', '', '', 'shuzchen', '2011-04-18', '', '36715.84', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('599', '33', '1', '231439767', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384920', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('600', '33', '1', '231439667', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384919', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('601', '33', '1', '231439875', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384909', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('602', '33', '1', '231439627', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384896', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('603', '33', '1', '231439842', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384883', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('604', '33', '1', '231439956', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384872', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('605', '33', '1', '231439848', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384845', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('606', '33', '1', '231439623', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384780', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('607', '33', '1', '231439833', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384747', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('608', '33', '1', '231439677', 'DPC3212 Modem,DOCSIS 3.0,EMTA,USB,NA PS (Mult=10)', 'ITM02384612', '', 'shuzchen', '2011-03-31', '', '573.03', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('609', '37', '1', '', 'N/A', '', '', 'shuzchen', '2010-04-14', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('610', '8', '0', 'FHK1341F1L1', '2811 w/ AC+POE,2FE,4HWICs,2PVDMs,1NME,2AIMS,IPBASE,128F/512D', 'ITM02391211', '', 'qinmeng', '2011-04-29', 'C13 Lab', '6482.64', 'qinmeng');
INSERT INTO AC_ASSET VALUES ('611', '41', '0', 'FTX1327A143', '2811 VSEC Bundle w/PVDM2-16,FL-CCME-35,Adv IP Serv,128F/512D', 'ITM02391242', '', 'qinmeng', '2011-04-29', 'C13 Lab', '10773.8', 'qinmeng');
INSERT INTO AC_ASSET VALUES ('612', '11', '1', '', 'RF cable bundle,RF line card to RF Switch ,Lm,spare', 'ITM02391109', '', 'shuzchen', '2011-07-28', '', '31710.84', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('613', '12', '1', '', 'High Density 8-port EIA-232 Async', 'ITM02391107', '', 'shuzchen', '2011-07-28', '', '213.56', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('614', '34', '0', 'FOC1201Z6LM', 'Catalyst 2960 48 10/100 + 2 1000BT LAN Base Image', 'ITM02391044', '', 'shuzchen', '2011-08-01', 'C13 Lab', '5145.05', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('615', '34', '0', 'FOC1201Z6S5', 'Catalyst 2960 48 10/100 + 2 1000BT LAN Base Image', 'ITM02391043', '', 'shuzchen', '2011-08-01', 'C13 Lab', '5145.05', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('616', '42', '0', 'FOC1351Y1AU', 'Catalyst 2960 48 10/100/1000,  4 T/SFP  LAN Base Image', 'ITM02390209', '', 'shuzchen', '2011-05-26', 'C13 Lab', '13636.53', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('617', '42', '0', 'FOC1351Y5DB', 'CATALYST 2960 48 10/100/1000, 4 T/SFP LAN BASE IMAGE', 'ITM02390199', '', 'shuzchen', '2011-05-26', 'C13 Lab', '12467.68', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('618', '32', '0', 'FOC1326V38A', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02390169', '', 'shuzchen', '2011-05-26', 'C13 Lab', '5675.25', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('619', '43', '0', 'FDO15-8Y300', 'Calalyst 3750e 48 10/100/1000+2*10GE(X2)', 'ITM02390151', '', 'shuzchen', '2011-06-08', 'C13 Lab', '36626.27', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('620', '44', '0', 'FOX1447GSK6', 'Catalyst 4948, IPB s/w, 48*10/100/1000+2*10GE(X2), 1 AC p/s', 'ITM02390155', '', 'shuzchen', '2011-06-08', 'C13 Lab', '34043.63', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('621', '13', '0', 'FOX1415GM2B', 'Catalyst 4948, ES Image, 48*10/100/1000+2*10GE(X2), 1 AC p/s', 'ITM02390132', '', 'shuzchen', '2011-05-09', 'C13 Lab', '39513.92', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('622', '42', '0', 'FOC1337Y13V', 'Catalyst 2960 48 10/100/1000,  4 T/SFP  LAN Base Image', 'ITM02388335', '', 'shuzchen', '2011-05-26', 'C13 Lab', '13636.53', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('623', '45', '0', '', 'Samsung E2220W', '', '', 'zhimzhan', '2011-08-04', 'C13 Lab', '1320', 'zhimzhan');
INSERT INTO AC_ASSET VALUES ('624', '40', '0', 'FOC1445Y4GT', 'Catalyst 2960 48 10/100 + 2 T/SFP   LAN Lite Image', 'ITM02385704', '', 'shuzchen', '2011-07-20', 'C13 Lab', '2820', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('625', '28', '1', '', 'Quad-shield RF cable bundle, RF Switch to HFC plant, 3m', 'ITM02385586', '', 'shuzchen', '2011-04-18', '', '50484.28', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('626', '29', '1', '', 'RF cable bundle, RF line card to RF Switch, 1m, spare', 'ITM02385587', '', 'shuzchen', '2011-04-18', '', '41305.32', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('627', '32', '1', 'FOC1438V26N', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02383577', '', 'shuzchen', '2011-03-16', '', '5249.64', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('628', '46', '0', 'FHK1435F14R', '2811 Security Bundle,Adv Security,128F/512D', 'ITM02372606', '', 'qinmeng', '2011-06-13', 'C13 Lab', '5861.99', 'qinmeng');
INSERT INTO AC_ASSET VALUES ('629', '46', '0', 'FHK1435F151', '2811 Security Bundle,Adv Security,128F/512D', 'ITM02372573', '', 'shuzchen', '2011-06-13', 'C13 Lab', '5861.99', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('630', '47', '1', 'FOC1433Y7U1', 'CATALYST 3750 48 10/100/1000T POE + 4 SFP + IPB IMAGE', 'ITM02386819', '', 'shuzchen', '2011-05-23', '', '32224.64', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('631', '29', '1', '', 'RF cable bundle, RF line card to RF Switch, 1m, spare', '', '', 'shuzchen', '2011-04-18', '', '36715.84', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('632', '37', '1', '', 'N/A', '', '', 'shuzchen', '2010-04-14', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('633', '11', '1', '', 'RF cable bundle,RF line card to RF Switch ,Lm,spare', 'ITM02391109', '', 'shuzchen', '2011-07-28', '', '31710.84', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('634', '12', '1', '', 'High Density 8-port EIA-232 Async', 'ITM02391107', '', 'shuzchen', '2011-07-28', '', '213.56', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('635', '45', '0', '', 'Samsung E2220W', '', '', 'zhimzhan', '2011-08-04', 'C13 Lab', '1320', 'zhimzhan');
INSERT INTO AC_ASSET VALUES ('636', '28', '1', '', 'Quad-shield RF cable bundle, RF Switch to HFC plant, 3m', 'ITM02385586', '', 'shuzchen', '2011-04-18', '', '50484.28', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('637', '29', '1', '', 'RF cable bundle, RF line card to RF Switch, 1m, spare', 'ITM02385587', '', 'shuzchen', '2011-04-18', '', '41305.32', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('638', '29', '1', '', 'RF cable bundle, RF line card to RF Switch, 1m, spare', '', '', 'shuzchen', '2011-04-18', '', '36715.84', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('639', '37', '1', '', 'N/A', '', '', 'shuzchen', '2010-04-14', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('640', '45', '1', '', 'Samsung E2220W', '', '', 'zhimzhan', '', '', '0', 'zhimzhan');
INSERT INTO AC_ASSET VALUES ('641', '48', '1', '232431039', 'DPC3010 CABLE,MODEM', 'ITM02389513', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('642', '48', '1', '232431773', 'DPC3010 CABLE,MODEM', 'ITM02389512', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('643', '48', '1', '232431149', 'DPC3010 CABLE,MODEM', 'ITM02389511', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('644', '48', '1', '232431786', 'DPC3010 CABLE,MODEM', 'ITM02389510', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('645', '48', '1', '232431070', 'DPC3010 CABLE,MODEM', 'ITM02389509', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('646', '48', '1', '232431033', 'DPC3010 CABLE,MODEM', 'ITM02389508', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('647', '48', '1', '232431781', 'DPC3010 CABLE,MODEM', 'ITM02389507', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('648', '48', '1', '232431756', 'DPC3010 CABLE,MODEM', 'ITM02389505', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('649', '48', '1', '232431736', 'DPC3010 CABLE,MODEM', 'ITM02389504', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('650', '48', '1', '232431040', 'DPC3010 CABLE,MODEM', 'ITM02389503', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('651', '48', '1', '232431458', 'DPC3010 CABLE,MODEM', 'ITM02389502', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('652', '48', '1', '232431790', 'DPC3010 CABLE,MODEM', 'ITM02389501', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('653', '48', '1', '232431737', 'DPC3010 CABLE,MODEM', 'ITM02389499', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('654', '48', '1', '232431759', 'DPC3010 CABLE,MODEM', 'ITM02389498', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('655', '48', '1', '232431732', 'DPC3010 CABLE,MODEM', 'ITM02389497', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('656', '48', '1', '232431707', 'DPC3010 CABLE,MODEM', 'ITM02389496', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('657', '48', '1', '232431763', 'DPC3010 CABLE,MODEM', 'ITM02389495', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('658', '48', '1', '232431053', 'DPC3010 CABLE,MODEM', 'ITM02389494', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('659', '48', '1', '232431751', 'DPC3010 CABLE,MODEM', 'ITM02389493', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('660', '48', '1', '232431742', 'DPC3010 CABLE,MODEM', 'ITM02389492', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('661', '48', '1', '232431799', 'DPC3010 CABLE,MODEM', 'ITM02389491', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('662', '48', '1', '232431733', 'DPC3010 CABLE,MODEM', 'ITM02389490', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('663', '48', '1', '232431791', 'DPC3010 CABLE,MODEM', 'ITM02389489', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('664', '48', '1', '232431074', 'DPC3010 CABLE,MODEM', 'ITM02389488', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('665', '48', '1', '232431754', 'DPC3010 CABLE,MODEM', 'ITM02389486', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('666', '48', '1', '232431692', 'DPC3010 CABLE,MODEM', 'ITM02389485', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('667', '48', '1', '232431787', 'DPC3010 CABLE,MODEM', 'ITM02389484', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('668', '48', '1', '232431758', 'DPC3010 CABLE,MODEM', 'ITM02389483', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('669', '48', '1', '232431072', 'DPC3010 CABLE,MODEM', 'ITM02389482', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('670', '48', '1', '232431983', 'DPC3010 CABLE,MODEM', 'ITM02389481', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('671', '48', '1', '232431699', 'DPC3010 CABLE,MODEM', 'ITM02389480', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('672', '48', '1', '232431980', 'DPC3010 CABLE,MODEM', 'ITM02389478', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('673', '48', '1', '232431734', 'DPC3010 CABLE,MODEM', 'ITM02389477', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('674', '48', '1', '232431135', 'DPC3010 CABLE,MODEM', 'ITM02389476', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('675', '48', '1', '232431060', 'DPC3010 CABLE,MODEM', 'ITM02389475', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('676', '48', '1', '232431788', 'DPC3010 CABLE,MODEM', 'ITM02389474', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('677', '48', '1', '232431730', 'DPC3010 CABLE,MODEM', 'ITM02389473', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('678', '48', '1', '232431832', 'DPC3010 CABLE,MODEM', 'ITM02389472', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('679', '48', '1', '232431974', 'DPC3010 CABLE,MODEM', 'ITM02389471', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('680', '48', '1', '232431741', 'DPC3010 CABLE,MODEM', 'ITM02389470', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('681', '48', '1', '232431755', 'DPC3010 CABLE,MODEM', 'ITM02389469', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('682', '48', '1', '232431769', 'DPC3010 CABLE,MODEM', 'ITM02389468', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('683', '48', '1', '232431727', 'DPC3010 CABLE,MODEM', 'ITM02389467', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('684', '48', '1', '232431869', 'DPC3010 CABLE,MODEM', 'ITM02389466', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('685', '48', '1', '232431972', 'DPC3010 CABLE,MODEM', 'ITM02389465', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('686', '48', '1', '232431975', 'DPC3010 CABLE,MODEM', 'ITM02389464', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('687', '48', '1', '232431147', 'DPC3010 CABLE,MODEM', 'ITM02389463', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('688', '48', '1', '232430928', 'DPC3010 CABLE,MODEM', 'ITM02389462', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('689', '48', '1', '232431748', 'DPC3010 CABLE,MODEM', 'ITM02389461', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('690', '48', '1', '232431154', 'DPC3010 CABLE,MODEM', 'ITM02389460', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('691', '48', '1', '232431119', 'DPC3010 CABLE,MODEM', 'ITM02389459', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('692', '48', '1', '232431770', 'DPC3010 CABLE,MODEM', 'ITM02389458', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('693', '48', '1', '232431735', 'DPC3010 CABLE,MODEM', 'ITM02389457', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('694', '48', '1', '232431976', 'DPC3010 CABLE,MODEM', 'ITM02389456', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('695', '48', '1', '232431729', 'DPC3010 CABLE,MODEM', 'ITM02389455', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('696', '48', '1', '232431793', 'DPC3010 CABLE,MODEM', 'ITM02389454', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('697', '48', '1', '232431158', 'DPC3010 CABLE,MODEM', 'ITM02389453', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('698', '48', '1', '232431981', 'DPC3010 CABLE,MODEM', 'ITM02389452', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('699', '48', '1', '232431089', 'DPC3010 CABLE,MODEM', 'ITM02389451', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('700', '48', '1', '232431157', 'DPC3010 CABLE,MODEM', 'ITM02389450', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('701', '48', '1', '232431921', 'DPC3010 CABLE,MODEM', 'ITM02389449', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('702', '48', '1', '232431728', 'DPC3010 CABLE,MODEM', 'ITM02389448', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('703', '48', '1', '232431066', 'DPC3010 CABLE,MODEM', 'ITM02389447', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('704', '48', '1', '232431191', 'DPC3010 CABLE,MODEM', 'ITM02389446', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('705', '48', '1', '232431028', 'DPC3010 CABLE,MODEM', 'ITM02389445', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('706', '48', '1', '232431075', 'DPC3010 CABLE,MODEM', 'ITM02389444', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('707', '48', '1', '232431731', 'DPC3010 CABLE,MODEM', 'ITM02389443', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('708', '48', '1', '232431065', 'DPC3010 CABLE,MODEM', 'ITM02389442', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('709', '48', '1', '232431038', 'DPC3010 CABLE,MODEM', 'ITM02389440', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('710', '48', '1', '232431689', 'DPC3010 CABLE,MODEM', 'ITM02389439', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('711', '48', '1', '232431054', 'DPC3010 CABLE,MODEM', 'ITM02389437', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('712', '48', '1', '232431795', 'DPC3010 CABLE,MODEM', 'ITM02389436', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('713', '48', '1', '232431134', 'DPC3010 CABLE,MODEM', 'ITM02389435', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('714', '48', '1', '232431139', 'DPC3010 CABLE,MODEM', 'ITM02389434', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('715', '48', '1', '232431523', 'DPC3010 CABLE,MODEM', 'ITM02389433', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('716', '48', '1', '232431749', 'DPC3010 CABLE,MODEM', 'ITM02389432', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('717', '48', '1', '232431016', 'DPC3010 CABLE,MODEM', 'ITM02389431', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('718', '48', '1', '232431138', 'DPC3010 CABLE,MODEM', 'ITM02389430', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('719', '48', '1', '232430902', 'DPC3010 CABLE,MODEM', 'ITM02389429', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('720', '48', '1', '232431194', 'DPC3010 CABLE,MODEM', 'ITM02389427', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('721', '48', '1', '232431706', 'DPC3010 CABLE,MODEM', 'ITM02389426', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('722', '48', '1', '232431550', 'DPC3010 CABLE,MODEM', 'ITM02389425', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('723', '48', '1', '232431760', 'DPC3010 CABLE,MODEM', 'ITM02389424', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('724', '48', '1', '232431782', 'DPC3010 CABLE,MODEM', 'ITM02389423', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('725', '48', '1', '232431637', 'DPC3010 CABLE,MODEM', 'ITM02389422', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('726', '48', '1', '232431610', 'DPC3010 CABLE,MODEM', 'ITM02389421', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('727', '48', '1', '232431623', 'DPC3010 CABLE,MODEM', 'ITM02389420', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('728', '48', '1', '232431619', 'DPC3010 CABLE,MODEM', 'ITM02389419', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('729', '48', '1', '232431617', 'DPC3010 CABLE,MODEM', 'ITM02389418', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('730', '48', '1', '232431551', 'DPC3010 CABLE,MODEM', 'ITM02389417', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('731', '48', '1', '232431643', 'DPC3010 CABLE,MODEM', 'ITM02389416', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('732', '48', '1', '232431472', 'DPC3010 CABLE,MODEM', 'ITM02389415', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('733', '48', '1', '232431558', 'DPC3010 CABLE,MODEM', 'ITM02389414', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('734', '48', '1', '232431502', 'DPC3010 CABLE,MODEM', 'ITM02389413', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('735', '48', '1', '232431494', 'DPC3010 CABLE,MODEM', 'ITM02389412', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('736', '48', '1', '232431490', 'DPC3010 CABLE,MODEM', 'ITM02389411', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('737', '48', '1', '232431488', 'DPC3010 CABLE,MODEM', 'ITM02389410', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('738', '48', '1', '232431485', 'DPC3010 CABLE,MODEM', 'ITM02389409', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('739', '48', '1', '232431508', 'DPC3010 CABLE,MODEM', 'ITM02389408', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('740', '48', '1', '232431476', 'DPC3010 CABLE,MODEM', 'ITM02389407', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('741', '48', '1', '232431511', 'DPC3010 CABLE,MODEM', 'ITM02389406', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('742', '48', '1', '232431464', 'DPC3010 CABLE,MODEM', 'ITM02389405', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('743', '48', '1', '232431463', 'DPC3010 CABLE,MODEM', 'ITM02389404', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('744', '48', '1', '232431462', 'DPC3010 CABLE,MODEM', 'ITM02389403', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('745', '48', '1', '232431460', 'DPC3010 CABLE,MODEM', 'ITM02389402', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('746', '48', '1', '232431986', 'DPC3010 CABLE,MODEM', 'ITM02389401', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('747', '48', '1', '232431477', 'DPC3010 CABLE,MODEM', 'ITM02389400', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('748', '48', '1', '232431698', 'DPC3010 CABLE,MODEM', 'ITM02389399', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('749', '48', '1', '232431515', 'DPC3010 CABLE,MODEM', 'ITM02389398', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('750', '48', '1', '232431518', 'DPC3010 CABLE,MODEM', 'ITM02389397', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('751', '48', '1', '232431521', 'DPC3010 CABLE,MODEM', 'ITM02389396', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('752', '48', '1', '232431528', 'DPC3010 CABLE,MODEM', 'ITM02389395', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('753', '48', '1', '232431529', 'DPC3010 CABLE,MODEM', 'ITM02389394', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('754', '48', '1', '232431541', 'DPC3010 CABLE,MODEM', 'ITM02389393', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('755', '48', '1', '232431542', 'DPC3010 CABLE,MODEM', 'ITM02389392', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('756', '48', '1', '232431546', 'DPC3010 CABLE,MODEM', 'ITM02389391', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('757', '48', '1', '232431547', 'DPC3010 CABLE,MODEM', 'ITM02389390', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('758', '48', '1', '232431548', 'DPC3010 CABLE,MODEM', 'ITM02389389', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('759', '48', '1', '232431549', 'DPC3010 CABLE,MODEM', 'ITM02389388', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('760', '48', '1', '232431612', 'DPC3010 CABLE,MODEM', 'ITM02389387', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('761', '48', '1', '231517330', 'DPC3010 CABLE,MODEM', 'ITM02389386', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('762', '48', '1', '232431579', 'DPC3010 CABLE,MODEM', 'ITM02389385', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('763', '48', '1', '232431605', 'DPC3010 CABLE,MODEM', 'ITM02389384', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('764', '48', '1', '232431601', 'DPC3010 CABLE,MODEM', 'ITM02389383', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('765', '48', '1', '232431594', 'DPC3010 CABLE,MODEM', 'ITM02389382', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('766', '48', '1', '232431590', 'DPC3010 CABLE,MODEM', 'ITM02389381', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('767', '48', '1', '232431589', 'DPC3010 CABLE,MODEM', 'ITM02389380', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('768', '48', '1', '232431588', 'DPC3010 CABLE,MODEM', 'ITM02389379', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('769', '48', '1', '232431556', 'DPC3010 CABLE,MODEM', 'ITM02389378', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('770', '48', '1', '232431582', 'DPC3010 CABLE,MODEM', 'ITM02389377', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('771', '48', '1', '232431576', 'DPC3010 CABLE,MODEM', 'ITM02389376', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('772', '48', '1', '232431574', 'DPC3010 CABLE,MODEM', 'ITM02389375', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('773', '48', '1', '232431572', 'DPC3010 CABLE,MODEM', 'ITM02389374', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('774', '48', '1', '232431562', 'DPC3010 CABLE,MODEM', 'ITM02389373', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('775', '48', '1', '232431457', 'DPC3010 CABLE,MODEM', 'ITM02389372', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('776', '48', '1', '232431627', 'DPC3010 CABLE,MODEM', 'ITM02389371', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('777', '48', '1', '232431688', 'DPC3010 CABLE,MODEM', 'ITM02389370', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('778', '48', '1', '232431685', 'DPC3010 CABLE,MODEM', 'ITM02389369', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('779', '48', '1', '232431677', 'DPC3010 CABLE,MODEM', 'ITM02389368', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('780', '48', '1', '232431663', 'DPC3010 CABLE,MODEM', 'ITM02389367', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('781', '48', '1', '232431653', 'DPC3010 CABLE,MODEM', 'ITM02389366', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('782', '48', '1', '232431652', 'DPC3010 CABLE,MODEM', 'ITM02389365', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('783', '48', '1', '232431607', 'DPC3010 CABLE,MODEM', 'ITM02389364', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('784', '48', '1', '232431778', 'DPC3010 CABLE,MODEM', 'ITM02389363', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('785', '48', '1', '232431128', 'DPC3010 CABLE,MODEM', 'ITM02389362', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('786', '48', '1', '232431503', 'DPC3010 CABLE,MODEM', 'ITM02389361', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('787', '48', '1', '232431739', 'DPC3010 CABLE,MODEM', 'ITM02389360', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('788', '48', '1', '232431794', 'DPC3010 CABLE,MODEM', 'ITM02389359', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('789', '48', '1', '232431087', 'DPC3010 CABLE,MODEM', 'ITM02389357', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('790', '48', '1', '232431738', 'DPC3010 CABLE,MODEM', 'ITM02389356', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('791', '48', '1', '232431785', 'DPC3010 CABLE,MODEM', 'ITM02389355', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('792', '48', '1', '232431701', 'DPC3010 CABLE,MODEM', 'ITM02389354', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('793', '48', '1', '232431272', 'DPC3010 CABLE,MODEM', 'ITM02389353', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('794', '48', '1', '232432001', 'DPC3010 CABLE,MODEM', 'ITM02389352', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('795', '48', '1', '232432122', 'DPC3010 CABLE,MODEM', 'ITM02389351', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('796', '48', '1', '232431989', 'DPC3010 CABLE,MODEM', 'ITM02389350', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('797', '48', '1', '232430443', 'DPC3010 CABLE,MODEM', 'ITM02389349', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('798', '48', '1', '232432233', 'DPC3010 CABLE,MODEM', 'ITM02389348', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('799', '48', '1', '232430100', 'DPC3010 CABLE,MODEM', 'ITM02389346', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('800', '48', '1', '232430288', 'DPC3010 CABLE,MODEM', 'ITM02389344', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('801', '48', '1', '231516410', 'DPC3010 CABLE,MODEM', 'ITM02389342', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('802', '48', '1', '232428438', 'DPC3010 CABLE,MODEM', 'ITM02389341', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('803', '48', '1', '232429823', 'DPC3010 CABLE,MODEM', 'ITM02389340', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('804', '48', '1', '232432071', 'DPC3010 CABLE,MODEM', 'ITM02389339', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('805', '48', '1', '232427899', 'DPC3010 CABLE,MODEM', 'ITM02389338', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('806', '48', '1', '232428502', 'DPC3010 CABLE,MODEM', 'ITM02389337', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('807', '48', '1', '232430494', 'DPC3010 CABLE,MODEM', 'ITM02389336', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('808', '48', '1', '232432186', 'DPC3010 CABLE,MODEM', 'ITM02389335', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('809', '48', '1', '232432210', 'DPC3010 CABLE,MODEM', 'ITM02389334', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('810', '48', '1', '232430526', 'DPC3010 CABLE,MODEM', 'ITM02389333', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('811', '48', '1', '232428546', 'DPC3010 CABLE,MODEM', 'ITM02389332', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('812', '48', '1', '232432131', 'DPC3010 CABLE,MODEM', 'ITM02389331', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('813', '48', '1', '232431417', 'DPC3010 CABLE,MODEM', 'ITM02389330', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('814', '48', '1', '231516478', 'DPC3010 CABLE,MODEM', 'ITM02389329', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('815', '48', '1', '232430586', 'DPC3010 CABLE,MODEM', 'ITM02389328', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('816', '48', '1', '232430381', 'DPC3010 CABLE,MODEM', 'ITM02389327', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('817', '48', '1', '232427993', 'DPC3010 CABLE,MODEM', 'ITM02389326', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('818', '48', '1', '232432018', 'DPC3010 CABLE,MODEM', 'ITM02389325', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('819', '48', '1', '232430943', 'DPC3010 CABLE,MODEM', 'ITM02389324', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('820', '48', '1', '232430434', 'DPC3010 CABLE,MODEM', 'ITM02389323', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('821', '48', '1', '232427837', 'DPC3010 CABLE,MODEM', 'ITM02389322', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('822', '48', '1', '232431404', 'DPC3010 CABLE,MODEM', 'ITM02389321', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('823', '48', '1', '232432043', 'DPC3010 CABLE,MODEM', 'ITM02389320', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('824', '48', '1', '232431353', 'DPC3010 CABLE,MODEM', 'ITM02389319', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('825', '48', '1', '232432200', 'DPC3010 CABLE,MODEM', 'ITM02389318', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('826', '48', '1', '231516955', 'DPC3010 CABLE,MODEM', 'ITM02389317', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('827', '48', '1', '232429565', 'DPC3010 CABLE,MODEM', 'ITM02389316', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('828', '48', '1', '232432065', 'DPC3010 CABLE,MODEM', 'ITM02389315', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('829', '48', '1', '232427978', 'DPC3010 CABLE,MODEM', 'ITM02389314', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('830', '48', '1', '232431990', 'DPC3010 CABLE,MODEM', 'ITM02389313', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('831', '48', '1', '231516048', 'DPC3010 CABLE,MODEM', 'ITM02389312', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('832', '48', '1', '232432310', 'DPC3010 CABLE,MODEM', 'ITM02389311', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('833', '48', '1', '232428487', 'DPC3010 CABLE,MODEM', 'ITM02389310', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('834', '48', '1', '232432373', 'DPC3010 CABLE,MODEM', 'ITM02389309', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('835', '48', '1', '232432146', 'DPC3010 CABLE,MODEM', 'ITM02389308', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('836', '48', '1', '232430016', 'DPC3010 CABLE,MODEM', 'ITM02389307', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('837', '48', '1', '232432187', 'DPC3010 CABLE,MODEM', 'ITM02389306', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('838', '48', '1', '232429876', 'DPC3010 CABLE,MODEM', 'ITM02389305', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('839', '48', '1', '232430718', 'DPC3010 CABLE,MODEM', 'ITM02389304', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('840', '48', '1', '232428547', 'DPC3010 CABLE,MODEM', 'ITM02389303', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('841', '48', '1', '232432047', 'DPC3010 CABLE,MODEM', 'ITM02389302', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('842', '48', '1', '232430038', 'DPC3010 CABLE,MODEM', 'ITM02389301', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('843', '48', '1', '232428120', 'DPC3010 CABLE,MODEM', 'ITM02389300', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('844', '48', '1', '232432104', 'DPC3010 CABLE,MODEM', 'ITM02389299', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('845', '48', '1', '232427841', 'DPC3010 CABLE,MODEM', 'ITM02389298', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('846', '48', '1', '232430436', 'DPC3010 CABLE,MODEM', 'ITM02389297', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('847', '48', '1', '232430369', 'DPC3010 CABLE,MODEM', 'ITM02389296', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('848', '48', '1', '232430419', 'DPC3010 CABLE,MODEM', 'ITM02389295', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('849', '48', '1', '232432061', 'DPC3010 CABLE,MODEM', 'ITM02389294', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('850', '48', '1', '232431379', 'DPC3010 CABLE,MODEM', 'ITM02389293', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('851', '48', '1', '232430203', 'DPC3010 CABLE,MODEM', 'ITM02389292', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('852', '48', '1', '232431288', 'DPC3010 CABLE,MODEM', 'ITM02389291', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('853', '48', '1', '232428347', 'DPC3010 CABLE,MODEM', 'ITM02389290', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('854', '48', '1', '232430537', 'DPC3010 CABLE,MODEM', 'ITM02389289', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('855', '48', '1', '232432020', 'DPC3010 CABLE,MODEM', 'ITM02389288', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('856', '48', '1', '232429939', 'DPC3010 CABLE,MODEM', 'ITM02389287', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('857', '48', '1', '232431266', 'DPC3010 CABLE,MODEM', 'ITM02389285', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('858', '48', '1', '232432110', 'DPC3010 CABLE,MODEM', 'ITM02389284', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('859', '48', '1', '231517259', 'DPC3010 CABLE,MODEM', 'ITM02389283', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('860', '48', '1', '232428290', 'DPC3010 CABLE,MODEM', 'ITM02389282', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('861', '48', '1', '232432191', 'DPC3010 CABLE,MODEM', 'ITM02389281', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('862', '48', '1', '232432378', 'DPC3010 CABLE,MODEM', 'ITM02389280', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('863', '48', '1', '231516416', 'DPC3010 CABLE,MODEM', 'ITM02389279', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('864', '48', '1', '231516842', 'DPC3010 CABLE,MODEM', 'ITM02389278', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('865', '48', '1', '232428942', 'DPC3010 CABLE,MODEM', 'ITM02389277', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('866', '48', '1', '232431436', 'DPC3010 CABLE,MODEM', 'ITM02389276', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('867', '48', '1', '232430359', 'DPC3010 CABLE,MODEM', 'ITM02389275', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('868', '48', '1', '232429747', 'DPC3010 CABLE,MODEM', 'ITM02389274', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('869', '48', '1', '232432078', 'DPC3010 CABLE,MODEM', 'ITM02389273', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('870', '48', '1', '232430869', 'DPC3010 CABLE,MODEM', 'ITM02389272', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('871', '48', '1', '232430861', 'DPC3010 CABLE,MODEM', 'ITM02389271', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('872', '48', '1', '231517197', 'DPC3010 CABLE,MODEM', 'ITM02389270', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('873', '48', '1', '232432003', 'DPC3010 CABLE,MODEM', 'ITM02389269', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('874', '48', '1', '231514543', 'DPC3010 CABLE,MODEM', 'ITM02389268', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('875', '48', '1', '232432013', 'DPC3010 CABLE,MODEM', 'ITM02389267', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('876', '48', '1', '232430545', 'DPC3010 CABLE,MODEM', 'ITM02389266', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('877', '48', '1', '232430166', 'DPC3010 CABLE,MODEM', 'ITM02389265', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('878', '48', '1', '232430609', 'DPC3010 CABLE,MODEM', 'ITM02389264', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('879', '48', '1', '232432111', 'DPC3010 CABLE,MODEM', 'ITM02389263', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('880', '48', '1', '232432052', 'DPC3010 CABLE,MODEM', 'ITM02389262', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('881', '48', '1', '232430424', 'DPC3010 CABLE,MODEM', 'ITM02389261', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('882', '48', '1', '232432190', 'DPC3010 CABLE,MODEM', 'ITM02389260', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('883', '48', '1', '232430873', 'DPC3010 CABLE,MODEM', 'ITM02389259', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('884', '48', '1', '232432070', 'DPC3010 CABLE,MODEM', 'ITM02389258', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('885', '48', '1', '232432183', 'DPC3010 CABLE,MODEM', 'ITM02389257', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('886', '48', '1', '232428203', 'DPC3010 CABLE,MODEM', 'ITM02389255', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('887', '48', '1', '232432198', 'DPC3010 CABLE,MODEM', 'ITM02389254', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('888', '48', '1', '232432217', 'DPC3010 CABLE,MODEM', 'ITM02389253', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('889', '48', '1', '232430208', 'DPC3010 CABLE,MODEM', 'ITM02389252', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('890', '48', '1', '232428541', 'DPC3010 CABLE,MODEM', 'ITM02389251', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('891', '48', '1', '232432062', 'DPC3010 CABLE,MODEM', 'ITM02389250', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('892', '48', '1', '232429849', 'DPC3010 CABLE,MODEM', 'ITM02389249', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('893', '48', '1', '232430142', 'DPC3010 CABLE,MODEM', 'ITM02389248', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('894', '48', '1', '232430379', 'DPC3010 CABLE,MODEM', 'ITM02389247', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('895', '48', '1', '232432246', 'DPC3010 CABLE,MODEM', 'ITM02389246', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('896', '48', '1', '232430384', 'DPC3010 CABLE,MODEM', 'ITM02389245', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('897', '48', '1', '232428516', 'DPC3010 CABLE,MODEM', 'ITM02389244', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('898', '48', '1', '232430483', 'DPC3010 CABLE,MODEM', 'ITM02389243', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('899', '48', '1', '232430719', 'DPC3010 CABLE,MODEM', 'ITM02389240', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('900', '48', '1', '232428833', 'DPC3010 CABLE,MODEM', 'ITM02389239', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('901', '48', '1', '231516023', 'DPC3010 CABLE,MODEM', 'ITM02389238', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('902', '48', '1', '232432152', 'DPC3010 CABLE,MODEM', 'ITM02389237', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('903', '48', '1', '231516029', 'DPC3010 CABLE,MODEM', 'ITM02389236', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('904', '48', '1', '231516917', 'DPC3010 CABLE,MODEM', 'ITM02389235', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('905', '48', '1', '231516887', 'DPC3010 CABLE,MODEM', 'ITM02389234', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('906', '48', '1', '232432301', 'DPC3010 CABLE,MODEM', 'ITM02389233', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('907', '48', '1', '232430141', 'DPC3010 CABLE,MODEM', 'ITM02389232', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('908', '48', '1', '232430907', 'DPC3010 CABLE,MODEM', 'ITM02389231', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('909', '48', '1', '232427748', 'DPC3010 CABLE,MODEM', 'ITM02389230', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('910', '48', '1', '232432069', 'DPC3010 CABLE,MODEM', 'ITM02389229', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('911', '48', '1', '231515933', 'DPC3010 CABLE,MODEM', 'ITM02389228', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('912', '48', '1', '232430415', 'DPC3010 CABLE,MODEM', 'ITM02389227', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('913', '48', '1', '232431987', 'DPC3010 CABLE,MODEM', 'ITM02389226', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('914', '48', '1', '231516896', 'DPC3010 CABLE,MODEM', 'ITM02389225', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('915', '48', '1', '232428249', 'DPC3010 CABLE,MODEM', 'ITM02389224', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('916', '48', '1', '231517390', 'DPC3010 CABLE,MODEM', 'ITM02389223', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('917', '48', '1', '232430499', 'DPC3010 CABLE,MODEM', 'ITM02389222', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('918', '48', '1', '232431250', 'DPC3010 CABLE,MODEM', 'ITM02389221', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('919', '48', '1', '231517500', 'DPC3010 CABLE,MODEM', 'ITM02389220', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('920', '48', '1', '232430626', 'DPC3010 CABLE,MODEM', 'ITM02389219', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('921', '48', '1', '232432094', 'DPC3010 CABLE,MODEM', 'ITM02389218', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('922', '48', '1', '232430779', 'DPC3010 CABLE,MODEM', 'ITM02389217', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('923', '48', '1', '232430457', 'DPC3010 CABLE,MODEM', 'ITM02389216', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('924', '48', '1', '232427963', 'DPC3010 CABLE,MODEM', 'ITM02389215', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('925', '48', '1', '231516844', 'DPC3010 CABLE,MODEM', 'ITM02389214', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('926', '48', '1', '232432072', 'DPC3010 CABLE,MODEM', 'ITM02389213', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('927', '48', '1', '232431440', 'DPC3010 CABLE,MODEM', 'ITM02389211', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('928', '48', '1', '232431295', 'DPC3010 CABLE,MODEM', 'ITM02389210', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('929', '48', '1', '231517352', 'DPC3010 CABLE,MODEM', 'ITM02389209', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('930', '48', '1', '232430504', 'DPC3010 CABLE,MODEM', 'ITM02389208', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('931', '48', '1', '231516730', 'DPC3010 CABLE,MODEM', 'ITM02389207', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('932', '48', '1', '232430972', 'DPC3010 CABLE,MODEM', 'ITM02389206', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('933', '48', '1', '231517460', 'DPC3010 CABLE,MODEM', 'ITM02389205', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('934', '48', '1', '232432057', 'DPC3010 CABLE,MODEM', 'ITM02389204', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('935', '48', '1', '232432226', 'DPC3010 CABLE,MODEM', 'ITM02389203', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('936', '48', '1', '232428285', 'DPC3010 CABLE,MODEM', 'ITM02389201', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('937', '48', '1', '232430036', 'DPC3010 CABLE,MODEM', 'ITM02389200', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('938', '48', '1', '232430312', 'DPC3010 CABLE,MODEM', 'ITM02389199', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('939', '48', '1', '232432112', 'DPC3010 CABLE,MODEM', 'ITM02389198', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('940', '48', '1', '232431248', 'DPC3010 CABLE,MODEM', 'ITM02389197', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('941', '48', '1', '232430295', 'DPC3010 CABLE,MODEM', 'ITM02389195', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('942', '48', '1', '232428115', 'DPC3010 CABLE,MODEM', 'ITM02389194', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('943', '48', '1', '232432144', 'DPC3010 CABLE,MODEM', 'ITM02389193', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('944', '48', '1', '232429918', 'DPC3010 CABLE,MODEM', 'ITM02389192', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('945', '48', '1', '232432166', 'DPC3010 CABLE,MODEM', 'ITM02389191', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('946', '48', '1', '232432309', 'DPC3010 CABLE,MODEM', 'ITM02389190', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('947', '48', '1', '232430110', 'DPC3010 CABLE,MODEM', 'ITM02389189', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('948', '48', '1', '232430061', 'DPC3010 CABLE,MODEM', 'ITM02389188', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('949', '48', '1', '232432135', 'DPC3010 CABLE,MODEM', 'ITM02389187', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('950', '48', '1', '232428530', 'DPC3010 CABLE,MODEM', 'ITM02389186', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('951', '48', '1', '232428531', 'DPC3010 CABLE,MODEM', 'ITM02389185', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('952', '48', '1', '232432339', 'DPC3010 CABLE,MODEM', 'ITM02389184', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('953', '48', '1', '231516139', 'DPC3010 CABLE,MODEM', 'ITM02389183', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('954', '48', '1', '232430356', 'DPC3010 CABLE,MODEM', 'ITM02389182', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('955', '48', '1', '232430405', 'DPC3010 CABLE,MODEM', 'ITM02389181', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('956', '48', '1', '232428694', 'DPC3010 CABLE,MODEM', 'ITM02389180', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('957', '48', '1', '232430378', 'DPC3010 CABLE,MODEM', 'ITM02389179', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('958', '48', '1', '232430881', 'DPC3010 CABLE,MODEM', 'ITM02389177', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('959', '48', '1', '232431390', 'DPC3010 CABLE,MODEM', 'ITM02389176', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('960', '48', '1', '232428411', 'DPC3010 CABLE,MODEM', 'ITM02389175', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('961', '48', '1', '232432156', 'DPC3010 CABLE,MODEM', 'ITM02389174', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('962', '48', '1', '232429875', 'DPC3010 CABLE,MODEM', 'ITM02389173', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('963', '48', '1', '232430512', 'DPC3010 CABLE,MODEM', 'ITM02389172', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('964', '48', '1', '232432163', 'DPC3010 CABLE,MODEM', 'ITM02389169', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('965', '48', '1', '232432334', 'DPC3010 CABLE,MODEM', 'ITM02389168', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('966', '48', '1', '232429326', 'DPC3010 CABLE,MODEM', 'ITM02389167', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('967', '48', '1', '231517216', 'DPC3010 CABLE,MODEM', 'ITM02389166', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('968', '48', '1', '232430128', 'DPC3010 CABLE,MODEM', 'ITM02389165', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('969', '48', '1', '231516877', 'DPC3010 CABLE,MODEM', 'ITM02389164', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('970', '48', '1', '232430163', 'DPC3010 CABLE,MODEM', 'ITM02389163', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('971', '48', '1', '231514434', 'DPC3010 CABLE,MODEM', 'ITM02389162', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('972', '48', '1', '232426633', 'DPC3010 CABLE,MODEM', 'ITM02389161', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('973', '48', '1', '232429868', 'DPC3010 CABLE,MODEM', 'ITM02389160', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('974', '48', '1', '232432042', 'DPC3010 CABLE,MODEM', 'ITM02389159', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('975', '48', '1', '232432360', 'DPC3010 CABLE,MODEM', 'ITM02389158', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('976', '48', '1', '232430768', 'DPC3010 CABLE,MODEM', 'ITM02389157', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('977', '48', '1', '232432108', 'DPC3010 CABLE,MODEM', 'ITM02389156', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('978', '48', '1', '232428814', 'DPC3010 CABLE,MODEM', 'ITM02389155', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('979', '48', '1', '232432058', 'DPC3010 CABLE,MODEM', 'ITM02389154', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('980', '48', '1', '232432199', 'DPC3010 CABLE,MODEM', 'ITM02389153', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('981', '48', '1', '232430032', 'DPC3010 CABLE,MODEM', 'ITM02389152', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('982', '48', '1', '232432352', 'DPC3010 CABLE,MODEM', 'ITM02389151', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('983', '48', '1', '232427810', 'DPC3010 CABLE,MODEM', 'ITM02389150', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('984', '48', '1', '232427513', 'DPC3010 CABLE,MODEM', 'ITM02389149', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('985', '48', '1', '232430387', 'DPC3010 CABLE,MODEM', 'ITM02389148', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('986', '48', '1', '232430263', 'DPC3010 CABLE,MODEM', 'ITM02389147', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('987', '48', '1', '232430486', 'DPC3010 CABLE,MODEM', 'ITM02389146', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('988', '48', '1', '231517464', 'DPC3010 CABLE,MODEM', 'ITM02389145', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('989', '48', '1', '232432336', 'DPC3010 CABLE,MODEM', 'ITM02389144', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('990', '48', '1', '232428308', 'DPC3010 CABLE,MODEM', 'ITM02389142', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('991', '48', '1', '232430847', 'DPC3010 CABLE,MODEM', 'ITM02389141', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('992', '48', '1', '232427882', 'DPC3010 CABLE,MODEM', 'ITM02389140', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('993', '48', '1', '232432100', 'DPC3010 CABLE,MODEM', 'ITM02389139', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('994', '48', '1', '232430360', 'DPC3010 CABLE,MODEM', 'ITM02389138', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('995', '48', '1', '232432346', 'DPC3010 CABLE,MODEM', 'ITM02389137', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('996', '48', '1', '232430374', 'DPC3010 CABLE,MODEM', 'ITM02389136', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('997', '48', '1', '231517454', 'DPC3010 CABLE,MODEM', 'ITM02389135', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('998', '48', '1', '232432154', 'DPC3010 CABLE,MODEM', 'ITM02389134', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('999', '48', '1', '232430395', 'DPC3010 CABLE,MODEM', 'ITM02389133', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1000', '48', '1', '231517276', 'DPC3010 CABLE,MODEM', 'ITM02389132', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1001', '48', '1', '232427772', 'DPC3010 CABLE,MODEM', 'ITM02389131', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1002', '48', '1', '232430397', 'DPC3010 CABLE,MODEM', 'ITM02389130', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1003', '48', '1', '232432263', 'DPC3010 CABLE,MODEM', 'ITM02389129', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1004', '48', '1', '232429767', 'DPC3010 CABLE,MODEM', 'ITM02389128', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1005', '48', '1', '231516871', 'DPC3010 CABLE,MODEM', 'ITM02389127', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1006', '48', '1', '231516307', 'DPC3010 CABLE,MODEM', 'ITM02389126', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1007', '48', '1', '232432048', 'DPC3010 CABLE,MODEM', 'ITM02389125', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1008', '48', '1', '232430598', 'DPC3010 CABLE,MODEM', 'ITM02389123', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1009', '48', '1', '232431400', 'DPC3010 CABLE,MODEM', 'ITM02389122', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1010', '48', '1', '231514647', 'DPC3010 CABLE,MODEM', 'ITM02389121', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1011', '48', '1', '232430753', 'DPC3010 CABLE,MODEM', 'ITM02389119', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1012', '48', '1', '232428074', 'DPC3010 CABLE,MODEM', 'ITM02389118', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1013', '48', '1', '232430761', 'DPC3010 CABLE,MODEM', 'ITM02389117', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1014', '48', '1', '232432005', 'DPC3010 CABLE,MODEM', 'ITM02389116', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1015', '48', '1', '232430657', 'DPC3010 CABLE,MODEM', 'ITM02389115', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1016', '48', '1', '232429420', 'DPC3010 CABLE,MODEM', 'ITM02389114', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1017', '48', '1', '232430709', 'DPC3010 CABLE,MODEM', 'ITM02389113', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1018', '48', '1', '232428165', 'DPC3010 CABLE,MODEM', 'ITM02389112', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1019', '48', '1', '232432083', 'DPC3010 CABLE,MODEM', 'ITM02389111', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1020', '48', '1', '232430976', 'DPC3010 CABLE,MODEM', 'ITM02389110', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1021', '48', '1', '232429797', 'DPC3010 CABLE,MODEM', 'ITM02389109', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1022', '48', '1', '232430577', 'DPC3010 CABLE,MODEM', 'ITM02389108', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1023', '48', '1', '232428406', 'DPC3010 CABLE,MODEM', 'ITM02389107', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1024', '48', '1', '232431337', 'DPC3010 CABLE,MODEM', 'ITM02389106', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1025', '48', '1', '232432227', 'DPC3010 CABLE,MODEM', 'ITM02389105', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1026', '48', '1', '232432143', 'DPC3010 CABLE,MODEM', 'ITM02389103', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1027', '48', '1', '232432059', 'DPC3010 CABLE,MODEM', 'ITM02389102', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1028', '48', '1', '232432077', 'DPC3010 CABLE,MODEM', 'ITM02389101', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1029', '48', '1', '232431992', 'DPC3010 CABLE,MODEM', 'ITM02389100', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1030', '48', '1', '232430427', 'DPC3010 CABLE,MODEM', 'ITM02389099', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1031', '48', '1', '231517135', 'DPC3010 CABLE,MODEM', 'ITM02389098', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1032', '48', '1', '232432300', 'DPC3010 CABLE,MODEM', 'ITM02389097', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1033', '48', '1', '232427924', 'DPC3010 CABLE,MODEM', 'ITM02389096', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1034', '48', '1', '232432219', 'DPC3010 CABLE,MODEM', 'ITM02389095', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1035', '48', '1', '232432109', 'DPC3010 CABLE,MODEM', 'ITM02389094', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1036', '48', '1', '232428758', 'DPC3010 CABLE,MODEM', 'ITM02389093', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1037', '48', '1', '232431293', 'DPC3010 CABLE,MODEM', 'ITM02389092', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1038', '48', '1', '232429957', 'DPC3010 CABLE,MODEM', 'ITM02389091', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1039', '48', '1', '232430417', 'DPC3010 CABLE,MODEM', 'ITM02389090', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1040', '48', '1', '232430792', 'DPC3010 CABLE,MODEM', 'ITM02389089', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1041', '48', '1', '232432222', 'DPC3010 CABLE,MODEM', 'ITM02389088', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1042', '48', '1', '232430659', 'DPC3010 CABLE,MODEM', 'ITM02389087', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1043', '48', '1', '232431454', 'DPC3010 CABLE,MODEM', 'ITM02389086', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1044', '48', '1', '231516886', 'DPC3010 CABLE,MODEM', 'ITM02389085', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1045', '48', '1', '232430510', 'DPC3010 CABLE,MODEM', 'ITM02389084', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1046', '48', '1', '232432115', 'DPC3010 CABLE,MODEM', 'ITM02389083', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1047', '48', '1', '232432055', 'DPC3010 CABLE,MODEM', 'ITM02389082', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1048', '48', '1', '232430228', 'DPC3010 CABLE,MODEM', 'ITM02389081', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1049', '48', '1', '232428793', 'DPC3010 CABLE,MODEM', 'ITM02389080', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1050', '48', '1', '232427928', 'DPC3010 CABLE,MODEM', 'ITM02389079', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1051', '48', '1', '232432168', 'DPC3010 CABLE,MODEM', 'ITM02389078', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1052', '48', '1', '232428811', 'DPC3010 CABLE,MODEM', 'ITM02389077', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1053', '48', '1', '232431427', 'DPC3010 CABLE,MODEM', 'ITM02389075', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1054', '48', '1', '232429745', 'DPC3010 CABLE,MODEM', 'ITM02389074', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1055', '48', '1', '231516647', 'DPC3010 CABLE,MODEM', 'ITM02389073', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1056', '48', '1', '232430973', 'DPC3010 CABLE,MODEM', 'ITM02389072', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1057', '48', '1', '232428443', 'DPC3010 CABLE,MODEM', 'ITM02389071', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1058', '48', '1', '232432315', 'DPC3010 CABLE,MODEM', 'ITM02389070', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1059', '48', '1', '232432192', 'DPC3010 CABLE,MODEM', 'ITM02389069', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1060', '48', '1', '231517193', 'DPC3010 CABLE,MODEM', 'ITM02389068', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1061', '48', '1', '232431242', 'DPC3010 CABLE,MODEM', 'ITM02389067', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1062', '48', '1', '232432145', 'DPC3010 CABLE,MODEM', 'ITM02389066', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1063', '48', '1', '232432248', 'DPC3010 CABLE,MODEM', 'ITM02389065', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1064', '48', '1', '232432125', 'DPC3010 CABLE,MODEM', 'ITM02389064', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1065', '48', '1', '232432159', 'DPC3010 CABLE,MODEM', 'ITM02389063', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1066', '48', '1', '232429597', 'DPC3010 CABLE,MODEM', 'ITM02389062', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1067', '48', '1', '231515989', 'DPC3010 CABLE,MODEM', 'ITM02389061', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1068', '48', '1', '232430864', 'DPC3010 CABLE,MODEM', 'ITM02389060', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1069', '48', '1', '232430154', 'DPC3010 CABLE,MODEM', 'ITM02389059', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1070', '48', '1', '232430562', 'DPC3010 CABLE,MODEM', 'ITM02389058', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1071', '48', '1', '232432214', 'DPC3010 CABLE,MODEM', 'ITM02389057', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1072', '48', '1', '232428697', 'DPC3010 CABLE,MODEM', 'ITM02389056', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1073', '48', '1', '232429537', 'DPC3010 CABLE,MODEM', 'ITM02389055', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1074', '48', '1', '232428596', 'DPC3010 CABLE,MODEM', 'ITM02389054', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1075', '48', '1', '232430530', 'DPC3010 CABLE,MODEM', 'ITM02389053', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1076', '48', '1', '232432123', 'DPC3010 CABLE,MODEM', 'ITM02389052', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1077', '48', '1', '232428296', 'DPC3010 CABLE,MODEM', 'ITM02389051', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1078', '48', '1', '232429858', 'DPC3010 CABLE,MODEM', 'ITM02389050', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1079', '48', '1', '232432205', 'DPC3010 CABLE,MODEM', 'ITM02389049', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1080', '48', '1', '232427865', 'DPC3010 CABLE,MODEM', 'ITM02389048', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1081', '48', '1', '232432321', 'DPC3010 CABLE,MODEM', 'ITM02389047', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1082', '48', '1', '232432363', 'DPC3010 CABLE,MODEM', 'ITM02389046', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1083', '48', '1', '232432050', 'DPC3010 CABLE,MODEM', 'ITM02389045', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1084', '48', '1', '232432116', 'DPC3010 CABLE,MODEM', 'ITM02389044', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1085', '48', '1', '232429901', 'DPC3010 CABLE,MODEM', 'ITM02389043', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1086', '48', '1', '232430646', 'DPC3010 CABLE,MODEM', 'ITM02389042', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1087', '48', '1', '231517221', 'DPC3010 CABLE,MODEM', 'ITM02389041', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1088', '48', '1', '232430452', 'DPC3010 CABLE,MODEM', 'ITM02389040', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1089', '48', '1', '232432201', 'DPC3010 CABLE,MODEM', 'ITM02389039', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1090', '48', '1', '232428781', 'DPC3010 CABLE,MODEM', 'ITM02389038', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1091', '48', '1', '232432053', 'DPC3010 CABLE,MODEM', 'ITM02389037', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1092', '48', '1', '232427130', 'DPC3010 CABLE,MODEM', 'ITM02389036', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1093', '48', '1', '232431984', 'DPC3010 CABLE,MODEM', 'ITM02389035', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1094', '48', '1', '231516616', 'DPC3010 CABLE,MODEM', 'ITM02389034', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1095', '48', '1', '232428107', 'DPC3010 CABLE,MODEM', 'ITM02389033', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1096', '48', '1', '232431196', 'DPC3010 CABLE,MODEM', 'ITM02389032', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1097', '48', '1', '231516810', 'DPC3010 CABLE,MODEM', 'ITM02389031', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1098', '48', '1', '232432230', 'DPC3010 CABLE,MODEM', 'ITM02389030', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1099', '48', '1', '232430365', 'DPC3010 CABLE,MODEM', 'ITM02389029', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1100', '48', '1', '232428844', 'DPC3010 CABLE,MODEM', 'ITM02389028', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1101', '48', '1', '232432004', 'DPC3010 CABLE,MODEM', 'ITM02389027', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1102', '48', '1', '232431368', 'DPC3010 CABLE,MODEM', 'ITM02389025', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1103', '48', '1', '232432045', 'DPC3010 CABLE,MODEM', 'ITM02389023', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1104', '48', '1', '232432017', 'DPC3010 CABLE,MODEM', 'ITM02389022', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1105', '48', '1', '232430482', 'DPC3010 CABLE,MODEM', 'ITM02389021', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1106', '48', '1', '232428374', 'DPC3010 CABLE,MODEM', 'ITM02389020', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1107', '48', '1', '232430083', 'DPC3010 CABLE,MODEM', 'ITM02389019', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1108', '48', '1', '232432118', 'DPC3010 CABLE,MODEM', 'ITM02389018', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1109', '48', '1', '232430498', 'DPC3010 CABLE,MODEM', 'ITM02389017', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1110', '48', '1', '232430556', 'DPC3010 CABLE,MODEM', 'ITM02389016', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1111', '48', '1', '232431446', 'DPC3010 CABLE,MODEM', 'ITM02389015', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1112', '48', '1', '232429771', 'DPC3010 CABLE,MODEM', 'ITM02389014', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1113', '48', '1', '232428683', 'DPC3010 CABLE,MODEM', 'ITM02389013', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1114', '48', '1', '232431192', 'DPC3010 CABLE,MODEM', 'ITM02389012', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1115', '48', '1', '232431453', 'DPC3010 CABLE,MODEM', 'ITM02389011', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1116', '48', '1', '232430645', 'DPC3010 CABLE,MODEM', 'ITM02389010', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1117', '48', '1', '231517190', 'DPC3010 CABLE,MODEM', 'ITM02389009', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1118', '48', '1', '232429751', 'DPC3010 CABLE,MODEM', 'ITM02389008', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1119', '48', '1', '232432232', 'DPC3010 CABLE,MODEM', 'ITM02389007', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1120', '48', '1', '232430941', 'DPC3010 CABLE,MODEM', 'ITM02389006', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1121', '48', '1', '232432170', 'DPC3010 CABLE,MODEM', 'ITM02389005', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1122', '48', '1', '232432358', 'DPC3010 CABLE,MODEM', 'ITM02389003', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1123', '48', '1', '232432120', 'DPC3010 CABLE,MODEM', 'ITM02389001', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1124', '48', '1', '232430936', 'DPC3010 CABLE,MODEM', 'ITM02389000', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1125', '48', '1', '232432314', 'DPC3010 CABLE,MODEM', 'ITM02388999', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1126', '48', '1', '232432086', 'DPC3010 CABLE,MODEM', 'ITM02388998', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1127', '48', '1', '232429790', 'DPC3010 CABLE,MODEM', 'ITM02388997', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1128', '48', '1', '232432333', 'DPC3010 CABLE,MODEM', 'ITM02388996', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1129', '48', '1', '232430442', 'DPC3010 CABLE,MODEM', 'ITM02388995', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1130', '48', '1', '232431200', 'DPC3010 CABLE,MODEM', 'ITM02388994', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1131', '48', '1', '232431422', 'DPC3010 CABLE,MODEM', 'ITM02388993', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1132', '48', '1', '232430522', 'DPC3010 CABLE,MODEM', 'ITM02388992', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1133', '48', '1', '232429288', 'DPC3010 CABLE,MODEM', 'ITM02388991', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1134', '48', '1', '231517234', 'DPC3010 CABLE,MODEM', 'ITM02388990', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1135', '48', '1', '232430856', 'DPC3010 CABLE,MODEM', 'ITM02388989', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1136', '48', '1', '232431332', 'DPC3010 CABLE,MODEM', 'ITM02388988', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1137', '48', '1', '232432313', 'DPC3010 CABLE,MODEM', 'ITM02388987', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1138', '48', '1', '232430650', 'DPC3010 CABLE,MODEM', 'ITM02388986', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1139', '48', '1', '232431224', 'DPC3010 CABLE,MODEM', 'ITM02388985', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1140', '48', '1', '232431230', 'DPC3010 CABLE,MODEM', 'ITM02388984', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1141', '48', '1', '231516040', 'DPC3010 CABLE,MODEM', 'ITM02388983', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1142', '48', '1', '232430383', 'DPC3010 CABLE,MODEM', 'ITM02388982', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1143', '48', '1', '232431437', 'DPC3010 CABLE,MODEM', 'ITM02388981', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1144', '48', '1', '232432046', 'DPC3010 CABLE,MODEM', 'ITM02388980', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1145', '48', '1', '232430279', 'DPC3010 CABLE,MODEM', 'ITM02388979', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1146', '48', '1', '232430164', 'DPC3010 CABLE,MODEM', 'ITM02388978', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1147', '48', '1', '232430713', 'DPC3010 CABLE,MODEM', 'ITM02388977', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1148', '48', '1', '232428354', 'DPC3010 CABLE,MODEM', 'ITM02388976', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1149', '48', '1', '232432221', 'DPC3010 CABLE,MODEM', 'ITM02388975', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1150', '48', '1', '232432075', 'DPC3010 CABLE,MODEM', 'ITM02388973', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1151', '48', '1', '232431381', 'DPC3010 CABLE,MODEM', 'ITM02388972', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1152', '48', '1', '232430904', 'DPC3010 CABLE,MODEM', 'ITM02388971', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1153', '48', '1', '231516905', 'DPC3010 CABLE,MODEM', 'ITM02388970', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1154', '48', '1', '232432224', 'DPC3010 CABLE,MODEM', 'ITM02388969', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1155', '48', '1', '231515736', 'DPC3010 CABLE,MODEM', 'ITM02388968', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1156', '48', '1', '232428903', 'DPC3010 CABLE,MODEM', 'ITM02388967', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1157', '48', '1', '232430211', 'DPC3010 CABLE,MODEM', 'ITM02388966', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1158', '48', '1', '232432127', 'DPC3010 CABLE,MODEM', 'ITM02388965', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1159', '48', '1', '232432054', 'DPC3010 CABLE,MODEM', 'ITM02388964', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1160', '48', '1', '232432256', 'DPC3010 CABLE,MODEM', 'ITM02388963', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1161', '48', '1', '232432241', 'DPC3010 CABLE,MODEM', 'ITM02388962', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1162', '48', '1', '232428481', 'DPC3010 CABLE,MODEM', 'ITM02388961', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1163', '48', '1', '232432137', 'DPC3010 CABLE,MODEM', 'ITM02388960', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1164', '48', '1', '232430527', 'DPC3010 CABLE,MODEM', 'ITM02388959', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1165', '48', '1', '232430291', 'DPC3010 CABLE,MODEM', 'ITM02388958', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1166', '48', '1', '232432085', 'DPC3010 CABLE,MODEM', 'ITM02388957', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1167', '48', '1', '231517163', 'DPC3010 CABLE,MODEM', 'ITM02388956', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1168', '48', '1', '232430886', 'DPC3010 CABLE,MODEM', 'ITM02388955', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1169', '48', '1', '232430058', 'DPC3010 CABLE,MODEM', 'ITM02388954', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1170', '48', '1', '232432113', 'DPC3010 CABLE,MODEM', 'ITM02388953', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1171', '48', '1', '232430594', 'DPC3010 CABLE,MODEM', 'ITM02388952', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1172', '48', '1', '232431340', 'DPC3010 CABLE,MODEM', 'ITM02388951', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1173', '48', '1', '232432090', 'DPC3010 CABLE,MODEM', 'ITM02388950', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1174', '48', '1', '232430570', 'DPC3010 CABLE,MODEM', 'ITM02388949', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1175', '48', '1', '232432060', 'DPC3010 CABLE,MODEM', 'ITM02388948', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1176', '48', '1', '232430565', 'DPC3010 CABLE,MODEM', 'ITM02388947', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1177', '48', '1', '232432234', 'DPC3010 CABLE,MODEM', 'ITM02388946', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1178', '48', '1', '232430393', 'DPC3010 CABLE,MODEM', 'ITM02388945', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1179', '48', '1', '231516553', 'DPC3010 CABLE,MODEM', 'ITM02388944', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1180', '48', '1', '232432098', 'DPC3010 CABLE,MODEM', 'ITM02388943', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1181', '48', '1', '232430147', 'DPC3010 CABLE,MODEM', 'ITM02388942', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1182', '48', '1', '232432311', 'DPC3010 CABLE,MODEM', 'ITM02388941', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1183', '48', '1', '232432142', 'DPC3010 CABLE,MODEM', 'ITM02388940', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1184', '48', '1', '232429843', 'DPC3010 CABLE,MODEM', 'ITM02388939', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1185', '48', '1', '232432089', 'DPC3010 CABLE,MODEM', 'ITM02388938', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1186', '48', '1', '232431991', 'DPC3010 CABLE,MODEM', 'ITM02388937', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1187', '48', '1', '232431231', 'DPC3010 CABLE,MODEM', 'ITM02388936', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1188', '48', '1', '232432216', 'DPC3010 CABLE,MODEM', 'ITM02388935', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1189', '48', '1', '232432185', 'DPC3010 CABLE,MODEM', 'ITM02388934', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1190', '48', '1', '232431249', 'DPC3010 CABLE,MODEM', 'ITM02388933', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1191', '48', '1', '231516666', 'DPC3010 CABLE,MODEM', 'ITM02388932', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1192', '48', '1', '232430927', 'DPC3010 CABLE,MODEM', 'ITM02388931', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1193', '48', '1', '232430438', 'DPC3010 CABLE,MODEM', 'ITM02388930', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1194', '48', '1', '232430623', 'DPC3010 CABLE,MODEM', 'ITM02388929', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1195', '48', '1', '232432203', 'DPC3010 CABLE,MODEM', 'ITM02388928', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1196', '48', '1', '232430290', 'DPC3010 CABLE,MODEM', 'ITM02388927', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1197', '48', '1', '232430608', 'DPC3010 CABLE,MODEM', 'ITM02388926', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1198', '48', '1', '232429640', 'DPC3010 CABLE,MODEM', 'ITM02388925', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1199', '48', '1', '232430910', 'DPC3010 CABLE,MODEM', 'ITM02388924', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1200', '48', '1', '232432167', 'DPC3010 CABLE,MODEM', 'ITM02388922', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1201', '48', '1', '231517113', 'DPC3010 CABLE,MODEM', 'ITM02388921', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1202', '48', '1', '232430097', 'DPC3010 CABLE,MODEM', 'ITM02388920', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1203', '48', '1', '232432056', 'DPC3010 CABLE,MODEM', 'ITM02388919', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1204', '48', '1', '232431997', 'DPC3010 CABLE,MODEM', 'ITM02388917', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1205', '48', '1', '232432092', 'DPC3010 CABLE,MODEM', 'ITM02388916', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1206', '48', '1', '232430649', 'DPC3010 CABLE,MODEM', 'ITM02388915', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1207', '48', '1', '232428477', 'DPC3010 CABLE,MODEM', 'ITM02388914', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1208', '48', '1', '231516327', 'DPC3010 CABLE,MODEM', 'ITM02388913', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1209', '48', '1', '232432088', 'DPC3010 CABLE,MODEM', 'ITM02388912', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1210', '48', '1', '232432293', 'DPC3010 CABLE,MODEM', 'ITM02388911', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1211', '48', '1', '232427946', 'DPC3010 CABLE,MODEM', 'ITM02388910', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1212', '48', '1', '232432133', 'DPC3010 CABLE,MODEM', 'ITM02388909', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1213', '48', '1', '231515947', 'DPC3010 CABLE,MODEM', 'ITM02388908', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1214', '48', '1', '232428208', 'DPC3010 CABLE,MODEM', 'ITM02388907', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1215', '48', '1', '232428188', 'DPC3010 CABLE,MODEM', 'ITM02388906', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1216', '48', '1', '232432298', 'DPC3010 CABLE,MODEM', 'ITM02388905', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1217', '48', '1', '232430533', 'DPC3010 CABLE,MODEM', 'ITM02388904', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1218', '48', '1', '232430922', 'DPC3010 CABLE,MODEM', 'ITM02388903', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1219', '48', '1', '232429932', 'DPC3010 CABLE,MODEM', 'ITM02388902', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1220', '48', '1', '231516643', 'DPC3010 CABLE,MODEM', 'ITM02388901', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1221', '48', '1', '232430358', 'DPC3010 CABLE,MODEM', 'ITM02388900', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1222', '48', '1', '231517232', 'DPC3010 CABLE,MODEM', 'ITM02388898', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1223', '48', '1', '232432114', 'DPC3010 CABLE,MODEM', 'ITM02388897', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1224', '48', '1', '231515938', 'DPC3010 CABLE,MODEM', 'ITM02388896', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1225', '48', '1', '232430372', 'DPC3010 CABLE,MODEM', 'ITM02388895', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1226', '48', '1', '232430425', 'DPC3010 CABLE,MODEM', 'ITM02388894', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1227', '48', '1', '232428279', 'DPC3010 CABLE,MODEM', 'ITM02388893', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1228', '48', '1', '231517161', 'DPC3010 CABLE,MODEM', 'ITM02388892', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1229', '48', '1', '232430571', 'DPC3010 CABLE,MODEM', 'ITM02388891', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1230', '48', '1', '232430093', 'DPC3010 CABLE,MODEM', 'ITM02388890', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1231', '48', '1', '232428520', 'DPC3010 CABLE,MODEM', 'ITM02388889', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1232', '48', '1', '232430375', 'DPC3010 CABLE,MODEM', 'ITM02388888', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1233', '48', '1', '232428450', 'DPC3010 CABLE,MODEM', 'ITM02388887', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1234', '48', '1', '232427696', 'DPC3010 CABLE,MODEM', 'ITM02388886', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1235', '48', '1', '232428410', 'DPC3010 CABLE,MODEM', 'ITM02388885', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1236', '48', '1', '232431452', 'DPC3010 CABLE,MODEM', 'ITM02388884', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1237', '48', '1', '232432014', 'DPC3010 CABLE,MODEM', 'ITM02388883', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1238', '48', '1', '231516861', 'DPC3010 CABLE,MODEM', 'ITM02388882', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1239', '48', '1', '232432134', 'DPC3010 CABLE,MODEM', 'ITM02388881', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1240', '48', '1', '232432294', 'DPC3010 CABLE,MODEM', 'ITM02388880', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1241', '48', '1', '231515387', 'DPC3010 CABLE,MODEM', 'ITM02388879', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1242', '48', '1', '232432270', 'DPC3010 CABLE,MODEM', 'ITM02388878', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1243', '48', '1', '232432180', 'DPC3010 CABLE,MODEM', 'ITM02388877', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1244', '48', '1', '232430698', 'DPC3010 CABLE,MODEM', 'ITM02388876', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1245', '48', '1', '232429902', 'DPC3010 CABLE,MODEM', 'ITM02388875', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1246', '48', '1', '232430655', 'DPC3010 CABLE,MODEM', 'ITM02388874', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1247', '48', '1', '232431341', 'DPC3010 CABLE,MODEM', 'ITM02388873', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1248', '48', '1', '232428991', 'DPC3010 CABLE,MODEM', 'ITM02388872', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1249', '48', '1', '232428211', 'DPC3010 CABLE,MODEM', 'ITM02388870', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1250', '48', '1', '232431253', 'DPC3010 CABLE,MODEM', 'ITM02388869', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1251', '48', '1', '232432236', 'DPC3010 CABLE,MODEM', 'ITM02388868', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1252', '48', '1', '232432132', 'DPC3010 CABLE,MODEM', 'ITM02388867', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1253', '48', '1', '232431414', 'DPC3010 CABLE,MODEM', 'ITM02388866', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1254', '48', '1', '232432066', 'DPC3010 CABLE,MODEM', 'ITM02388865', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1255', '48', '1', '232432282', 'DPC3010 CABLE,MODEM', 'ITM02388864', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1256', '48', '1', '232432087', 'DPC3010 CABLE,MODEM', 'ITM02388863', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1257', '48', '1', '232429674', 'DPC3010 CABLE,MODEM', 'ITM02388862', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1258', '48', '1', '232431225', 'DPC3010 CABLE,MODEM', 'ITM02388861', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1259', '48', '1', '232430777', 'DPC3010 CABLE,MODEM', 'ITM02388860', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1260', '48', '1', '232430640', 'DPC3010 CABLE,MODEM', 'ITM02388859', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1261', '48', '1', '232430551', 'DPC3010 CABLE,MODEM', 'ITM02388858', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1262', '48', '1', '232430618', 'DPC3010 CABLE,MODEM', 'ITM02388857', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1263', '48', '1', '232428168', 'DPC3010 CABLE,MODEM', 'ITM02388856', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1264', '48', '1', '232430216', 'DPC3010 CABLE,MODEM', 'ITM02388855', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1265', '48', '1', '232432356', 'DPC3010 CABLE,MODEM', 'ITM02388854', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1266', '48', '1', '232428124', 'DPC3010 CABLE,MODEM', 'ITM02388853', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1267', '48', '1', '232432041', 'DPC3010 CABLE,MODEM', 'ITM02388852', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1268', '48', '1', '232432218', 'DPC3010 CABLE,MODEM', 'ITM02388850', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1269', '48', '1', '232432151', 'DPC3010 CABLE,MODEM', 'ITM02388849', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1270', '48', '1', '232431996', 'DPC3010 CABLE,MODEM', 'ITM02388848', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1271', '48', '1', '232427592', 'DPC3010 CABLE,MODEM', 'ITM02388847', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1272', '48', '1', '231515265', 'DPC3010 CABLE,MODEM', 'ITM02388846', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1273', '48', '1', '232431320', 'DPC3010 CABLE,MODEM', 'ITM02388845', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1274', '48', '1', '232432012', 'DPC3010 CABLE,MODEM', 'ITM02388844', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1275', '48', '1', '232429517', 'DPC3010 CABLE,MODEM', 'ITM02388843', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1276', '48', '1', '232429746', 'DPC3010 CABLE,MODEM', 'ITM02388842', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1277', '48', '1', '232430554', 'DPC3010 CABLE,MODEM', 'ITM02388841', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1278', '48', '1', '231517229', 'DPC3010 CABLE,MODEM', 'ITM02388840', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1279', '48', '1', '232430133', 'DPC3010 CABLE,MODEM', 'ITM02388839', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1280', '48', '1', '232432247', 'DPC3010 CABLE,MODEM', 'ITM02388838', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1281', '48', '1', '232427594', 'DPC3010 CABLE,MODEM', 'ITM02388837', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1282', '48', '1', '232431426', 'DPC3010 CABLE,MODEM', 'ITM02388836', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1283', '48', '1', '232432128', 'DPC3010 CABLE,MODEM', 'ITM02388835', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1284', '48', '1', '231516927', 'DPC3010 CABLE,MODEM', 'ITM02388834', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1285', '48', '1', '232427900', 'DPC3010 CABLE,MODEM', 'ITM02388833', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1286', '48', '1', '232430087', 'DPC3010 CABLE,MODEM', 'ITM02388832', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1287', '48', '1', '232429890', 'DPC3010 CABLE,MODEM', 'ITM02388831', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1288', '48', '1', '231516719', 'DPC3010 CABLE,MODEM', 'ITM02388830', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1289', '48', '1', '232430967', 'DPC3010 CABLE,MODEM', 'ITM02388829', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1290', '48', '1', '232428191', 'DPC3010 CABLE,MODEM', 'ITM02388828', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1291', '48', '1', '231517263', 'DPC3010 CABLE,MODEM', 'ITM02388826', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1292', '48', '1', '232430283', 'DPC3010 CABLE,MODEM', 'ITM02388825', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1293', '48', '1', '232432121', 'DPC3010 CABLE,MODEM', 'ITM02388824', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1294', '48', '1', '232427976', 'DPC3010 CABLE,MODEM', 'ITM02388823', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1295', '48', '1', '232428759', 'DPC3010 CABLE,MODEM', 'ITM02388821', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1296', '48', '1', '232431372', 'DPC3010 CABLE,MODEM', 'ITM02388820', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1297', '48', '1', '232428162', 'DPC3010 CABLE,MODEM', 'ITM02388819', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1298', '48', '1', '232431357', 'DPC3010 CABLE,MODEM', 'ITM02388818', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1299', '48', '1', '232432239', 'DPC3010 CABLE,MODEM', 'ITM02388817', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1300', '48', '1', '232431993', 'DPC3010 CABLE,MODEM', 'ITM02388816', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1301', '48', '1', '232431309', 'DPC3010 CABLE,MODEM', 'ITM02388815', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1302', '48', '1', '232432044', 'DPC3010 CABLE,MODEM', 'ITM02388814', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1303', '48', '1', '232432039', 'DPC3010 CABLE,MODEM', 'ITM02388813', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1304', '48', '1', '232429979', 'DPC3010 CABLE,MODEM', 'ITM02388812', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1305', '48', '1', '231517409', 'DPC3010 CABLE,MODEM', 'ITM02388811', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1306', '48', '1', '232429856', 'DPC3010 CABLE,MODEM', 'ITM02388810', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1307', '48', '1', '232430539', 'DPC3010 CABLE,MODEM', 'ITM02388809', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1308', '48', '1', '232430536', 'DPC3010 CABLE,MODEM', 'ITM02388808', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1309', '48', '1', '232430617', 'DPC3010 CABLE,MODEM', 'ITM02388807', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1310', '48', '1', '232428967', 'DPC3010 CABLE,MODEM', 'ITM02388806', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1311', '48', '1', '232429704', 'DPC3010 CABLE,MODEM', 'ITM02388805', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1312', '48', '1', '232428742', 'DPC3010 CABLE,MODEM', 'ITM02388804', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1313', '48', '1', '232430647', 'DPC3010 CABLE,MODEM', 'ITM02388803', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1314', '48', '1', '232430149', 'DPC3010 CABLE,MODEM', 'ITM02388802', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1315', '48', '1', '232428422', 'DPC3010 CABLE,MODEM', 'ITM02388801', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1316', '48', '1', '232428129', 'DPC3010 CABLE,MODEM', 'ITM02388800', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1317', '48', '1', '232430956', 'DPC3010 CABLE,MODEM', 'ITM02388799', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1318', '48', '1', '232430402', 'DPC3010 CABLE,MODEM', 'ITM02388798', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1319', '48', '1', '232432002', 'DPC3010 CABLE,MODEM', 'ITM02388797', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1320', '48', '1', '232430624', 'DPC3010 CABLE,MODEM', 'ITM02388796', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1321', '48', '1', '232430468', 'DPC3010 CABLE,MODEM', 'ITM02388795', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1322', '48', '1', '232428823', 'DPC3010 CABLE,MODEM', 'ITM02388794', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1323', '48', '1', '232428254', 'DPC3010 CABLE,MODEM', 'ITM02388793', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1324', '48', '1', '232430569', 'DPC3010 CABLE,MODEM', 'ITM02388792', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1325', '48', '1', '232432000', 'DPC3010 CABLE,MODEM', 'ITM02388791', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1326', '48', '1', '231516073', 'DPC3010 CABLE,MODEM', 'ITM02388790', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1327', '48', '1', '232432011', 'DPC3010 CABLE,MODEM', 'ITM02388789', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1328', '48', '1', '231516793', 'DPC3010 CABLE,MODEM', 'ITM02388788', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1329', '48', '1', '232428320', 'DPC3010 CABLE,MODEM', 'ITM02388786', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1330', '48', '1', '232429952', 'DPC3010 CABLE,MODEM', 'ITM02388784', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1331', '48', '1', '232432362', 'DPC3010 CABLE,MODEM', 'ITM02388783', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1332', '48', '1', '232432164', 'DPC3010 CABLE,MODEM', 'ITM02388782', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1333', '48', '1', '232430546', 'DPC3010 CABLE,MODEM', 'ITM02388781', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1334', '48', '1', '232430824', 'DPC3010 CABLE,MODEM', 'ITM02388780', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1335', '48', '1', '232431407', 'DPC3010 CABLE,MODEM', 'ITM02388779', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1336', '48', '1', '231517652', 'DPC3010 CABLE,MODEM', 'ITM02388778', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1337', '48', '1', '232428938', 'DPC3010 CABLE,MODEM', 'ITM02388777', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1338', '48', '1', '232430717', 'DPC3010 CABLE,MODEM', 'ITM02388776', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1339', '48', '1', '232430366', 'DPC3010 CABLE,MODEM', 'ITM02388775', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1340', '48', '1', '232428807', 'DPC3010 CABLE,MODEM', 'ITM02388774', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1341', '48', '1', '232432162', 'DPC3010 CABLE,MODEM', 'ITM02388773', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1342', '48', '1', '232428804', 'DPC3010 CABLE,MODEM', 'ITM02388772', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1343', '48', '1', '232428418', 'DPC3010 CABLE,MODEM', 'ITM02388771', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1344', '48', '1', '232432124', 'DPC3010 CABLE,MODEM', 'ITM02388770', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1345', '48', '1', '231516371', 'DPC3010 CABLE,MODEM', 'ITM02388769', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1346', '48', '1', '232430364', 'DPC3010 CABLE,MODEM', 'ITM02388768', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1347', '48', '1', '232428536', 'DPC3010 CABLE,MODEM', 'ITM02388767', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1348', '48', '1', '232432188', 'DPC3010 CABLE,MODEM', 'ITM02388766', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1349', '48', '1', '232429764', 'DPC3010 CABLE,MODEM', 'ITM02388765', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1350', '48', '1', '232431344', 'DPC3010 CABLE,MODEM', 'ITM02388764', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1351', '48', '1', '232430401', 'DPC3010 CABLE,MODEM', 'ITM02388763', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1352', '48', '1', '232430674', 'DPC3010 CABLE,MODEM', 'ITM02388762', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1353', '48', '1', '232431412', 'DPC3010 CABLE,MODEM', 'ITM02388761', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1354', '48', '1', '232430682', 'DPC3010 CABLE,MODEM', 'ITM02388760', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1355', '48', '1', '231517657', 'DPC3010 CABLE,MODEM', 'ITM02388759', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1356', '48', '1', '232430446', 'DPC3010 CABLE,MODEM', 'ITM02388758', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1357', '48', '1', '232428090', 'DPC3010 CABLE,MODEM', 'ITM02388757', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1358', '48', '1', '232428496', 'DPC3010 CABLE,MODEM', 'ITM02388756', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1359', '48', '1', '232428109', 'DPC3010 CABLE,MODEM', 'ITM02388755', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1360', '48', '1', '232428548', 'DPC3010 CABLE,MODEM', 'ITM02388754', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1361', '48', '1', '232429951', 'DPC3010 CABLE,MODEM', 'ITM02388753', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1362', '48', '1', '232431378', 'DPC3010 CABLE,MODEM', 'ITM02388752', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1363', '48', '1', '232430720', 'DPC3010 CABLE,MODEM', 'ITM02388751', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1364', '48', '1', '232430361', 'DPC3010 CABLE,MODEM', 'ITM02388750', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1365', '48', '1', '231516329', 'DPC3010 CABLE,MODEM', 'ITM02388749', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1366', '48', '1', '232430400', 'DPC3010 CABLE,MODEM', 'ITM02388748', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1367', '48', '1', '231516936', 'DPC3010 CABLE,MODEM', 'ITM02388747', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1368', '48', '1', '232427956', 'DPC3010 CABLE,MODEM', 'ITM02388746', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1369', '48', '1', '232430648', 'DPC3010 CABLE,MODEM', 'ITM02388745', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1370', '48', '1', '231515384', 'DPC3010 CABLE,MODEM', 'ITM02388744', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1371', '48', '1', '231515839', 'DPC3010 CABLE,MODEM', 'ITM02388743', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1372', '48', '1', '232431376', 'DPC3010 CABLE,MODEM', 'ITM02388742', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1373', '48', '1', '232432179', 'DPC3010 CABLE,MODEM', 'ITM02388741', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1374', '48', '1', '232432279', 'DPC3010 CABLE,MODEM', 'ITM02388740', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1375', '48', '1', '232427790', 'DPC3010 CABLE,MODEM', 'ITM02388738', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1376', '48', '1', '232432076', 'DPC3010 CABLE,MODEM', 'ITM02388737', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1377', '48', '1', '231516956', 'DPC3010 CABLE,MODEM', 'ITM02388736', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1378', '48', '1', '231517167', 'DPC3010 CABLE,MODEM', 'ITM02388735', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1379', '48', '1', '232432271', 'DPC3010 CABLE,MODEM', 'ITM02388734', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1380', '48', '1', '232429799', 'DPC3010 CABLE,MODEM', 'ITM02388733', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1381', '48', '1', '231517158', 'DPC3010 CABLE,MODEM', 'ITM02388732', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1382', '48', '1', '232431269', 'DPC3010 CABLE,MODEM', 'ITM02388730', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1383', '48', '1', '232432010', 'DPC3010 CABLE,MODEM', 'ITM02388729', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1384', '48', '1', '232430529', 'DPC3010 CABLE,MODEM', 'ITM02388728', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1385', '48', '1', '232432117', 'DPC3010 CABLE,MODEM', 'ITM02388727', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1386', '48', '1', '232429813', 'DPC3010 CABLE,MODEM', 'ITM02388725', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1387', '48', '1', '232430426', 'DPC3010 CABLE,MODEM', 'ITM02388723', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1388', '48', '1', '232432284', 'DPC3010 CABLE,MODEM', 'ITM02388722', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1389', '48', '1', '232432280', 'DPC3010 CABLE,MODEM', 'ITM02388721', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1390', '48', '1', '232430451', 'DPC3010 CABLE,MODEM', 'ITM02388720', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1391', '48', '1', '232430950', 'DPC3010 CABLE,MODEM', 'ITM02388719', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1392', '48', '1', '232432193', 'DPC3010 CABLE,MODEM', 'ITM02388718', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1393', '48', '1', '232432281', 'DPC3010 CABLE,MODEM', 'ITM02388717', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1394', '48', '1', '232428352', 'DPC3010 CABLE,MODEM', 'ITM02388716', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1395', '48', '1', '232430509', 'DPC3010 CABLE,MODEM', 'ITM02388715', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1396', '48', '1', '231517656', 'DPC3010 CABLE,MODEM', 'ITM02388714', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1397', '48', '1', '232430474', 'DPC3010 CABLE,MODEM', 'ITM02388713', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1398', '48', '1', '232432074', 'DPC3010 CABLE,MODEM', 'ITM02388712', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1399', '48', '1', '232428161', 'DPC3010 CABLE,MODEM', 'ITM02388711', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1400', '48', '1', '232430734', 'DPC3010 CABLE,MODEM', 'ITM02388710', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1401', '48', '1', '232432009', 'DPC3010 CABLE,MODEM', 'ITM02388709', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1402', '48', '1', '232427835', 'DPC3010 CABLE,MODEM', 'ITM02388708', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1403', '48', '1', '232432130', 'DPC3010 CABLE,MODEM', 'ITM02388707', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1404', '48', '1', '232427759', 'DPC3010 CABLE,MODEM', 'ITM02388706', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1405', '48', '1', '232431429', 'DPC3010 CABLE,MODEM', 'ITM02388705', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1406', '48', '1', '231517083', 'DPC3010 CABLE,MODEM', 'ITM02388704', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1407', '48', '1', '232428157', 'DPC3010 CABLE,MODEM', 'ITM02388703', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1408', '48', '1', '232431281', 'DPC3010 CABLE,MODEM', 'ITM02388702', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1409', '48', '1', '232432261', 'DPC3010 CABLE,MODEM', 'ITM02388700', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1410', '48', '1', '232430022', 'DPC3010 CABLE,MODEM', 'ITM02388698', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1411', '48', '1', '232430090', 'DPC3010 CABLE,MODEM', 'ITM02388697', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1412', '48', '1', '232430748', 'DPC3010 CABLE,MODEM', 'ITM02388696', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1413', '48', '1', '232432103', 'DPC3010 CABLE,MODEM', 'ITM02388695', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1414', '48', '1', '232429595', 'DPC3010 CABLE,MODEM', 'ITM02388694', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1415', '48', '1', '232432148', 'DPC3010 CABLE,MODEM', 'ITM02388693', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1416', '48', '1', '232428465', 'DPC3010 CABLE,MODEM', 'ITM02388692', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1417', '48', '1', '232428146', 'DPC3010 CABLE,MODEM', 'ITM02388691', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1418', '48', '1', '232431435', 'DPC3010 CABLE,MODEM', 'ITM02388690', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1419', '48', '1', '232428799', 'DPC3010 CABLE,MODEM', 'ITM02388689', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1420', '48', '1', '232430660', 'DPC3010 CABLE,MODEM', 'ITM02388688', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1421', '48', '1', '232431382', 'DPC3010 CABLE,MODEM', 'ITM02388687', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1422', '48', '1', '232431219', 'DPC3010 CABLE,MODEM', 'ITM02388686', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1423', '48', '1', '232432204', 'DPC3010 CABLE,MODEM', 'ITM02388685', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1424', '48', '1', '232428204', 'DPC3010 CABLE,MODEM', 'ITM02388684', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1425', '48', '1', '232431004', 'DPC3010 CABLE,MODEM', 'ITM02388683', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1426', '48', '1', '231517437', 'DPC3010 CABLE,MODEM', 'ITM02388682', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1427', '48', '1', '232428231', 'DPC3010 CABLE,MODEM', 'ITM02388681', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1428', '48', '1', '232430644', 'DPC3010 CABLE,MODEM', 'ITM02388680', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1429', '48', '1', '231517219', 'DPC3010 CABLE,MODEM', 'ITM02388679', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1430', '48', '1', '232432184', 'DPC3010 CABLE,MODEM', 'ITM02388678', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1431', '48', '1', '232430404', 'DPC3010 CABLE,MODEM', 'ITM02388677', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1432', '48', '1', '232430021', 'DPC3010 CABLE,MODEM', 'ITM02388676', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1433', '48', '1', '232432157', 'DPC3010 CABLE,MODEM', 'ITM02388675', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1434', '48', '1', '232432119', 'DPC3010 CABLE,MODEM', 'ITM02388674', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1435', '48', '1', '232432264', 'DPC3010 CABLE,MODEM', 'ITM02388673', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1436', '48', '1', '231516874', 'DPC3010 CABLE,MODEM', 'ITM02388672', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1437', '48', '1', '232430445', 'DPC3010 CABLE,MODEM', 'ITM02388671', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1438', '48', '1', '232432102', 'DPC3010 CABLE,MODEM', 'ITM02388670', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1439', '48', '1', '231516629', 'DPC3010 CABLE,MODEM', 'ITM02388669', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1440', '48', '1', '232432245', 'DPC3010 CABLE,MODEM', 'ITM02388668', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1441', '48', '1', '231517162', 'DPC3010 CABLE,MODEM', 'ITM02388667', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1442', '48', '1', '231516838', 'DPC3010 CABLE,MODEM', 'ITM02388666', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1443', '48', '1', '232432006', 'DPC3010 CABLE,MODEM', 'ITM02388665', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1444', '48', '1', '232432295', 'DPC3010 CABLE,MODEM', 'ITM02388664', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1445', '48', '1', '232431988', 'DPC3010 CABLE,MODEM', 'ITM02388663', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1446', '48', '1', '232430437', 'DPC3010 CABLE,MODEM', 'ITM02388662', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1447', '48', '1', '232432153', 'DPC3010 CABLE,MODEM', 'ITM02388661', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1448', '48', '1', '231514991', 'DPC3010 CABLE,MODEM', 'ITM02388659', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1449', '48', '1', '232430165', 'DPC3010 CABLE,MODEM', 'ITM02388657', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1450', '48', '1', '232432260', 'DPC3010 CABLE,MODEM', 'ITM02388656', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1451', '48', '1', '232430611', 'DPC3010 CABLE,MODEM', 'ITM02388655', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1452', '48', '1', '232431333', 'DPC3010 CABLE,MODEM', 'ITM02388654', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1453', '48', '1', '232432299', 'DPC3010 CABLE,MODEM', 'ITM02388653', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1454', '48', '1', '231517399', 'DPC3010 CABLE,MODEM', 'ITM02388652', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1455', '48', '1', '232432049', 'DPC3010 CABLE,MODEM', 'ITM02388651', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1456', '48', '1', '232431307', 'DPC3010 CABLE,MODEM', 'ITM02388650', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1457', '48', '1', '232432364', 'DPC3010 CABLE,MODEM', 'ITM02388649', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1458', '48', '1', '232430524', 'DPC3010 CABLE,MODEM', 'ITM02388648', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1459', '48', '1', '232432093', 'DPC3010 CABLE,MODEM', 'ITM02388647', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1460', '48', '1', '232429591', 'DPC3010 CABLE,MODEM', 'ITM02388646', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1461', '48', '1', '232432158', 'DPC3010 CABLE,MODEM', 'ITM02388645', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1462', '48', '1', '232430900', 'DPC3010 CABLE,MODEM', 'ITM02388644', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1463', '48', '1', '231516421', 'DPC3010 CABLE,MODEM', 'ITM02388643', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1464', '48', '1', '232427656', 'DPC3010 CABLE,MODEM', 'ITM02388642', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1465', '48', '1', '231517377', 'DPC3010 CABLE,MODEM', 'ITM02388641', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1466', '48', '1', '232430377', 'DPC3010 CABLE,MODEM', 'ITM02388640', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1467', '48', '1', '232430589', 'DPC3010 CABLE,MODEM', 'ITM02388639', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1468', '48', '1', '232432081', 'DPC3010 CABLE,MODEM', 'ITM02388638', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1469', '48', '1', '232430528', 'DPC3010 CABLE,MODEM', 'ITM02388637', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1470', '48', '1', '232432182', 'DPC3010 CABLE,MODEM', 'ITM02388636', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1471', '48', '1', '232428313', 'DPC3010 CABLE,MODEM', 'ITM02388635', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1472', '48', '1', '232431387', 'DPC3010 CABLE,MODEM', 'ITM02388634', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1473', '48', '1', '232430534', 'DPC3010 CABLE,MODEM', 'ITM02388633', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1474', '48', '1', '232429619', 'DPC3010 CABLE,MODEM', 'ITM02388632', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1475', '48', '1', '232430559', 'DPC3010 CABLE,MODEM', 'ITM02388631', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1476', '48', '1', '232431218', 'DPC3010 CABLE,MODEM', 'ITM02388630', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1477', '48', '1', '232430963', 'DPC3010 CABLE,MODEM', 'ITM02388629', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1478', '48', '1', '232432228', 'DPC3010 CABLE,MODEM', 'ITM02388628', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1479', '48', '1', '231517270', 'DPC3010 CABLE,MODEM', 'ITM02388627', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1480', '48', '1', '231517236', 'DPC3010 CABLE,MODEM', 'ITM02388626', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1481', '48', '1', '232430403', 'DPC3010 CABLE,MODEM', 'ITM02388625', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1482', '48', '1', '232429599', 'DPC3010 CABLE,MODEM', 'ITM02388624', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1483', '48', '1', '231515894', 'DPC3010 CABLE,MODEM', 'ITM02388622', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1484', '48', '1', '232428838', 'DPC3010 CABLE,MODEM', 'ITM02388621', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1485', '48', '1', '232428839', 'DPC3010 CABLE,MODEM', 'ITM02388620', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1486', '48', '1', '231517484', 'DPC3010 CABLE,MODEM', 'ITM02388619', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1487', '48', '1', '232432303', 'DPC3010 CABLE,MODEM', 'ITM02388618', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1488', '48', '1', '232430132', 'DPC3010 CABLE,MODEM', 'ITM02388617', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1489', '48', '1', '231517153', 'DPC3010 CABLE,MODEM', 'ITM02388616', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1490', '48', '1', '232431999', 'DPC3010 CABLE,MODEM', 'ITM02388615', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1491', '48', '1', '232432267', 'DPC3010 CABLE,MODEM', 'ITM02388614', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1492', '48', '1', '232426571', 'DPC3010 CABLE,MODEM', 'ITM02388613', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1493', '48', '1', '232432347', 'DPC3010 CABLE,MODEM', 'ITM02388612', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1494', '48', '1', '232429514', 'DPC3010 CABLE,MODEM', 'ITM02388611', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1495', '48', '1', '232432068', 'DPC3010 CABLE,MODEM', 'ITM02388610', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1496', '48', '1', '232432229', 'DPC3010 CABLE,MODEM', 'ITM02388609', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1497', '48', '1', '232430616', 'DPC3010 CABLE,MODEM', 'ITM02388608', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1498', '48', '1', '232431003', 'DPC3010 CABLE,MODEM', 'ITM02388607', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1499', '48', '1', '232429854', 'DPC3010 CABLE,MODEM', 'ITM02388606', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1500', '48', '1', '232430311', 'DPC3010 CABLE,MODEM', 'ITM02388605', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1501', '48', '1', '232430398', 'DPC3010 CABLE,MODEM', 'ITM02388604', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1502', '48', '1', '232428483', 'DPC3010 CABLE,MODEM', 'ITM02388603', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1503', '48', '1', '231517203', 'DPC3010 CABLE,MODEM', 'ITM02388602', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1504', '48', '1', '232430490', 'DPC3010 CABLE,MODEM', 'ITM02388601', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1505', '48', '1', '231515023', 'DPC3010 CABLE,MODEM', 'ITM02388600', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1506', '48', '1', '232430370', 'DPC3010 CABLE,MODEM', 'ITM02388599', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1507', '48', '1', '232432141', 'DPC3010 CABLE,MODEM', 'ITM02388598', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1508', '48', '1', '232429488', 'DPC3010 CABLE,MODEM', 'ITM02388597', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1509', '48', '1', '232430630', 'DPC3010 CABLE,MODEM', 'ITM02388596', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1510', '48', '1', '232427644', 'DPC3010 CABLE,MODEM', 'ITM02388595', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1511', '48', '1', '232432344', 'DPC3010 CABLE,MODEM', 'ITM02388594', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1512', '48', '1', '232430460', 'DPC3010 CABLE,MODEM', 'ITM02388593', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1513', '48', '1', '232430668', 'DPC3010 CABLE,MODEM', 'ITM02388592', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1514', '48', '1', '232432155', 'DPC3010 CABLE,MODEM', 'ITM02388591', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1515', '48', '1', '232432015', 'DPC3010 CABLE,MODEM', 'ITM02388590', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1516', '48', '1', '232431247', 'DPC3010 CABLE,MODEM', 'ITM02388588', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1517', '48', '1', '232427944', 'DPC3010 CABLE,MODEM', 'ITM02388587', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1518', '48', '1', '232429828', 'DPC3010 CABLE,MODEM', 'ITM02388586', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1519', '48', '1', '232430831', 'DPC3010 CABLE,MODEM', 'ITM02388585', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1520', '48', '1', '232430662', 'DPC3010 CABLE,MODEM', 'ITM02388584', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1521', '48', '1', '232432080', 'DPC3010 CABLE,MODEM', 'ITM02388583', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1522', '48', '1', '232432063', 'DPC3010 CABLE,MODEM', 'ITM02388582', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1523', '48', '1', '232432327', 'DPC3010 CABLE,MODEM', 'ITM02388581', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1524', '48', '1', '231515080', 'DPC3010 CABLE,MODEM', 'ITM02388580', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1525', '48', '1', '232432099', 'DPC3010 CABLE,MODEM', 'ITM02388579', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1526', '48', '1', '232428674', 'DPC3010 CABLE,MODEM', 'ITM02388578', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1527', '48', '1', '232428387', 'DPC3010 CABLE,MODEM', 'ITM02388577', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1528', '48', '1', '232431001', 'DPC3010 CABLE,MODEM', 'ITM02388576', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1529', '48', '1', '231517579', 'DPC3010 CABLE,MODEM', 'ITM02388575', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1530', '48', '1', '232428763', 'DPC3010 CABLE,MODEM', 'ITM02388574', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1531', '48', '1', '232429076', 'DPC3010 CABLE,MODEM', 'ITM02388573', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1532', '48', '1', '232432149', 'DPC3010 CABLE,MODEM', 'ITM02388572', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1533', '48', '1', '232430653', 'DPC3010 CABLE,MODEM', 'ITM02388571', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1534', '48', '1', '231516547', 'DPC3010 CABLE,MODEM', 'ITM02388570', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1535', '48', '1', '232430420', 'DPC3010 CABLE,MODEM', 'ITM02388569', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1536', '48', '1', '232430266', 'DPC3010 CABLE,MODEM', 'ITM02388568', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1537', '48', '1', '232432286', 'DPC3010 CABLE,MODEM', 'ITM02388567', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1538', '48', '1', '231514975', 'DPC3010 CABLE,MODEM', 'ITM02388566', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1539', '48', '1', '231517250', 'DPC3010 CABLE,MODEM', 'ITM02388565', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1540', '48', '1', '232429848', 'DPC3010 CABLE,MODEM', 'ITM02388564', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1541', '48', '1', '232428392', 'DPC3010 CABLE,MODEM', 'ITM02388563', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1542', '48', '1', '231516335', 'DPC3010 CABLE,MODEM', 'ITM02388562', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1543', '48', '1', '232432007', 'DPC3010 CABLE,MODEM', 'ITM02388561', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1544', '48', '1', '232428213', 'DPC3010 CABLE,MODEM', 'ITM02388560', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1545', '48', '1', '232430872', 'DPC3010 CABLE,MODEM', 'ITM02388559', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1546', '48', '1', '232428888', 'DPC3010 CABLE,MODEM', 'ITM02388558', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1547', '48', '1', '232430726', 'DPC3010 CABLE,MODEM', 'ITM02388557', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1548', '48', '1', '232430441', 'DPC3010 CABLE,MODEM', 'ITM02388556', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1549', '48', '1', '232430204', 'DPC3010 CABLE,MODEM', 'ITM02388555', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1550', '48', '1', '232430380', 'DPC3010 CABLE,MODEM', 'ITM02388554', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1551', '48', '1', '232430308', 'DPC3010 CABLE,MODEM', 'ITM02388325', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1552', '48', '1', '232430353', 'DPC3010 CABLE,MODEM', 'ITM02388324', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1553', '48', '1', '232430262', 'DPC3010 CABLE,MODEM', 'ITM02388323', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1554', '48', '1', '232430240', 'DPC3010 CABLE,MODEM', 'ITM02388322', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1555', '48', '1', '232430355', 'DPC3010 CABLE,MODEM', 'ITM02388321', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1556', '48', '1', '232430326', 'DPC3010 CABLE,MODEM', 'ITM02388320', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1557', '48', '1', '232430241', 'DPC3010 CABLE,MODEM', 'ITM02388319', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1558', '48', '1', '232430257', 'DPC3010 CABLE,MODEM', 'ITM02388318', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1559', '48', '1', '232430322', 'DPC3010 CABLE,MODEM', 'ITM02388317', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1560', '48', '1', '232430357', 'DPC3010 CABLE,MODEM', 'ITM02388316', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1561', '48', '1', '232430407', 'DPC3010 CABLE,MODEM', 'ITM02388315', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1562', '48', '1', '232430282', 'DPC3010 CABLE,MODEM', 'ITM02388314', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1563', '48', '1', '232430327', 'DPC3010 CABLE,MODEM', 'ITM02388313', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1564', '48', '1', '232430341', 'DPC3010 CABLE,MODEM', 'ITM02388312', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1565', '48', '1', '232430342', 'DPC3010 CABLE,MODEM', 'ITM02388311', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1566', '48', '1', '232430338', 'DPC3010 CABLE,MODEM', 'ITM02388310', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1567', '48', '1', '232430335', 'DPC3010 CABLE,MODEM', 'ITM02388309', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1568', '48', '1', '232430333', 'DPC3010 CABLE,MODEM', 'ITM02388308', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1569', '48', '1', '232430332', 'DPC3010 CABLE,MODEM', 'ITM02388307', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1570', '48', '1', '232430352', 'DPC3010 CABLE,MODEM', 'ITM02388306', '', 'yuliache', '', '', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1571', '42', '1', 'FOC1406X0RE', 'Catalyst 2960 48 10/100/1000, 4T/SFP', 'ITM02150805', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1572', '42', '1', 'FOC1342X4LX', 'CATALYST 2960 48 10/100/1000, 4 T/SFP LAN BASE IMAGE', 'ITM02368934', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1573', '32', '1', 'FOC1413X1Z4', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02386866', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1574', '32', '1', 'foc1413x1zu', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02386865', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1575', '32', '1', 'FOC1413X21B', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02386864', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1576', '32', '1', 'foc1413x217', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02386863', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1577', '32', '1', 'foc1413x21c', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02386862', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1578', '32', '1', 'foc1413x1vu', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02386861', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1579', '32', '1', 'FOC1451Z729', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02385705', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1580', '28', '1', '', 'Quad-shield RF cable bundle, RF Switch to HFC plant, 3m', 'ITM02385586', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1581', '29', '1', '', 'RF cable bundle, RF line card to RF Switch, 1m, spare', 'ITM02385587', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1582', '32', '1', 'FOC1426X33V', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02383595', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1583', '32', '1', 'FOC1423W669', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02383594', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1584', '32', '1', 'FOC1423Z5R7', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02383593', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1585', '32', '1', 'FOC1424W5C1', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02383592', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1586', '32', '1', 'FOC1423W66C', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02383591', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1587', '32', '1', 'FOC1423Z5KY', 'Catalyst 2960 48 10/100 + 2 T/SFP LAN Base Image', 'ITM02383590', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1588', '29', '1', '', 'RF cable bundle, RF line card to RF Switch, 1m, spare', '', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1589', '37', '1', '', 'N/A', '', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1590', '49', '1', '', 'Bajie??', 'CAT1343E0CC', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1591', '46', '1', 'FHK1435F147', '2811 Security Bundle,Adv Security,128F/512D', 'ITM02372619', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1592', '46', '1', 'FHK1435F145', '2811 Security Bundle,Adv Security,128F/512D', 'ITM02372615', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1593', '46', '1', 'FHK1435F14E', '2811 Security Bundle,Adv Security,128F/512D', 'ITM02372596', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1594', '46', '1', 'FHK1435F146', '2811 Security Bundle,Adv Security,128F/512D', 'ITM02372596', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1595', '46', '1', 'FHK1435F15L', '2811 Security Bundle,Adv Security,128F/512D', 'ITM02372595', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1596', '46', '1', 'FHK1435F149', '2811 Security Bundle,Adv Security,128F/512D', 'ITM02372588', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1597', '46', '1', 'FHK1435F158', '2811 Security Bundle,Adv Security,128F/512D', 'ITM02372580', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1598', '46', '1', 'FHK1435F148', '2811 Security Bundle,Adv Security,128F/512D', 'ITM02372571', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1599', '50', '1', 'FHK1435F13E', 'CISCO 2811', 'N/A', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1600', '45', '1', '', 'Samsung E2220W', '', '', 'zhimzhan', '', '', '0', 'zhimzhan');
INSERT INTO AC_ASSET VALUES ('1601', '28', '1', '', 'Quad-shield RF cable bundle, RF Switch to HFC plant, 3m', 'ITM02385586', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1602', '29', '1', '', 'RF cable bundle, RF line card to RF Switch, 1m, spare', 'ITM02385587', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1603', '29', '1', '', 'RF cable bundle, RF line card to RF Switch, 1m, spare', '', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1604', '37', '1', '', 'N/A', '', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1605', '49', '1', '', 'Bajie??', 'CAT1343E0CC', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1606', '45', '1', '', 'Samsung E2220W', '', '', 'zhimzhan', '', '', '0', 'zhimzhan');
INSERT INTO AC_ASSET VALUES ('1607', '28', '1', '', 'Quad-shield RF cable bundle, RF Switch to HFC plant, 3m', 'ITM02385586', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1608', '29', '1', '', 'RF cable bundle, RF line card to RF Switch, 1m, spare', 'ITM02385587', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1609', '29', '1', '', 'RF cable bundle, RF line card to RF Switch, 1m, spare', '', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1610', '37', '1', '', 'N/A', '', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1611', '49', '1', '', 'Bajie??', 'CAT1343E0CC', '', 'shuzchen', '', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1612', '51', '1', '', 'MODEM DOCSIS 3.0 EMTA', '', '', 'shuzchen', '2011-09-06', '', '278300.45', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1613', '32', '0', 'FOC1423Y0CD', 'Catalyst 2960 48 10/100+2T/SFP', '', '', 'zhiqian', '2011-08-22', 'C13 Lab', '3537.22', 'zhiqian');
INSERT INTO AC_ASSET VALUES ('1614', '32', '1', 'FOC1423Y0B7', 'Catalyst 2960 48 10/100+2T/SFP', '', '', 'zhiqian', '2011-08-22', 'C13 Lab', '3537.22', 'zhiqian');
INSERT INTO AC_ASSET VALUES ('1615', '32', '0', 'FOC1423Y04K', 'Catalyst 2960 48 10/100+2T/SFP', '', '', 'zhiqian', '2011-08-22', 'C13 Lab', '3537.22', 'zhiqian');
INSERT INTO AC_ASSET VALUES ('1616', '52', '1', 'FDO1443V2ZK', 'Catalyst 3750E 24 10/100/1000+2*10GE(X2),265W,IPB s/w', 'ITM02392832', '', 'shuzchen', '2011-08-22', '', '19580.06', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1617', '11', '1', '', 'RF cable bundle,RF line card to RF Switch ,Lm,spare', 'ITM02391109', '', 'shuzchen', '2011-07-28', '', '31710.84', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1618', '12', '1', '', 'High Density 8-port EIA-232 Async', 'ITM02391107', '', 'shuzchen', '2011-07-28', '', '213.56', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1619', '28', '1', '', 'Quad-shield RF cable bundle, RF Switch to HFC plant, 3m', 'ITM02385586', '', 'shuzchen', '2011-04-18', '', '50484.28', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1620', '29', '1', '', 'RF cable bundle, RF line card to RF Switch, 1m, spare', 'ITM02385587', '', 'shuzchen', '2011-04-18', '', '41305.32', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1621', '29', '1', '', 'RF cable bundle, RF line card to RF Switch, 1m, spare', '', '', 'shuzchen', '2011-04-18', '', '36715.84', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1622', '37', '1', '', 'N/A', '', '', 'shuzchen', '2010-04-14', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1623', '51', '1', '', 'MODEM DOCSIS 3.0 EMTA', '', '', 'shuzchen', '2011-09-06', '', '278300.45', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1624', '11', '1', '', 'RF cable bundle,RF line card to RF Switch ,Lm,spare', 'ITM02391109', '', 'shuzchen', '2011-07-28', '', '31710.84', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1625', '12', '1', '', 'High Density 8-port EIA-232 Async', 'ITM02391107', '', 'shuzchen', '2011-07-28', '', '213.56', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1626', '28', '1', '', 'Quad-shield RF cable bundle, RF Switch to HFC plant, 3m', 'ITM02385586', '', 'shuzchen', '2011-04-18', '', '50484.28', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1627', '29', '1', '', 'RF cable bundle, RF line card to RF Switch, 1m, spare', 'ITM02385587', '', 'shuzchen', '2011-04-18', '', '41305.32', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1628', '29', '1', '', 'RF cable bundle, RF line card to RF Switch, 1m, spare', '', '', 'shuzchen', '2011-04-18', '', '36715.84', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1629', '37', '1', '', 'N/A', '', '', 'shuzchen', '2010-04-14', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1630', '51', '1', '', 'MODEM DOCSIS 3.0 EMTA', '', '', 'shuzchen', '2011-09-06', '', '278300.45', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1631', '11', '1', '', 'RF cable bundle,RF line card to RF Switch ,Lm,spare', 'ITM02391109', '', 'shuzchen', '2011-07-28', '', '31710.84', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1632', '12', '1', '', 'High Density 8-port EIA-232 Async', 'ITM02391107', '', 'shuzchen', '2011-07-28', '', '213.56', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1633', '28', '1', '', 'Quad-shield RF cable bundle, RF Switch to HFC plant, 3m', 'ITM02385586', '', 'shuzchen', '2011-04-18', '', '50484.28', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1634', '29', '1', '', 'RF cable bundle, RF line card to RF Switch, 1m, spare', 'ITM02385587', '', 'shuzchen', '2011-04-18', '', '41305.32', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1635', '29', '1', '', 'RF cable bundle, RF line card to RF Switch, 1m, spare', '', '', 'shuzchen', '2011-04-18', '', '36715.84', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1636', '37', '1', '', 'N/A', '', '', 'shuzchen', '2010-04-14', '', '0', 'shuzchen');
INSERT INTO AC_ASSET VALUES ('1638', '19', '0', 'FOX1211GXPD', 'NPE-G2    JAF1352ACAG   \r\nUBR88V  CAT1342E0FF, CAT1343E0BW', '', '', 'keqfan', '2011-10-27', '', '0', 'keqfan');
INSERT INTO AC_ASSET VALUES ('1646', '54', '0', 'CAT1426E04Q', '', '', '', 'fanfang', '2011-11-02', 'C13 Lab', '0', 'fanfang');
INSERT INTO AC_ASSET VALUES ('1645', '54', '0', 'CAT1426E04N', '', '', '', 'xuawang', '2011-11-02', 'C13 Lab', '0', 'xuawang');
INSERT INTO AC_ASSET VALUES ('1647', '54', '0', 'CAT1427E01P', '', '', '', 'miaoc', '2011-11-02', 'C13 Lab', '0', 'miaoc');
INSERT INTO AC_ASSET VALUES ('1648', '54', '0', 'CAT1426E04S', '', '', '', 'miaoc', '2011-11-02', 'C13 Lab', '0', 'miaoc');
INSERT INTO AC_ASSET VALUES ('1649', '54', '0', 'CAT1425E03E', '', '', '', 'liahong', '2011-11-02', 'C13 Lab', '0', 'liahong');
INSERT INTO AC_ASSET VALUES ('1650', '54', '0', 'CAT1426E04K', '', '', '', 'liahong', '2011-11-02', 'C13 Lab', '0', 'liahong');
INSERT INTO AC_ASSET VALUES ('1651', '54', '0', 'CAT1426E04V', '', '', '', 'bachen', '2011-11-02', 'C13 Lab', '0', 'bachen');
INSERT INTO AC_ASSET VALUES ('1652', '54', '0', 'CAT1427E01M', '', '', '', 'taowan', '2011-11-02', 'C13 Lab', '0', 'taowan');
INSERT INTO AC_ASSET VALUES ('1653', '54', '0', 'CAT1452E1BN', '', '', '', 'liahong', '2011-11-02', 'C13 Lab', '0', 'liahong');
INSERT INTO AC_ASSET VALUES ('1654', '54', '0', 'CAT1502E0CU', '', '', '', 'bachen', '2011-11-02', 'C13 Lab', '0', 'bachen');
INSERT INTO AC_ASSET VALUES ('1655', '54', '0', 'CAT1502E0BC', '', '', '', 'xuawang', '2011-11-02', 'C13 Lab', '0', 'xuawang');
INSERT INTO AC_ASSET VALUES ('1656', '54', '0', 'CSJ13462905', '', '', '', 'yuliache', '2011-11-02', 'C13 Lab', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1657', '54', '0', 'CSJ13462926', '', '', '', 'yuliache', '2011-11-02', 'C13 Lab', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1658', '54', '0', 'CAT1502E0CC', '', '', '', 'yuliache', '2011-11-02', 'C13 Lab', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1659', '54', '0', 'CSJ13462910', '', '', '', 'yuliache', '2011-11-02', 'C13 Lab', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1660', '54', '0', 'CSJ13422901', '', '', '', 'licao', '2011-11-03', 'C13Lab', '0', 'licao');
INSERT INTO AC_ASSET VALUES ('1661', '54', '0', 'CSJ13422919', '', '', '', 'licao', '2011-11-03', 'C13Lab', '0', 'licao');
INSERT INTO AC_ASSET VALUES ('1662', '54', '0', 'CSJ13422907', '', '', '', 'juzhao', '2011-11-03', 'C13Lab', '0', 'juzhao');
INSERT INTO AC_ASSET VALUES ('1663', '54', '0', 'CSJ13462940', '', '', '', 'yuliache', '2011-11-03', 'C13Lab', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1664', '54', '0', 'CSJ13462908', '', '', '', 'yuliache', '2011-11-03', 'C13Lab', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1665', '55', '0', 'CAT1329E09H', '', '', '', 'taowan', '2011-11-03', 'C13Lab', '0', 'taowan');
INSERT INTO AC_ASSET VALUES ('1666', '55', '0', 'CAT1329E09K', '', '', '', 'wedong', '2011-11-03', 'C13Lab', '0', 'wedong');
INSERT INTO AC_ASSET VALUES ('1667', '55', '0', 'CAT1408E172', '', '', '', 'wenctang', '2011-11-03', 'C13Lab', '0', 'wenctang');
INSERT INTO AC_ASSET VALUES ('1668', '55', '0', 'CAT1408E17R', '', '', '', 'linzha', '2011-11-03', 'C13Lab', '0', 'linzha');
INSERT INTO AC_ASSET VALUES ('1669', '55', '0', 'CAT1408E15N', '', '', '', 'Lihchen', '2011-11-03', 'C13Lab', '0', 'Lihchen');
INSERT INTO AC_ASSET VALUES ('1670', '55', '0', 'CAT1349E01Q', '', '', '', 'xuawang', '2011-11-03', 'C13Lab', '0', 'xuawang');
INSERT INTO AC_ASSET VALUES ('1671', '55', '0', 'CAT1408E14S', '', '', '', 'xuawang', '2011-11-03', 'C13Lab', '0', 'xuawang');
INSERT INTO AC_ASSET VALUES ('1672', '55', '0', 'CSJ13152134', '', '', '', 'chunmwan', '2011-11-03', 'C13Lab', '0', 'chunmwan');
INSERT INTO AC_ASSET VALUES ('1673', '55', '0', 'CAT1413E145', '', '', '', 'yuliache', '2011-11-03', 'C13Lab', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1674', '55', '0', 'CAT1413E10K', '', '', '', 'Lihchen', '2011-11-03', 'C13Lab', '0', 'Lihchen');
INSERT INTO AC_ASSET VALUES ('1675', '55', '0', 'CAT1413E13Y', '', '', '', 'Zhimzhan', '2011-11-03', 'C13Lab', '0', 'Zhimzhan');
INSERT INTO AC_ASSET VALUES ('1676', '55', '0', 'CAT1413E13B', '', '', '', 'yuliache', '2011-11-03', 'C13Lab', '0', 'yuliache');
INSERT INTO AC_ASSET VALUES ('1677', '55', '0', 'CAT1413E13Q', '', '', '', 'jifu', '2011-11-03', 'C13Lab', '0', 'jifu');
INSERT INTO AC_ASSET VALUES ('1678', '55', '0', 'CAT1413E10Q', '', '', '', 'taowan', '2011-11-03', 'C13Lab', '0', 'taowan');
INSERT INTO AC_ASSET VALUES ('1679', '55', '0', 'CAT1413E12F', '', '', '', 'jimeng', '2011-11-03', 'C13Lab', '0', 'jimeng');
INSERT INTO AC_ASSET VALUES ('1680', '55', '0', 'CAT1413E10N', '', '', '', 'guyin', '2011-11-03', 'C13Lab', '0', 'guyin');
INSERT INTO AC_ASSET VALUES ('1681', '55', '0', 'CAT1431E0Q3', '', '', '', 'daszhang', '2011-11-03', 'C13Lab', '0', 'daszhang');
INSERT INTO AC_ASSET VALUES ('1682', '55', '0', 'CAT1431E0W1', '', '', '', 'daszhang', '2011-11-03', 'C13Lab', '0', 'daszhang');
INSERT INTO AC_ASSET VALUES ('1683', '55', '0', 'CAT1431E0S4', '', '', '', 'jihuang2', '2011-11-03', 'C13Lab', '0', 'jihuang2');
INSERT INTO AC_ASSET VALUES ('1684', '55', '0', 'CAT1431E0UZ', '', '', '', 'jihuang2', '2011-11-03', 'C13Lab', '0', 'jihuang2');
INSERT INTO AC_ASSET VALUES ('1685', '55', '0', 'CAT1431E0T7', '', '', '', 'lliwhuang', '2011-11-03', 'C13Lab', '0', 'lliwhuang');
INSERT INTO AC_ASSET VALUES ('1686', '55', '0', 'CAT1431E0TS', '', '', '', 'licao', '2011-11-03', 'C13Lab', '0', 'licao');
INSERT INTO AC_ASSET VALUES ('1687', '56', '0', '5A1106E05738', 'APC    power cycle', '', '', 'baorliu', '2011-11-11', 'C13 Lab', '0', 'baorliu');

-- ----------------------------
-- Records of ac_asset_type
-- ----------------------------
INSERT INTO AC_ASSET_TYPE VALUES ('2', 'UBR7200-NPE-G1=', 'UBR7200-NPE-G1=');
INSERT INTO AC_ASSET_TYPE VALUES ('3', 'WS-C3560-24PS-E', 'WS-C3560-24PS-E');
INSERT INTO AC_ASSET_TYPE VALUES ('4', 'NM-32A=', 'NM-32A=');
INSERT INTO AC_ASSET_TYPE VALUES ('5', 'PVDM2-64=', 'PVDM2-64=');
INSERT INTO AC_ASSET_TYPE VALUES ('6', 'X2-10GB-LR=', 'X2-10GB-LR=');
INSERT INTO AC_ASSET_TYPE VALUES ('7', 'GLC-ZX-SM=', 'GLC-ZX-SM=');
INSERT INTO AC_ASSET_TYPE VALUES ('8', 'CISCO2811-AC-IP', 'CISCO2811-AC-IP');
INSERT INTO AC_ASSET_TYPE VALUES ('9', 'CISCO3825', 'CISCO3825');
INSERT INTO AC_ASSET_TYPE VALUES ('10', 'CISCO3845', 'CISCO3845');
INSERT INTO AC_ASSET_TYPE VALUES ('11', 'CAB-RFSW5200TIMM2=', 'CAB-RFSW5200TIMM2=');
INSERT INTO AC_ASSET_TYPE VALUES ('12', 'CAB-HD8-ASYNC=', 'CAB-HD8-ASYNC=');
INSERT INTO AC_ASSET_TYPE VALUES ('13', 'WS-C4948-10GE-E', 'WS-C4948-10GE-E');
INSERT INTO AC_ASSET_TYPE VALUES ('14', 'UBR-RFSW', 'UBR-RFSW');
INSERT INTO AC_ASSET_TYPE VALUES ('15', 'WS-C4948', 'WS-C4948');
INSERT INTO AC_ASSET_TYPE VALUES ('16', 'WS-C3750G-48TS-E', 'WS-C3750G-48TS-E');
INSERT INTO AC_ASSET_TYPE VALUES ('17', 'WS-C3560G-48TS-S', 'WS-C3560G-48TS-S');
INSERT INTO AC_ASSET_TYPE VALUES ('18', 'PWR-UBR7225VXR-AC=', 'PWR-UBR7225VXR-AC=');
INSERT INTO AC_ASSET_TYPE VALUES ('19', 'CHAS-UBR7225VXR=', 'CHAS-UBR7225VXR=');
INSERT INTO AC_ASSET_TYPE VALUES ('20', 'NM-2E2W=', 'NM-2E2W=');
INSERT INTO AC_ASSET_TYPE VALUES ('21', 'VIC-2E/M=', 'VIC-2E/M=');
INSERT INTO AC_ASSET_TYPE VALUES ('22', 'XENPAK-10GB-LR+=', 'XENPAK-10GB-LR+=');
INSERT INTO AC_ASSET_TYPE VALUES ('23', 'GLC-T=', 'GLC-T=');
INSERT INTO AC_ASSET_TYPE VALUES ('24', 'XENPAK-10GB-SR=', 'XENPAK-10GB-SR=');
INSERT INTO AC_ASSET_TYPE VALUES ('25', '7204VXR/CPE', '7204VXR/CPE');
INSERT INTO AC_ASSET_TYPE VALUES ('26', 'CISCO7204VXR=', 'CISCO7204VXR=');
INSERT INTO AC_ASSET_TYPE VALUES ('27', 'WS-C4948-E', 'WS-C4948-E');
INSERT INTO AC_ASSET_TYPE VALUES ('28', 'CAB-RFSW520QTPMF2=', 'CAB-RFSW520QTPMF2=');
INSERT INTO AC_ASSET_TYPE VALUES ('29', 'CAB-RFSW520QTIMM2=', 'CAB-RFSW520QTIMM2=');
INSERT INTO AC_ASSET_TYPE VALUES ('30', 'WS-C4948-S', 'WS-C4948-S');
INSERT INTO AC_ASSET_TYPE VALUES ('31', 'SPA2102-UK', 'SPA2102-UK');
INSERT INTO AC_ASSET_TYPE VALUES ('32', 'WS-C2960-48TC-L', 'WS-C2960-48TC-L');
INSERT INTO AC_ASSET_TYPE VALUES ('33', '4034437', '4034437');
INSERT INTO AC_ASSET_TYPE VALUES ('34', 'WS-C2960-48TT-L', 'WS-C2960-48TT-L');
INSERT INTO AC_ASSET_TYPE VALUES ('35', 'UBR10-TCC+-T1', 'UBR10-TCC+-T1');
INSERT INTO AC_ASSET_TYPE VALUES ('36', 'uBR 10012 Modem card cover', 'uBR 10012 Modem card cover');
INSERT INTO AC_ASSET_TYPE VALUES ('37', 'PWR-UBR7200-AC', 'PWR-UBR7200-AC');
INSERT INTO AC_ASSET_TYPE VALUES ('38', '4033836', '4033836');
INSERT INTO AC_ASSET_TYPE VALUES ('39', '4034138', '4034138');
INSERT INTO AC_ASSET_TYPE VALUES ('40', 'WS-C2960-48TC-S', 'WS-C2960-48TC-S');
INSERT INTO AC_ASSET_TYPE VALUES ('41', 'C2811-VSEC-CCME/K9', 'C2811-VSEC-CCME/K9');
INSERT INTO AC_ASSET_TYPE VALUES ('42', 'WS-C2960G-48TC-L', 'WS-C2960G-48TC-L');
INSERT INTO AC_ASSET_TYPE VALUES ('43', 'WS-C3750E-48TD-S', 'WS-C3750E-48TD-S');
INSERT INTO AC_ASSET_TYPE VALUES ('44', 'WS-C4948-10GE-S', 'WS-C4948-10GE-S');
INSERT INTO AC_ASSET_TYPE VALUES ('45', 'Samsung E2220W', 'Samsung E2220W');
INSERT INTO AC_ASSET_TYPE VALUES ('46', 'CISCO2811-SEC/K9', 'CISCO2811-SEC/K9');
INSERT INTO AC_ASSET_TYPE VALUES ('47', 'WS-C3750G-48PS-S', 'WS-C3750G-48PS-S');
INSERT INTO AC_ASSET_TYPE VALUES ('48', '4027668', '4027668');
INSERT INTO AC_ASSET_TYPE VALUES ('49', '800-30844-02-CIL', '800-30844-02-CIL');
INSERT INTO AC_ASSET_TYPE VALUES ('50', 'CISCO 2811 ROUTER', 'CISCO 2811 ROUTER');
INSERT INTO AC_ASSET_TYPE VALUES ('51', 'DPC3212', 'DPC3212');
INSERT INTO AC_ASSET_TYPE VALUES ('52', 'WS-C3750E-24TD-S', 'WS-C3750E-24TD-S');
INSERT INTO AC_ASSET_TYPE VALUES ('55', 'UBR20X20', 'UBR20X20');
INSERT INTO AC_ASSET_TYPE VALUES ('54', 'UBR3G60', 'UBR3G60');
INSERT INTO AC_ASSET_TYPE VALUES ('56', 'AP7822', 'AP7822');

-- ----------------------------
-- Records of ac_case_type
-- ----------------------------
INSERT INTO AC_CASE_TYPE VALUES ('1', 'ASSET_CASE', 'CASE FOR ASSET');
INSERT INTO AC_CASE_TYPE VALUES ('2', 'PROJECT_CASE', 'CASE FOR PROJECT');
INSERT INTO AC_CASE_TYPE VALUES ('3', 'TEAM_CASE', 'CASE FOR TEAM');
INSERT INTO AC_CASE_TYPE VALUES ('4', 'ORDER_CASE', 'CASE FOR ORDER');

-- ----------------------------
-- Records of ac_user
-- ----------------------------
INSERT INTO AC_USER VALUES ('1', 'xiaoqwu', '', '4', 'xiaoqwu@cisco.com', 'Xiaoqing Wu', '2011-10-27 07:17:29', '2011-10-27 07:17:29');
INSERT INTO AC_USER VALUES ('2', 'shuzchen', '', '4', 'shuzchen@cisco.com', 'shuzhan chen', '2011-10-27 07:17:29', '2011-10-27 07:17:29');
INSERT INTO AC_USER VALUES ('3', 'shuaizha', '', '4', 'shuaizha@cisco.com', 'shuai zhang', '2011-10-27 07:17:29', '2011-10-27 07:17:29');
INSERT INTO AC_USER VALUES ('4', 'ruifma', '', '4', 'ruifma@cisco.com', 'ruifeng ma', '2011-11-02', '2011-11-02');
INSERT INTO AC_USER VALUES ('5', 'yizh', '', '2', 'yizh@cisco.com', 'Yi Zhang', '2011-11-02', '2011-11-02');
INSERT INTO AC_USER VALUES ('6', 'xiaowshe', '', '2', 'xiaowshe@cisco.com', 'Xiaowei Shen', '2011-11-02', '2011-11-02');
INSERT INTO AC_USER VALUES ('7', 'yuliache', '', '2', 'yuliache@cisco.com', 'Yuliang Chen', '2011-11-03', '2011-11-03');
INSERT INTO AC_USER VALUES ('8', 'kuzhao', '', '2', 'kuzhao@cisco.com', 'Kun Zhao', '2011-11-03', '2011-11-03');
INSERT INTO AC_USER VALUES ('9', 'linzha', '', '2', 'linzha@cisco.com', 'Lin Zhang', '2011-11-03', '2011-11-03');
INSERT INTO AC_USER VALUES ('10', 'keqfan', '', '2', 'keqfan@cisco.com', 'Keqi Fan', '2011-11-03', '2011-11-03');
INSERT INTO AC_USER VALUES ('11', 'zhiqian', '', '2', 'zhiqian@cisco.com', 'Zhiwei Qian', '2011-11-03', '2011-11-03');
INSERT INTO AC_USER VALUES ('12', 'shge', '', '2', 'shge@cisco.com', 'Shenbo Ge', '2011-11-03', '2011-11-03');
INSERT INTO AC_USER VALUES ('13', 'blu2', '', '2', 'blu2@cisco.com', 'Lu Bin', '2011-11-03', '2011-11-03');