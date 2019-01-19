USE itwiki_p;
SELECT CONCAT('# [[', page_title, ']]')
FROM page
WHERE page_namespace = 0
AND page_is_redirect = 0
AND page_title LIKE '%(disambigua)'
AND page_id NOT IN
(SELECT pp_page
FROM page_props
WHERE pp_propname = 'disambiguation')
ORDER BY page_title;
