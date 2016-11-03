CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', x_nsname, ':', ar_title, ']]: ', COUNT(ar_rev_id))
FROM archive, s51223__lists_p.x_namespaces
WHERE ar_namespace = x_nsnumber
GROUP BY ar_title
ORDER BY COUNT(ar_rev_id) DESC
LIMIT 1000;
