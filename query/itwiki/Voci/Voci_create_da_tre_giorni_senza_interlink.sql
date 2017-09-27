CONNECT itwiki_p itwiki.labsdb;
SELECT distinct CONCAT("# [[", page_title, "]]")
FROM page, revision
LEFT JOIN langlinks ON ll_from = rev_page
WHERE page_is_redirect = 0
AND page_namespace = 0
AND page_id = rev_page
AND rev_parent_id = 0
AND rev_timestamp > NOW() - INTERVAL 3 DAY
AND rev_timestamp < NOW() - INTERVAL 2 DAY
AND ll_from IS NULL
ORDER BY rev_timestamp DESC;
