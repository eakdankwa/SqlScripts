-- Data Cleaning
-- Remove duplicates
-- Standardize the Data
-- Null Values or blank 
--  remove any columns / rows

SELECT *
FROM layoffs;

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT * 
FROM layoffs_staging;

INSERT layoffs_staging
SELECT * 
FROM layoffs;


-- This query Removes duplicate rows Using Window Function (ROW_NUMBER) & PARTITION BY
WITH duplicates_cte AS
(
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`,
 stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT * 
FROM duplicates_cte
WHERE row_num > 1;

SELECT * FROM layoffs_staging
WHERE company LIKE 'Casper' AND total_laid_off IS NULL
LIMIT 1;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM layoffs_staging2
WHERE row_num > 1;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`,
 stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

SELECT * 
FROM layoffs_staging2;

-- Standardizing data USING string functions and other super cool functions ):
SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT industry
FROM layoffs_staging2;

SELECT DISTINCT `date` -- , STR_TO_DATE(`date`,'%m/%d/%Y')
FROM layoffs_staging2
-- WHERE country LIKE 'United State%'
-- ORDER BY 1
;

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United State%';

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT * 
FROM layoffs 
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL
;

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
	OR industry = '' 
;

UPDATE layoffs_staging2
SET industry  = (CASE
	WHEN company LIKE '%Airbnb%' AND (industry = '' OR industry IS NULL) THEN 'Travel' 
    WHEN company LIKE '%Carvan%' AND (industry = '' OR industry IS NULL) THEN 'Transportation' 
    WHEN company LIKE '%Juul%' AND (industry = '' OR industry IS NULL) THEN 'Consumer' 
    WHEN company LIKE '%Bally%' AND (industry = '' OR industry IS NULL) THEN 'Unknown'
    ELSE COALESCE(industry, 'Travel') 
    END) 
;    
    
    -- company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
    
SELECT * FROM layoffs_staging2 
;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT * FROM layoffs_staging2 ;