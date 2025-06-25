# Introduction
Dive into the data job market! Focusing on data analysts roles, this project explores top-paying jobs, in-demand skills, and where high demand meets high salary in data analytics. 

SQL queries? Find them here: [project_sql folder](/project_sql/)

# Background
Intrigued by the data job market, this project is born from my own personal desire to find the top-paid and most in-demand skills, streamlining others work to find optimal jobs.

Data is from [Luke Barousse](https://lukebarousse.com/sql) It's filled with insights on job titles, salaries, locations, and essential skills.

## The question I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For this project I utilized  4 key tools:

- **SQL**: The backbone of my analysis, allowing me to query the database and find critical insights.
- **PostgreSQL**: The chosen database management system, ideal for handling the job  posting date.
- **Visual Studio Code**: My go-to  for database management and executing SQL queries.
- **Git & GitHub**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst market. Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT
    job_id,
    name AS company_name,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    (job_location = 'Washington, DC' OR job_location = 'Atlanta, GA' OR job_location = 'New York, NY' OR job_location = 'Wilmington, DE') AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
### 2. Skills Required for Top Paying Jobs

I joined top-paying jobs with their associated skills to identify which specific technologies or tools are most commonly listed in high-paying roles. This helped clarify what skills might unlock better compensation.

```sql
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

```

### 3. Most Demanded Data Analyst Skills

I then aggregated skill counts across all job postings to determine which skills appear most frequently in the market. This gave me a clear picture of core competencies employers are consistently seeking.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    (job_location = 'Washington, DC' OR job_location = 'Atlanta, GA' OR job_location = 'New York, NY' OR job_location = 'Wilmington, DE')
GROUP BY
    skills
ORDER BY
    demand_count desc
LIMIT 5;
```

### 4. Highest Paying Skills

Next I calculated the average salary associated with each skill, revealing which tools or technologies tend to correlate with higher pay. This highlighted emerging or specialized skills with strong earning potential.

```sql
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
```

### 5. Optimal Skills to Learn
Finally, I combined demand and salary data to determine the "best of both worlds"—skills that are both in high demand and command high salaries. This query offers actionable guidance on where to focus skill development for maximum return.

```sql
WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND (job_location = 'Washington, DC' OR job_location = 'Atlanta, GA' OR job_location = 'New York, NY' OR job_location = 'Wilmington, DE')
    GROUP BY
        skills_dim.skill_id
),  average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND (job_location = 'Washington, DC' OR job_location = 'Atlanta, GA' OR job_location = 'New York, NY' OR job_location = 'Wilmington, DE')
    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    demand_count DESC,
    average_salary DESC
LIMIT 25;
```

# What I Learned
Although I took an SQL and database course in college, I didn’t feel fully prepared to apply those skills in real-world scenarios. Much of it felt theoretical and disconnected from practical job-related tasks.

This project gave me the hands-on experience I was missing. Writing actual queries to answer real questions about the job market helped me solidify my understanding of joins, aggregations, subqueries, and filtering logic.

By working through this analysis, I’ve gained confidence in my SQL abilities and taken meaningful steps forward in my journey as a data analyst. It’s one thing to learn SQL in a classroom—it’s another to use it to uncover insights that matter. This project bridged that gap for me.
# Conclusions 

### Insights
1. **Top-Paying Data Analyst Jobs**: The highest-paying data analyst jobs exceed $240,000 annually and are often located in major cities like New York, NY and Atlanta, GA. Roles with titles like "Director Analytics" and "Data Sector Analyst" top the list.

2. **Skills for Top-Paying Jobs**: Among the most lucrative job postings, skills such as SQL, Python, and Pandas frequently appear, suggesting that technical proficiency in these areas significantly boosts salary potential.

3. **Most In-Demand Skills**: SQL leads the demand chart, followed by Excel, Tableau, and Python. These core tools remain essential in the data analyst toolkit and are requested in thousands of job postings.

4. **Skills with Higher Salaries**: Specialized or niche skills like SVN, Solidity, Couchbase, and Golang command the highest average salaries, indicating strong compensation for candidates with advanced or rare technical abilities.

5. **Optimal Skills for Job Market Value**: Balancing demand and compensation, SQL, Python, and Tableau emerge as the most optimal skills for data analysts to learn—these tools are both in high demand and associated with six-figure average salaries.

### Closing Thoughts
This project was more than just running SQL queries—it was a hands-on journey to deepen my understanding of the data analytics job market and sharpen my technical skills in a real-world context. I began with a personal question: What should I learn to be a competitive data analyst? From there, I explored the data with curiosity, asking:

- What are the highest-paying roles in the field?

- Which skills lead to those top salaries?

- What tools are in the highest demand?

- And most importantly—where do salary and demand intersect?

As I moved through problems involving salary bucketing, quarterly analysis, skill-job associations, and market optimization, I didn’t just learn how to write more complex queries—I learned how to ask better questions and think like an analyst. I experimented with subqueries, CTEs, and joins. I challenged myself to visualize patterns in skills, salaries, and job titles. Even seemingly small questions (like why a LIKE query returned nothing) led to deeper understanding of query structure and data behavior.

One of my biggest takeaways is that data analysis isn’t about perfection—it’s about iteration, pattern-seeking, and decision-making. The skills I investigated—SQL, Python, Tableau—are not just valuable because they pay well, but because they allow you to uncover meaning in messy data and make informed decisions.

By working through these questions, not only did I clarify where the best opportunities lie, I also became far more confident in my SQL skills and analytical thinking. This project helped bridge the gap between classroom knowledge and real-world application—and it’s only the beginning of my journey as a data analyst.