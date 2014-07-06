CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', page_title, ']]')
FROM page
WHERE page_namespace = 0
AND page_is_redirect = 0
AND page_id NOT IN
(SELECT pl_from
FROM pagelinks
WHERE pl_namespace = 0
AND pl_title IN
(SELECT page_title FROM page
WHERE page_namespace = 0
AND page_title NOT IN
(SELECT page_title
FROM categorylinks, pagelinks, page
WHERE cl_to = pl_title
AND cl_from = page_id
AND pl_namespace = 14
AND pl_from = 4195411))) /* Wikipedia:ConnectivityProjectInternationalization/ArticlesNotFormingValidLinks */
AND page_id NOT IN
(SELECT pp_page
FROM page_props
WHERE pp_propname = 'disambiguation')
ORDER BY page_title;