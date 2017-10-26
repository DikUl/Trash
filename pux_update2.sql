select v.* from
(
   select
        q.attr1, q.attr2, q.adddate, percentile_disc(0.5) within group(order by qj.cost) over (partition by q.attr1, q.attr2, q.adddate) as perc
   from plv_test_table q
   inner join plv_test_table qj
           on q.attr1 = qj.attr1
          and q.attr2 = qj.attr2
          and qj.adddate between q.adddate - 30 and q.adddate
) v
group by v.attr1, v.attr2, v.adddate, v.perc
