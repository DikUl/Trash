create table plv_test_table as
with q as
(
select 1 as attr1, 1 as attr2, 1 as adddate, 97 as cost from dual union all
select 1 as attr1, 1 as attr2, 3 as adddate, 23 as cost from dual union all
select 2 as attr1, 2 as attr2, 2 as adddate, 435 as cost from dual union all
select 2 as attr1, 2 as attr2, 1 as adddate, 54 as cost from dual union all
select 1 as attr1, 1 as attr2, 2 as adddate, 345 as cost from dual union all
select 2 as attr1, 2 as attr2, 3 as adddate, 99 as cost from dual union all
select 2 as attr1, 2 as attr2, 4 as adddate, 7 as cost from dual
)
select * from plv_test_table;

select * from plv_test_table;

merge into plv_test_table t
using
(
   select
        q.*
      , max(q.cost) over (partition by q.attr1, q.attr2 order by q.adddate range between unbounded preceding and current row)
      as prevcost
   from plv_test_table q 
) v
on ( t.attr1 = v.attr1 and t.attr2 = v.attr2 and t.adddate = v.adddate )
when matched then update set t.cost = v.prevcost;

select * from plv_test_table;
