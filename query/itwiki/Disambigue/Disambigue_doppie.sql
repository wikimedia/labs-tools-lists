CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', p.page_title, ']] - [[', p.page_title, '_(disambigua)]]')
FROM page as p, page_props
WHERE pp_propname = 'disambiguation'
AND page_id = pp_page
AND page_namespace = 0
AND page_is_redirect = 0
AND page_title NOT LIKE '%_(disambigua)'
AND page_title IN
(SELECT SUBSTRING(page_title, 1, LENGTH(page_title)-13)
FROM page, page_props
WHERE pp_propname = 'disambiguation'
AND page_id = pp_page
AND page_namespace = 0
AND page_is_redirect = 0
AND page_title LIKE '%_(disambigua)')
ORDER BY page_title;