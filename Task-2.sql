select * from Passenger;
select * from Price;

-- 2. (Medium) Perform read operation on the designed table created in the above task.

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- a. How many female passengers traveled a minimum distance of 600 KMs? (1 mark)
select count(*) 'Count of female passengers travelled a minimum distance of 600kms' from passenger 
where gender = 'F' and distance >= 600;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- b. Write a query to display the passenger details whose travel distance is greater than 500 and
-- who are traveling in a sleeper bus. (2 marks)
select * from passenger where distance > 500 and bus_type = 'sleeper';

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- c. Select passenger names whose names start with the character 'S'.(2 marks)
select passenger_name from passenger where passenger_name like 'S%';

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- d. Calculate the price charged for each passenger, displaying the Passenger name, Boarding City,
-- Destination City, Bus type, and Price in the output. (3 marks)
select passenger_name, boarding_city, destination_city, p1.bus_type, price from passenger p1, price p2
where p1.distance = p2.distance and p1.bus_type = p2.bus_type order by passenger_id;
-- or
select passenger_name, boarding_city, destination_city, p1.bus_type, price from passenger p1 left join price p2
using(distance,bus_type)
order by passenger_id;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- e. What are the passenger name(s) and the ticket price for those who traveled 1000 KMs Sitting in a bus? (4 marks)
select passenger_name, price from passenger p1 left join price p2 
using(distance,bus_type)
where p1.distance = 1000 and p1.bus_type = 'Sitting'
union
select passenger_name, price from passenger p1 right join price p2 
using(distance,bus_type)
where p2.distance = 1000 and p2.bus_type = 'Sitting';
# there is no passenger present in passenger table who travelled 1000 KMs Sitting in a bus, 
# but from price table we can say that price will be 1240.

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- f. What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji? (5 marks)
select ifnull(passenger_name,'Pallavi') as name,p1.bus_type, price from passenger p1 left join price p2 
using(distance,bus_type)
where p1.distance = (select distance from passenger where passenger_name='Pallavi' and (boarding_city='Panaji' and destination_city='Bengaluru' or boarding_city='Bengaluru' and destination_city='Panaji')) and p1.bus_type in ('Sitting','Sleeper')
union
select ifnull(passenger_name,'Pallavi') as name,p2.bus_type, price from passenger p1 right join price p2 
using(distance,bus_type)
where p2.distance = (select distance from passenger where passenger_name='Pallavi' and (boarding_city='Panaji' and destination_city='Bengaluru' or boarding_city='Bengaluru' and destination_city='Panaji')) and p2.bus_type in ('Sitting','Sleeper'); 

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- g. Alter the column category with the value "Non-AC" where the Bus_Type is sleeper (2 marks)
update passenger set category = 'Non-AC' where bus_type = 'Sleeper';
select  * from passenger;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- h. Delete an entry from the table where the passenger name is Piyush and commit this change in
-- the database. (1 mark)
delete from passenger where passenger_name = 'Piyush';
select  * from passenger;
commit;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- i. Truncate the table passenger and comment on the number of rows in the table (explain if
-- required). (1 mark)
truncate table passenger;
select count(*) number_of_rows from passenger;
# After truncating the table, all records in the table will be deleted but structure of the table will be remained same as before.

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- j. Delete the table passenger from the database. (1 mark)
drop table passenger;
show tables from travego;
# we can say that after dropping table, all records and structure of the table also will be deleted.

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
