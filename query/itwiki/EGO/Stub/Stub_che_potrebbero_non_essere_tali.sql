CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', page_title, ']]')
FROM page
JOIN templatelinks ON page_id = tl_from
WHERE page_namespace = 0
AND tl_title = 'S'
AND tl_namespace = 10
AND page_len > 5000
ORDER BY page_len DESC, page_title;