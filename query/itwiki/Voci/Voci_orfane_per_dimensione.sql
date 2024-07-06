SELECT CONCAT('# [[', page_title, ']] - ', page_len)
FROM page
WHERE page_namespace = 0
AND page_is_redirect = 0
AND page_title NOT IN (
  SELECT DISTINCT lt_title FROM linktarget
  WHERE lt_namespace = 0
  AND lt_title = page_title
  AND lt_id IN (
  SELECT pl_target_id
  FROM pagelinks
  WHERE pl_from_namespace = 0
  AND NOT pl_from = page_id
  AND pl_from NOT IN (
  SELECT DISTINCT page_id
  FROM page
  WHERE page_namespace=0
  AND page_is_redirect=1
  AND page_title NOT IN 
  (SELECT DISTINCT lt_title FROM linktarget
  WHERE lt_namespace = 0
  AND lt_title = page_title
  AND lt_id IN (
  SELECT pl_target_id
  FROM pagelinks
    WHERE pl_from_namespace = 0)))
  AND pl_from NOT IN
        (SELECT DISTINCT cl_from
      FROM categorylinks, linktarget
      WHERE cl_to = lt_title
      AND lt_namespace = 14
      AND lt_id IN (
        SELECT pl_target_id
        FROM pagelinks
        WHERE pl_from = 4195411)))) /* Wikipedia:ConnectivityProjectInternationalization/ArticlesNotFormingValidLinks */
   AND page_id NOT IN
   (SELECT DISTINCT cl_from
      FROM categorylinks, linktarget
      WHERE cl_to = lt_title
      AND lt_namespace = 14
      AND lt_id IN (
        SELECT pl_target_id
        FROM pagelinks
        WHERE pl_from = 4195411)) /* Wikipedia:ConnectivityProjectInternationalization/ArticlesNotFormingValidLinks */
ORDER BY page_len DESC;
