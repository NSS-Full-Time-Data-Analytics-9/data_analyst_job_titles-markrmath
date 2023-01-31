--- Q1.	How many rows are in the data_analyst_jobs table? 

SELECT COUNT(*) AS number_of_rows
FROM data_analyst_jobs;

--- Q2.	Write a query to look at just the first 10 rows.

SELECT *
FROM data_analyst_jobs
LIMIT 10;

--- What company is associated with the job posting on the 10th row? ExxonMobil

--- Q3.	How many postings are in Tennessee?

SELECT COUNT (title) AS number_of_job_postings
FROM data_analyst_jobs
WHERE location = 'TN';

--- Q3b. How many are there in either Tennessee or Kentucky?

SELECT COUNT (title) AS number_of_job_postings
FROM data_analyst_jobs
WHERE location IN ('KY','TN');

---- Q4. How many postings in Tennessee have a star rating above 4?

SELECT COUNT (title) AS number_of_hq_job_postings
FROM data_analyst_jobs
WHERE location = 'TN' AND star_rating > 4;

--- Q5.	How many postings in the dataset have a review count between 500 and 1000?

SELECT COUNT(title) AS adequately_reviewed
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

--- Q6.	Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`.

SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
GROUP BY location
ORDER BY avg_rating DESC;

--- Q6b. Which state shows the highest average rating? Nebraska

--- Q7.	Select unique job titles from the data_analyst_jobs table.

SELECT DISTINCT(title)
FROM data_analyst_jobs;

--- Q7b. How many are there?

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;

--- Q8.	How many unique job titles are there for California companies?

SELECT COUNT(DISTINCT title) AS california_unique_jobs
FROM data_analyst_jobs
WHERE location = 'CA';

--- Q9.	Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations.

SELECT company, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000
	AND company IS NOT NULL
GROUP BY company
ORDER BY avg_rating DESC;

--- Q9b. How many companies are there with more that 5000 reviews across all locations?

SELECT COUNT(DISTINCT company) AS no_of_highly_reviewed_companies
FROM data_analyst_jobs
WHERE review_count > 5000;

--- Q10. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?

SELECT company, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000
	AND company IS NOT NULL
GROUP BY company
ORDER BY avg_rating DESC;

--- Unilever, GM, Nike, American Express, Microsoft, and Kaiser Permanente all have a rating of 4.19~

--- Q11. Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';

--- Q12. How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE title IS NOT NULL
	AND (title NOT ILIKE '%Analyst%'
	OR title NOT ILIKE '%Analytics%');
	
--- BONUS. You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
--- - Disregard any postings where the domain is NULL. 
--- - Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
---  - Which three industries are in the top 4 on this list?

SELECT domain, COUNT(title) AS hard_to_fill_job_number
FROM data_analyst_jobs
WHERE days_since_posting > 21
	AND domain IS NOT NULL
GROUP BY domain
ORDER BY hard_to_fill_job_number DESC
LIMIT 4;