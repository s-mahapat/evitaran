USE evitaran;

truncate table `invoice_types`;
ALTER TABLE `invoice_types` AUTO_INCREMENT = 1;

insert into `invoice_types`(`invoice_type`) values ('Request For Invoice'),('Outstanding Payment'),('Upcoming Year Invoice')