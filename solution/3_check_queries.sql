-- Провека общего количесства
select count(distinct shippingid)
from shipping
union all
select count(distinct shipping_id)
from shipping_info
union all
select count(distinct shipping_id)
from shipping_status

-- Проверка суммы оплат
with shipping_only_one as (
    select distinct shippingid, payment_amount from shipping
)
select sum(payment_amount) from shipping_only_one
union all
select sum(payment_amount) from shipping_info
union all
select sum(payment_amount) from shipping_datamart
