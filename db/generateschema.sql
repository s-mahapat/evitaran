DROP schema IF EXISTS `jds`;
create schema jds;
DROP USER 'jds'@'localhost';
CREATE USER 'jds'@'localhost' IDENTIFIED BY 'jds';
GRANT SELECT,INSERT,UPDATE ON jds.* TO 'jds'@'localhost';