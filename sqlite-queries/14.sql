-- using 1661112540 as a seed to the RNG


select ((100.00 * sum(case
  when p_type like 'PROMO%' then (l_extendedprice * (1 - l_discount))
  else 0
end)) / sum((l_extendedprice * (1 - l_discount)))) as promo_revenue
from lineitem, part
where (
  l_partkey = p_partkey
  and l_shipdate >= '1994-11-01'
  and l_shipdate < strftime('%Y-%m-%d %H:%M:%f', '1994-11-01', (cast(1E0 as varchar) || ' months'))
)
limit 1;