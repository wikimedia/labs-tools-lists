CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', x_nsname, ':', page_title, ']]')
	FROM page, s51223__lists_p.x_namespaces
	WHERE page_namespace IN (2,3)
		AND page_namespace = x_nsnumber
		AND page_is_redirect = 0
		AND NOT page_title LIKE '%/%'
		AND NOT page_title LIKE '%.%.%.%' /* IPv4 */
		AND NOT page_title LIKE '%:%:%:%:%:%:%:%' /* IPv6 */
		AND page_title NOT IN (SELECT REPLACE(user_name, ' ', '_') FROM user)
		AND page_id >= 4000000
		LIMIT 100;
