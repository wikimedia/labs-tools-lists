SELECT CONCAT('# [[Utente:', actor_name, ']] (', COUNT(*), ')')
FROM page, revision JOIN actor ON actor_id = rev_actor
WHERE page_namespace = 0
AND page_is_redirect = 0
AND rev_page = page_id
AND rev_parent_id = 0
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
GROUP BY actor_name
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;
