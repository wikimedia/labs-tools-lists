select concat('[[Template:', page_title, ']]') as template
from page p
where page_namespace = 10
and page_is_redirect = 0
and page_title not like '%/%'
and not exists (
	select 1 from page d
	where d.page_namespace = 10
    and d.page_title = concat(p.page_title, '/doc')
)
order by p.page_title
