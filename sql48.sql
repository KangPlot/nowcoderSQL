UPDATE salaries as s
set s.salary=s.salary*1.1
where s.to_date='9999-01-01'
  and s.emp_no in (
    SELECT emp_no
    from
        emp_bonus

)

