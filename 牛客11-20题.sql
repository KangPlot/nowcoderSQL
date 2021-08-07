牛客11-20题

11:medium 题目：获取所有员工当前的manager，如果当前的manager是自己的话结果不显示，
SELECT de.emp_no, dm.emp_no as manager
from dept_emp de
inner join dept_manager dm
on de.dept_no = dm.dept_no
WHERE de.emp_no!=dm.emp_no -- 这个很关键

12:hard 
https://blog.nowcoder.net/n/5338a91350c541518946e26a9314110b?f=comment

-- not all ac,,如果同部门有多条同等最大salary，仅显示一条
select t.dept_no, t.emp_no, max(t.salary)
from(
SELECT de.dept_no, de.emp_no, s.salary
from dept_emp de 
inner join salaries s
on de.emp_no = s.emp_no
) t
group by t.dept_no
order by t.dept_no asc;


第一步：每个部门最高的薪水

select 
  d.dept_no,max(s.salary) salary 
from 
  dept_emp d
join 
  salaries s
on 
  d.emp_no=s.emp_no and d.to_date='9999-01-01' and s.to_date='9999-01-01'
group by 
  d.dept_no;

第二步(将员工、部门、薪水整合在一张表内)：

select 
  d.emp_no,d.dept_no,s.salary 
from 
  dept_emp d
join 
  salaries s
on 
  d.emp_no=s.emp_no

第三步：(将t1和t2整合)


select 
  t1.dept_no,t2.emp_no,t1.salary 
from 
  (表t1) t1
join 
  (表t2) t2
on 
  t1.dept_no=t2.dept_no and t1.salary=t2.salary
order by 
  t1.dept_no;


---all
select 
  t1.dept_no,t2.emp_no,t1.salary 
from 
  (select 
    d.dept_no,max(s.salary) salary 
  from 
    dept_emp d
  join 
    salaries s
  on 
    d.emp_no=s.emp_no and d.to_date='9999-01-01' and s.to_date='9999-01-01'
  group by 
    d.dept_no) t1
join 
  (select 
    d.emp_no,d.dept_no,s.salary 
  from 
    dept_emp d
  join 
    salaries s
  on 
    d.emp_no=s.emp_no and d.to_date='9999-01-01' and s.to_date='9999-01-01') t2
on 
  t1.dept_no=t2.dept_no and t1.salary=t2.salary
order by 
  t1.dept_no;



15:esay 请你查找employees表所有emp_no为奇数，且last_name不为Mary的员工信息，并按照hire_date逆序排列，以上例子查询结果如下:

select * 
from employees
where emp_no%2 != 0
and last_name != "Mary"
order by hire_date desc


16:medium 两表联立，ｇｒｏｕｐ　ｂｙ
select t.title ,avg(s.salary)
from titles t
inner join salaries s
on t.emp_no = s.emp_no
group by t.title

ｔｉｐｓ：
1. 需要返回 2 列，写上 title, avg(salary)
2. 内连接 2 张表，需要加上关联条件是员工号相同 salary.emp_no = ti.emp_no
3. 查询的约束条件是两个日期，加上 WHERE
4. 最后得到的数组是符合条件的数组，对 title 分组，可以求得 avg(salary) 


１７
select emp_no, salary from salaries
where to_date = '9999-01-01' and salary = (select distinct salary from salaries order by salary desc limit 1,1)
# 避免了2个问题：
# (1) 首先这样可以解决多个人工资相同的问题；
# (2) 另外，筛选出第二多的工资时要注意distinct salary，否则不能选出第二多的工资。


-- limit m, n
-- 从m+1 位置开始，取n个

19：medium 三个表连接，看输出要用left join ，输出有null
select e.last_name, e.first_name, d.dept_name
from employees e
left join dept_emp de
on e.emp_no = de.emp_no
left join departments d
on d.dept_no = de.dept_no

-- 第一步，将员工表employees与员工-部门关系表dept_emp进行外连接left join，
-- 连接条件是员工编号对应，这样得到的连表包含所有的员工信息+对应的部门编号信息
-- （如果员工未分配部门，则按照外连接规则，默认填写null）；
-- 第二步，将第一步中得到的连表，与部门信息表departments进行外连接，
-- 连接条件是部门编号对应，这样得到的新的连表即包含题目要求的所有记录。

