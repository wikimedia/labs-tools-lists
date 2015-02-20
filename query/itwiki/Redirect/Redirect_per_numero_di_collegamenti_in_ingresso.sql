CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', page_title, ']] (', COUNT(*), ')')
FROM page, pagelinks
WHERE pl_title = page_title
AND page_namespace = 0
AND page_is_redirect = 1
AND pl_namespace = 0
AND pl_from IN
(SELECT page_id
FROM page
WHERE page_namespace = 0)
GROUP BY page_title
ORDER BY COUNT(*) DESC
LIMIT 5000;