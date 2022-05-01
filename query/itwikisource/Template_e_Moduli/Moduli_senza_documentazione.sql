use itwikisource_p;
select concat('[[Modulo:', page_title, ']]') as modulo
from page p
where page_namespace = 828
and page_is_redirect = 0
and page_title not like '%/%'
and not exists (
	select 1 from page d
	where d.page_namespace = 828
    and d.page_title = concat(p.page_title, '/man')
)
order by p.page_title
