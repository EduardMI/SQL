/**/

drop trigger if exists update_status_tickets;

create 
	trigger updete_status_tickets after insert on orders
	for each row
		update  tickets set status = 'забронирован'
		where id = new.tickets_id;



insert into orders values
	(122, 'Мария', 89998887766, 6),
	(122, 'Мария', 89998887766, 7);
	