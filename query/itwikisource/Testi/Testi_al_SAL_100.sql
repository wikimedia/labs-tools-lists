use itwikisource_p;
select concat('[[', page.page_title, ']]') as titolo
from page
join categorylinks catlink on catlink.cl_from = page.page_id
join category cat on cat.cat_title = catlink.cl_to
where cat.cat_title = 'Testi_SAL_100%'
order by page_title
