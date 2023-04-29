SELECT CONCAT('# [[', page_title, ']] - ', page_len)
FROM page
WHERE page_id IN
(SELECT pp_page
FROM page_props
WHERE pp_propname = 'disambiguation')
ORDER BY page_len
LIMIT 1000;
