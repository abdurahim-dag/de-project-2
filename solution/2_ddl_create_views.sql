-- Создание представления shipping_datamart для аналитики
-- full_day_at_shipping — количество полных дней, в течение которых длилась доставка
-- поэтому 0 значения означают, что полный день не прошёл

create or replace view shipping_datamart as
select
    si.shipping_id,
    si.vendor_id,
    st.shipping_transfer_type,
    date_part('day', age(ss.shipping_end_fact_datetime, ss.shipping_start_fact_datetime))  full_day_at_shipping,
    ss.shipping_end_fact_datetime > si.shipping_plan_datetime is_delay,
    ss.status = 'finished' is_shipping_finish,
    case when ss.shipping_end_fact_datetime > si.shipping_plan_datetime
            then ss.shipping_end_fact_datetime::date - si.shipping_plan_datetime::date
    end delay_day_at_shipping,
    si.payment_amount,
    si.payment_amount * (scr.shipping_country_base_rate + sag.agreement_rate + st.shipping_transfer_rate) vat,
    si.payment_amount * sag.agreement_commission profit
from shipping_info si
join shipping_transfer st ON st.shipping_transfer_id = si.transfer_id
join shipping_status ss on ss.shipping_id = si.shipping_id
join shipping_agreement sag on sag.agreement_id = si.agreement_id
join shipping_country_rates scr on scr.shipping_country_id =  si.shipping_country_id