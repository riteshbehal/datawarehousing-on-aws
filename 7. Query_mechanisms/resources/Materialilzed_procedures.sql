-- create schema
create schema mat_view_demo

-- set search path
SET search_path = mat_view_demo,public;

-- query to get the event(eventname) and the total sales associated with it
SELECT e.eventname eventname, sum(s.pricepaid) total_sales
FROM event e, sales sWHERE e.eventid = s.eventid GROUP BY e.eventnameorder by e.eventname

-- create materialized view
CREATE MATERIALIZED VIEW tickets_mv AS (SELECT e.eventname eventname,sum(s.pricepaid) total_sales FROM event e, sales sWHERE e.eventid = s.eventid GROUP BY e.eventname)

-- check the view data
select * from mat_view_demo.tickets_mv order by eventname

-- update the results
update sales s set pricepaid= pricepaid*2 where eventid in (select eventid from event where eventname = ‘.38 Special’)

-- refresh the view data
refresh materialized view mat_view_demo.tickets_mv;

-- auto refresh
CREATE MATERIALIZED VIEW tickets_mv_2 AUTO REFRESH YES AS (SELECT e.eventname eventname, sum(s.pricepaid) total_sales FROM event e, sales sWHERE e.eventid = s.eventid GROUP BY e.eventname)