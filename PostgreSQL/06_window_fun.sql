-- Active: 1719589117756@@127.0.0.1@5432@postgres@public
---sum() over();count() over();avg() over();
-- row_number() over();rank() over(); dense_rank() over();
-- ntile() over()
-- lag() over();lead() over(); first_value() last_value()

drop table if exists products;
create table products(
    id varchar(10) collate "default",
    name text collate "default",
    price numeric,
    uid varchar(14) collate "default",
    type varchar(100) collate "default"
)
with (oids=FALSE);


BEGIN;
INSERT INTO "public"."products" VALUES ('0006', 'iPhone X', '9600', null, '电器');
INSERT INTO "public"."products" VALUES ('0012', '电视', '3299', '4', '电器');
INSERT INTO "public"."products" VALUES ('0004', '辣条', '5.6', '4', '零食');
INSERT INTO "public"."products" VALUES ('0007', '薯条', '7.5', '1', '零食');
INSERT INTO "public"."products" VALUES ('0009', '方便面', '3.5', '1', '零食');
INSERT INTO "public"."products" VALUES ('0005', '铅笔', '7', '4', '文具');
INSERT INTO "public"."products" VALUES ('0014', '作业本', '1', null, '文具');
INSERT INTO "public"."products" VALUES ('0001', '鞋子', '27', '2', '衣物');
INSERT INTO "public"."products" VALUES ('0002', '外套', '110.9', '3', '衣物');
INSERT INTO "public"."products" VALUES ('0013', '围巾', '93', '5', '衣物');
INSERT INTO "public"."products" VALUES ('0008', '香皂', '17.5', '2', '日用品');
INSERT INTO "public"."products" VALUES ('0010', '水杯', '27', '3', '日用品');
INSERT INTO "public"."products" VALUES ('0015', '洗发露', '36', '1', '日用品');
INSERT INTO "public"."products" VALUES ('0011', '毛巾', '15', '1', '日用品');
INSERT INTO "public"."products" VALUES ('0003', '手表', '1237.55', '5', '电器');
INSERT INTO "public"."products" VALUES ('0016', '绘图笔', '15', null, '文具');
INSERT INTO "public"."products" VALUES ('0017', '汽水', '3.5', null, '零食');
COMMIT;



select
  type,
  name,
  price,
  row_number() over(order by price asc) as idx
from products;


select
  type,
  name,
  price,
  row_number() over(partition by type order by price asc) as idx
from products;


select
  type,
  name,
  price,
  rank() over(partition by type order by price asc) as rnk
from products;


select
  type,
  name,
  price,
  dense_rank() over(partition by type order by price asc) as debse_rnk
from products;


select
  type,
  name,
  price,
  percent_rank() over(partition by type order by price asc) as percent_rnk
from products;


select
  type,
  name,
  price,
  cume_dist() over(partition by type order by price asc) as cume_dist
from products;


select
  type,
  name,
  price,
  ntile(2) over(partition by type order by price asc) as ntlie
from products;


select
  id,
  type,
  name,
  price,
  lag(id,1,'') over(partition by type order by price asc) as lagid
from products;

select
  id,
  type,
  name,
  price,
  lead(id,1,'') over(partition by type order by price asc) as downid
from products;


select
  id,
  type,
  name,
  price,
  first_value(name) over(partition by type order by price asc) as first_name
from products;


select
  id,
  type,
  name,
  price,
  last_value(name) over(partition by type order by price asc) as last_name
from products;

-- 分区 组的第n名
select
  id,
  type,
  name,
  price,
  nth_value(name,2) over(partition by type order by price asc) as nth_value
from products;


select
  sum(price) over(partition by type) as total_type_price,
  (sum(price) over(order by type)) / sum(price) over() as type_price_rate,
  round(price/ (sum(price) over(partition by type rows between unbounded preceding and unbounded following )),3) as child_type_rate,
  rank() over(partition by type order by price  desc) as rnk,
  sum(price) over() as total_price
from products
order by type,price asc;



select   
  id,
  type,
  name,
  price,
  sum(price) over w1 as total_type_price,
  (sum(price) over(order by type)) / sum(price) over() as type_price_rate,
  round(price/(sum(price) over w2),3) as child_type_rate,
  rank() over w3 as rnk,
  sum(price) over() as total_price
from products
WINDOW
  w1 as (partition by type),
  w2 as (partition by type rows between unbounded preceding and unbounded following),
  w3 as (partition by type order by price  desc)
order by type,price asc;


