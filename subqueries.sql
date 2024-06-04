SELECT * 
FROM
(SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1)
AS january_jobs;

SELECT name AS company_name
FROM company_dim
WHERE company_id IN
(SELECT company_id 
FROM job_postings_fact
WHERE job_no_degree_mention = TRUE);

SELECT skills_dim.skills AS skills, job_counts
FROM skills_dim
JOIN
(SELECT COUNT(job_id) AS job_counts, skill_id
FROM skills_job_dim
GROUP BY skill_id
) AS jobs_per_skill
ON skills_dim.skill_id = jobs_per_skill.skill_id
ORDER BY job_counts DESC
LIMIT 5;

