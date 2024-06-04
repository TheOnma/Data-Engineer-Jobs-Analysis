SELECT
COUNT(job_id) AS number_of_jobs,
CASE WHEN job_location = 'Anywhere' THEN 'Remote'
  WHEN job_location = 'New York, NY' THEN 'Local'
  ELSE 'Onsite'
END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category;

SELECT * FROM job_postings_fact;

SELECT job_title, job_location, salary_year_avg, job_via, job_no_degree_mention, EXTRACT(YEAR FROM job_posted_date) AS year,
CASE
    WHEN salary_year_avg >=200000 THEN 'High'
    WHEN salary_year_avg <200000 AND salary_year_avg >= 130000 THEN 'Standard'
    ELSE 'LOW'
    END AS salary_category
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL AND job_location = 'Anywhere'
ORDER BY salary_year_avg DESC
LIMIT 1000;
