SQL66-67 牛客每个人最近的登录日期(二)

--查询每个用户最近一天登录的日子，并且按照user_id升序排序
select user_id, max(date)
from login
group by user_id order by user_id;


--查询每个用户最近一天登录的日子，用户的名字，以及用户用的设备的名字
# select u.name, c.name, max(date)
# from login l 
# left join user as u 
# on l.user_id = u.id
# join client c
# on l.client_id = c.id
# group by u.name
# order by l.user_id
--这个答案错误



select u.name as u_n, c.name as c_n,l.date
from login l 
join user u 
on l.user_id=u.id
join client c 
on l.client_id=c.id
where
(l.user_id,l.date) 
in --in 帅选
    (select 
         user_id,max(date) 
     from login 
     group by login.user_id )--指明login
order by u.name;