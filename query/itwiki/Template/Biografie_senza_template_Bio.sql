CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', page_title, ']]')
FROM page
WHERE page_namespace = 0 AND page_is_redirect = 0
AND page_id IN
(SELECT page_id
FROM page JOIN pagelinks ON page_id = pl_from
WHERE pl_namespace = 100 AND pl_title = 'Biografie')
AND page_id NOT IN
(SELECT page_id
FROM page JOIN templatelinks ON page_id = tl_from
WHERE tl_namespace = 10 AND tl_title = 'Bio')
AND page_title NOT IN
(SELECT page_title
FROM categorylinks, pagelinks, page
WHERE cl_to = pl_title
AND cl_from = page_id
AND pl_namespace = 14
AND pl_from = 4195411) /* Wikipedia:ConnectivityProjectInternationalization/ArticlesNotFormingValidLinks */
ORDER BY page_title;
