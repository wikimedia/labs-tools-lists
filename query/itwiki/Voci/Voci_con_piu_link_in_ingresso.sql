CONNECT itwiki_p itwiki.labsdb;
SELECT pl_title, COUNT(*)
FROM pagelinks
WHERE pl_namespace = 0
AND pl_from NOT IN
(SELECT page_id
FROM page
WHERE page_namespace <> 0)
GROUP BY pl_title
ORDER BY COUNT(*) DESC;
