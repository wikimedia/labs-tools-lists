use itwikisource_p;
select concat('[[', page.page_title, ']]') as titolo
from page
where page_is_redirect = 0
and page_namespace = 0
and (page_title like '%—%' or page_title like '%’%')
order by page_title
