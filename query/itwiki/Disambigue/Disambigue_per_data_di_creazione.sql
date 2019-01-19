USE itwiki_p;
SELECT CONCAT('# [[', page_title, ']] (', DATE_FORMAT(rev_timestamp, '%e %b %Y, %H:%i'), ') (', COUNT(*), ')')
FROM page, pagelinks, revision
WHERE pl_title = page_title
AND page_namespace = 0
AND page_is_redirect = 0
AND pl_namespace = 0
AND page_id = rev_page
AND rev_parent_id = 0
AND page_id IN
(SELECT pp_page
FROM page_props
WHERE pp_propname = 'disambiguation')
AND pl_from IN
(SELECT page_id
FROM page
WHERE page_namespace = 0)
GROUP BY page_title
ORDER BY rev_timestamp, COUNT(*) DESC
LIMIT 5000;