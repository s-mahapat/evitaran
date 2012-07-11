USE jds;

delete from countries;
ALTER TABLE countries AUTO_INCREMENT = 1;

insert into countries
(country) VALUES
('Australia'), 
('Brazil'), 
('Canada'), 
('China'), 
('India'), 
('Italy'), 
('Japan'), 
('Netherlands'), 
('Saudi Arabia'), 
('Singapore'), 
('Sri Lanka'), 
('Switzerland'), 
('Taiwan'), 
('UK'), 
('USA')