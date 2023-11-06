SELECT CONCAT('# [[', page_title, ']]')
FROM page
WHERE page_namespace = 0
AND page_id IN (SELECT tl_from
FROM templatelinks
WHERE tl_target_id IN
(SELECT lt_id
 FROM linktarget
 WHERE lt_namespace = 10
 AND lt_title IN ('S')))
AND page_id NOT IN (SELECT tl_from
FROM templatelinks
WHERE tl_target_id IN
(SELECT lt_id
 FROM linktarget
 WHERE lt_namespace = 10
 AND lt_title IN ('S_sezione')))
AND page_len > 10000
ORDER BY page_len DESC, page_title;