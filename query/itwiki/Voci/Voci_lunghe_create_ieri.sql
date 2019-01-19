USE itwiki_p;
SELECT CONCAT("# [[", page_title, "]]")
FROM page
JOIN revision ON page_id = rev_page
WHERE page_is_redirect = 0
AND page_namespace = 0
AND rev_parent_id = 0
AND rev_timestamp > NOW() - INTERVAL 1 DAY
AND page_len > 10000
ORDER BY rev_timestamp DESC;
