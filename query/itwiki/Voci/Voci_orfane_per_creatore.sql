SELECT CONCAT('# [[Utente:', actor_name, ']] (', COUNT(*), ')')
FROM page, revision JOIN actor ON actor_id = rev_actor
WHERE page_namespace = 0
AND page_is_redirect = 0
AND rev_page = page_id
AND rev_parent_id = 0
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
GROUP BY actor_name
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;
