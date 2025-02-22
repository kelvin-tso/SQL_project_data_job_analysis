# 📊 UK Data Job Market Analysis 🚀
## 📌 Overview
📢 This project dives into the **UK data job market**, analyzing trends in:  

- **💼 The most common job in the UK** 🏆📊  
- **🚀 Which skills are most in demand** 🔥📈  
- **💰 How salaries vary** 📉💵  

📊 Using datasets from various job postings, we explore **industry trends, skill requirements, and earning potential**.  

 Hoping to become a data analyst or similar roles? This analysis provides key insights to help you navigate the industry! 📊📈

 📌 **SQL Queries** ➡️ [Project SQL](/project_sql/)  💾


## Background
Coming from a background in aviation engineering and carpentry, with experience at Princess Yachts, I’ve decided to take a bold step and shift my career towards the **dynamic field of data analysis**. 📊

After years of honing my problem-solving skills and seeing firsthand how data is transforming industries, I realized the immense potential data holds. The UK, with its booming data industry, offers exciting opportunities in this field, and I’m committed to mastering the essential skills **—from SQL and Python to Excel and Tableau—** that are in high demand. 🔧💻

This project represents my journey toward understanding the key aspects of the UK data job market, focusing on 🎯**in-demand roles, required skills, and salary expectations**.

### 💡Through my SQL queries, I sought to answer the following questions:
1. What are the most common data roles in the UK?
2. Which are the top-paying analytic roles in the UK, and which companies are offering them?
3. What are the key skills required for these roles, and how do they differ based on experience?
4. Which skills are most desirable for data analyst roles?
5. What skills are the most rewarding in terms of salary?
6. Which skill is the most optimal to learn, considering both demand and earning potential?

I’m excited to dive deep into the data, acquire the right skills, and uncover the diverse job opportunities that lie ahead in the data industry. 🚀📈

## Tools i used
For my deep dive into the data analytics job market, I leveraged several key tools:

🧠**SQL:** The backbone of this project, enabling me to query the database and extract critical insights.

🗄️**PostgreSQL:** A robust database management system, ideal for handling the job posting data used in this analysis.

💻**Visual Studio Code:** My platform of choice for executing SQL queries and managing code.

🌍**Git & GitHub:** Used to share my SQL scripts and analysis, version control, and collaborate with others.
## The analysis
Each query for this project aimed at investigating specific aspect of the data analytic job market in the UK. Here's how I approached each question:
### 1. What are the most common data roles in the UK?
To identify the data roles with the most job postings in the UK, it's essential to understand the demand for different roles. This analysis aims to provide a brief guide to help navigate the job market.
```
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
```
## What I learned

## Conclusion
