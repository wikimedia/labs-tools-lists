SELECT CONCAT('# [[', page_title, ']] -> [[', rd_title, ']] - ', COUNT(*)) 
FROM page JOIN redirect ON page_id = rd_from, pagelinks
WHERE page_namespace = 0 
AND rd_namespace = 0
AND rd_title IN
(SELECT page_title
FROM page
WHERE page_id IN
(SELECT pp_page
FROM page_props
WHERE pp_propname = 'disambiguation'))
AND page_title = pl_title
AND pl_from_namespace IN (0, 6)
AND pl_namespace = 0
GROUP BY page_title
ORDER BY COUNT(*) DESC