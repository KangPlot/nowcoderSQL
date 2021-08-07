--行列如何互换

--case when + group by 聚合
--合并字段显示：利用group_concat(),行转列，可以使用group_concat()函数结合group by实现。


select 学号,
max(case 课程号 when '0001' then 成绩 else 0 end) as '课程号0001',
max(case 课程号 when '0002' then 成绩 else 0 end) as '课程号0002',
max(case 课程号 when '0003' then 成绩 else 0 end) as '课程号0003'
from score
group by 学号;

--https://www.cnblogs.com/xiaoxi/p/7151433.html
SELECT userid,
SUM(CASE `subject` WHEN '语文' THEN score ELSE 0 END) as '语文',
SUM(CASE `subject` WHEN '数学' THEN score ELSE 0 END) as '数学',
SUM(CASE `subject` WHEN '英语' THEN score ELSE 0 END) as '英语',
SUM(CASE `subject` WHEN '政治' THEN score ELSE 0 END) as '政治' 
FROM tb_score 
GROUP BY userid


--https://www.huaweicloud.com/articles/8357604.html
SELECT c2,
SUM(CASE when c3 = '正式' then 1 else 0 END) as "正式",
SUM(CASE when c3 = '临时' then 1 else 0 END) as "临时"
FROM col_index
GROUP BY c2

--https://blog.csdn.net/fdipzone/article/details/76473148

--行转列，可以使用group_concat()函数结合group by实现。

select id, 
group_concat(name) as name 
from tb 
group by id;




--列转行；
	--本质是将userid的每个科目分数分散成一条记录显示出来。
SELECT userid,'语文' AS course,cn_score AS score FROM tb_score1
UNION ALL
SELECT userid,'数学' AS course,math_score AS score FROM tb_score1
UNION ALL
SELECT userid,'英语' AS course,en_score AS score FROM tb_score1
UNION ALL
SELECT userid,'政治' AS course,po_score AS score FROM tb_score1
ORDER BY userid

--附：UNION与UNION ALL的区别（摘）：

1.对重复结果的处理：UNION会去掉重复记录，UNION ALL不会；

2.对排序的处理：UNION会排序，UNION ALL只是简单地将两个结果集合并；

3.效率方面的区别：因为UNION 会做去重和排序处理，因此效率比UNION ALL慢很多；