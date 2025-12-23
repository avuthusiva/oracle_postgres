CREATE TABLE baskets (
    Person VARCHAR(10),
    Basket VARCHAR(100)
);
INSERT INTO baskets (Person, Basket) VALUES ('A', 'Apple,Mango,Orange');
INSERT INTO baskets (Person, Basket) VALUES ('B', 'Apple');
INSERT INTO baskets (Person, Basket) VALUES ('C', 'Guava,Cherry');
INSERT INTO baskets (Person, Basket) VALUES ('D', 'Mango,Cherry,Orange');
commit;

truncate table baskets;

with cte as 
(select person,basket,regexp_count(basket,'[^,]+',1) cnt from baskets)
select c.* from cte c,lateral(select level from cte d where c.person = d.person and c.basket = d.basket
connect by level <= cnt) v
order by 1;

