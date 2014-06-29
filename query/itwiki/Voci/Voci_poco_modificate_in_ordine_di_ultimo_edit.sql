CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT("# [[", page_title, "]], (", DATE_FORMAT(rev_timestamp, '%e %b %Y, %H:%i'), ")")
FROM page
JOIN revision ON page_id = rev_page
LEFT JOIN langlinks ON ll_from = rev_page
WHERE page_is_redirect = 0
AND page_namespace = 0
AND rev_parent_id = 0
AND ll_from IS NULL
AND rev_timestamp < NOW() - INTERVAL 6 YEAR
AND rev_len < 5000
AND CAST(page_len AS SIGNED)-CAST(rev_len AS SIGNED) < 500
ORDER BY rev_timestamp, page_title
LIMIT 10000;
