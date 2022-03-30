--多表连接
--https://zhuanlan.zhihu.com/p/38354000
--查询不同老师所教不同课程平均分从高到低显示

--【知识点】分组+条件+排序+多表连接，思路如图

select a.教师号,a.教师姓名,avg(c.成绩) 
from  teacher as a 
inner join course as b
on a.教师号= b.教师号
inner join score  c on b.课程号= c.课程号
group by a.教师姓名 --没有聚合列。
order by avg(c.成绩) desc;

--查询课程名称为"数学"，且分数低于60的学生姓名和分数
select a.姓名,b.成绩 --的后面的东西
from student as a 
inner join score as b 
on a.学号 =b.学号 --两表连接，
inner join course c on b.课程号 =c.课程号 --再连接第三个表
where b.成绩  <60 and c.课程名称 ='数学'; --帅选


--查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩

select b.姓名,avg(a.成绩),a.学号  
from score as a
inner join student as b 
on a.学号 =b.学号 
where a.成绩 <60
group by a.学号 --一个学号就是一个姓名
having count(a.学号) >=2;