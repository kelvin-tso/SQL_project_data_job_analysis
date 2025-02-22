/*What are the top paying skill in the UK?
 ie You earn the most money if you know this skill, based on the job posting in the UK

Result:
Top-Paying Skills
MySQL (£104,083) is the highest-paid skill.
Firebase, PostgreSQL, Airflow, Kubernetes, and GitHub (£93,331 each) follow closely.
Cognos, SAP, and NoSQL (£87,828 each) are also highly paid.

Key insights
Database skills (MySQL, PostgreSQL, NoSQL) dominate high salaries.
Cloud and Big Data tools (AWS, Databricks, Spark) are highly paid.
Tableau (£65,941) vs. Power BI (£59,949): Tableau commands a higher salary.
Basic office software (Word, PowerPoint) pays the least.
 */

WITH top_paying_role_UK as 
(
    SELECT
    job_id,
    job_title,
    name as company_name,
    salary_year_avg *0.79 as average_salary_yearly_GBP,
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
)

select
    skills,
    round(avg(average_salary_yearly_GBP),0) as earning_average
from skills_job_dim
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
inner join top_paying_role_UK on top_paying_role_UK.job_id = skills_job_dim.job_id
GROUP BY
    skills
order BY
    earning_average DESC
