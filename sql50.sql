--- sql 50
--- mysql中用concat()连接字符串
 select concat(last_name, '''', first_name) as name
 from employees;