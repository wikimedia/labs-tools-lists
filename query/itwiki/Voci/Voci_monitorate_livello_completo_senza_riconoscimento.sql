SELECT CONCAT('# [[', page_title, ']] - ', page_len)
FROM page
WHERE page_namespace = 0
AND page_title IN (SELECT page_title
FROM page
JOIN categorylinks ON page_id = cl_from
WHERE page_namespace = 1
AND cl_to = 'Voci_monitorate_-_livello_completo'
AND NOT EXISTS
(SELECT *
FROM page AS p
JOIN categorylinks AS c ON p.page_id = c.cl_from
WHERE p.page_namespace = 0
AND p.page_title = page.page_title
AND (cl_to LIKE 'Voci_in_vetrina%'
OR cl_to LIKE 'Voci_di_qualit%')))
ORDER BY page_len DESC;
