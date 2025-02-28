-- data cleaning 

select * from layoffs;
-- 1. remove duplicates
-- 2. standardize data
-- 3. Null values or blank values, (should I populate it or not)
-- 4. remove unncecesary rows and columns ( should i or should not)   

CREATE TABLE layoffs_staging LIKE layoffs;

Insert layoffs_staging Select * from layoffs;

Select *, ROW_NUMBER() OVER (PARTITION BY company, industry, 
total_laid_off, 'date') as Row_num
from layoffs_staging;

WITH duplicate_CTE as
(
Select *, ROW_NUMBER() OVER (PARTITION BY company, location, industry
, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as Row_num
from layoffs_staging
)
Select * from duplicate_CTE where Row_num > 1;

Select * from layoffs_staging;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` double DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `Row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO layoffs_staging2 
Select *, ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off,percentage_laid_off, `date`, stage, country, funds_raised_millions) as Row_num
from layoffs_staging;

select * from layoffs_staging2 where Row_num>1;

Delete from layoffs_staging2 where Row_num>1;

Select * from layoffs_staging2;

-- STANDARDIZATION OF DATA

Select company, TRIM(company) from layoffs_staging2;

update layoffs_staging2 
set company=trim(company);

select DISTINCT(industry)
 from layoffs_staging2 order by industry;

select * from layoffs_staging2
 where location like 'D%';

update layoffs_staging2 
set industry='Crypto' where industry like 'Crypto%';

select DISTINCT(country)
 from layoffs_staging2 order by country;

update layoffs_staging2 
set country='United States' where country like 'United Sta%';

Select `date`, str_to_date(`date`, '%m/%d/%Y') 
from layoffs_staging2;

update layoffs_staging2 
set `date`= str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_staging2 
MODIFY column `date` DATE; 

-- fixing and findind null

SELECT * FROM layoffs_staging2
WHERE total_laid_off is NULL
and percentage_laid_off is NULL;

select * from layoffs_staging2 where company like 'airbnb';

Select * from layoffs_staging2 
where industry is null or industry =''; -- try to populate thje missing values if possible

sELECT * FROM layoffs_staging2 t1 join layoffs_staging2 t2 ON t1.company = t2.company
and t1.location=t2.location
where (t1.industry is null OR t1.industry='')and t2.industry is not null;

UPdate layoffs_staging2 SET industry = NULL where industry ='';

UPDATE layoffs_staging2 t1 join layoffs_staging2 t2 ON t1.company = t2.company and t1.location=t2.location 
SET t1.industry=t2.industry 
where (t1.industry is null OR t1.industry='')and t2.industry is not null;

DELETE from layoffs_staging2 where total_laid_off is null and percentage_laid_off is null;

ALTER table layoffs_staging2 drop column Row_num;




