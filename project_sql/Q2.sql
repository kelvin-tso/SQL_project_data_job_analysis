-- What are the required skills for the top paying analyst jobs in the UK?
/*
Result:
Most Commonly Required Skills
SQL: Found in a majority of job postings, making it a fundamental skill for data analysts.
Python: Frequently appears, suggesting that scripting and data manipulation are critical.
Excel: Still widely required, especially in business intelligence and financial roles.
Tableau / Power BI / Looker: Popular visualization tools, highlighting the need for data storytelling.
AWS / Azure / GCP: Cloud technologies are valuable, particularly for larger organizations.
VBA: Still present, especially in finance-related roles.

Senior vs. Junior Role Skill Differences:
Junior Data Analysts: Often focus on Excel, SQL, Power BI, and Tableau.
Senior Data Analysts: Expected to know Python, SQL, Databricks, Spark, Kubernetes, and Cloud platforms (AWS, Azure).
Specialized Senior Roles: Require additional tools like Airflow, Jupyter, Firebase, and NoSQL databases.
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
    job_title,
    company_name,
    skills
from skills_job_dim
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
inner join top_paying_role_UK on top_paying_role_UK.job_id = skills_job_dim.job_id
order BY
    average_salary_yearly_GBP DESC