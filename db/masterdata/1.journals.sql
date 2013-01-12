USE jds;

delete from journals;
ALTER TABLE journals AUTO_INCREMENT = 1;

insert into `journals`(`journalCode`,`journalName`,`issnNo`,`startYear`) values ('P','Pramana - Journal of Physics','0304-4289',1987);
insert into `journals`(`journalCode`,`journalName`,`issnNo`,`startYear`) values ('JAA','Journal of Astrophysics and Astronomy','0250-6335',1978);
insert into `journals`(`journalCode`,`journalName`,`issnNo`,`startYear`) values ('MS','Proceedings (Mathematical Sciences)','0253-4142',2010);
insert into `journals`(`journalCode`,`journalName`,`issnNo`,`startYear`) values ('EPS','Journal of Earth System Science (formerly Proc. Earth Planet Sci.)','0253-4126',1991);
insert into `journals`(`journalCode`,`journalName`,`issnNo`,`startYear`) values ('CS','Journal of Chemical Sciences (formerly Proc. Chemical Sci.)','0253-4134',2000);
insert into `journals`(`journalCode`,`journalName`,`issnNo`,`startYear`) values ('BMS','Bulletin of Materials Science','0250-4707',1995);
insert into `journals`(`journalCode`,`journalName`,`issnNo`,`startYear`) values ('S','Sadhana (Engineering Sciences)','0256-2499',1980);
insert into `journals`(`journalCode`,`journalName`,`issnNo`,`startYear`) values ('JB','Journal of Biosciences','0250-5991',2010);
insert into `journals`(`journalCode`,`journalName`,`issnNo`,`startYear`) values ('JG','Journal of Genetics','0022-1333',2011);
insert into `journals`(`journalCode`,`journalName`,`issnNo`,`startYear`) values ('RES','Resonanace - Journal of Science Education','0971-8044',2000);
insert into `journals`(`journalCode`,`journalName`,`issnNo`,`startYear`) values ('CURR','Current Science','0011-3891',2000);

delete from journal_details;
ALTER TABLE journal_details AUTO_INCREMENT = 1;

insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (1,2012,1800,12,'A4',2);
insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (2,2012,400,4,'A4',1);
insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (3,2012,400,4,'A4',1);
insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (4,2012,600,6,'Other',1);
insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (5,2012,600,6,'Other',1);
insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (6,2012,600,6,'Other',1);
insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (7,2012,600,6,'A4',1);
insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (8,2012,500,4,'Other',1);
insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (9,2012,400,3,'Other',1);
insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (10,2012,1200,12,'A4',1);
insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (11,2012,3000,24,'Other',2);

insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (1,2013,1800,12,'A4',2);
insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (2,2013,400,4,'A4',1);
insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (3,2013,400,4,'A4',1);
insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (4,2013,600,6,'Other',1);
insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (5,2013,600,6,'Other',1);
insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (6,2013,600,6,'Other',1);
insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (7,2013,600,6,'A4',1);
insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (8,2013,500,4,'Other',1);
insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (9,2013,400,3,'Other',1);
insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (10,2013,1200,12,'A4',1);
insert into `journal_details`(`journals_id`,`year`,`pages`,`issues`,`page_size`,`no_of_volumes`) values (11,2013,3000,24,'Other',2);

delete from journal_volume_details;
ALTER TABLE journal_volume_details AUTO_INCREMENT = 1;

insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (1,78,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (1,79,'July');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (2,33,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (3,122,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (4,121,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (5,124,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (6,35,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (7,37,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (8,37,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (9,91,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (10,17,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (11,102,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (11,103,'July');

insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (12,80,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (12,81,'July');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (13,34,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (14,123,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (15,122,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (16,125,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (17,36,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (18,38,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (19,38,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (20,92,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (21,18,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (22,104,'January');
insert into `journal_volume_details`(`journal_details_id`, `volume_number`,`start_month`) values (22,105,'July');
