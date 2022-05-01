use itwikisource_p;
select concat('[[', page.page_title, ']]') as titolo
from page
order by page_title
