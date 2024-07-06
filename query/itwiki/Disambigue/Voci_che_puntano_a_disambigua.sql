SELECT CONCAT('# [[', page_title, ']] (', COUNT(*), ')')
FROM pagelinks, page
WHERE pl_from = page_id
AND page_namespace = 0
AND page_is_redirect = 0
AND pl_target_id IN
(SELECT DISTINCT lt_id FROM linktarget
  WHERE lt_namespace = 0 
 AND lt_title IN
(SELECT page_title
FROM page, page_props
WHERE pp_propname = 'disambiguation'
AND page_id = pp_page
AND page_namespace = 0
 AND page_is_redirect = 0))
AND pl_from IN
(SELECT page_id
FROM page
WHERE page_namespace = 0)
AND page_id NOT IN
(SELECT pp_page
FROM page_props
WHERE pp_propname = 'disambiguation')
GROUP BY page_title
HAVING COUNT(*) >= 7
ORDER BY COUNT(*) DESC
LIMIT 5000;