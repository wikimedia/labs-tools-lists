CONNECT itwiki_p itwiki.labsdb;
SELECT DISTINCT CONCAT("# [[", ns_name, ":", page_title, "]], (", DATE_FORMAT(rev_timestamp, '%e %b %Y, %H:%i'), ")")
FROM page, revision, p50380g50614__lists.ns_it
WHERE page_id = rev_page
AND page_namespace = ns_id
AND page_is_new = 1
AND page_is_redirect = 0
AND rev_user = 0
AND page_namespace <> 0
ORDER BY rev_timestamp, page_namespace, page_title
LIMIT 5000;
