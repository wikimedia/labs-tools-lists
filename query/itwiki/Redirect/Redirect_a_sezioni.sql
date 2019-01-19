USE itwiki_p;
SELECT CONCAT("# [[", page_title, "]], (", DATE_FORMAT(page_touched, '%e %b %Y, %H:%i'), ")")
FROM page, redirect
WHERE rd_from = page_id
AND page_namespace = 0
AND rd_fragment NOT LIKE ''
ORDER BY page_touched DESC
LIMIT 1000;
