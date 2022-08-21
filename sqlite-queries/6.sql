-- using 1661112539 as a seed to the RNG


select sum((l_extendedprice * l_discount)) as revenue
from lineitem
where (
  l_shipdate >= '1997-01-01'
  and l_shipdate < strftime('%Y-%m-%d %H:%M:%f', '1997-01-01', (cast(1.2E1 as varchar) || ' months'))
  and l_discount between (0.05 - 0.01) and (0.05 + 0.01)
  and l_quantity < 24
)
limit 1;