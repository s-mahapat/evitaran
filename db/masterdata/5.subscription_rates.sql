USE jds;

delete from subscription_rates;
ALTER TABLE subscription_rates AUTO_INCREMENT = 1;

/*----This is for legacy data--------------------------------------------------------------------------------------*/
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (0, 0, 0, 0, 0);

/*----2012---------------------------------------------------------------------------------------------------------*/
/* For Industry Corporates */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 10, 2012, 1, 10000);

/* For Indian Universities and Institutions */
/* Individual Journals */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 8, 2012, 1, 750);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 8, 2012, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 8, 2012, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 8, 2012, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 8, 2012, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 8, 2012, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 8, 2012, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 8, 2012, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 8, 2012, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 8, 2012, 1, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 8, 2012, 1, 4000);
/* Concessional rates for multiple subscriptions */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (12, 8, 2012, 1, 7000);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (13, 8, 2012, 1, 3300);
/* Subscription rates for multiple years - Resonance */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 8, 2012, 2, 900);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 8, 2012, 3, 1300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 8, 2012, 5, 2000);
/* Subscription rates for multiple years - Current Science */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 8, 2012, 2, 7500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 8, 2012, 3, 10000);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 8, 2012, 5, 16000);


/* For Indian Schools and Colleges */
/* Individual Journals */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 9, 2012, 1, 750);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 9, 2012, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 9, 2012, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 9, 2012, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 9, 2012, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 9, 2012, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 9, 2012, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 9, 2012, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 9, 2012, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 9, 2012, 1, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 9, 2012, 1, 1500);
/* Concessional rates for multiple subscriptions */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (12, 9, 2012, 1, 4800);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (13, 9, 2012, 1, 3300);
/* Subscription rates for multiple years - Resonance */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 9, 2012, 2, 900);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 9, 2012, 3, 1300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 9, 2012, 5, 2000);
/* Subscription rates for multiple years - Current Science */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 9, 2012, 2, 2250);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 9, 2012, 3, 3500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 9, 2012, 5, 6000);

/* For Indian Personal */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 11, 2012, 2, 700);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 11, 2012, 2, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 11, 2012, 2, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 11, 2012, 2, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 11, 2012, 2, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 11, 2012, 2, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 11, 2012, 2, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 11, 2012, 2, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 11, 2012, 2, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 11, 2012, 2, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 11, 2012, 2, 1250);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 11, 2012, 3, 650);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 11, 2012, 5, 1010);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 11, 2012, 3, 1750);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 11, 2012, 5, 3000);

/* For free subscribers - Fellows */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 1, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 1, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 1, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 1, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 1, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 1, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 1, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 1, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 1, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 1, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 1, 2012, 1, 0);

/* For free subscribers - Associate */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 2, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 2, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 2, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 2, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 2, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 2, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 2, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 2, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 2, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 2, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 2, 2012, 1, 0);

/* For free subscribers - Editorial Board Members */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 3, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 3, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 3, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 3, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 3, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 3, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 3, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 3, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 3, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 3, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 3, 2012, 1, 0);

/* For free subscribers - Indian Exchange */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 4, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 4, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 4, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 4, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 4, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 4, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 4, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 4, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 4, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 4, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 4, 2012, 1, 0);

/* For free subscribers - Foreign Exchange */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 5, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 5, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 5, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 5, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 5, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 5, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 5, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 5, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 5, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 5, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 5, 2012, 1, 0);

/* For free subscribers - Grant */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 6, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 6, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 6, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 6, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 6, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 6, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 6, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 6, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 6, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 6, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 6, 2012, 1, 0);

/* For free subscribers - Author */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 7, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 7, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 7, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 7, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 7, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 7, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 7, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 7, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 7, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 7, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 7, 2012, 1, 0);

/* For free subscribers - Summer Fellows */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 14, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 14, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 14, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 14, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 14, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 14, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 14, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 14, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 14, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 14, 2012, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 14, 2012, 1, 0);

/*----2011---------------------------------------------------------------------------------------------------------*/
/* For Industry Corporates - Not defined for year 2011 */

/* For Indian Universities and Institutions */
/* Individual Journals */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 8, 2011, 1, 750);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 8, 2011, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 8, 2011, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 8, 2011, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 8, 2011, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 8, 2011, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 8, 2011, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 8, 2011, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 8, 2011, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 8, 2011, 1, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 8, 2011, 1, 4000);
/* Concessional rates for multiple subscriptions */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (12, 8, 2011, 1, 6000);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (13, 8, 2011, 1, 3300);
/* Subscription rates for multiple years - Resonance */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 8, 2011, 2, 900);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 8, 2011, 3, 1300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 8, 2011, 5, 2000);
/* Subscription rates for multiple years - Current Science */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 8, 2011, 2, 5400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 8, 2011, 3, 8000);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 8, 2011, 5, 12000);


