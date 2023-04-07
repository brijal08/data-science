-- use orders database
use orders;
show tables;

-- 1. Write a query to display the product details (product_class_code, product_id, product_desc,
-- product_price) as per the following criteria and sort them descending order of category:
--   i) If the category is 2050, increase the price by 2000
--  ii) If the category is 2051, increase the price by 500
--  iii) If the category is 2052, increase the price by 600 

select product_class_code, product_id, product_desc,
CASE 
     WHEN product_class_code = 2050 THEN (product_price + 2000)
     WHEN product_class_code = 2051 THEN (product_price + 500)
     WHEN product_class_code = 2052 THEN (product_price + 600)
ELSE product_price
END AS product_price 
from PRODUCT 
order by product_class_code;


-- 2. Write a query to display (product_class_desc, product_id, product_desc, product_quantity_avail ) and Show inventory status of products as below
-- as per their available quantity:
--    a. For Electronics and Computer categories, if available quantity is <= 10, show
--       'Low stock', 11 <= qty <= 30, show 'In stock', >= 31, show 'Enough stock'
--    b. For Stationery and Clothes categories, if qty <= 20, show 'Low stock', 21 <= qty <=
--       80, show 'In stock', >=81, show 'Enough stock'
--    c. Rest of the categories, if qty <= 15 – 'Low Stock', 16 <= qty <= 50 – 'In Stock', >=
--       51 – 'Enough stock'
-- For all categories, if available quantity is 0, show 'Out of stock'. 

select PRODUCT_CLASS_DESC, PRODUCT_ID, PRODUCT_DESC, PRODUCT_QUANTITY_AVAIL, 
case
	when PRODUCT_QUANTITY_AVAIL = 0 then 'Out of stock'
	when PRODUCT_CLASS_DESC in ('Electronics','Computer') then 
    (case 
		when PRODUCT_QUANTITY_AVAIL <= 10 then 'Low stock'
		when PRODUCT_QUANTITY_AVAIL <= 30  then 'In stock'
		else 'Enough stock'
    end)
    when PRODUCT_CLASS_DESC in ('Stationery','Clothes') then
    (case
		when PRODUCT_QUANTITY_AVAIL <= 20 then 'Low stock'
		when PRODUCT_QUANTITY_AVAIL <= 80  then 'In stock'
		else 'Enough stock'
    end)
	else 
	(case 
		when PRODUCT_QUANTITY_AVAIL <= 15 then 'Low stock'
		when PRODUCT_QUANTITY_AVAIL <= 50 then 'In stock'
		else 'Enough stock'
	end) 
end as inventory_status
from product inner join product_class using(PRODUCT_CLASS_CODE)
order by PRODUCT_ID;

-- 3. Write a query to Show the count of cities in all countries other than USA & MALAYSIA, with more than 1 city, in the descending order of CITIES. 
select COUNTRY, count(CITY) as city_count 
from address
where COUNTRY not in ('USA','MALAYSIA') 
group by COUNTRY
having city_count > 1;

-- 4. Write a query to display the customer_id,customer full name ,city,pincode,and order details (order id,order date, product class desc, product desc, 
-- subtotal(product_quantity * product_price)) for orders shipped to cities whose pin codes do not have any 0s in them. Sort the output on customer name, 
-- order date and subtotal.

select oc.CUSTOMER_ID, concat(oc.CUSTOMER_FNAME,  ' ', oc.CUSTOMER_LNAME) as customer_name, addr.CITY, addr.PINCODE,
ordh.ORDER_ID, ordh.ORDER_DATE, prdc.PRODUCT_CLASS_DESC, prd.PRODUCT_DESC, (ordi.PRODUCT_QUANTITY * prd.PRODUCT_PRICE) as subtotal
from online_customer oc 
join address addr using(ADDRESS_ID)
join order_header ordh using(CUSTOMER_ID)
join order_items ordi using(ORDER_ID)
join product prd using(PRODUCT_ID)
join product_class prdc using(PRODUCT_CLASS_CODE)
where addr.PINCODE not like '%0%'
order by customer_name, ordh.ORDER_DATE, subtotal;

-- 5. A stakeholder wants to find which product is ordered in highest quantity along with product_id 201. In the orders that contain product id 201, 
-- find which other product is ordered in highest quantity (i.e. total quantity added across the orders is highest). Display following details: product id, 
-- product description, total quantity (i.e. sum(product quantity)) 

select s.PRODUCT_ID, s.PRODUCT_DESC, s.total_quantity
from (select p.PRODUCT_ID, p.PRODUCT_DESC, sum(oi.PRODUCT_QUANTITY) as total_quantity
	from order_items oi join product p using(PRODUCT_ID)
	group by oi.PRODUCT_ID ) s
