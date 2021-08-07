牛客4-11题

4:easy
select e.last_name, e.first_name, de.dept_no -- 写出查询什么东西
from employees e -- 在哪个表
inner join dept_emp de -- 还有哪个表
on e.emp_no = de.emp_no -- 联立条件


5:easy
select e.last_name, e.first_name, de.dept_no #写出查询什么东西
from employees e  #在哪个表
left join dept_emp de -- 还有哪个表，左连接，左表里面没有的会显示null,这题就是这个意思
on e.emp_no = de.emp_no #联立条件

tips:
--------------------------------------------------------------------------------------------------------------------------------
left join :左连接，返回左表中所有的记录以及右表中连接字段相等的记录。

right join :右连接，返回右表中所有的记录以及左表中连接字段相等的记录。

inner join: 内连接，又叫等值连接，只返回两个表中连接字段相等的行。

full join:外连接，返回两个表中的行：left join + right join。

cross join:结果是笛卡尔积，就是第一个表的行数乘以第二个表的行数。

关键字: on

数据库在通过连接两张或多张表来返回记录时，都会生成一张中间的临时表，然后再将这张临时表返回给用户。

在使用left jion时，on和where条件的区别如下：

1、on条件是在生成临时表时使用的条件，它不管on中的条件是否为真，都会返回左边表中的记录。

2、where条件是在临时表生成好后，再对临时表进行过滤的条件。这时已经没有left join的含义（必须返回左边表的记录）了，条件不为真的就全部过滤掉。




7:easy
select emp_no, count(salary) as t
from salaries
group by emp_no
having t>15

tip
1、用COUNT()函数和GROUP BY语句可以统计同一emp_no值的记录条数
2、根据题意，输出的变动次数为t，故用AS语句将COUNT(emp_no)的值转换为t
3、WHERE语句在GROUP BY语句之前；SQL会在分组之前计算WHERE语句。   
	HAVING语句在GROUP BY语句之后；
	SQL会在分组之后计算HAVING语句。故使用HAVING语句来限定t>15的条件


8:easy
select distinct salary 
from salaries 
order by salary desc

对于distinct与group by的使用: 
1、当对系统的性能高并数据量大时使用group by 
2、当对系统的性能不高时使用数据量少时两者皆可 
3、尽量使用group by

-- another solution
select salary 
from salaries 
group by salary
order by salary desc


10:easy
SELECT emp_no 
from employees
where emp_no not IN
(
    select e.emp_no
    from employees e
    inner join dept_manager de
    on e.emp_no = de.emp_no
)


-- 可以简化
SELECT emp_no 
from employees
where emp_no not IN
(
    select emp_no
    from dept_manager
)

tips:
not in在实际使用中，因为not in会转化成多表连接，
而且不使用索引，在这里，觉得还是用left_join代替会好一点
-- left join,帅选null
SELECT employees.emp_no FROM employees LEFT JOIN dept_manager
ON employees.emp_no = dept_manager.emp_no
WHERE dept_no IS NULL

11:medium 题目：获取所有员工当前的manager，如果当前的manager是自己的话结果不显示，
SELECT de.emp_no, dm.emp_no as manager
from dept_emp de
inner join dept_manager dm
on de.dept_no = dm.dept_no
WHERE de.emp_no!=dm.emp_no -- 这个很关键