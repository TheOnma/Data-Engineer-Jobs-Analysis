# Introduction

Dive into the data job market! Focusing on data engineer roles, this project explores top-paying jobs, in-demand skills, and where high demand meets high salary in data engineering.

SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background

Data engineering is a crucial aspect of data science, focusing on designing, building, and maintaining the infrastructure of data systems.
This project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

# Tools I used

- SQL
- PostgreSQL
- Visual Studio Code
- Git & Github

# The Analysis

### 1. Top Paying Data Engineer Jobs

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short= 'Data Engineer' AND job_location = 'Anywhere' AND salary_year_avg IS NOT NULL
    AND job_no_degree_mention = 'TRUE'
ORDER BY salary_year_avg DESC
LIMIT 10;
```

#### Summary of High-Paying Data Engineer Roles

- **Leadership and High Salaries:**
  Top roles such as the Director of Engineering at Twitch offer significant salaries, with an average of $251,000.
  Staff Data Engineer positions at companies like Handshake and Hinge also command high salaries, ranging from $210,000 to $245,000, indicating a strong demand for experienced professionals in leadership positions.

- **Remote Work Trend:**
  All listed roles are full-time and location-flexible ("Anywhere"), showcasing a significant trend towards remote work in the data engineering field.
  Companies are offering high salaries to attract top talent globally, with roles such as Principal Data Engineer at Zscaler and Murmuration offering around $200,000.

- **Value of Specialized Skills:**
  Specialized roles, like the Rust Data Engineer at Understanding Recruitment, command high salaries, highlighting the demand for niche

### 2. Top Paying Skills

```sql
WITH top_paying_jobs AS (
  SELECT
      job_id,
      job_title,
      job_location,
      salary_year_avg,
      name AS company_name
  FROM
      job_postings_fact
  LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
  WHERE
      job_title_short= 'Data Engineer' AND job_location = 'Anywhere' AND salary_year_avg IS NOT NULL
  ORDER BY salary_year_avg DESC
  LIMIT 10
  )

SELECT top_paying_jobs.*,
       skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC;
```

#### Highest Paid Skills:

- Python: 7 mentions
- Spark: 5 mentions
- Hadoop: 3 mentions
- Kafka: 3 mentions
- Scala: 3 mentions

### 3. Skills in High Demand

```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer'
GROUP BY
    skills
ORDER BY demand_count DESC
LIMIT 5;
```

| Skills | Demand Count |
| ------ | ------------ |
| SQL    | 113,375      |
| Python | 108,265      |
| AWS    | 62,174       |
| Azure  | 60,823       |
| Spark  | 53,789       |

### 4. Highest Paid Data Engineer Skills for Remote Work

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer' AND
    salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY avg_salary DESC
LIMIT 25

```

#### Here's a breakdown of the results for top paying skills for Data Engineers for Remote Jobs:

- **Niche Programming Languages and Frameworks:** High salaries are associated with specialized programming languages (Assembly, Rust, Clojure, Julia) and frameworks (ggplot2, FastAPI), indicating a premium on expertise in less common but highly valuable technologies.

- **Big Data and Database Technologies:** Skills in managing and analyzing large datasets with tools like MongoDB, Neo4j, Redis, Cassandra, and Kafka are highly paid, emphasizing the importance of data management capabilities in the data engineering field.

- **Cloud, DevOps, and Emerging Technologies:** Proficiency in cloud and container orchestration (Kubernetes), version control (Bitbucket), and blockchain (Solidity) commands top salaries, reflecting the demand for expertise in modern infrastructure and emerging tech areas.

### 5. Top Optimal Skills- Highest Paid and in Highest Demand

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

#### Top 25 Most Optimal Skills

| Skill ID | Skills        | Demand Count | Avg Salary |
| -------- | ------------- | ------------ | ---------- |
| 213      | Kubernetes    | 56           | $158,190   |
| 94       | NumPy         | 14           | $157,592   |
| 63       | Cassandra     | 19           | $151,282   |
| 98       | Kafka         | 134          | $150,549   |
| 27       | Golang        | 11           | $147,818   |
| 212      | Terraform     | 44           | $146,057   |
| 93       | Pandas        | 38           | $144,656   |
| 59       | Elasticsearch | 21           | $144,102   |
| 144      | Ruby          | 14           | $144,000   |
| 30       | Ruby          | 14           | $144,000   |
| 83       | Aurora        | 14           | $142,887   |
| 101      | PyTorch       | 11           | $142,254   |
| 3        | Scala         | 113          | $141,777   |
| 92       | Spark         | 237          | $139,838   |
| 95       | PySpark       | 64           | $139,428   |
| 64       | DynamoDB      | 27           | $138,883   |
| 18       | MongoDB       | 32           | $138,569   |
| 62       | MongoDB       | 32           | $138,569   |
| 96       | Airflow       | 151          | $138,518   |
| 4        | Java          | 139          | $138,087   |
| 97       | Hadoop        | 98           | $137,707   |
| 17       | TypeScript    | 19           | $137,207   |
| 2        | NoSQL         | 93           | $136,430   |
| 6        | Shell         | 34           | $135,499   |
| 185      | Looker        | 30           | $134,614   |

#### High Demand and High Salary Skills:

- Skills that are both in high demand and command high salaries include Kubernetes (56 demand count, $158,190), Kafka (134 demand count, $150,549), and Cassandra (19 demand count, $151,282).
- These skills highlight the importance of cloud management, real-time data processing, and robust database management in the current data engineering landscape.

# What I Learned

- Top paying data engineer jobs are mostly remote, with an average salary of $140,000/year.

- Python, Spark, AWS, Azure and Sql are the most sought-after Data Engineer skills.

# Conclusions

- Data engineer jobs with no degree requirements are highly sought after and lucrative.
- Remote work is becoming increasingly popular in the data engineering field.

### Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data engineer job market.
