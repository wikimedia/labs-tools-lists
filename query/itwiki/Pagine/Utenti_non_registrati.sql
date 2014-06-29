CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT('# [[', ns_name, ':', page_title, ']]')
	FROM page, p50380g50614__lists.ns_it
	WHERE page_namespace IN (2,3)
		AND page_namespace = ns_id
		AND page_is_redirect = 0
		AND NOT page_title LIKE '%/%'
		AND NOT page_title LIKE '%.%.%.%' /* IPv4 */
		AND NOT page_title LIKE '%:%:%:%:%:%:%:%' /* IPv6 */
		AND page_title NOT IN (SELECT REPLACE(user_name, ' ', '_') FROM user)
		AND page_id >= 4000000
		LIMIT 100;
