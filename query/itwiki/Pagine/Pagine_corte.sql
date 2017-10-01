USE itwiki_p;
SELECT CONCAT("# [[{{ns:", page_namespace, "}}:", page_title, "]] (", page_len, ")")
FROM page
WHERE page_namespace <> '0'
AND page_namespace <> '2'
AND page_namespace <> '3'
AND page_len < '5'
ORDER BY page_namespace, page_title;
