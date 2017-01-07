CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', page_title, ']]')
FROM page
WHERE page_namespace = 0
AND page_is_redirect = 0
AND page_title NOT IN
(SELECT pl_title
FROM pagelinks
WHERE pl_namespace = 0
AND pl_from NOT IN
(SELECT page_id
FROM page
WHERE page_namespace <> 0)
AND pl_from NOT IN
(SELECT page_id
FROM page JOIN redirect ON page_id=rd_from
  WHERE page_namespace=0 AND rd_namespace = 0
    AND NOT EXISTS ( SELECT * 
      FROM page AS p JOIN pagelinks ON p.page_id = pl_from 
        WHERE p.page_namespace IN (0, 4, 10, 12, 100, 102) AND pl_namespace = 0 AND pl_title = page.page_title))
AND pl_from NOT IN
(SELECT cl_from
FROM categorylinks, pagelinks
WHERE cl_to = pl_title
AND pl_namespace = 14
AND pl_from = 4195411)) /* Wikipedia:ConnectivityProjectInternationalization/ArticlesNotFormingValidLinks */
AND page_id NOT IN
(SELECT cl_from
FROM categorylinks, pagelinks
WHERE cl_to = pl_title
AND pl_namespace = 14
AND pl_from = 4195411) /* Wikipedia:ConnectivityProjectInternationalization/ArticlesNotFormingValidLinks */
AND page_id IN
(SELECT ll_from
FROM langlinks)
ORDER BY page_title;