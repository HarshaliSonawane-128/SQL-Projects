/*  .1 Create a table “Station” to store information about weather observation stations?*/

Create table station  
(  
    ID number primary key,  
    city char(20),  
    state char(2),  
    Lat_N number ,  
    long_w number  
);

/* ue.2.Insert the following records into the table */

insert into station values (13,'phoenix','AZ',33,112);

INSERT INTO Station values (44 ,'denver','AZ',40,105);

insert into Station values (66 ,'caribou','ME',47 ,68);

/* Que.3-Execute a query to look at table STATION in undefined order. */
select * from station;

/* Que.4.Execute a query to select Northern stations (Northern latitude >39.7)*/

select * from station  Where lat_N >39.7;

/* Q.5.Create another table ,‘STATS’ ,to store normalized temperature and 
precipitation data*/

create table Stats   
( ID number references station (ID),  
    month number check(month between 1 and 12 ),  
    Temp_f int check (temp_f between -80 and 150 ),  
    Rain_I int check (rain_i between 0 and 100),  
    primary key (ID ,month)  
    );
    
/* Q.6.Populate the table STATS with some statistics for January and July*/

insert into stats values (13,1,57.4 ,0.31);
insert into stats values ( 13,7,91.7 ,5.15);
insert into stats values (44,1,27.3 ,0.18);
insert into stats values ( 44,7,74.7 ,2.11);
insert into stats values (66,1,6.7,2.1);
insert into stats values (66 ,7,65.8 ,4.52);

/* Q.7.Execute a query to display temperature stats (from STAT Stable) for each city 
(from Station table) */

select city , temp_F 
    from station  
    inner join stats  
    on station.id = stats .id ;

/* Q.7.Execute a query to display temperature stats (from STAT Stable) for each city 
(from Station table) */

select city ,month , rain_i from stations   
inner join stats on station.id  = stats.ID  
order by month , rain_i;

/*Q.8 Execute a query to look at the table STATS, ordered by month and greatest 
rainfall ,with columns rearranged. It should also show the corresponding cities*/

select city ,month , Rain_I from station  
inner join stats on station.id  = stats.ID  
order by month , rain_i;


/* Q.9 Execute a query to look at temperatures for July from table STATS, lowest 
temperatures first, picking up city name and latitude */

SELECT City , temp_f ,lat_n  
from stats   
inner join station   
using (id)  
where month = 7   
order by temp_f desc;

/* Q.10 Execute a query to show MAX and MIN temperatures as well as average rainfall 
for each city */

select max(temp_f) as max_temp,  
min(temp_f) as min_temp,  
avg(rain_i) as avg_temp  
from stats ;

/* Q.11 Execute a query to display each city’ smonthly temperature in Celcius and rainfall 
in Centimeter */

select A.city , B.month ,  
((B.temp_f - 32)*5/9) as temp_inc,  
(B.rain_i * 2.54) as rain_inc  
from station A   
inner join stats B  
using (ID);

/*Q.12 Update all rows of table STATS to compensate for faulty rain gauges known to 
read 0.01 inche slow */

update stats   
set rain_i = rain_i +0.01 ;
select * from stats  ;

/* Q.13 Update Denver's July temperature reading as 74.9 */

update (select city , temp_f ,month from station inner join stats using (id))  
set temp_f = 74.9 where city = 'denver' and month = 7;
select city ,temp_f , month from station inner join stats using (id);

