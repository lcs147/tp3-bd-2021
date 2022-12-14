-- using 1661112540 as a seed to the RNG

create view revenue0(supplier_no, total_revenue)
as
select
  l_suppkey,
  sum((l_extendedprice * (1 - l_discount)))
from lineitem
where (
  l_shipdate >= '1995-11-01'
  and l_shipdate < strftime('%Y-%m-%d %H:%M:%f', '1995-11-01', (cast(3E0 as varchar) || ' months'))
)
group by l_suppkey;



select
  s_suppkey,
  s_name,
  s_address,
  s_phone,
  total_revenue
from supplier, revenue0
where (
  s_suppkey = supplier_no
  and total_revenue = (
    select max(total_revenue)
    from revenue0
  )
)
order by s_suppkey
limit 1;


drop view revenue0;