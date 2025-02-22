-- What is the most optimal skills to learn as a Data analyst?
-- ie High Demand AND High Paying

/*Result:
Skills with Both High Demand and Strong Salary
Python (£72,527) is both highly in demand and offers a good salary.
SQL (£66,221) remains a critical skill with solid pay.
Tableau (£67,907) and Excel (£64,992) show the importance of BI and data analysis.
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
    job_title ilike '%Data%analyst%' 
    and
    (job_country = 'United Kingdom' or
    job_country = 'England')
    and
    salary_year_avg is not null
),
skill_counts as
(
select
    skills_job_dim.skill_id,
    skills,
    count(skills) as skill_count
from skills_job_dim
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
GROUP BY
    skills_job_dim.skill_id,
    skills
)

select
    skills,
    skill_count,
    round(avg(average_salary_yearly_GBP),0) as average_salary
from skill_counts
inner join skills_job_dim on skills_job_dim.skill_id = skill_counts.skill_id
inner join top_paying_role_UK on top_paying_role_UK.job_id = skills_job_dim.job_id
GROUP BY
    skills, skill_count
order BY
    skill_count DESC, average_salary DESC