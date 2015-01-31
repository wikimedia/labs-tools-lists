CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', page_title, ']]')
FROM page
WHERE page_namespace = 0
AND page_id IN
(SELECT tl_from 
FROM templatelinks
WHERE tl_title LIKE 'Tassobox')
AND page_id NOT IN
(SELECT ll_from
FROM langlinks)
ORDER BY page_title;