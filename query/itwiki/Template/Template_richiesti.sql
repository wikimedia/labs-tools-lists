USE itwiki_p;
SELECT CONCAT('# [[Template:', tl_title, ']] (', COUNT(*), ' collegamenti)')
FROM templatelinks
LEFT JOIN page ON ((page_namespace = tl_namespace) AND (page_title = tl_title))
WHERE (page_title IS NULL)
AND tl_namespace = '10'
AND tl_from IN (SELECT page_id FROM page
WHERE page_namespace = '0' OR page_namespace = '6' OR page_namespace = '10'
OR page_namespace = '12' OR page_namespace = '14' OR page_namespace = '100'
OR page_namespace = '102')
GROUP BY tl_namespace, tl_title
ORDER BY COUNT(*) DESC
LIMIT 500;
