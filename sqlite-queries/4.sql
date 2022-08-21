-- using 1661112539 as a seed to the RNG


select
  o_orderpriority,
  count(*) as order_count
from orders
where (
  o_orderdate >= '1995-03-01'
  and o_orderdate < strftime('%Y-%m-%d %H:%M:%f', '1995-03-01', (cast(3E0 as varchar) || ' months'))
  and exists (
    select *
    from lineitem
    where (
      l_orderkey = o_orderkey
      and l_commitdate < l_receiptdate
    )
  )
)
group by o_orderpriority
order by o_orderpriority
limit 1;