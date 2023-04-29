SELECT CONCAT("# [[", page_title, "]] - ", COUNT(rev_id))
FROM page
JOIN revision ON page_id = rev_page
WHERE page_is_redirect = 0
AND page_namespace = 0
AND rev_timestamp > NOW() - INTERVAL 1 WEEK
GROUP BY page_title
ORDER BY COUNT(rev_id) DESC
LIMIT 100;
