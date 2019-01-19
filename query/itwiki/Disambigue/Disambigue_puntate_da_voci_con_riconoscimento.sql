USE itwiki_p;
SELECT CONCAT('# [[', page_title, ']] (', COUNT(*), ')')
FROM page, pagelinks
WHERE pl_title = page_title
AND page_namespace = 0
AND page_is_redirect = 0
AND pl_namespace = 0
AND page_id IN
(SELECT pp_page
FROM page_props
WHERE pp_propname = 'disambiguation'
AND page_namespace = 0
AND page_is_redirect = 0
AND page_title NOT LIKE '%(disambigua)')
AND pl_from IN
(SELECT page_id
FROM page, categorylinks
WHERE page_namespace = 0
AND page_id = cl_from
AND (cl_to LIKE 'VdQ'
OR cl_to LIKE 'Voci_in_vetrina_su_it.wiki'))
GROUP BY page_title
ORDER BY COUNT(*) DESC, page_title;
