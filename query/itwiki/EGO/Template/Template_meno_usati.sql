CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT("# [[:Template:", tl_title, "]] (", COUNT(*) AS C, ")")
FROM templatelinks, page 
WHERE tl_namespace = 10 
AND page_title = tl_title 
AND page_namespace = 10 
AND tl_title NOT LIKE '%/%' 
GROUP BY tl_title 
ORDER BY C 
LIMIT 1000