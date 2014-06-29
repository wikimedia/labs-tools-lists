CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', ns_name, ':', ar_title, ']]: ', COUNT(ar_rev_id))
FROM archive, p50380g50614__lists.ns_it
WHERE ar_namespace = ns_id
GROUP BY ar_title
ORDER BY COUNT(ar_rev_id) DESC
LIMIT 1000;