where s.PRODUCT_ID = 201 or s.PRODUCT_ID = (select oi2.PRODUCT_ID
											from order_items oi2
											group by oi2.PRODUCT_ID
                                            order by sum(oi2.PRODUCT_QUANTITY) desc
                                            limit 1);
select s.PRODUCT_ID, s.PRODUCT_DESC, s.total_quantity
from ( 	select oi.ORDER_ID, oi.PRODUCT_ID, p.PRODUCT_DESC , sum(oi.PRODUCT_QUANTITY) as total_quantity 
		from order_items oi join product p using(PRODUCT_ID)
		group by oi.PRODUCT_ID
		having oi.ORDER_ID in (	select ORDER_ID 
								from order_items
								where PRODUCT_ID = 201)
	) as s
order by s.total_quantity desc
limit 1;

-- 6. Write a query to display the customer_id,customer name, email and order details 
-- (order id, product desc,product qty, subtotal(product_quantity * product_price)) for all
-- customers even if they have not ordered any item. 

select oc.CUSTOMER_ID, concat(oc.CUSTOMER_FNAME,  ' ', oc.CUSTOMER_LNAME) as customer_name, oc.CUSTOMER_EMAIL,
ordh.ORDER_ID, prd.PRODUCT_DESC, ordi.PRODUCT_QUANTITY, (ordi.PRODUCT_QUANTITY * prd.PRODUCT_PRICE) as subtotal
from online_customer oc
left join order_header ordh using(CUSTOMER_ID)
left join order_items ordi using(ORDER_ID)
left join product prd using(PRODUCT_ID);

-- 7. Write a query to display carton id ,(len*width*height) as carton_vol and identify the
-- optimum carton (carton with the least volume whose volume is greater than the total volume of
-- all items(len * width * height * product_quantity)) for a given order whose order id is 10006
-- , Assume all items of an order are packed into one single carton (box) .

select CARTON_ID, (LEN * WIDTH * HEIGHT) as carton_vol
from carton
having carton_vol >= (select sum(LEN * WIDTH * HEIGHT * PRODUCT_QUANTITY) 
                    from product join order_items using (PRODUCT_ID)
                    where ORDER_ID = 10006)
order by carton_vol
limit 1;

-- 8. Write a query to display details (customer id,customer fullname,order id,product quantity)
-- of customers who bought more than ten (i.e. total order qty) products with credit card or net
-- banking as the mode of payment per shipped order. 

select CUSTOMER_ID, concat(CUSTOMER_FNAME, ' ', CUSTOMER_LNAME) as customer_name, ORDER_ID, sum(PRODUCT_QUANTITY) as total_order_qty
from order_header join online_customer using(CUSTOMER_ID)
join order_items using(ORDER_ID)
where PAYMENT_MODE in ('Credit Card', 'Net Banking') and ORDER_STATUS = 'Shipped'
group by ORDER_ID
having total_order_qty > 10;


-- 9.Write a query to display the order_id,customer_id and customer fullname starting with “A” along
-- with (product quantity) as total quantity of products shipped for order ids > 10030 

select ORDER_ID, CUSTOMER_ID, concat(CUSTOMER_FNAME, ' ', CUSTOMER_LNAME) as customer_name, sum(PRODUCT_QUANTITY) as total_quantity
from order_header join order_items using(ORDER_ID)
join online_customer using(CUSTOMER_ID)
where ORDER_ID > 10030 and ORDER_STATUS = 'shipped'
group by ORDER_ID
having upper(customer_name) like 'A%';


-- 10. Write a query to display product class description, totalquantity(sum(product_quantity), Total
-- value (product_quantity * product price) and show which class of products have been shipped
-- highest(Quantity) to countries outside India other than USA? Also show the total value of those
-- items.  [NOTE:PRODUCT TABLE,ADDRESS TABLE,ONLINE_CUSTOMER TABLE,ORDER_HEADER TABLE,ORDER_ITEMS TABLE,PRODUCT_CLASS TABLE]

select PRODUCT_CLASS_DESC, sum(PRODUCT_QUANTITY) as total_quantity, (PRODUCT_QUANTITY * PRODUCT_PRICE) as total_value
from order_items join product using(PRODUCT_ID)
join product_class using(PRODUCT_CLASS_CODE)
join order_header using(ORDER_ID)
join online_customer using(CUSTOMER_ID)
join address using(ADDRESS_ID)
where ORDER_STATUS = 'shipped' and COUNTRY not in ('India','USA')
group by PRODUCT_CLASS_CODE
order by total_quantity desc
limit 1;





