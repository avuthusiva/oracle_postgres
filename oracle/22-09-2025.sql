WITH fib ( lvl, value, next ) AS (
  SELECT 1, 0, 1
  FROM DUAL
UNION ALL
  SELECT lvl + 1, next, value + next
  FROM fib
  WHERE lvl < 10
)
SELECT lvl, value FROM fib;

with cte(lvl,value,next) as
(
  select 1,0,1 from dual
  union all
  select lvl +1,next+value,value from cte
  where lvl <10
)
select * from cte;