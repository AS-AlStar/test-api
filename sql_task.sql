create temp table users(id bigserial, group_id bigint);
insert into users(group_id) values (1),(1),(1),(2),(1),(3);

with group_table as (
    select
        id,
        group_id,
        row_number() over(order by id) -
            row_number() over(order by group_id, id) as group_filter
    from users
)
select
    min(id) as min_value,
    count(id) as values_count,
    group_id
from group_table
group by group_id, group_filter
order by min_value;

 min_value | values_count | group_id
-----------+--------------+----------
         1 |            3 |        1
         4 |            1 |        2
         5 |            1 |        1
         6 |            1 |        3
