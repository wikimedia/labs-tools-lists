CONNECT itwiki_p itwiki.labsdb;
SELECT CONCAT("# [[", ns_name, ":", page_title, "]]")
FROM page, revision
JOIN p50380g50614__lists.ns_it ON page_namespace = ns_id
WHERE page_id = rev_page
AND page_is_new = 1
AND page_is_redirect = 0
AND rev_user = 0
AND page_namespace IN (0, 2, 4, 10, 12, 100, 102)
ORDER BY page_namespace, page_title;
