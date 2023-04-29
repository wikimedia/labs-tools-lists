SELECT CONCAT("# [[Discussione:", page_title, "]]")
FROM page
WHERE page_namespace = 1
AND page_is_redirect = 0
AND page_len > 100000
AND page_title NOT LIKE '%/%'
ORDER BY page_title;
