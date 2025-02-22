--What are the top paying analyst role in the UK?

/*
Result:
The highest-paying data analyst role in this dataset is "Market Data Lead Analyst" at Deutsche Bank, offering £142,200 per year.
Other top-paying companies include Plexus Resource Solutions (£130,350) and Octopus Energy (£93,330.60) for senior-level roles.
These high salaries indicate that finance, banking, and energy sectors may offer the most lucrative data roles.
*/

SELECT
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
ORDER BY
    salary_year_avg DESC
