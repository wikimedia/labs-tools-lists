CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[Template:', page_title, ']]')
FROM page
WHERE page_namespace = 10
AND page_is_redirect = 0
AND page_title NOT LIKE '%/%'
AND page_id NOT IN
(SELECT cl_from
FROM categorylinks)
ORDER BY page_title;
