USE itwiki_p;
SELECT CONCAT("# [[:Categoria:", page_title, "]]")
FROM page
WHERE page_id NOT IN
(SELECT cl_from
FROM categorylinks)
AND page_namespace = 14
AND page_is_redirect = 0
ORDER BY page_title;