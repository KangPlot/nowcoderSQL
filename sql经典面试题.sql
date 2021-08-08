经典面试题：用户连续登录天数

故实现该连续登陆的标记部分的查询语句应该是
SELECT uid, dat, (DAY(dat) - ROW_NUMBER() OVER(PARTITION BY uid ORDER BY dat)) AS day_label
FROM table

故计算连续登陆天数day_count的语句是：
SELECT uid,day_label,count(*) as day_count
FROM (
    SELECT uid, dat, 
    (DAY(dat) - ROW_NUMBER() OVER(PARTITION BY uid ORDER BY dat)) 
    AS day_label FROM table)

GROUP BY uid,day_label

-- ————————————————
-- 版权声明：本文为CSDN博主「theodorewy」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
-- 原文链接：https://blog.csdn.net/theodorewy/article/details/101444607

故求最大连续登陆天数max(day_count)的语句是：

SELECT uid,max(day_count) as max_day
FROM
   ( SELECT uid,day_label,count(*) as day_count
        FROM (
             SELECT uid, dat, (DAY(dat) - ROW_NUMBER() OVER(PARTITION BY uid ORDER BY dat)) AS day_label FROM table)
GROUP BY uid,day_label)

GROUP BY uid




-- 存在一张用户登陆表 user_login 表，
-- 其中uid 为用户ID , 
-- login_time 为用户登陆时间，
-- 需要找出每个用户最大的连续登陆天数。
--表
uid	login_time
1	‘2018-10-01’
2	‘2018-10-02’
3	‘2018-10-05’
1	‘2018-10-02’

SELECT uid, MAX(cnt) AS max_login_time
FROM (
	SELECT a.uid, a.rn, COUNT(a.rn) AS cnt
	FROM (
		SELECT uid, day(login_time) - ROW_NUMBER() OVER (PARTITION BY uid ORDER BY login_time) AS rn
		FROM user_login
	) a
	GROUP BY a.uid, a.rn
) b
GROUP BY uid;




select uid, rn, count(rn) as cnt
	select uid, day(login_time) - ROW_NUMBER() over (PARTITION by uid order by login_time) as rn
	from t
GROUP by uid,rn having cnt >=5;







查找每科成绩大于70的学生
select 
 	id
    ,name
 from
    table1
 group by
    id
    ,name
 having 
    min(score) > 70   --  这个秒 