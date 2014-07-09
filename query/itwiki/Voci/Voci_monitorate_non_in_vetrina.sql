CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', page_title, ']] (', page_len, ')')
FROM page
JOIN categorylinks ON page_id = cl_from
WHERE page_namespace = 1
AND cl_to = 'Voci_monitorate_-_livello_completo'
AND NOT EXISTS(
SELECT *
FROM page AS p
JOIN categorylinks AS c ON p.page_id = c.cl_from
WHERE p.page_namespace = 0
AND p.page_title = page.page_title
AND cl_to LIKE 'Voci_in_vetrina%')
ORDER BY page_len DESC;
