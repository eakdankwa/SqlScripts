
-- Exploratory Data Analysis (EDA)

SELECT * 
FROM layoffs_staging3;

SELECT MAX(total_laid_off), MAX(percentage_laid_off),
MIN(total_laid_off),
AVG(total_laid_off),
STD(total_laid_off)
FROM layoffs_staging3;

SELECT * 
FROM layoffs_staging3
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT * 
FROM layoffs_staging3
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY 1
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2
;

SELECT  industry, SUM(total_laid_off)
FROM layoffs_staging3
GROUP BY 1
ORDER BY 2 ASC;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging3
GROUP BY 1
ORDER BY 2 DESC;

SELECT EXTRACT(YEAR FROM `date`) AS yr , SUM(total_laid_off)
FROM layoffs_staging3
GROUP BY 1
ORDER BY 1 DESC;

SELECT stage , SUM(total_laid_off)
FROM layoffs_staging3
GROUP BY 1
ORDER BY 1 DESC;

WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging3
GROUP BY 1, 2
)
SELECT *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL 
ORDER BY Ranking; 
