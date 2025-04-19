Select * from layoffs;

#creating a new table with existing table
CREATE TABLE layoffs_staging
LIKE layoffs;

Select * from layoffs_staging;

#inserting a table values with existing values in another table
Insert layoffs_staging 
SELECT *
FROM layoffs;

#Remove duplicates
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM layoffs_staging;


WITH duplicate_cte AS (
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off,  percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT * 
FROM duplicate_cte
WHERE row_num >1;

#Deleting
WITH duplicate_cte AS (
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off,  percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
DELETE 
FROM duplicate_cte
WHERE row_num >1;

#creating a row_num table to delete the duplicates
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

SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off,  percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

SET SQL_SAFE_UPDATES = 0;

SELECT *
FROM layoffs_staging2;

#Standardizing data

SELECT company, trim(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = trim(company);

SELECT distinct(industry)
FROM layoffs_staging2
order by 1;

SELECT industry
from layoffs_staging2
where industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
where industry LIKE 'Crypto%';

SELECT distinct(country)
FROM layoffs_staging2
order by 1;


SELECT distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';


#concerting a sting column to a date format

SELECT `date`,
str_to_date(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = str_to_date(`date`, '%m/%d/%Y');

SELECT `date`
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2;

#now changing the date column to date type

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

#seeing the null and blank values in the data

SELECT * 
from layoffs_staging2
where total_laid_off is null and 
percentage_laid_off is null;

select *
from layoffs_staging2
where industry is null or
industry = '';

select *
from layoffs_staging2
where company = 'Airbnb';

SELECT * 
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry is NULL or t1.industry = '')
AND t2.industry is not null;

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE t1.industry is NULL
AND t2.industry is not null;

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry is NULL
AND t2.industry is not null;

SELECT * 
from layoffs_staging2
where total_laid_off is null and 
percentage_laid_off is null;

delete
from layoffs_staging2
where total_laid_off is null and 
percentage_laid_off is null;

SELECT * 
from layoffs_staging2;

#droping a column

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;












