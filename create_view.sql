drop view sales_report;
create view sales_report as
select 	t1.order_id,
		t1.order_date,
		t2.name as customer_name,
		t4.product_name,
		t3.unit_price,
		t3.quantity,
		t3.unit_price*t3.quantity as line_total,
		t4.standard_cost,
		(t3.unit_price-t4.standard_cost)*t3.quantity gross_profit,
		t4.list_price,
		(t4.list_price-t3.unit_price)*t3.quantity as discount
from orders t1
	inner join customers t2 on (t1.customer_id = t2.customer_id)
	inner join order_items t3 on (t1.order_id = t3.order_id)
	inner join products t4 on (t3.product_id= t4.product_id)
order by t1.order_id, t1.order_date;

drop view inventory_report;
create view inventory_report as
select 	
		t2.product_name,
		t1.quantity,
		t3.warehouse_name,
		t5.country_name,
		t6.region_name
from inventories t1
	inner join products t2 on (t1.product_id = t2.product_id)
	inner join warehouses t3 on (t1.warehouse_id = t3.warehouse_id)
	inner join locations t4 on (t3.location_id = t4.location_id)
	inner join countries t5 on (t4.country_id = t5.country_id)
	inner join regions t6 on (t5.region_id = t6.region_id)
order by t5.country_name, t6.region_name;

drop view customer_list;
create view customer_list as
select 	t1.customer_id, t1.name as Customer_Name, t1.address, t1.website, t1.credit_limit, 
		t2.first_name||' '||t2.last_name as contact_person, t2.email as Contact_email, t2.phone as Contact_Phone
from 	customers t1
		left join contacts t2 on (t1.customer_id = t2.customer_id)
order by customer_id;		