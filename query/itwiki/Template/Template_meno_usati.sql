USE itwiki_p;
SELECT CONCAT("# [[:Template:", tl_title, "]] (", COUNT(*), ")")
FROM templatelinks, page
WHERE tl_namespace = 10
AND page_title = tl_title
AND page_namespace = 10
AND tl_title NOT LIKE '%/%'
GROUP BY tl_title
ORDER BY COUNT(*)
LIMIT 10000;
