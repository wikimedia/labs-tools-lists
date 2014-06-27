CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT("# [[Template:", page_title, "]]")
FROM page
WHERE page_title NOT IN (
SELECT tl_title
FROM templatelinks
WHERE tl_namespace = 10)
AND page_namespace = 10
AND page_is_redirect = 0
AND page_title NOT LIKE '%/%'
ORDER BY page_title;
