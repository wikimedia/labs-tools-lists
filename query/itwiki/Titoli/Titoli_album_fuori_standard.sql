USE itwiki_p;
SELECT CONCAT("# [[", page_title, "]]") FROM page
WHERE page_namespace = 0 AND page_is_redirect = 0
AND (page_title LIKE "%(album_%)" OR page_title LIKE "%(Album_%)"
OR page_title LIKE "%(singolo_%)" OR page_title LIKE "%(Singolo_%)")
ORDER BY page_title;
