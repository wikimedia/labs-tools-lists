USE itwiki_p;
SELECT CONCAT('# [[', page_title, ']]')
FROM page
WHERE page_namespace = 0
AND page_is_redirect = 0
AND page_title NOT IN (
  SELECT DISTINCT pl_title
  FROM pagelinks
  WHERE pl_from_namespace = 0
  AND pl_namespace = 0
  AND pl_title = page_title
  AND pl_from NOT IN
  (SELECT DISTINCT page_id
   FROM page
   WHERE page_namespace=0
   AND page_is_redirect=1
   AND page_title NOT IN 
   (SELECT DISTINCT pl_title
  FROM pagelinks
  WHERE pl_from_namespace = 0
  AND pl_namespace = 0
  AND pl_title = page_title))
  AND pl_from NOT IN
  (SELECT DISTINCT cl_from
   FROM categorylinks, pagelinks
   WHERE cl_to = pl_title
   AND pl_namespace = 14
   AND pl_from = 4195411)) /* Wikipedia:ConnectivityProjectInternationalization/ArticlesNotFormingValidLinks */
   AND page_id NOT IN
   (SELECT DISTINCT cl_from
    FROM categorylinks, pagelinks
    WHERE cl_to = pl_title
    AND pl_namespace = 14
    AND pl_from = 4195411) /* Wikipedia:ConnectivityProjectInternationalization/ArticlesNotFormingValidLinks */
AND page_id IN
(SELECT ll_from
FROM langlinks)
ORDER BY page_title;