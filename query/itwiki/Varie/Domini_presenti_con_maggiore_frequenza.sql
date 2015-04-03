CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT(url, " (", COUNT(*), ")")
FROM (
	SELECT SUBSTRING_INDEX(SUBSTRING(el_to, LOCATE('://', el_to) + 3), '/', 1) url
	FROM externallinks
	WHERE el_from IN (
			SELECT page_id
			FROM page
			WHERE page_namespace = 0
			)
	) tmp_table
GROUP BY url
HAVING COUNT(*) > 100
ORDER BY COUNT(*) DESC;
