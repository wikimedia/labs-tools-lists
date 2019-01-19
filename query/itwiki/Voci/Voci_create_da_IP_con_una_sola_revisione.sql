USE itwiki_p;
SELECT DISTINCT CONCAT("# [[", page_title, "]]")
FROM page, revision
WHERE page_id = rev_page
AND page_is_new = 1
AND page_is_redirect = 0
AND rev_user = 0
AND page_namespace = 0
ORDER BY page_title;
