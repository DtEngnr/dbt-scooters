-- Calculate the number of trips per day and age group
with
    cnt_trips as (
        select
            date(t.started_at) as date,
            date_part('YEAR', age(t.started_at, u.birth_date)) as age,
            count(*) as count_trips
        from scooters_raw.trips t
        inner join scooters_raw.users u on t.user_id = u.id
        group by date, age
    )
-- Calculate the average number of trips per age group
select age, round(avg(count_trips)) as avg_count_trips
from cnt_trips
group by age
order by age
