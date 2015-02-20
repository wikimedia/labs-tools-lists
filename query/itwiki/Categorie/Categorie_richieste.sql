CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT("# [[:Categoria:", cl_to, "]] contiene [[", page_title, "]]")
FROM categorylinks, page
WHERE cl_to NOT IN
(SELECT page_title
FROM page
WHERE page_namespace=14)
AND cl_from = page_id
AND page_namespace = 0
ORDER BY cl_to;