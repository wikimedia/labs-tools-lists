SELECT CONCAT("# [[Template:", page_title, "]]")
FROM page
WHERE page_title NOT IN (
SELECT tl_title
FROM templatelinks
WHERE tl_namespace = 10)
AND page_namespace = 10
AND page_is_redirect = 0
AND page_title NOT LIKE '%/%'
AND page_id NOT IN (
SELECT tl_from
FROM templatelinks
WHERE tl_from_namespace = 10
AND tl_namespace = 10
AND tl_title = 'Template_non_incluso')
ORDER BY page_title;
