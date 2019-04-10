drop view sales_employee;
create view sales_employee as
select 	t1.first_name||' '||t1.last_name as Salesman, 
		count(distinct t2.order_id) as Total_Orders, 
		sum(t3.quantity*t3.unit_price) as Total_Sales
from employees t1
	inner join orders t2 on (t2.salesman_id = t1.employee_id)
	inner join order_items t3 on (t2.order_id = t3.order_id)
group by t1.first_name, t1.last_name;