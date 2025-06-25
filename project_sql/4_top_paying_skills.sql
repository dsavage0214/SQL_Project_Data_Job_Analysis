/* 
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and
    helps identify the most financially rewarding skills to aquire or improve
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
   -- AND (job_location = 'Washington, DC' OR job_location = 'Atlanta, GA' OR job_location = 'New York, NY' OR job_location = 'Wilmington, DE')
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;


/*

Key Takeaways:

AI & Machine Learning skills like hugging face, pytorch, and tensorflow dominate the list — showing high demand and premium pay for ML expertise.
- Web3 knowledge, especially solidity, commands top-tier salaries, reflecting the value of blockchain developers.
- DevOps tools like terraform, kafka, and ansible appear frequently, signaling high-paying roles in infrastructure automation and cloud engineering.
- Modern backend languages like golang and scala offer strong earning potential in performance-focused systems.
- Niche or collaborative tools like gitlab, notion, and atlassian show that employers value both specialization and team efficiency.

[
  {
    "skills": "svn",
    "avg_salary": "400000"
  },
  {
    "skills": "solidity",
    "avg_salary": "179000"
  },
  {
    "skills": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skills": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skills": "golang",
    "avg_salary": "155000"
  },
  {
    "skills": "mxnet",
    "avg_salary": "149000"
  },
  {
    "skills": "dplyr",
    "avg_salary": "147633"
  },
  {
    "skills": "vmware",
    "avg_salary": "147500"
  },
  {
    "skills": "terraform",
    "avg_salary": "146734"
  },
  {
    "skills": "twilio",
    "avg_salary": "138500"
  },
  {
    "skills": "gitlab",
    "avg_salary": "134126"
  },
  {
    "skills": "kafka",
    "avg_salary": "129999"
  },
  {
    "skills": "puppet",
    "avg_salary": "129820"
  },
  {
    "skills": "keras",
    "avg_salary": "127013"
  },
  {
    "skills": "pytorch",
    "avg_salary": "125226"
  },
  {
    "skills": "perl",
    "avg_salary": "124686"
  },
  {
    "skills": "ansible",
    "avg_salary": "124370"
  },
  {
    "skills": "hugging face",
    "avg_salary": "123950"
  },
  {
    "skills": "tensorflow",
    "avg_salary": "120647"
  },
  {
    "skills": "cassandra",
    "avg_salary": "118407"
  },
  {
    "skills": "notion",
    "avg_salary": "118092"
  },
  {
    "skills": "atlassian",
    "avg_salary": "117966"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "116712"
  },
  {
    "skills": "airflow",
    "avg_salary": "116387"
  },
  {
    "skills": "scala",
    "avg_salary": "115480"
  }
]
*/