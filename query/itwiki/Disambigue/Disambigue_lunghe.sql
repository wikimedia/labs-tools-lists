SELECT CONCAT('# [[', page_title, ']] - ', page_len)
FROM page
WHERE page_id IN
(SELECT pp_page
FROM page_props
WHERE pp_propname = 'disambiguation')
AND page_namespace = 0
ORDER BY page_len DESC
LIMIT 1000;