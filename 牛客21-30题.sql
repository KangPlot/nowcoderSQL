牛客21-30题

22:medium
select d.dept_no, d.dept_name, a.sum
from departments d
join (
	SELECT de.dept_no, count(s.emp_no) as `sum`
	from dept_emp de
	inner join 
	salaries s
	on de.emp_no = s.emp_no
	group by de.dept_no
) a 
on d.dept_no = a.dept_no

-- 先把2，3表联立，根据薪水表的员工记录数，对应工资数，按部门编号分组。
-- 最后和第一个表联立


# SELECT emp_no, count(salary)
# from salaries 
# group by emp_no,
这个思路不对

23：hard

select emp_no, salary, 
dense_rank() over(order by salary desc) as t_rank
from salaries


# 排序函数row_number、rank、dense_rank的区别

# 口诀：
# row_number 不存在并列
# dense_rank 和rank存在并列，但rank很跳。
# 口诀的意思是：
# row_number：不考虑并列的情况，哪怕分数相同，排名都是一溜下来的自然数。
# dense_rank和rank 考虑并列的情况，区别在于rank很跳，并列排名的个数会影响接下来的排名，表现为数字的中断。而dense_rank 不管有几个并列的第5名，接下来都是从6开始排。
# ————————————————
# 版权声明：本文为CSDN博主「海上*钢琴师*」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
# 原文链接：https://blog.csdn.net/weixin_41710541/article/details/118531655

24:hard
select  de.dept_no, e.emp_no, s.salary
from employees e 
inner join dept_emp de
on e.emp_no = de.emp_no
inner join salaries s
on e.emp_no = s.emp_no
-- 非manager员工
where e.emp_no not in(
    select emp_no 
    from dept_manager
)

# 涉及到三个表inner join然后添加一个条件即可