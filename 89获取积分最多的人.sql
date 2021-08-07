SELECT u.name, bbb.grade_num AS  grade_num
FROM (
SELECT SUM(grade_num) AS grade_num , user_id
FROM grade_info
GROUP BY user_id
    ORDER BY grade_num DESC LIMIT 1
) bbb
INNER JOIN USER AS u

ON u.id = bbb.user_id