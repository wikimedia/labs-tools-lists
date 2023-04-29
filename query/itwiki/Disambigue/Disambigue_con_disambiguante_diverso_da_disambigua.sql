SELECT CONCAT('# [[', page_title, ']]')
FROM page, page_props
WHERE pp_propname = 'disambiguation'
AND page_id = pp_page
AND page_namespace = 0
AND page_is_redirect = 0
AND page_title LIKE '%(%)'
AND page_title NOT LIKE '%(disambigua)'
ORDER BY page_title;
