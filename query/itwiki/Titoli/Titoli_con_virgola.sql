CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT("# [[", page_title, "]]") 
FROM page
WHERE page_namespace = 0
AND page_is_redirect = 0
AND page_title LIKE "%,%" 
ORDER BY page_title;