USE itwiki_p;
SELECT CONCAT('* [[', page_title, ']], (', DATE_FORMAT(rev_timestamp, '%e %b %Y, %H:%i'), ')')
FROM page JOIN revision ON page_latest=rev_id
WHERE page_namespace=0
AND page_is_redirect=0
AND page_id IN
(SELECT pp_page
FROM page_props
WHERE pp_propname = 'disambiguation')
ORDER BY rev_timestamp ASC
LIMIT 5000;