/* For Indian Schools and Colleges */
/* Individual Journals */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 9, 2011, 1, 750);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 9, 2011, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 9, 2011, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 9, 2011, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 9, 2011, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 9, 2011, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 9, 2011, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 9, 2011, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 9, 2011, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 9, 2011, 1, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 9, 2011, 1, 1500);
/* Concessional rates for multiple subscriptions */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (12, 9, 2011, 1, 4200);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (13, 9, 2011, 1, 3300);
/* Subscription rates for multiple years - Resonance */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 9, 2011, 2, 900);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 9, 2011, 3, 1300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 9, 2011, 5, 2000);
/* Subscription rates for multiple years - Current Science */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 9, 2011, 2, 1750);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 9, 2011, 3, 2500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 9, 2011, 5, 4500);

/* For Indian Personal */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 11, 2011, 2, 700);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 11, 2011, 2, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 11, 2011, 2, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 11, 2011, 2, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 11, 2011, 2, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 11, 2011, 2, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 11, 2011, 2, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 11, 2011, 2, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 11, 2011, 2, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 11, 2011, 2, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 11, 2011, 2, 1250);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 11, 2011, 3, 650);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 11, 2011, 5, 1010);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 11, 2011, 3, 1600);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 11, 2011, 5, 2700);

/* For free subscribers - Fellows */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 1, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 1, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 1, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 1, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 1, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 1, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 1, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 1, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 1, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 1, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 1, 2011, 1, 0);

/* For free subscribers - Associate */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 2, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 2, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 2, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 2, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 2, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 2, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 2, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 2, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 2, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 2, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 2, 2011, 1, 0);

/* For free subscribers - Editorial Board Members */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 3, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 3, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 3, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 3, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 3, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 3, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 3, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 3, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 3, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 3, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 3, 2011, 1, 0);

/* For free subscribers - Indian Exchange */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 4, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 4, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 4, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 4, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 4, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 4, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 4, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 4, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 4, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 4, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 4, 2011, 1, 0);

/* For free subscribers - Foreign Exchange */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 5, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 5, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 5, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 5, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 5, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 5, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 5, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 5, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 5, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 5, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 5, 2011, 1, 0);

/* For free subscribers - Grant */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 6, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 6, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 6, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 6, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 6, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 6, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 6, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 6, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 6, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 6, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 6, 2011, 1, 0);

/* For free subscribers - Author */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 7, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 7, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 7, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 7, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 7, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 7, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 7, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 7, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 7, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 7, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 7, 2011, 1, 0);

/* For free subscribers - Summer Fellows */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 14, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 14, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 14, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 14, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 14, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 14, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 14, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 14, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 14, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 14, 2011, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 14, 2011, 1, 0);

/*----2010---------------------------------------------------------------------------------------------------------*/
/* For Industry Corporates - Not defined for year 2010 */

/* For Indian Universities and Institutions */
/* Individual Journals */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 8, 2010, 1, 750);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 8, 2010, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 8, 2010, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 8, 2010, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 8, 2010, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 8, 2010, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 8, 2010, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 8, 2010, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 8, 2010, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 8, 2010, 1, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 8, 2010, 1, 4000);
/* Concessional rates for multiple subscriptions */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (12, 8, 2010, 1, 6000);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (13, 8, 2010, 1, 3300);
/* Subscription rates for multiple years - Resonance */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 8, 2010, 2, 900);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 8, 2010, 3, 1300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 8, 2010, 5, 2000);
/* Subscription rates for multiple years - Current Science */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 8, 2010, 2, 5400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 8, 2010, 3, 8000);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 8, 2010, 5, 12000);


/* For Indian Schools and Colleges */
/* Individual Journals */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 9, 2010, 1, 750);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 9, 2010, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 9, 2010, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 9, 2010, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 9, 2010, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 9, 2010, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 9, 2010, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 9, 2010, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 9, 2010, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 9, 2010, 1, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 9, 2010, 1, 1500);
/* Concessional rates for multiple subscriptions */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (12, 9, 2010, 1, 4200);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (13, 9, 2010, 1, 3300);
/* Subscription rates for multiple years - Resonance */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 9, 2010, 2, 900);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 9, 2010, 3, 1300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 9, 2010, 5, 2000);
/* Subscription rates for multiple years - Current Science */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 9, 2010, 2, 1750);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 9, 2010, 3, 2500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 9, 2010, 5, 4500);

/* For Indian Personal */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 11, 2010, 2, 700);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 11, 2010, 2, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 11, 2010, 2, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 11, 2010, 2, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 11, 2010, 2, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 11, 2010, 2, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 11, 2010, 2, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 11, 2010, 2, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 11, 2010, 2, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 11, 2010, 2, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 11, 2010, 2, 1250);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 11, 2010, 3, 650);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 11, 2010, 5, 1010);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 11, 2010, 3, 1600);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 11, 2010, 5, 2700);

