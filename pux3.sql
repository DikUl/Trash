with q as
(
   select 1 as a, 2 as b from dual union all
   select 1 as a, 2 as b from dual union all
   select 2 as a, 2 as b from dual union all
   select 2 as a, 3 as b from dual union all
   select 3 as a, 4 as b from dual
)
select q.*, dense_rank() over (order by q.a, q.b) from q 
