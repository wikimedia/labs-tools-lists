SELECT CONCAT('# [[', page_title, ']] in [[Categoria:', cl_to, ']]')
FROM page, categorylinks
WHERE page_is_redirect = 1
AND page_id = cl_from
AND cl_to <> 'Redirect_da_mantenere_orfani'
AND cl_to <> 'Formule_molecolari'
GROUP BY page_title
ORDER BY page_title;