/* For free subscribers - Fellows */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 1, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 1, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 1, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 1, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 1, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 1, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 1, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 1, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 1, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 1, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 1, 2010, 1, 0);

/* For free subscribers - Associate */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 2, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 2, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 2, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 2, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 2, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 2, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 2, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 2, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 2, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 2, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 2, 2010, 1, 0);

/* For free subscribers - Editorial Board Members */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 3, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 3, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 3, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 3, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 3, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 3, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 3, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 3, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 3, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 3, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 3, 2010, 1, 0);

/* For free subscribers - Indian Exchange */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 4, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 4, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 4, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 4, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 4, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 4, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 4, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 4, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 4, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 4, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 4, 2010, 1, 0);

/* For free subscribers - Foreign Exchange */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 5, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 5, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 5, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 5, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 5, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 5, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 5, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 5, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 5, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 5, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 5, 2010, 1, 0);

/* For free subscribers - Grant */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 6, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 6, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 6, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 6, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 6, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 6, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 6, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 6, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 6, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 6, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 6, 2010, 1, 0);

/* For free subscribers - Author */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 7, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 7, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 7, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 7, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 7, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 7, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 7, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 7, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 7, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 7, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 7, 2010, 1, 0);

/* For free subscribers - Summer Fellows */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 14, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 14, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 14, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 14, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 14, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 14, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 14, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 14, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 14, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 14, 2010, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 14, 2010, 1, 0);

/*----2009---------------------------------------------------------------------------------------------------------*/
/* For Industry Corporates - Not defined for year 2009 */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 10, 2009, 1, 4000);

/* For Indian Personal */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 11, 2009, 2, 600);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 11, 2009, 2, 350);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 11, 2009, 2, 350);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 11, 2009, 2, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 11, 2009, 2, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 11, 2009, 2, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 11, 2009, 2, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 11, 2009, 2, 350);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 11, 2009, 2, 350);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 11, 2009, 2, 350);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 11, 2009, 2, 900);

/* For Indian Universities and Institutions */
/* Individual Journals */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 8, 2009, 1, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 8, 2009, 1, 250);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 8, 2009, 1, 250);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 8, 2009, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 8, 2009, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 8, 2009, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 8, 2009, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 8, 2009, 1, 250);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 8, 2009, 1, 250);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 8, 2009, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 8, 2009, 1, 2000);
/* Concessional rates for multiple subscriptions */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (12, 8, 2009, 1, 4300);

/* For Indian Schools and Colleges */
/* Individual Journals */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 9, 2009, 1, 500);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 9, 2009, 1, 250);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 9, 2009, 1, 250);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 9, 2009, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 9, 2009, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 9, 2009, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 9, 2009, 1, 300);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 9, 2009, 1, 250);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 9, 2009, 1, 250);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 9, 2009, 1, 400);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 9, 2009, 1, 750);
/* Concessional rates for multiple subscriptions */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (12, 9, 2009, 1, 3200);

/* For free subscribers - Fellows */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 1, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 1, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 1, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 1, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 1, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 1, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 1, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 1, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 1, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 1, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 1, 2009, 1, 0);

/* For free subscribers - Associate */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 2, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 2, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 2, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 2, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 2, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 2, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 2, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 2, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 2, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 2, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 2, 2009, 1, 0);

/* For free subscribers - Editorial Board Members */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 3, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 3, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 3, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 3, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 3, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 3, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 3, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 3, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 3, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 3, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 3, 2009, 1, 0);

/* For free subscribers - Indian Exchange */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 4, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 4, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 4, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 4, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 4, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 4, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 4, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 4, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 4, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 4, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 4, 2009, 1, 0);

/* For free subscribers - Foreign Exchange */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 5, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 5, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 5, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 5, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 5, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 5, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 5, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 5, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 5, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 5, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 5, 2009, 1, 0);

/* For free subscribers - Grant */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 6, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 6, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 6, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 6, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 6, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 6, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 6, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 6, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 6, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 6, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 6, 2009, 1, 0);

/* For free subscribers - Author */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 7, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 7, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 7, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 7, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 7, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 7, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 7, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 7, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 7, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 7, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 7, 2009, 1, 0);

/* For free subscribers - Summer Fellows */
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (1, 14, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (2, 14, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (3, 14, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (4, 14, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (5, 14, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (6, 14, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (7, 14, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (8, 14, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (9, 14, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (10, 14, 2009, 1, 0);
insert into subscription_rates (journalGroupId, subtypeId, `year`, period, rate) VALUES (11, 14, 2009, 1, 0);
