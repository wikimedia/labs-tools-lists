use itwikisource_p;
select concat(autore, ' (', ifnull(nascita, '?'), '-', ifnull(morte, ' '), ')')
from (
	select 
	  concat('[[Autore:', autori.page_title, ']]')                autore,
	  (select replace(cat_title, 'Nati_nel_', '')
	   from category join categorylinks on cat_title = cl_to
	   where cl_from = page_id and cat_title like 'Nati_nel_%')   nascita,
	  (select replace(cat_title, 'Morti_nel_', '')
	   from category join categorylinks on cat_title = cl_to
	   where cl_from = page_id and cat_title like 'Morti_nel_%')  morte,
    cl_sortkey
    from page autori
	join categorylinks on page_id = cl_from
    where page_namespace = 102 and cl_to = 'Autori_del_XXI_secolo'
) q
order by cl_sortkey
