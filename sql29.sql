select
    film_id, title
from film
where film_id not in(
    select fc.film_id as film_id
    from category c
             join film_category fc
                  on fc.category_id = c.category_id
)

# film
# category
# film_category


# sql29:解题思路：
# 找出已经分类的，然后用where not in
# https://www.nowcoder.com/practice/a158fa6e79274ac497832697b4b83658?tpId=82&&tqId=29781&rp=1&ru=/activity/oj&qru=/ta/sql/question-ranking
