select concat('[[', page_title, ']]') as titolo, page_len as length
from page
where page_is_redirect = 0
and page_namespace = 0
and page_title not like '%/%'
and page_len < 2000
and not exists (select 1 from categorylinks where cl_from = page_id and cl_to = 'Disambigua')
and not exists (select 1 from categorylinks where cl_from = page_id and cl_to = 'Testi_con_versione_cartacea_a_fronte')
order by page_len asc;

