use evitaran;

truncate table inward;
ALTER TABLE inward AUTO_INCREMENT = 1;

truncate table subscriber;
ALTER TABLE subscriber AUTO_INCREMENT = 1;

delete from subscriptiondetails;
ALTER TABLE subscriptiondetails AUTO_INCREMENT = 1;

delete from subscription;
ALTER TABLE subscription AUTO_INCREMENT = 1;

truncate table subscription_legacy;
ALTER TABLE subscription_legacy AUTO_INCREMENT = 1;

truncate table mailing_list;
ALTER TABLE mailing_list AUTO_INCREMENT = 1;

truncate table mailing_list_detail;
ALTER TABLE mailing_list_detail AUTO_INCREMENT = 1;

truncate table back_issue_list;
ALTER TABLE back_issue_list AUTO_INCREMENT = 1;

truncate table reminder_details;
ALTER TABLE reminder_details AUTO_INCREMENT = 1;

truncate table reminders;
ALTER TABLE reminders AUTO_INCREMENT = 1;

truncate table missing_issue;
ALTER TABLE missing_issue AUTO_INCREMENT = 1;

truncate table missing_issue_journals;
ALTER TABLE missing_issue_journals AUTO_INCREMENT = 1;

truncate table invoice;
ALTER TABLE invoice AUTO_INCREMENT = 1;

truncate table payment;
ALTER TABLE payment AUTO_INCREMENT = 1;

truncate table print_order;
ALTER TABLE print_order AUTO_INCREMENT = 1;

truncate table circulation_figure;
ALTER TABLE circulation_figure AUTO_INCREMENT = 1;

truncate table inward_agent_details;
ALTER TABLE inward_agent_details AUTO_INCREMENT = 1;

truncate table prl;
ALTER TABLE prl AUTO_INCREMENT = 1;

truncate table prl_details;
ALTER TABLE prl_details AUTO_INCREMENT = 1;

truncate table agents;
ALTER TABLE agents AUTO_INCREMENT = 1;

truncate table chq_return_details;
ALTER TABLE chq_return_details AUTO_INCREMENT = 1;
