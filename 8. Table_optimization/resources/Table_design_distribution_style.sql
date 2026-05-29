create schema table_design_demo;

SET search_path = table_design_demo,public;

-- checking the sortkey for users
select "column", type, distkey
from pg_table_def where tablename = 'users' and schemaname='public';

select * from svv_table_info s where s. schema='public' and s.table ='users';

-- USERID is defined as the DISTKEY column

-- checking the disk usage, distribution
select slice, col, num_values as rows, minvalue, maxvalue
from svv_diskusage
where name='users' and tbl = (select table_id from svv_table_info s where s.schema='public' and s.table ='users')
and col=0
and num_values>0
order by slice, col;

-- table is evenly distributed, same range,
-- col is userid

-- state as the dist key
create table userskey distkey(state) as select * from users;

-- checking the disk usage with state as distkey
select slice, col, num_values as rows, minvalue, maxvalue
from svv_diskusage
where name='userskey' and tbl = (select table_id from svv_table_info s where s.schema='table_design_demo' and s.table ='userskey')
and col=0
and num_values>0;

-- not evenly distributed
-- even e. g.
create table userseven diststyle even as
select * from users;

select slice, col, num_values as rows, minvalue, maxvalue
from svv_diskusage
where name='userseven' and tbl = (select table_id from svv_table_info s where s.schema='table_design_demo' and s.table ='userseven')
and col=0 
and num_values>0;

-- all example
create table usersall diststyle all as
select * from users;

select slice, col, num_values as rows, minvalue, maxvalue
from svv_diskusage
where name='usersall' and tbl = (select table_id from svv_table_info s where s.schema='table_design_demo' and s.table ='usersall')
and col=0
and num_values>0;


-- auto example
create table usersauto as
select * from users;

select slice, col, num_values as rows, minvalue, maxvalue
from svv_diskusage
where name='usersauto' and tbl = (select table_id from svv_table_info s where s.schema='table_design_demo' and s.table ='usersauto')
and col=0
and num_values>0;

select * from svv_table_info s where s. schema='table_design_demo' and s. table ='usersauto';