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


/*
Here's a breakdown of the results for top paying skills for Data Engineers for Remote Jobs:
-Niche Programming Languages and Frameworks: High salaries are associated with specialized programming languages (Assembly, Rust, Clojure, Julia) and frameworks (ggplot2, FastAPI), indicating a premium on expertise in less common but highly valuable technologies.

-Big Data and Database Technologies: Skills in managing and analyzing large datasets with tools like MongoDB, Neo4j, Redis, Cassandra, and Kafka are highly paid, emphasizing the importance of data management capabilities in the data engineering field.

-Cloud, DevOps, and Emerging Technologies: Proficiency in cloud and container orchestration (Kubernetes), version control (Bitbucket), and blockchain (Solidity) commands top salaries, reflecting the demand for expertise in modern infrastructure and emerging tech areas.
/*