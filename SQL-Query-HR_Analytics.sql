--create a join table:
select*from absentatwork a
left join compensation c
on a.ID = c.ID
left join reasons r on
a.reason_for_absence = r.number

--Find the helthiest employees for the bonus
select*from absentatwork
where social_drinker = 0 and social_smoker = 0
and body_mass_index <25 and
absenteeism_time_in_hours < (select avg(absenteeism_time_in_hours) from absentatwork)

--compensation rate increase for non-smokers/ budget $983,221 so 0.68 increase per hour/1,414.4 per year
select count(*) as nonsmokers from absentatwork
where social_smoker = 0
--optimize the query
select 
a.ID,
r.reason,
month_of_absence,
body_mass_index,
case when body_mass_index < 18.5 then 'Underweight'
	 when body_mass_index between 18.5 and 25 then 'Healthy weight'
	 when body_mass_index between 25 and 30 then 'Overweight'
	 when body_mass_index < 30 then 'Obese'
	 else 'unknown' end as BMI_category,
case when month_of_absence in (12,1,2) then 'Winter'
	 when month_of_absence in (3,4,5) then 'Spring'
	 when month_of_absence in (6,7,8) then 'Summer'
	 when month_of_absence in (9,10,11) then 'Fall'
	 else 'unknown' end as Season_names,

seasons,
day_of_the_week,
transportation_expense,
education,
son,
social_drinker,
social_smoker,
pet,
disciplinary_failure,
age,
work_load_avg_day,
absenteeism_time_in_hours
from absentatwork a
left join compensation c
on a.ID = c.ID
left join reasons r on
a.reason_for_absence = r.number

