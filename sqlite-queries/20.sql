-- using 1661112540 as a seed to the RNG


select s_name, s_address
from supplier, nation
where (
  s_suppkey in (
    select ps_suppkey
    from
      partsupp,
      (
        select
          l_partkey as agg_partkey,
          l_suppkey as agg_suppkey,
          (0.5 * sum(l_quantity)) as agg_quantity
        from lineitem
        where (
          l_shipdate >= '1996-01-01'
          and l_shipdate < strftime('%Y-%m-%d %H:%M:%f', '1996-01-01', (cast(1.2E1 as varchar) || ' months'))
        )
        group by l_partkey, l_suppkey
      ) as agg_lineitem
    where (
      agg_partkey = ps_partkey
      and agg_suppkey = ps_suppkey
      and ps_partkey in (
        select p_partkey
        from part
        where p_name like 'lavender%'
      )
      and ps_availqty > agg_quantity
    )
  )
  and s_nationkey = n_nationkey
  and n_name = 'ETHIOPIA'
)
order by s_name
limit 1;