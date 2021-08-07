--窗口函数

增加了一列，排名
row_number () over(partition by xx order by x desc) as rk


select 学号 ,avg(成绩),
row_number () over( order by avg(成绩) desc)--增加了一列，排名
from score
group by 学号  ;

select 课程号 ,
row_number () over(partition by 课程号 order by 成绩 )--按各科成绩进行排序，并显示排名
from score ;



--查询每门功成绩最好的前两名学生姓名

select a.课程号 ,b.姓名 ,a.成绩,a.ranking 
from (
	select 课程号 ,学号 ,成绩 ,
	row_number () over(partition by 课程号 order by 成绩 desc) as ranking
	from  score) as a 
inner join student b on a.学号 =b.学号 
where a.ranking <3 ;