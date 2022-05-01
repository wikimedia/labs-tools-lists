use itwikisource_p;
select concat('[[Autore:', replace(author.page_title, '_', ' '), ']]') as 'author/translator', 
concat('[[', replace(text.page_title, '_', ' '), ']]') as text
from page author
inner join pagelinks on author.page_title = pagelinks.pl_title
inner join page text on text.page_id = pagelinks.pl_from
where author.page_namespace = 102
and text.page_namespace = 0
and author.page_is_redirect = 0
and text.page_title not like '%/%'
and author.page_title <> 'Anonimo'
and author.page_title <> 'Autori_vari'
and author.page_title <> 'Stati_vari'
and not exists  (select 1 from pagelinks where pl_from = author.page_id and pl_namespace = 0 and pl_title = text.page_title)
and (
  exists (select 1 from categorylinks where cl_from = text.page_id and cl_to = concat('Testi_di_', author.page_title))
  or exists (select 1 from categorylinks where cl_from = text.page_id and cl_to = concat('Traduzioni_di_', author.page_title))
)
order by author.page_title, text.page_title
