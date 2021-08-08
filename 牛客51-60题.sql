牛客50-60
50
SELECT concat(  last_name,"'",first_name)
from employees 
51
select (length("10,A,B") - length(replace("10,A,B",",","")) )as cnt


53

# SELECT dept_no,group_concat(emp_no,",")
# from dept_emp
# group by dept_no


# d001|10001,,10002,
# d002|10006,
# d003|10005,
# d004|10003,,10004,
# d005|10007,,10008,,10010,
# d006|10009,,10010,


SELECT dept_no,group_concat(emp_no) -- 默认是，分割
from dept_emp
group by dept_no

54
查找排除最大、最小salary之后的
当前(to_date = '9999-01-01' )员工的平均工资avg_salary。

SELECT avg(salary) 
from salaries
where to_date = '9999-01-01' 
and salary not in(
    SELECT min(salary)
    from salaries where to_date = '9999-01-01' 
)
and salary not in(
    SELECT max(salary)
        from salaries where to_date = '9999-01-01' 
)
tips
-- 在挑选当前最大、最小salary时
-- 没加 to_date = '9999-01-01' 作条件限制，
-- 导致挑选出来的是全表最大、最小salary，
-- 然后对除去这两个salary再作条件限制 to_date = '9999-01-01' 


55 hard
select * from employees limit 5,5;
# 解题思路：每页5行，返回第二页，即返回第6-10行数据，


57:m

SELECT * from 
employees 
where not EXISTS ( -- 注意where 后面
    select emp_no 
    from 
    dept_emp where employees.emp_no = dept_emp.emp_no
)
tips
1.什么时候用EXISTS，什么时候用IN？
主表为employees，从表为dept_emp，在主表和从表都对关联的列emp_no建立索引的前提下：
    当主表比从表大时，IN查询的效率较高；
    当从表比主表大时，EXISTS查询的效率较高；
原因如下：
    in是先执行子查询，得到一个结果集，将结果集代入外层谓词条件执行主查询，子查询只需要执行一次
    exists是先从主查询中取得一条数据，再代入到子查询中，执行一次子查询，判断子查询是否能返回结果，
		主查询有多少条数据，子查询就要执行多少次


59 med
给出emp_no、first_name、last_name、奖金类型btype、
对应的当前薪水情况salary以及奖金金额bonus。 
bonus类型btype为1其奖金为薪水salary的10%，btype为2其奖金为薪水的20%，
其他类型均为薪水的30%。 当前薪水表示to_date='9999-01-01'

SELECT 
    e.emp_no, e.first_name, e.last_name, eb.btype, s.salary,
    (case when eb.btype = 1 then s.salary * 0.1 
        when eb.btype = 2 then s.salary * 0.2 
         else s.salary * 0.3 
     end  ) as bonus
from employees e
inner join emp_bonus eb
on e.emp_no = eb.emp_no
inner join salaries s
on s.emp_no = e.emp_no
where s.to_date = '9999-01-01'

tips

-- 简单case函数
case sex
  when '1' then '男'
  when '2' then '女'
  else '其他' end

--case搜索函数
case when sex = '1' then '男'
     when sex = '2' then '女'
     else '其他' end


60 hard

按照salary的累计和running_total，
其中running_total为前N个当前( to_date = '9999-01-01')员工的salary累计和，
emp_no	salary	running_total
10001	88958	88958
10002	72527	161485
10003	43311	204796
10004	74057	278853
10005	94692	373545

后面一个是前面一个的累加(美团面试题)


SELECT s1.emp_no, s1.salary, 
    (SELECT SUM(s2.salary) 
     FROM salaries AS s2 
     WHERE s2.emp_no <= s1.emp_no AND s2.to_date = '9999-01-01') 
     AS running_total 
FROM salaries AS s1 WHERE s1.to_date = '9999-01-01' ORDER BY s1.emp_no


# 将子查询内复用的 salaries 表记为 s2，主查询的 salaries 表记为 s1，
# 当主查询的 s1.emp_no 确定时，
# 对子查询中不大于 s1.emp_no 的 s2.emp_no 所对应的薪水求和

美团面试题: 求每天累计的订单数（第二天是第一天的叠加，和这题类似）
people

datetime NUM 
20210501 10
20210502 10
20210503 30

SELECT p1.datetime, (SELECT SUM(p2.sum) 
     FROM people AS p2 
     WHERE p2.datetime <= p1.datetime) 
     AS allpeople
from people p1
order by p1.datetime



