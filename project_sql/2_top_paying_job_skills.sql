/* 
Question: What skills are required for the top-paying data analyst jobs?
- Use the top highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (

    SELECT
        job_id,
        name AS company_name,
        job_title,
        salary_year_avg
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        (job_location = 'Washington, DC' OR job_location = 'Atlanta, GA' OR job_location = 'New York, NY' OR job_location = 'Wilmington, DE') AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)


SELECT 
    top_paying_jobs.*,
    skills
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC


/*
Skill Frequency Insights
Let’s dive into the most frequently mentioned skills for data analysts in 2023:

Skill	Count
SQL	      7
Python	  6
Express	  3
R	      3
Tableau	  2
Airflow	  1
Power BI  1
Excel	  1
Kafka	  1
Spark	  1

This visual shows SQL and Python clearly dominating the field — a strong indicator of their relevance in today’s data analyst roles.


[
  {
    "job_id": 339646,
    "company_name": "Coda Search│Staffing",
    "job_title": "Data Sector Analyst - Hedge Fund in Midtown",
    "salary_year_avg": "240000.0",
    "skills": "sql"
  },
  {
    "job_id": 339646,
    "company_name": "Coda Search│Staffing",
    "job_title": "Data Sector Analyst - Hedge Fund in Midtown",
    "salary_year_avg": "240000.0",
    "skills": "python"
  },
  {
    "job_id": 339646,
    "company_name": "Coda Search│Staffing",
    "job_title": "Data Sector Analyst - Hedge Fund in Midtown",
    "salary_year_avg": "240000.0",
    "skills": "pandas"
  },
  {
    "job_id": 841064,
    "company_name": "TikTok",
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "239777.5",
    "skills": "sql"
  },
  {
    "job_id": 841064,
    "company_name": "TikTok",
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "239777.5",
    "skills": "python"
  },
  {
    "job_id": 841064,
    "company_name": "TikTok",
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "239777.5",
    "skills": "r"
  },
  {
    "job_id": 841064,
    "company_name": "TikTok",
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "239777.5",
    "skills": "express"
  },
  {
    "job_id": 1713491,
    "company_name": "TikTok",
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "239777.5",
    "skills": "sql"
  },
  {
    "job_id": 1713491,
    "company_name": "TikTok",
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "239777.5",
    "skills": "python"
  },
  {
    "job_id": 1713491,
    "company_name": "TikTok",
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "239777.5",
    "skills": "r"
  },
  {
    "job_id": 1713491,
    "company_name": "TikTok",
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "239777.5",
    "skills": "express"
  },
  {
    "job_id": 204500,
    "company_name": "Selby Jennings",
    "job_title": "Reference Data Analyst",
    "salary_year_avg": "225000.0",
    "skills": "sql"
  },
  {
    "job_id": 204500,
    "company_name": "Selby Jennings",
    "job_title": "Reference Data Analyst",
    "salary_year_avg": "225000.0",
    "skills": "python"
  },
  {
    "job_id": 1563879,
    "company_name": "Pronix Inc",
    "job_title": "Data Analysis Manager",
    "salary_year_avg": "185000.0",
    "skills": "sql"
  },
  {
    "job_id": 1563879,
    "company_name": "Pronix Inc",
    "job_title": "Data Analysis Manager",
    "salary_year_avg": "185000.0",
    "skills": "neo4j"
  },
  {
    "job_id": 1563879,
    "company_name": "Pronix Inc",
    "job_title": "Data Analysis Manager",
    "salary_year_avg": "185000.0",
    "skills": "elasticsearch"
  },
  {
    "job_id": 1563879,
    "company_name": "Pronix Inc",
    "job_title": "Data Analysis Manager",
    "salary_year_avg": "185000.0",
    "skills": "sql server"
  },
  {
    "job_id": 1563879,
    "company_name": "Pronix Inc",
    "job_title": "Data Analysis Manager",
    "salary_year_avg": "185000.0",
    "skills": "aws"
  },
  {
    "job_id": 1563879,
    "company_name": "Pronix Inc",
    "job_title": "Data Analysis Manager",
    "salary_year_avg": "185000.0",
    "skills": "oracle"
  },
  {
    "job_id": 1563879,
    "company_name": "Pronix Inc",
    "job_title": "Data Analysis Manager",
    "salary_year_avg": "185000.0",
    "skills": "spark"
  },
  {
    "job_id": 1563879,
    "company_name": "Pronix Inc",
    "job_title": "Data Analysis Manager",
    "salary_year_avg": "185000.0",
    "skills": "kafka"
  },
  {
    "job_id": 396924,
    "company_name": "TikTok",
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "181177.5",
    "skills": "sql"
  },
  {
    "job_id": 396924,
    "company_name": "TikTok",
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "181177.5",
    "skills": "python"
  },
  {
    "job_id": 396924,
    "company_name": "TikTok",
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "181177.5",
    "skills": "r"
  },
  {
    "job_id": 396924,
    "company_name": "TikTok",
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "181177.5",
    "skills": "express"
  },
  {
    "job_id": 386504,
    "company_name": "Brewer Morris",
    "job_title": "Data Associate, Investor Relations",
    "salary_year_avg": "180000.0",
    "skills": "python"
  },
  {
    "job_id": 386504,
    "company_name": "Brewer Morris",
    "job_title": "Data Associate, Investor Relations",
    "salary_year_avg": "180000.0",
    "skills": "excel"
  },
  {
    "job_id": 386504,
    "company_name": "Brewer Morris",
    "job_title": "Data Associate, Investor Relations",
    "salary_year_avg": "180000.0",
    "skills": "tableau"
  },
  {
    "job_id": 386504,
    "company_name": "Brewer Morris",
    "job_title": "Data Associate, Investor Relations",
    "salary_year_avg": "180000.0",
    "skills": "power bi"
  },
  {
    "job_id": 1293960,
    "company_name": "Parabolic Career",
    "job_title": "Data Research Analyst",
    "salary_year_avg": "175000.0",
    "skills": "sql"
  },
  {
    "job_id": 1293960,
    "company_name": "Parabolic Career",
    "job_title": "Data Research Analyst",
    "salary_year_avg": "175000.0",
    "skills": "python"
  },
  {
    "job_id": 1293960,
    "company_name": "Parabolic Career",
    "job_title": "Data Research Analyst",
    "salary_year_avg": "175000.0",
    "skills": "java"
  },
  {
    "job_id": 1293960,
    "company_name": "Parabolic Career",
    "job_title": "Data Research Analyst",
    "salary_year_avg": "175000.0",
    "skills": "cassandra"
  },
  {
    "job_id": 1293960,
    "company_name": "Parabolic Career",
    "job_title": "Data Research Analyst",
    "salary_year_avg": "175000.0",
    "skills": "spark"
  },
  {
    "job_id": 1293960,
    "company_name": "Parabolic Career",
    "job_title": "Data Research Analyst",
    "salary_year_avg": "175000.0",
    "skills": "hadoop"
  },
  {
    "job_id": 1293960,
    "company_name": "Parabolic Career",
    "job_title": "Data Research Analyst",
    "salary_year_avg": "175000.0",
    "skills": "tableau"
  }
]

*/