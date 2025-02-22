-- What are the most disired skills for those top paying analyst roles in the UK?

/*
Result:
Top Skills in Demand
SQL (16%) is the most in-demand skill, appearing 41 times.
Excel (12%) follows closely with 31 occurrences.
Python (10%) is another highly sought-after skill, appearing 26 times.

Key insight:
SQL, Excel, and Python are core skills in data analytics.
Tableau is more in demand than Power BI.
Cloud and database technologies have varied demand but aren’t as crucial as SQL itself.
Machine learning and programming skills are in relatively low demand compared to core analytics tools.
*/

WITH top_paying_role_UK as 
(
    SELECT
    job_id,
    job_title,
    name as company_name,
    salary_year_avg * 0.79 as average_salary_yearly_GBP,
    job_country as country
FROM
    job_postings_fact
INNER JOIN company_dim on company_dim.company_id = job_postings_fact.company_id
WHERE
    job_title ilike '%analyst%' 
    and
    (job_country = 'United Kingdom' or
    job_country = 'England')
    and
    salary_year_avg is not null
),
skill_counts as
(

select
    skills,
    count(skills) as skill_count
from skills_job_dim
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
inner join top_paying_role_UK on top_paying_role_UK.job_id = skills_job_dim.job_id
GROUP BY
    skills
)

select
    skills,
    skill_count,
    round(skill_count*100/sum(skill_count) over (),0) as percentage
from
skill_counts
ORDER BY
    percentage DESC
limit 10
