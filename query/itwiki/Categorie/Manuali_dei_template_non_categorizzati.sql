USE itwiki_p;
SELECT CONCAT('* [[Template:', page_title, ']]')
FROM page
WHERE page_namespace = 10
AND page_is_redirect = 0
AND page_title LIKE '%/man'
AND page_id NOT IN
(SELECT cl_from
FROM categorylinks
WHERE cl_to = 'Manuali_dei_template')
ORDER BY page_title;
