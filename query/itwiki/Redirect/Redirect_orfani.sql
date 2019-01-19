USE itwiki_p;
SELECT CONCAT('# [[', page_title, ']] - [[', rd_title, ']] ([[Speciale:PuntanoQui/', page_title, ']])')
FROM page 
LEFT JOIN pagelinks
ON pl_title = page_title
AND pl_namespace = page_namespace
LEFT JOIN redirect
ON rd_from = page_id
WHERE page_namespace=0
AND rd_namespace=0
AND pl_namespace IS NULL
ORDER BY page_title
LIMIT 10000;
