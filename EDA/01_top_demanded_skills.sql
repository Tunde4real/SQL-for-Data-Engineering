/*
Ansqwers the question: What are the most in-demand skills for data engineers?
- Identifies the top ten in demand skills for data engineers
- Focuses on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/


SELECT
  -- jpf.job_title_short,
  COUNT(jpf.*) AS posting_count,
  sjd.skill_id,
  sd.skills
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim as sjd
  ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim as sd
  ON sjd.skill_id = sd.skill_id
WHERE
  job_work_from_home = TRUE AND 
  jpf.job_title_short='Data Engineer'
GROUP BY
  sjd.skill_id,
  sd.skills
ORDER BY
  COUNT(jpf.*) DESC
LIMIT 10;


/*
Here's the breakdown of the most demanded skills for data engineers:

┌───────────────┬──────────┬────────────┐
│ posting_count │ skill_id │   skills   │
│     int64     │  int32   │  varchar   │
├───────────────┼──────────┼────────────┤
│         29221 │        0 │ sql        │
│         28776 │        1 │ python     │
│         17823 │       77 │ aws        │
│         14143 │       74 │ azure      │
│         12799 │       92 │ spark      │
│          9996 │      104 │ airflow    │
│          8639 │       73 │ snowflake  │
│          8183 │       75 │ databricks │
│          7267 │       12 │ java       │
│          6446 │       78 │ gcp        │
├───────────────┴──────────┴────────────┤
│ 10 rows                     3 columns │
└───────────────────────────────────────┘

SQL and Python are by far the most in-demand skills, with around 29,000 job postings each - nearly double the next closest skill.
Cloud platforms round out the top skills, with AWS leading at ~18,000 postings, followed by Azure at ~14,000.
Apache Spark completes the top 5 with nearly 13,000 postings, highlighting the importance of big data processing skills.

Key takeaways:
- SQL and Python remain the foundational skills for data engineers
- Cloud platforms (AWS, Azure) are critical for modern data engineering
- Big data tools like Spark continue to be highly valued
- Data pipeline tools (Airflow, Snowflake, Databricks) show growing demand
- Java and GCP round out the top 10 most requested skills


*/