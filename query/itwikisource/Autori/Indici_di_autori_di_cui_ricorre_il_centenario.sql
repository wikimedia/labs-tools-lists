use itwikisource_p;
select concat('SAL ', SAL, ': ', Indice, ' di ', Autore, ' (', Nascita, '-', Morte, ')')
from (
	select
	  concat('[[Indice:', replace(indice.page_title, '_', ' '), ']]')                                                       Indice,
	  (select replace(cat_title, 'Pagine_indice_SAL_', '')
	   from category join categorylinks on cat_title = cl_to
	   where cl_from = indice.page_id and cat_title like 'Pagine_indice_SAL_%')                             SAL,
	  concat('[[Autore:', autori.autore, ']]')                      Autore,
	  (select replace(cat_title, 'Nati_nel_', '')
	   from category join categorylinks on cat_title = cl_to
	   where cl_from = id_autore and cat_title like 'Nati_nel_%')                                                           Nascita,
	  (select replace(cat_title, 'Morti_nel_', '')
	   from category join categorylinks on cat_title = cl_to
	   where cl_from = id_autore and cat_title like 'Morti_nel_%')                                                          Morte
	from category cat
	join categorylinks catlink on cat.cat_title = catlink.cl_to
	join page indice on catlink.cl_from = indice.page_id
	join (
	  select author.page_title autore, author.page_id id_autore
	  from page author
	  join categorylinks catlink2 on author.page_id = catlink2.cl_from
	  where cl_to in (
		select cat_title
		from category
		where cat_title rlike concat('Nati_nel_[0-9][0-9]', DATE_FORMAT(now(), '%y'))
		   or cat_title rlike concat('Morti_nel_[0-9][0-9]', DATE_FORMAT(now(), '%y'))
	  )
	) autori on cat_title = concat('Libri_di_', autori.autore)
) q
order by CAST(SAL as signed), Indice
