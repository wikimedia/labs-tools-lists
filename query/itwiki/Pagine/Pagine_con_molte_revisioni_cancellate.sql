SELECT CONCAT('# [[{{ns:', ar_namespace, '}}:', ar_title, ']]: ', COUNT(ar_rev_id))
FROM archive
GROUP BY ar_title
ORDER BY COUNT(ar_rev_id) DESC
LIMIT 1000;
