USE evitaran;

truncate table subscriber_type;
ALTER TABLE subscriber_type AUTO_INCREMENT = 1;

insert into `subscriber_type`(`subtypecode`,`subtypedesc`,`subtype`,`nationality`,`institutional`,`freejrnl`,`discount`) values ('FELJM','Fellows','Free','I','P',2,0);
insert into `subscriber_type`(`subtypecode`,`subtypedesc`,`subtype`,`nationality`,`institutional`,`freejrnl`,`discount`) values ('AS','Associate','Free','I','P',2,0);
insert into `subscriber_type`(`subtypecode`,`subtypedesc`,`subtype`,`nationality`,`institutional`,`freejrnl`,`discount`) values ('EBALL','Editorial Board Member','Free','I','P',1,0);
insert into `subscriber_type`(`subtypecode`,`subtypedesc`,`subtype`,`nationality`,`institutional`,`freejrnl`,`discount`) values ('EI','Indian Exchange','Free','I','I',0,0);
insert into `subscriber_type`(`subtypecode`,`subtypedesc`,`subtype`,`nationality`,`institutional`,`freejrnl`,`discount`) values ('EF','Foreign Exchange','Free','F','I',0,0);
insert into `subscriber_type`(`subtypecode`,`subtypedesc`,`subtype`,`nationality`,`institutional`,`freejrnl`,`discount`) values ('GRANT','Grant','Free','I','P',2,0);
insert into `subscriber_type`(`subtypecode`,`subtypedesc`,`subtype`,`nationality`,`institutional`,`freejrnl`,`discount`) values ('AUTH','Author','Free','I','P',1,0);
insert into `subscriber_type`(`subtypecode`,`subtypedesc`,`subtype`,`nationality`,`institutional`,`freejrnl`,`discount`) values ('II','Indian Universities and Institutions','Paid','I','I',0,0);
insert into `subscriber_type`(`subtypecode`,`subtypedesc`,`subtype`,`nationality`,`institutional`,`freejrnl`,`discount`) values ('IC','Indian Schools and Colleges','Paid','I','I',0,0);
insert into `subscriber_type`(`subtypecode`,`subtypedesc`,`subtype`,`nationality`,`institutional`,`freejrnl`,`discount`) values ('IN','Industry Corporates','Paid','I','I',0,0);
insert into `subscriber_type`(`subtypecode`,`subtypedesc`,`subtype`,`nationality`,`institutional`,`freejrnl`,`discount`) values ('IP','Indian Personal','Paid','I','P',0,0);
insert into `subscriber_type`(`subtypecode`,`subtypedesc`,`subtype`,`nationality`,`institutional`,`freejrnl`,`discount`) values ('FP','Foreign Personal','Paid','F','P',0,0);
insert into `subscriber_type`(`subtypecode`,`subtypedesc`,`subtype`,`nationality`,`institutional`,`freejrnl`,`discount`) values ('FI','Foreign Institutions','Paid','F','I',0,0);
insert into `subscriber_type`(`subtypecode`,`subtypedesc`,`subtype`,`nationality`,`institutional`,`freejrnl`,`discount`) values ('SF','Summer Fellows','Free','I','P',1,0);
insert into `subscriber_type`(`subtypecode`,`subtypedesc`,`subtype`,`nationality`,`institutional`,`freejrnl`,`discount`) values ('HONFEL','Honorary Fellow','Free','I','P',0,0);
insert into `subscriber_type`(`subtypecode`,`subtypedesc`,`subtype`,`nationality`,`institutional`,`freejrnl`,`discount`) values ('LSP','Life Subscriber Personal','Paid','I','P',0,0);
insert into `subscriber_type`(`subtypecode`,`subtypedesc`,`subtype`,`nationality`,`institutional`,`freejrnl`,`discount`) values ('LSI','Life Subscriber Institutions','Paid','I','I',0,0);
insert into `subscriber_type`(`subtypecode`,`subtypedesc`,`subtype`,`nationality`,`institutional`,`freejrnl`,`discount`) values ('MEMBER','Members','Paid','I','I',0,0);
insert into `subscriber_type`(`subtypecode`,`subtypedesc`,`subtype`,`nationality`,`institutional`,`freejrnl`,`discount`) values ('WC','Working Committee','Free','I','P',0,0);