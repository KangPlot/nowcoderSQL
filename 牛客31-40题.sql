牛客31-40题

30:medium 找出属于Action分类的所有电影对应的title,description
SELECT f.TITLE, f.DESCRIPTION
FROM film f 
where f.film_id in (
    SELECT fc.film_id
    from category c 
    join film_category fc
    on c.category_id = fc.category_id
    where c.name = "Action"
)

-- 用in作为子表刷选
-- 观察，2，3表相同字段有category_id，1，3表相同字段有film_id,
-- 先找出属于action的电影的全部，
-- 然后用in 判断属于它的


32：easy 将employees表的所有员工的last_name和first_name拼接起来作为Name，中间以一个空格区分
select CONCAT(last_name," ",first_name) as name  from employees

33:easy 创建一个actor表
CREATE TABLE if not exists actor (
actor_id smallint(5) not null primary key,
first_name varchar(45) not null,
last_name varchar(45) not null,
last_update date not null);

34:easy
INSERT INTO actor(actor_id,
                  first_name,
                  last_name,
                  last_update)
VALUES(1,'PENELOPE','GUINESS','2006-02-15 12:34:33'),
      (2,'NICK','WAHLBERG','2006-02-15 12:34:33');

35:easy
# mysql中常用的三种插入数据的语句: 
# insert into表示插入数据，数据库会检查主键，如果出现重复会报错； 
# replace into表示插入替换数据，需求表中有PrimaryKey，
#             或者unique索引，如果数据库已经存在数据，则用新数据替换，如果没有数据效果则和insert into一样； 
# insert ignore表示，如果中已经存在相同的记录，则忽略当前新数据；
insert ignore into actor values("3","ED","CHASE","2006-02-15 12:34:33");


36:medium 
create table if not exists actor_name(
first_name  varchar(45)  not null,
last_name   varchar(45)  not null); -- 创建表

-- 将actor表中的所有first_name以及last_name导入该表
insert into actor_name
select     first_name,last_name
from actor; -- 插入查

37:创建索引
ALTER TABLE actor ADD UNIQUE INDEX  uniq_idx_firstname(first_name);
ALTER TABLE actor ADD INDEX idx_lastname(last_name);

38:创建视图view
CREATE VIEW actor_name_view AS
SELECT first_name AS first_name_v, last_name AS last_name_v
FROM actor 

40:增加列
alter table actor 
add column create_date datetime not null default '2020-10-01 00:00:00' 
after last_update;