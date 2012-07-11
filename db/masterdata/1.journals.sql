USE jds;

delete from journals;
ALTER TABLE journals AUTO_INCREMENT = 1;

insert into `journals`(`journalCode`,`journalName`,`issnNo`,`pages`,`startYear`,`issues`) values ('P','Pramana - Journal of Physics','0304-4289',1800,1987,12);
insert into `journals`(`journalCode`,`journalName`,`issnNo`,`pages`,`startYear`,`issues`) values ('JAA','Journal of Astrophysics and Astronomy','0250-6335',400,1234,4);
insert into `journals`(`journalCode`,`journalName`,`issnNo`,`pages`,`startYear`,`issues`) values ('MS','Proceedings (Mathematical Sciences)','0253-4142',400,2010,4);
insert into `journals`(`journalCode`,`journalName`,`issnNo`,`pages`,`startYear`,`issues`) values ('EPS','Journal of Earth System Science (formerly Proc. Earth Planet Sci.)','0253-4126',600,1991,6);
insert into `journals`(`journalCode`,`journalName`,`issnNo`,`pages`,`startYear`,`issues`) values ('CS','Journal of Chemical Sciences (formerly Proc. Chemical Sci.)','0253-4134',600,2000,6);
insert into `journals`(`journalCode`,`journalName`,`issnNo`,`pages`,`startYear`,`issues`) values ('BMS','Bulletin of Materials Science','0250-4707',600,1995,6);
insert into `journals`(`journalCode`,`journalName`,`issnNo`,`pages`,`startYear`,`issues`) values ('S','Sadhana (Engineering Sciences)','0256-2499',600,1980,6);
insert into `journals`(`journalCode`,`journalName`,`issnNo`,`pages`,`startYear`,`issues`) values ('JB','Journal of Biosciences','0250-5991',500,2010,4);
insert into `journals`(`journalCode`,`journalName`,`issnNo`,`pages`,`startYear`,`issues`) values ('JG','Journal of Genetics','0022-1333',400,2011,3);
insert into `journals`(`journalCode`,`journalName`,`issnNo`,`pages`,`startYear`,`issues`) values ('RES','Resonanace - Journal of Science Education','0971-8044',1200,2000,12);
insert into `journals`(`journalCode`,`journalName`,`issnNo`,`pages`,`startYear`,`issues`) values ('CURR','Current Science','0011-3891',3000,2000,24);