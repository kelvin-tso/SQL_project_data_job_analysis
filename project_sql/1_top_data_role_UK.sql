-- What is the most common data job category in the UK?
/*
Result:
Most Common Data Roles
Data Engineer (29%) is the most prevalent role, highlighting a strong demand for building and maintaining data infrastructure.
Data Analyst (26%) follows closely, emphasizing the importance of data interpretation and reporting.
Data Scientist (23%) ranks third, showing significant demand for advanced analytics and machine learning.

Key insights:
Data Analysts and Data Scientists collectively make up 49%, showing strong demand for insights and machine learning.
Engineering roles (Data + Senior Data Engineers) make up 37% of total roles, highlighting the need for data infrastructure expertise.
Fewer senior analyst roles (3%) suggest limited upward mobility for analysts compared to engineers/scientists.
Machine Learning Engineers are rare (1%), indicating specialization within Data Scientist roles.
*/
WITH top_paying_role_UK as 
(
    SELECT
    job_id,
    job_title,
    job_title_short,
    name as company_name,
    salary_year_avg *0.79 as average_salary_yearly_GBP,
    job_country as country
FROM
    job_postings_fact
INNER JOIN company_dim on company_dim.company_id = job_postings_fact.company_id
WHERE 
    (job_country = 'United Kingdom' or
    job_country = 'England')
),
role_counts AS (
    SELECT
        job_title_short AS Data_role,
        COUNT(job_id) AS role_count
    FROM top_paying_role_UK
    GROUP BY job_title_short
)
SELECT
    Data_role,
    role_count,
    ROUND((role_count * 100.0) / SUM(role_count) OVER(), 0) AS percentage
FROM role_counts
ORDER BY role_count DESC;

