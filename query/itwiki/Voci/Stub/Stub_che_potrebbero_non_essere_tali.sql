USE itwiki_p;
SELECT CONCAT('# [[', page_title, ']]')
FROM page
JOIN templatelinks ON page_id = tl_from
WHERE page_namespace = 0
AND tl_title = 'S'
AND tl_namespace = 10
AND page_len > 10000
ORDER BY page_len DESC, page_title;
