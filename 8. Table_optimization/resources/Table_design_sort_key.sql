---- sort
select "column", type, sortkey
from pg_table_def where tablename = 'usersauto';

-- update the sort key
create table users_custom_sort sortkey (firstname, lastname) as
select * from users;

select "column", type, sortkey
from pg_table_def where tablename = 'users_custom_sort';

explain SELECT firstname, lastname, total_quantity
FROM (SELECT buyerid, sum(qtysold) total_quantity 
      FROM sales
      GROUP BY buyerid
      ORDER BY total_quantity desc limit 10) Q, table_design_demo.users_custom_sort U
WHERE Q.buyerid = U.userid
ORDER BY Q.total_quantity desc;

-- explain functions
--  cost - 1st value to return the first row, 2nd value to complete the whole operation