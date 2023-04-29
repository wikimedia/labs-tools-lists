SELECT CONCAT("# [[:Categoria:", page_title, "]]")
FROM page
WHERE page_namespace = 14
AND page_is_redirect = 1
ORDER BY page_title;