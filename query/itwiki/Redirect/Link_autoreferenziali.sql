SELECT DISTINCT CONCAT("# [[", page.page_title, "]]", " → [[", redirs.page_title, "]]")
FROM page
JOIN pagelinks ON pl_from = page_id
JOIN page AS redirs ON (pl_namespace = redirs.page_namespace AND pl_title = redirs.page_title)
JOIN redirect ON rd_from = redirs.page_id
WHERE redirs.page_is_redirect = 1
AND page.page_namespace = 0
AND redirs.page_namespace = 0
AND rd_namespace = page.page_namespace
AND rd_title = page.page_title
LIMIT 10000;
