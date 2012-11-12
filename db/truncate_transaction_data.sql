use jds;

delete from inward;
ALTER TABLE inward AUTO_INCREMENT = 1;

delete from subscriber;
ALTER TABLE subscriber AUTO_INCREMENT = 1;

delete from subscriptiondetails;
ALTER TABLE subscriptiondetails AUTO_INCREMENT = 1;

delete from subscription;
ALTER TABLE subscription AUTO_INCREMENT = 1;

delete from mailing_list;
ALTER TABLE mailing_list AUTO_INCREMENT = 1;

delete from mailing_list_detail;
ALTER TABLE mailing_list_detail AUTO_INCREMENT = 1;

delete from back_issue_list;
ALTER TABLE back_issue_list AUTO_INCREMENT = 1;

delete from reminder_details;
ALTER TABLE reminder_details AUTO_INCREMENT = 1;

delete from reminders;
ALTER TABLE reminders AUTO_INCREMENT = 1;

delete from missing_issue;
ALTER TABLE missing_issue AUTO_INCREMENT = 1;

delete from missing_issue_journals;
ALTER TABLE missing_issue_journals AUTO_INCREMENT = 1;

delete from invoice;
ALTER TABLE invoice AUTO_INCREMENT = 1;

delete from payment;
ALTER TABLE payment AUTO_INCREMENT = 1;

delete from print_order;
ALTER TABLE print_order AUTO_INCREMENT = 1;

delete from circulation_figure;
ALTER TABLE circulation_figure AUTO_INCREMENT = 1;

delete from inward_agent_details;
ALTER TABLE inward_agent_details AUTO_INCREMENT = 1;

delete from prl;
ALTER TABLE prl AUTO_INCREMENT = 1;

delete from prl_details;
ALTER TABLE prl_details AUTO_INCREMENT = 1;

delete from agents;
ALTER TABLE agents AUTO_INCREMENT = 1;

delete from chq_return_details;
ALTER TABLE chq_return_details AUTO_INCREMENT = 1;
