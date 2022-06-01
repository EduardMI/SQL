/* View наличие билетов в продаже на представление*/

create or replace view tickets_to_buy as
	select e.name, e.date_event, e.time_event, count(t.event)
	from events e
	join tickets t on t.event = e.id and t.status = 'свободен'
	group by e.id;

select * from tickets_to_buy;

/*View репертуар на сегодня*/
create or replace view events_to_day as
	select e.name as events, e.time_event, t.name as theatre 
	from events e
	join theaters t on e.theatre = t.id 
	where date_event = CURRENT_DATE(); 

select * from events_to_day;
