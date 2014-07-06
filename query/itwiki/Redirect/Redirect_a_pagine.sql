CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', page_title, ']]')
FROM page, redirect
WHERE rd_from = page_id
AND page_namespace = 0
AND rd_namespace <> 0
ORDER BY page_title;