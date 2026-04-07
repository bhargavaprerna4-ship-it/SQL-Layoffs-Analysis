with company_year (company, year, total_laid_off) AS
(
select company, year(`date`), sum(total_laid_off)
from world_layoffs.layoffs_staging2
group by  company, year(`date`)
), company_year_rank as
(select *,
dense_rank() over(partition by year order by total_laid_off desc) as ranking
from company_year
where year is not null
)
select*
from company_year_rank;